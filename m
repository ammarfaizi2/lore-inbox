Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUIBUZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUIBUZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268988AbUIBUZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:25:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:37292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268339AbUIBUXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:23:37 -0400
Date: Thu, 2 Sep 2004 13:22:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent
 semantic changes with reiser4)
In-Reply-To: <1094150760.5809.30.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409021315111.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org> 
 <200408282314.i7SNErYv003270@localhost.localdomain> 
 <20040901200806.GC31934@mail.shareable.org>  <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
  <1094118362.4847.23.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
 <1094150760.5809.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Alan Cox wrote:
> 
> I asked our desktop people. They want something like inotify because
> dontify doesn't cut it.

Well, dnotify() really _is_ inotify(), since it does actually work on 
inodes, not dentries.

I think what they are really complaining about is that dnotify() only 
notifies the _directory_ when a file is changed, and they'd like it to 
notify the file itself too. Which is a one-liner, really.

Does the following make sense? (Totally untested, use-at-your-own-risk, 
I've-never-actually-used-dnotify-in-user-space, whatever).

		Linus

===== fs/dnotify.c 1.17 vs edited =====
--- 1.17/fs/dnotify.c	2004-08-09 18:45:22 -07:00
+++ edited/fs/dnotify.c	2004-09-02 13:21:26 -07:00
@@ -160,6 +160,8 @@
 	if (!dir_notify_enable)
 		return;
 
+	__inode_dir_notify(dentry->d_inode, event);
+
 	spin_lock(&dentry->d_lock);
 	parent = dentry->d_parent;
 	if (parent->d_inode->i_dnotify_mask & event) {
