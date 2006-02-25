Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWBYFR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWBYFR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 00:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWBYFR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 00:17:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030182AbWBYFR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 00:17:56 -0500
Date: Fri, 24 Feb 2006 21:16:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marr <marr@flex.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM
 Change?
Message-Id: <20060224211650.569248d0.akpm@osdl.org>
In-Reply-To: <200602241522.48725.marr@flex.com>
References: <200602241522.48725.marr@flex.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marr <marr@flex.com> wrote:
>
> ..
>
> When switching from kernel 2.4.31 to 2.6.13 (with everything else the same), 
> there is a drastic increase in the time required to perform 'fseek()' on 
> larger files (e.g. 4.3 MB, using ReiserFS [in case it matters], in my test 
> case).
> 
> It seems that any seeks in a range larger than 128KB (regardless of the file 
> size or the position within the file) cause the performace to drop 
> precipitously.
>

Interesting.

What's happening is that glibc does a read from the file within each
fseek().  Which might seem a bit silly because the app could seek somewhere
else without doing any IO.  But then the app would be silly too.

Also, glibc is using the value returned in struct stat's blksize (a hint as
to this file's preferred read chunk size) as, umm, a hint as to this file's
preferred read size.

Most filesystems return 4k in stat.blksize.  But in 2.6, reiserfs bumped
that to 128k to get good I/O patterns.   Consequently this:

>          for (j=0; j < max_calls; j++) {
>             pos = (int)(((double)random() / (double)RAND_MAX) * 4000000.0);
>             if (fseek(inp_fh, pos, SEEK_SET)) {
>                printf("Error ('%s') seeking to position %d!\n", 
>                       strerror(errno), pos);
>             }
>          }

runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
on every fseek.

- There may be a libc stdio function which allows you to tune this
  behaviour.

- libc should probably be a bit more defensive about this anyway -
  plainly the filesystem is being silly.

- You can alter the filesystem's behaviour by mounting with the
  `nolargeio=1' option.  That sets stat.blksize back to 4k.

  This will alter the behaviour of every reiserfs filesystem in the
  machine.  Even the already mounted ones.

  `mount -o remount,nolargeio=1' can probably also be used.  But that
  won't affect inodes which are already in cache - a umount/mount cycle may
  be needed.

  If you like, you can just mount and unmount a different reiserfs
  filesystem to switch this reiserfs filesystem's behaviour.  IOW: the
  reiserfs guys were lazy and went and made this a global variable :(

- fseek is a pretty dumb function anyway - you're better off with
  stateless functions like pread() - half the number of syscalls, don't
  have to track where the file pointer is at.  I don't know if there's a
  pread()-like function in stdio though?

No happy answers there, sorry.  But a workaround.
