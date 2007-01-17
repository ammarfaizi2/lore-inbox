Return-Path: <linux-kernel-owner+w=401wt.eu-S1751766AbXAQVzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXAQVzh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXAQVzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:55:36 -0500
Received: from 1wt.eu ([62.212.114.60]:1984 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbXAQVzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:55:35 -0500
Date: Wed, 17 Jan 2007 22:55:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: Santiago Garcia Mantinan <manty@debian.org>
Cc: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org,
       dannf@dannf.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Message-ID: <20070117215519.GX24090@1wt.eu>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117100030.GA11251@clandestino.aytolacoruna.es>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Santiago,

On Wed, Jan 17, 2007 at 11:00:30AM +0100, Santiago Garcia Mantinan wrote:
> Hi!
> 
> I have discovered a problem with the changes applied to smbfs in 2.4.34 and
> in the security backports like last Debian's 2.4 kernel update these changes
> seem to be made to solve CVE-2006-5871 and they have broken symbolic links
> and changed the way that special files (like devices) are seen.
> 
> For example:
> Before: symbolic links were seen as that, symbolic links an thus if you tried
> to open the file the link was followed and you ended up reading the
> destination file
> Now: symbolic links are seen as normal files (at least with a ls) but their
> length (N) is the length of the symbolic link, if you read it, you'll get the
> first N characters of the destination file. For example, on my filesystem
> bin/sh is a symlink to bash, thus it is 4 bytes long, if I to a cat bin/sh I
> get ELF (this is, the first 4 characters of the bash program, first one
> being a DEL).
> 
> Another example:
> Before: if you did a ls of a device file, like dev/zero you could see it as
> a device, if you tried opening it, it wouldn't work, but if you did a cp -a
> of that file to a local filesystem the result was a working zero device.
> Now: the devices are seen as normal files with a length of 0 bytes.
> 
> Seems to me like a mask is erasing some mode bits that shouldn't be erased.
> 
> I have carried my tests on a Debian Sarge machine always mounting the share
> using: smbmount //server/share /mnt without any other options. The tests
> were carried on a unpatched 2.4.34 comparing it to 2.4.33 and also on
> Debian's 2.4.27 comparing 2.4.27-10sarge4 vs -10sarge5. The server is a
> samba 3.0.23d and I have experienced the same behaviour with samba's
> unix extensions = yes and unix extensions = no.
> 
> I don't know what else to add, if you need any more info or want me to do
> any tests just ask for it.

Well, there is not much to add there. Thanks very much for all your tests.
This problem was not easy to fix, and Dann Frazier did a careful job at
backporting it and testing it. Unfortunately, corner cases like this may
sometimes pass through the tests.

Dann, do you still have your samba server ready to try to reproduce this
problem ? Also, there are very suspect lines right there in the patch :

@@ -505,8 +510,13 @@
 		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
 		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
 
-		mnt->flags = (oldmnt->file_mode >> 9);
+		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
+			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
 	} else {
+		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+						S_IROTH | S_IXOTH | S_IFREG;
+		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+						S_IROTH | S_IXOTH | S_IFDIR;
 		if (parse_options(mnt, raw_data))
 			goto out_bad_option;
 	}


See above ? mnt->dir_mode being assigned 3 times. It still *seems* to do the
expected thing like this but I wonder if the initial intent was exactly this.
Also, would not it be necessary to add "|S_IFLNK" to the file_mode ? Maybe
what I say is stupid, but it's just a guess.

Santiago, if you feel brave enough to try completely untested code, I
would suggest to try this change :

 	} else {
-		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
-						S_IROTH | S_IXOTH | S_IFREG;
-		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
-						S_IROTH | S_IXOTH | S_IFDIR;
+		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+				S_IROTH | S_IXOTH | S_IFREG | S_IFLNK;
+		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+				S_IROTH | S_IXOTH | S_IFDIR;
 		if (parse_options(mnt, raw_data))
 			goto out_bad_option;


Also, please try making symlinks to directories to see how they behave.

Thanks in advance,
Willy

