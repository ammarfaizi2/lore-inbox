Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTJRMtu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 08:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTJRMtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 08:49:50 -0400
Received: from 62.79.102.158.adsl.arc.worldonline.dk ([62.79.102.158]:2052
	"EHLO mail.bitplanet.net") by vger.kernel.org with ESMTP
	id S261566AbTJRMtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 08:49:46 -0400
Message-ID: <3F91348B.5080102@bitplanet.net>
Date: Sat, 18 Oct 2003 14:39:39 +0200
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, kakadu_croc@yahoo.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
References: <20031015032215.58d832c1.akpm@osdl.org> <20031015123444.46223.qmail@web40904.mail.yahoo.com> <20031015102810.4017950f.akpm@osdl.org> <20031015174047.GE971@phunnypharm.org> <20031015105359.31c016c3.akpm@osdl.org> <20031016022547.GA615@phunnypharm.org>
In-Reply-To: <20031016022547.GA615@phunnypharm.org>
Content-Type: multipart/mixed;
 boundary="------------060302010508040505050204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302010508040505050204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ben Collins wrote:
> On Wed, Oct 15, 2003 at 10:53:59AM -0700, Andrew Morton wrote:
> 
>>Ben Collins <bcollins@debian.org> wrote:
>>
>>>>highlevel_add_host() does read_lock() and then proceeds to do things like
>>>
>>> > starting kernel threads under that lock.  The locking is pretty broken
>>> > in there :(
>>>
>>> No, highlevel_add_host() itself doesn't start any threads. But it does
>>> pass around data that needs to be locked from changes, and one of the
>>> handlers happens to start a thread, and other things allocate memory
>>> (such as this case).
>>>
>>> It's ugly, and I've been trying to clean it up. This case can be fixed
>>> quickly with a simple check in hpsb_create_hostinfo() to pass GFP_ATOMIC
>>> to kmalloc.
>>
>>nodemgr_add_host() looks like the hard one.  Maybe make hl_drivers_lock a
>>sleeping lock?
> 
> 
> Problem is, things like bus resets happen in interrupt, and while I can
> push off some things to occur in the nodemgr thread, a lot of other
> stuff has to happen in the interrupt, and they require the same lock.

I was looking briefly at this too, and as you say, the problem is that 
some things have to happen in interrupt, others happen in process 
context.  I've attached a patch that implements one way to fix it: 
double book-keeping - we maintain two lists of the highlevel drivers, 
one protected by a semaphore another protected by the rw spinlock. The 
lists are identical, except between the two list_add_tail()'s (and the 
two list_del()'s), but that doesn't allow any harmful race conditions.

A more radical approach would be to split the highlevel interface into 
two interfaces add_host() + remove_host() in a hpsb_host_notification 
interface and the rest in another interface.  The driver would have to 
register both interfaces if it needs them. Some drivers only use 
add_host() and remove_host(), so they could register only the 
hpsb_host_notification interface.

best regards,
Kristian

--------------060302010508040505050204
Content-Type: text/plain;
 name="double-list-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="double-list-patch"

Index: highlevel.c
===================================================================
--- highlevel.c	(revision 1073)
+++ highlevel.c	(working copy)
@@ -37,9 +37,18 @@
 };
 
 
+/* Double bookkeeping: hl_drivers and hl_sem_drivers are essentially
+ * the same lists, but hl_sem_list is protected by a semaphore and is
+ * used to notify highlevel drivers when we add and remove hosts. The
+ * other, hl_drivers is protected by an rw spinlock, and is used when
+ * we notify highlevel drivers of bus resets and incoming packets. */
+
 static LIST_HEAD(hl_drivers);
 static rwlock_t hl_drivers_lock = RW_LOCK_UNLOCKED;
 
+static LIST_HEAD(hl_sem_drivers);
+static DECLARE_MUTEX(hl_drivers_sem);
+
 static LIST_HEAD(addr_space);
 static rwlock_t addr_space_lock = RW_LOCK_UNLOCKED;
 
@@ -238,6 +247,10 @@
 
 	rwlock_init(&hl->host_info_lock);
 
+	down(&hl_drivers_sem);
+	list_add_tail(&hl->hl_sem_list, &hl_sem_drivers);
+	up(&hl_drivers_sem);
+
 	write_lock_irqsave(&hl_drivers_lock, flags);
         list_add_tail(&hl->hl_list, &hl_drivers);
 	write_unlock_irqrestore(&hl_drivers_lock, flags);
@@ -272,6 +285,10 @@
         list_del(&hl->hl_list);
 	write_unlock_irqrestore(&hl_drivers_lock, flags);
 
+	down(&hl_drivers_sem);
+	list_del(&hl->hl_sem_list);
+	up(&hl_drivers_sem);
+
         if (hl->remove_host) {
 		down(&hpsb_hosts_lock);
 		list_for_each(lh, &hpsb_hosts) {
@@ -391,33 +408,28 @@
 
 void highlevel_add_host(struct hpsb_host *host)
 {
-        struct list_head *entry;
         struct hpsb_highlevel *hl;
 
-        read_lock(&hl_drivers_lock);
-        list_for_each(entry, &hl_drivers) {
-                hl = list_entry(entry, struct hpsb_highlevel, hl_list);
+	down(&hl_drivers_sem);
+	list_for_each_entry(hl, &hl_sem_drivers, hl_sem_list) {
 		if (hl->add_host)
 			hl->add_host(host);
         }
-        read_unlock(&hl_drivers_lock);
+	up(&hl_drivers_sem);
 }
 
 void highlevel_remove_host(struct hpsb_host *host)
 {
-        struct list_head *entry;
         struct hpsb_highlevel *hl;
 
-	read_lock(&hl_drivers_lock);
-	list_for_each(entry, &hl_drivers) {
-                hl = list_entry(entry, struct hpsb_highlevel, hl_list);
-
+	down(&hl_drivers_sem);
+	list_for_each_entry(hl, &hl_sem_drivers, hl_sem_list) {
 		if (hl->remove_host) {
 			hl->remove_host(host);
 			hpsb_destroy_hostinfo(hl, host);
 		}
         }
-	read_unlock(&hl_drivers_lock);
+	up(&hl_drivers_sem);
 }
 
 void highlevel_host_reset(struct hpsb_host *host)
Index: highlevel.h
===================================================================
--- highlevel.h	(revision 1073)
+++ highlevel.h	(working copy)
@@ -56,6 +56,7 @@
                              int cts, u8 *data, size_t length);
 
 
+	struct list_head hl_sem_list;
 	struct list_head hl_list;
 	struct list_head addr_list;
 

--------------060302010508040505050204--

