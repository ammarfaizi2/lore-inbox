Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbUDNAHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUDNAHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:07:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:41890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263822AbUDNAG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:06:59 -0400
Date: Tue, 13 Apr 2004 17:06:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
Message-Id: <20040413170642.22894ebc.akpm@osdl.org>
In-Reply-To: <407C4130.8000901@austin.ibm.com>
References: <407C4130.8000901@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> On some larger ppc64 configurations /proc/device-tree is exhausting 
>  procfs' dynamic (non-pid) inode range (16K).  This patch makes the 
>  dynamic inode range 0xf0000000-0xffffffff

OK.

> and changes the inode number 
>  allocator to use a growable linked list of bitmaps.

This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
instead.  There's an example in fs/super.c

This bit:

@@ -535,22 +537,26 @@ void emergency_remount(void)
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-enum {Max_anon = 256};
-static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
+static struct idr unnamed_dev_idr;
 static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
 
 int set_anon_super(struct super_block *s, void *data)
 {
 	int dev;
+
 	spin_lock(&unnamed_dev_lock);
-	dev = find_first_zero_bit(unnamed_dev_in_use, Max_anon);
-	if (dev == Max_anon) {
+	if (idr_pre_get(&unnamed_dev_idr, GFP_ATOMIC) == 0) {
 		spin_unlock(&unnamed_dev_lock);
-		return -EMFILE;
+		return -ENOMEM;
 	}
-	set_bit(dev, unnamed_dev_in_use);
+	dev = idr_get_new(&unnamed_dev_idr, NULL);
 	spin_unlock(&unnamed_dev_lock);
-	s->s_dev = MKDEV(0, dev);
+
+	if ((dev & MAX_ID_MASK) == (1 << MINORBITS)) {
+		idr_remove(&unnamed_dev_idr, dev);
+		return -EMFILE;
+	}
+	s->s_dev = MKDEV(0, dev & MINORMASK);
 	return 0;
 }
 
@@ -559,14 +565,20 @@ EXPORT_SYMBOL(set_anon_super);
 void kill_anon_super(struct super_block *sb)
 {
 	int slot = MINOR(sb->s_dev);
+
 	generic_shutdown_super(sb);
 	spin_lock(&unnamed_dev_lock);
-	clear_bit(slot, unnamed_dev_in_use);
+	idr_remove(&unnamed_dev_idr, slot);
 	spin_unlock(&unnamed_dev_lock);
 }
 
 EXPORT_SYMBOL(kill_anon_super);
 
+void __init unnamed_dev_init(void)
+{
+	idr_init(&unnamed_dev_idr);
+}
+
 void kill_litter_super(struct super_block *sb)
 {
 	if (sb->s_root)

