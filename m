Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSD2PDE>; Mon, 29 Apr 2002 11:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312484AbSD2PDD>; Mon, 29 Apr 2002 11:03:03 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:28176 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312480AbSD2PDD>; Mon, 29 Apr 2002 11:03:03 -0400
Message-Id: <5.1.0.14.2.20020429154159.04a13d80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Apr 2002 16:03:18 +0100
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] module locking
Cc: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200204291430.g3TEUiV02444@fokkensr.vertis.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:30 29/04/02, Rolf Fokkens wrote:
>On Monday 29 April 2002 09:23, Thomas 'Dent' Mirlacher wrote:
> > the capable call is sthell there, but with the module_lock
> > kind or redundant.
>
>once set module_lock cannot be cleared, not even by root. This differs from
>the CAP_SYS_MODULE which can be activated by root, if I'm correct.
>
>module_lock is only a suggestion, w/o /dev/kmem write locking or even 
>locking writes on other /dev/.. or doing mounts it won't be full proof.

*sigh*

RTFM man 2 sysctl

With your patch applied AND module_lock set to 1, anyone with sufficient 
privileges could still do:

#include <linux/unistd.h>
#include <linux/types.h>
#include <linux/sysctl.h>

_syscall1(int, _sysctl, struct __sysctl_args *, args);
#define SIZE(x) sizeof(x)/sizeof(x[0])

int main(void)
{
         int name[] = { CTL_KERN, KERN_MODPROBE };
         int hack = 0;
         struct __sysctl_args args = { name, SIZE(name), 0, 0,
                         &hack, sizeof(hack) };

         if (_sysctl(&args)) {
                 perror("sysctl failed");
                 exit(1);
         }
         printf("module_lock has been zeroed! Muahaha!");
         return 0;
}

Good bye module_lock! /me waves

What was that about not being able to zero it again...?

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

