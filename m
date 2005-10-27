Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVJ0Wym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVJ0Wym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVJ0Wym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:54:42 -0400
Received: from pat.uio.no ([129.240.130.16]:11979 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932673AbVJ0Wym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:54:42 -0400
Subject: Re: NFS Permission denied instead of EROFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: hooanon05@yahoo.co.jp, Unionfs mailing list <unionfs@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510272236230.13626@yvahk01.tjqt.qr>
References: <E1EVAnp-0000p1-Tq@jroun>
	 <Pine.LNX.4.61.0510272236230.13626@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 18:54:28 -0400
Message-Id: <1130453668.23138.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.971, required 12,
	autolearn=disabled, AWL 1.03, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 27.10.2005 klokka 22:57 (+0200) skreiv Jan Engelhardt:

> # grep export /etc/exports 
> /export *(ro,async,no_root_squash)
> # mount localhost:/export /mnt -t nfs -oro
> # logout
> $ cat /proc/mounts | grep nfs
> localhost:/export /mnt nfs ro,v3,rsize=32768,wsize=32768,hard,tcp,lock,addr=localhost 0 0
> $ ls -l /mnt/file
> -rw-r--r--  1 root root 0 Oct 27 22:42 /mnt/file
> $ touch /mnt/file
> touch: cannot touch `file': Read-only file system
> $ strace -e trace=file touch /mnt/file
> open("/mnt/file", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = 
> -1 EACCES (Permission denied)
> utimes("/mnt/file", NULL) = -1 EACCES (Permission denied)
>   ...
> touch: cannot touch `/mnt/file': Permission denied

This is on a filesystem that has been mounted with the -ro flag? That
would be a client bug.

Hmm... The client code does look a bit dodgy there (particularly NFSv4).
I'll see if I can come up with a patch.

> If the file does not exist however, everything is ok:
> $ touch /mnt/file
> touch: cannot touch /mnt/file': Read-only file system
> $ strace -e trace=file touch /mnt/file
> open("/mnt/file", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) =
> -1 EROFS (Read-only file system)
> utimes("/mnt/file", NULL) = -1 ENOENT (No such file or directory)
> 
> 
> Which brings me right to question... should mountd or knfsd be adjusted to
> refuse a rw mount request if an nfs export is only available as ro? Like it is
> already the case with normal block devices:

How would knfsd or mountd know? There is no way for the client to
communicate to the server that it is mounting for read-write.

Cheers,
  Trond

