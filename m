Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267380AbSLLAM2>; Wed, 11 Dec 2002 19:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267381AbSLLAM2>; Wed, 11 Dec 2002 19:12:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267380AbSLLAMX>;
	Wed, 11 Dec 2002 19:12:23 -0500
Subject: Re: [PATCH] Notifier for significant events on i386
From: Stephen Hemminger <shemminger@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Levon <levon@movementarian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039641336.18587.30.camel@irongate.swansea.linux.org.uk>
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>
	 <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com>
	 <20021211171337.A17600@in.ibm.com>
	 <20021211202727.GF20735@compsoc.man.ac.uk>
	 <1039641336.18587.30.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1039652384.1649.17.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 16:19:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2002-12-11 at 13:15, Alan Cox wrote:
> On Wed, 2002-12-11 at 20:27, John Levon wrote:
> > There are notifiers being used that sleep inside the called notifiers.
> > 
> > You could easily make a __notifier_call_chain that is lockless and
> > another one that readlocks the notifier_lock ...
> 
> The notifier chains assume the users will do the locking needed for
> them. It might be possible to do cool things there with RCU

This patch changes notifier to use RCU.  No interface change, just a little
more memory in each notifier_block. Also some formatting cleanup.
Please review and give comments.

diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Wed Dec 11 15:46:05 2002
+++ b/include/linux/notifier.h	Wed Dec 11 15:46:05 2002
@@ -9,13 +9,19 @@
  
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
+
 #include <linux/errno.h>
+#include <linux/rcupdate.h>
+#include <linux/completion.h>
 
 struct notifier_block
 {
 	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
 	struct notifier_block *next;
 	int priority;
+
+	struct rcu_head    rcu;
+	struct completion  complete;
 };
 
 
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Dec 11 15:46:05 2002
+++ b/kernel/sys.c	Wed Dec 11 15:46:05 2002
@@ -78,7 +78,7 @@
  */
 
 static struct notifier_block *reboot_notifier_list;
-rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
+static spinlock_t notifier_lock = SPIN_LOCK_UNLOCKED;
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
@@ -89,46 +89,60 @@
  *
  *	Currently always returns zero.
  */
- 
 int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while(*list)
-	{
+	spin_lock(&notifier_lock);
+	while (*list) {
 		if(n->priority > (*list)->priority)
 			break;
 		list= &((*list)->next);
 	}
+
 	n->next = *list;
-	*list=n;
-	write_unlock(&notifier_lock);
+	*list = n;
+	wmb();
+
+	spin_unlock(&notifier_lock);
 	return 0;
 }
 
+static void notifier_unreg_complete(void *arg) {
+	struct notifier_block *n = arg;
+
+	n->next = NULL;
+	complete(&n->complete);
+}
+
 /**
  *	notifier_chain_unregister - Remove notifier from a notifier chain
- *	@nl: Pointer to root list pointer
+ *	@list: Pointer to root list pointer
  *	@n: New entry in notifier chain
  *
  *	Removes a notifier from a notifier chain.
  *
  *	Returns zero on success, or %-ENOENT on failure.
  */
- 
-int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
+int notifier_chain_unregister(struct notifier_block **list, struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while((*nl)!=NULL)
-	{
-		if((*nl)==n)
-		{
-			*nl=n->next;
-			write_unlock(&notifier_lock);
+	spin_lock(&notifier_lock);
+	while(*list) {
+		if (*list == n) {
+			*list = n->next;
+			wmb();
+
+			init_completion(&n->complete);
+			call_rcu(&n->rcu, notifier_unreg_complete, n);
+			spin_unlock(&notifier_lock);
+
+			wait_for_completion(&n->complete);
+
 			return 0;
 		}
-		nl=&((*nl)->next);
+
+		list = &((*list)->next);
 	}
-	write_unlock(&notifier_lock);
+
+	spin_unlock(&notifier_lock);
 	return -ENOENT;
 }
 
@@ -147,21 +161,19 @@
  *	Otherwise, the return value is the return value
  *	of the last notifier function called.
  */
- 
 int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
 {
-	int ret=NOTIFY_DONE;
+	int ret = NOTIFY_DONE;
 	struct notifier_block *nb = *n;
 
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
+	while (nb) {
+		ret = nb->notifier_call(nb,val,v);
+		if (ret & NOTIFY_STOP_MASK) 
 			return ret;
-		}
-		nb=nb->next;
+		nb = nb->next;
+		read_barrier_depends();
 	}
+
 	return ret;
 }
 




