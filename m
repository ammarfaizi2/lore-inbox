Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVAEUgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVAEUgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAEUgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:36:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbVAEUcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:32:53 -0500
Date: Wed, 5 Jan 2005 12:32:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Eirik Thorsnes <eithor@ii.uib.no>, smfrench@austin.rr.com,
       trond.myklebust@fys.uio.no, matthew@wil.cx
Subject: Re: panic - Attempting to free lock with active block list
Message-ID: <20050105123207.J469@build.pdx.osdl.net>
References: <20050105195736.GA26989@ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050105195736.GA26989@ii.uib.no>; from Jan-Frode.Myklebust@bccs.uib.no on Wed, Jan 05, 2005 at 08:57:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan-Frode Myklebust (Jan-Frode.Myklebust@bccs.uib.no) wrote:
> We have a couple of mail-servers running first 2.6.9-1.681_FC3smp
> and was later upgraded to the Fedora test kernel 2.6.10-1.727_FC3smp
> which I think is pretty plain 2.6.10 + ac2. But they both keep
> crashing with the message:
> 
>        Kernel panic - not syncing: Attempting to free lock with active block list
> 
> Any ideas how to attack this?
> 
> We're running Centos 3.3, ext3 for root-disks, ext2 on /boot,
> XFS for mail-spools, lots of nfs-mounted directories..

It seems likely it's nfs related in this case since it stresses the
fs/locks code differently than local filesystems.  I recall Steve French
reporting similar issue with cifs last month.

Message-Id: <1102097193.3540.4.camel@smfhome1.smfdom>

Are those three cases really panic-worthy?  Could we change to BUG_ON()
and try and get some useful debugging?  Trond, Willy, any ideas?

thanks,
-chris

===== fs/locks.c 1.76 vs edited =====
--- 1.76/fs/locks.c	2005-01-04 18:48:28 -08:00
+++ edited/fs/locks.c	2005-01-05 12:31:34 -08:00
@@ -159,14 +159,20 @@ static inline void locks_free_lock(struc
 		BUG();
 		return;
 	}
-	if (waitqueue_active(&fl->fl_wait))
-		panic("Attempting to free lock with active wait queue");
+	if (waitqueue_active(&fl->fl_wait)) {
+		printk("Attempting to free lock with active wait queue");
+		BUG();
+	}
 
-	if (!list_empty(&fl->fl_block))
-		panic("Attempting to free lock with active block list");
+	if (!list_empty(&fl->fl_block)) {
+		printk("Attempting to free lock with active block list");
+		BUG();
+	}
 
-	if (!list_empty(&fl->fl_link))
-		panic("Attempting to free lock on active lock list");
+	if (!list_empty(&fl->fl_link)) {
+		printk("Attempting to free lock on active lock list");
+		BUG();
+	}
 
 	if (fl->fl_ops) {
 		if (fl->fl_ops->fl_release_private)
