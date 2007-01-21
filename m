Return-Path: <linux-kernel-owner+w=401wt.eu-S1751898AbXAVHV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXAVHV5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 02:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXAVHV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 02:21:56 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:45494 "EHLO
	relay01.mail-hub.dodo.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbXAVHV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 02:21:56 -0500
X-Greylist: delayed 30546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 02:21:55 EST
From: Grant Coady <grant_lkml@dodo.com.au>
To: dann frazier <dannf@dannf.org>
Cc: Willy Tarreau <w@1wt.eu>, Santiago Garcia Mantinan <manty@debian.org>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Date: Mon, 22 Jan 2007 09:52:44 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <t1r7r2thimh3gpuhtfc9l3aehjdd6dqkp8@4ax.com>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo> <20070120010544.GY26210@colo>
In-Reply-To: <20070120010544.GY26210@colo>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007 18:05:44 -0700, dann frazier <dannf@dannf.org> wrote:

>On Thu, Jan 18, 2007 at 06:00:40PM -0700, dann frazier wrote:
>Ah, think I see the problem now:
>
>--- kernel-source-2.4.27.orig/fs/smbfs/proc.c	2007-01-19 17:53:57.247695476 -0700
>+++ kernel-source-2.4.27/fs/smbfs/proc.c	2007-01-19 17:49:07.480161733 -0700
>@@ -1997,7 +1997,7 @@
> 		fattr->f_mode = (server->mnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFDIR;
> 	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
> 	          !(S_ISDIR(fattr->f_mode)) )
>-		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFREG;
>+		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | (fattr->f_mode & S_IFMT);
> 
> }
> 
client running 2.4.34 with above patch, server is running 2.6.19.2 to 
eliminate it from the problem space (hopefully ;) :
grant@sempro:/home/other$ uname -r
2.4.34b
grant@sempro:/home/other$ ls -l
total 9
drwxr-xr-x 1 grant wheel 4096 2007-01-21 11:44 dir/
drwxr-xr-x 1 grant wheel 4096 2007-01-21 11:44 dirlink/
-rwxr-xr-x 1 grant wheel   15 2007-01-21 11:43 file*
-rwxr-xr-x 1 grant wheel   15 2007-01-21 11:43 filelink*
grant@sempro:/home/other$ ls -l dirlink/
total 1
-rwxr-xr-x 1 grant wheel 15 2007-01-21 11:44 file*
-rwxr-xr-x 1 grant wheel 15 2007-01-21 11:44 filelink*
grant@sempro:/home/other$

problem is still there :(

With client 2.4.33.3 (slackware-11 distro kernel):
grant@sempro:/home/other$ uname -r
2.4.33.3
grant@sempro:/home/other$ ls -l
total 2048
drwxr-xr-x 1 root root  0 2007-01-21 11:44 dir/
lrwxrwxrwx 1 root root  3 2007-01-21 11:43 dirlink -> dir/
-rw-r--r-- 1 root root 15 2007-01-21 11:43 file
lrwxrwxrwx 1 root root  4 2007-01-21 11:44 filelink -> file
grant@sempro:/home/other$ ls -l dirlink/
total 2048
-rw-r--r-- 1 root root 15 2007-01-21 11:44 file
lrwxrwxrwx 1 root root  4 2007-01-21 11:44 filelink -> file
grant@sempro:/home/other$ cat filelink
this is a test

No problem with symlinks, execute flag.

Grant.
