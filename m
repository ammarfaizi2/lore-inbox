Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277695AbRJRKmA>; Thu, 18 Oct 2001 06:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277696AbRJRKll>; Thu, 18 Oct 2001 06:41:41 -0400
Received: from pat.uio.no ([129.240.130.16]:60670 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S277695AbRJRKlh> convert rfc822-to-8bit;
	Thu, 18 Oct 2001 06:41:37 -0400
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfsfh.c:nfsd_findparent lookup("..") failure fix in 2.4.4 - xfs related?
In-Reply-To: <3BCEA924.14415870@loewe-komp.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Oct 2001 12:42:01 +0200
In-Reply-To: Peter =?iso-8859-1?q?W=E4chtler's?= message of "Thu, 18 Oct 2001 12:04:20 +0200"
Message-ID: <shsitddmdqe.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Peter Wächtler <pwaechtler@loewe-komp.de> writes:

     > The following diff was made in 2.4.4.  diff -u --recursive
     > --new-file v2.4.4/linux/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
     > --- v2.4.4/linux/fs/nfsd/nfsfh.c Fri Feb 9 11:29:44 2001
     > +++ linux/fs/nfsd/nfsfh.c Sat May 19 17:47:55 2001
     > @@ -244,6 +245,11 @@
     >          */
     >         pdentry = child->d_inode->i_op->lookup(child->d_inode,
     >         tdentry); d_drop(tdentry); /* we never want ".." hashed
     >         */
     > + if (!pdentry && tdentry->d_inode == NULL) {
     > + /* File system cannot find ".." ... sad but possible */
     > + dput(tdentry);
     > + pdentry = ERR_PTR(-EINVAL);
     > + }


     > Umh. How is it possible to have a valid dentry which has no
     > parent?  Even "/.." is linked to "/."

Who said these are *valid* dentries?

There's no way you can fit full path information into an NFS
filehandle, so when the client passes such an object to nfsd, the
latter sometimes has to make so-called 'disconnected' dentries. These
are dentries which contain no path information, and are basically just
providing a dentry alias for the inode.

The code you are looking at attempts to call the filesystem in order
to lookup a file named '..' from just such a disconnected dentry. The
purpose being to actually recreate the path, and hence convert the
dentry into a valid one...

Cheers,
  Trond
