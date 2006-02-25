Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWBYQiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWBYQiS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBYQiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:38:18 -0500
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:12292 "EHLO
	mail.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S932409AbWBYQiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:38:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17408.34808.422077.518881@zeus.sw.starentnetworks.com>
Date: Sat, 25 Feb 2006 11:38:16 -0500
From: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cramfs mounts provide corrupted content since 2.6.15
In-Reply-To: <20060225125551.GA21203@suse.de>
References: <20060225110844.GA18221@suse.de>
	<20060225125551.GA21203@suse.de>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering writes:
>  On Sat, Feb 25, Olaf Hering wrote: 
> > 
> > Any ideas why a cramfs mount provides empty files since at least 2.6.15?
> > It worked ok in 2.6.13 at least. Bug is still present in Linus tree.
> 
> Reverting a97c9bf33f4612e2aed6f000f6b1d268b6814f3c (from 2.6.14-rc1)
> does appearently fix it:
>  [PATCH] fix cramfs making duplicate entries in inode cache

Humm, I've retested my patch against 2.6.12.6 (it was originally
created for 2.6.12) as well as 2.6.15.4 (no patch needed).

Appears fine with both kernel versions with an image containing a
variety of file types.  Test was on ix86 not ppc though.

Looking at your output it's definitely getting inodes confused with
each other so the checks in cramfs_iget5_test() aren't working.

Can you stat the files in question to make sure they are actually
inode #1 on a working as well as non-working kernel?  If your mkcramfs
isn't using #1 for empty files/links/dirs that'd be the problem.

Guess it could be endian issues, however cramfs is always host order
so that shouldn't matter as long as mkcramfs is run on the same
machine.


My test:
-------

Source material:

wallowa2:/localdisk/root/cramtest# find . |sort |xargs ls -ldi |sort
1520737 drwxr-xr-x  2 root root   4096 Feb 25 11:23 ./emptydir1
1520738 drwxrwxr-x  2 root root   4096 Feb 25 11:23 ./emptydir2
1520739 drwxr-xrwx  2 root root   4096 Feb 25 11:23 ./emptydir3
1520740 -rwxr-xr-x  1 root root     33 Feb 25 11:29 ./fulldir1/filea
1520741 drwxr-xr-x  2 root root   4096 Feb 25 11:29 ./fulldir1
1520742 drwxrwxr-x  2 root root   4096 Feb 25 11:29 ./fulldir2
1520743 drwxr-xrwx  2 root root   4096 Feb 25 11:30 ./fulldir3
1520744 brw-r--r--  1 root root  1,  2 Feb 25 11:24 ./block1
1520745 brw-rw-r--  1 root root  3,  4 Feb 25 11:24 ./block2
1520746 brw-r--rw-  1 root root  5,  6 Feb 25 11:24 ./block3
1520747 crw-r--r--  1 root root  7,  8 Feb 25 11:25 ./char1
1520748 crw-rw-r--  1 root root  9, 10 Feb 25 11:25 ./char2
1520749 crw-r--rw-  1 root root 11, 12 Feb 25 11:25 ./char3
1520750 lrwxrwxrwx  1 root root      6 Feb 25 11:25 ./link1 -> stuff1
1520751 lrwxrwxrwx  1 root root      6 Feb 25 11:25 ./link2 -> stuff2
1520752 lrwxrwxrwx  1 root root      6 Feb 25 11:25 ./link3 -> stuff3
1520753 -rwxr-xr-x  1 root root 628684 Feb 25 11:26 ./file1
1520754 -rwxrwxr-x  1 root root  31724 Feb 25 11:26 ./file2
1520755 -rwxr-xrwx  1 root root 113880 Feb 25 11:26 ./file3
1520756 -rwxrwxrwx  3 root root   4124 Feb 25 11:27 ./hardlink1
1520756 -rwxrwxrwx  3 root root   4124 Feb 25 11:27 ./hardlink2
1520756 -rwxrwxrwx  3 root root   4124 Feb 25 11:27 ./hardlink3
1520757 lrwxrwxrwx  1 root root      5 Feb 25 11:29 ./fulldir1/linka -> filea
1520758 -rwxr-xr-x  1 root root  53676 Feb 25 11:29 ./fulldir2/fileb
1520759 -rw-r--r--  1 root root   3228 Feb 25 11:30 ./fulldir3/filec
1523357 drwxr-xr-x  8 root root   4096 Feb 25 11:29 .


2.6.12.6 (with my patch applied) cramfs:

wallowa2:/tmp/cramtest# find . |sort |xargs ls -ldi |sort
     1 brw-r--r--  1 root root  1,  2 Dec 31  1969 ./block1
     1 brw-r--rw-  1 root root  5,  6 Dec 31  1969 ./block3
     1 brw-rw-r--  1 root root  3,  4 Dec 31  1969 ./block2
     1 crw-r--r--  1 root root  7,  8 Dec 31  1969 ./char1
     1 crw-r--rw-  1 root root 11, 12 Dec 31  1969 ./char3
     1 crw-rw-r--  1 root root  9, 10 Dec 31  1969 ./char2
     1 drwxr-xr-x  1 root root      0 Dec 31  1969 ./emptydir1
     1 drwxr-xrwx  1 root root      0 Dec 31  1969 ./emptydir3
     1 drwxrwxr-x  1 root root      0 Dec 31  1969 ./emptydir2
    76 drwxr-xr-x  1 root root    444 Dec 31  1969 .
   520 drwxr-xr-x  1 root root     40 Dec 31  1969 ./fulldir1
   560 drwxrwxr-x  1 root root     20 Dec 31  1969 ./fulldir2
   580 drwxr-xrwx  1 root root     20 Dec 31  1969 ./fulldir3
   600 -rwxr-xr-x  1 root root 628684 Dec 31  1969 ./file1
332096 -rwxrwxr-x  1 root root  31724 Dec 31  1969 ./file2
349944 -rwxr-xrwx  1 root root 113880 Dec 31  1969 ./file3
408876 -rwxr-xr-x  1 root root     33 Dec 31  1969 ./fulldir1/filea
408924 lrwxrwxrwx  1 root root      5 Dec 31  1969 ./fulldir1/linka -> filea
408944 -rwxr-xr-x  1 root root  53676 Dec 31  1969 ./fulldir2/fileb
438440 -rw-r--r--  1 root root   3228 Dec 31  1969 ./fulldir3/filec
439152 -rwxrwxrwx  1 root root   4124 Dec 31  1969 ./hardlink1
439152 -rwxrwxrwx  1 root root   4124 Dec 31  1969 ./hardlink2
439152 -rwxrwxrwx  1 root root   4124 Dec 31  1969 ./hardlink3
441280 lrwxrwxrwx  1 root root      6 Dec 31  1969 ./link1 -> stuff1
441300 lrwxrwxrwx  1 root root      6 Dec 31  1969 ./link2 -> stuff2
441320 lrwxrwxrwx  1 root root      6 Dec 31  1969 ./link3 -> stuff3


2.6.15.4 cramfs:

wallowa2:/tmp/cramtest# find . |sort |xargs ls -ldi |sort
     1 brw-r--r--  1 root root  1,  2 Dec 31  1969 ./block1
     1 brw-r--rw-  1 root root  5,  6 Dec 31  1969 ./block3
     1 brw-rw-r--  1 root root  3,  4 Dec 31  1969 ./block2
     1 crw-r--r--  1 root root  7,  8 Dec 31  1969 ./char1
     1 crw-r--rw-  1 root root 11, 12 Dec 31  1969 ./char3
     1 crw-rw-r--  1 root root  9, 10 Dec 31  1969 ./char2
     1 drwxr-xr-x  1 root root      0 Dec 31  1969 ./emptydir1
     1 drwxr-xrwx  1 root root      0 Dec 31  1969 ./emptydir3
     1 drwxrwxr-x  1 root root      0 Dec 31  1969 ./emptydir2
    76 drwxr-xr-x  1 root root    444 Dec 31  1969 .
   520 drwxr-xr-x  1 root root     40 Dec 31  1969 ./fulldir1
   560 drwxrwxr-x  1 root root     20 Dec 31  1969 ./fulldir2
   580 drwxr-xrwx  1 root root     20 Dec 31  1969 ./fulldir3
   600 -rwxr-xr-x  1 root root 628684 Dec 31  1969 ./file1
332096 -rwxrwxr-x  1 root root  31724 Dec 31  1969 ./file2
349944 -rwxr-xrwx  1 root root 113880 Dec 31  1969 ./file3
408876 -rwxr-xr-x  1 root root     33 Dec 31  1969 ./fulldir1/filea
408924 lrwxrwxrwx  1 root root      5 Dec 31  1969 ./fulldir1/linka -> filea
408944 -rwxr-xr-x  1 root root  53676 Dec 31  1969 ./fulldir2/fileb
438440 -rw-r--r--  1 root root   3228 Dec 31  1969 ./fulldir3/filec
439152 -rwxrwxrwx  1 root root   4124 Dec 31  1969 ./hardlink1
439152 -rwxrwxrwx  1 root root   4124 Dec 31  1969 ./hardlink2
439152 -rwxrwxrwx  1 root root   4124 Dec 31  1969 ./hardlink3
441280 lrwxrwxrwx  1 root root      6 Dec 31  1969 ./link1 -> stuff1
441300 lrwxrwxrwx  1 root root      6 Dec 31  1969 ./link2 -> stuff2
441320 lrwxrwxrwx  1 root root      6 Dec 31  1969 ./link3 -> stuff3


-- 
Dave Johnson
Starent Networks

