Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUIGOGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUIGOGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUIGOGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:06:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:35228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268076AbUIGOGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:06:10 -0400
Date: Tue, 7 Sep 2004 07:06:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 4/4] copyfile: copyfile
In-Reply-To: <20040907121520.GC27297@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
 <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de>
 <20040907121520.GC27297@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Sep 2004, Jörn Engel wrote:
>
> Again, the syscall itself may be a stupid idea, but Steve indicated
> interest for cifs.  I'll hide behind his back and let him fight for
> it. ;)

Well, this isn't useful for cifs.

For cifs to be able to use it, the "copyfile()" interface needs to
basically just be a pathname operation (ie a "dir->i_op->copy()"), not a
"struct file" operation.  It's more like the VFS "->rename()" or "->link"
operations, in other words. And it should return -EXDEV the same way
rename returns EXDEV if the files aren't on the same filesystem.

Then you could (and should) make a "generic_file_copy()" function that
takes that pathname format, and then uses sendfile() to do the copy for
regular disk-based filesystems.

I think you should be able to copy the "sys_link()" code for almost all of 
the top-level stuff. The only real difference being

-	error = dir->i_op->link(old_dentry, dir, new_dentry);
+	error = dir->i_op->copy(old_dentry, dir, new_dentry);

or something.

And no, I don't know how to handle interruptability. I think the right
answer may be that filesystems that don't support this as a "native op"  
and can't do it quickly should just return an error, and then users can
copy their multi-gigabyte files by hand, like they used to.

So if we do this, we do this _right_. We also make sure that we error out 
"too much" rather than "too little", so that people don't start depending 
on behaviour that we don't want them to depend on. 

		Linus
