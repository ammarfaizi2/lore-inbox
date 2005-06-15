Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVFOL2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFOL2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFOL2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:28:55 -0400
Received: from [62.206.217.67] ([62.206.217.67]:4819 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261407AbVFOL2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:28:50 -0400
Message-ID: <42B010F1.7060505@trash.net>
Date: Wed, 15 Jun 2005 13:28:49 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: thibault dory <dory.thibault@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG using iptable
References: <243922d60506150304348bb817@mail.gmail.com>
In-Reply-To: <243922d60506150304348bb817@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080503010907070109030707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503010907070109030707
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

thibault dory wrote:
> Since I try to use iptable with kernel 2.6.11.X serie I get the same
> bug with iptable. It didn't work at all and I experience problems with
> my connection. I give you my kernel config file in attachement.
> For the moment I'm using 2.6.11.12 kernel on a 1.4Ghz Centrino.
> 
> BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/1529
> caller is ip_conntrack_helper_register+0x18/0x170

You need to disable CONFIG_NETFILTER_DEBUG or apply this patch.

--------------080503010907070109030707
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

Avoid smp_processor_id() in premptible code in the netfilter lock debugging
code.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/netfilter_ipv4/lockhelp.h |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN include/linux/netfilter_ipv4/lockhelp.h~netfilter-debug-locking-fix include/linux/netfilter_ipv4/lockhelp.h
--- 25/include/linux/netfilter_ipv4/lockhelp.h~netfilter-debug-locking-fix	Thu Apr 28 20:53:26 2005
+++ 25-akpm/include/linux/netfilter_ipv4/lockhelp.h	Thu Apr 28 20:53:26 2005
@@ -63,9 +63,11 @@ do { if ((l)->read_locked_map & (1UL << 
 
 #define LOCK_BH(lk)						\
 do {								\
+	preempt_disable();					\
 	MUST_BE_UNLOCKED(lk);					\
 	spin_lock_bh(&(lk)->l);					\
 	atomic_set(&(lk)->locked_by, smp_processor_id());	\
+	preempt_enable();					\
 } while(0)
 
 #define UNLOCK_BH(lk)				\
@@ -77,16 +79,20 @@ do {						\
 
 #define READ_LOCK(lk) 						\
 do {								\
+	preempt_disable();					\
 	MUST_BE_READ_WRITE_UNLOCKED(lk);			\
 	read_lock_bh(&(lk)->l);					\
 	set_bit(smp_processor_id(), &(lk)->read_locked_map);	\
+	preempt_enable();					\
 } while(0)
 
-#define WRITE_LOCK(lk)							  \
-do {									  \
-	MUST_BE_READ_WRITE_UNLOCKED(lk);				  \
-	write_lock_bh(&(lk)->l);					  \
-	set_bit(smp_processor_id(), &(lk)->write_locked_map);		  \
+#define WRITE_LOCK(lk)						\
+do {								\
+	preempt_disable();					\
+	MUST_BE_READ_WRITE_UNLOCKED(lk);			\
+	write_lock_bh(&(lk)->l);				\
+	set_bit(smp_processor_id(), &(lk)->write_locked_map);	\
+	preempt_enable();					\
 } while(0)
 
 #define READ_UNLOCK(lk)							\

--------------080503010907070109030707--
