Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVG0G53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVG0G53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 02:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVG0G53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 02:57:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262020AbVG0G51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 02:57:27 -0400
Date: Tue, 26 Jul 2005 23:56:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akihana@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Reclaim space from unused ramdisk?
Message-Id: <20050726235624.4f3ca2a8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507270823490.10780@yvahk01.tjqt.qr>
References: <4746469c05072615167ca234ce@mail.gmail.com>
	<Pine.LNX.4.61.0507270823490.10780@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >I wonder if it would be possible to somehow reclaim space that has
> >been previously reserved for a ramdisk without rebooting.
> 
> free_ramdisk.c:
> 
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> 
> int main(int argc, const char **argv) {
>     int eax = 0;
>     while(*argv != NULL) {
>         int fd = open(*argv, O_RDWR);
>         if(fd < 0) {
>             fprintf(stderr, "Warning: Cannot open %s: %s\n",
>              *argv, strerror(errno));
>             if(eax == 0) { eax = errno; }
>             continue;
>         }
>         ioctl(fd, BLKFLSBUF, 0);
>         close(fd);
>         ++argv;
>     }
>     return eax == 0;
> }
> 

hmm, yes.  That's a special-case in the ramdisk driver.

The command `blockdev --flushbufs /dev/ram0' should have the same effect.
