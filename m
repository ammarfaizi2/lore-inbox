Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265688AbSKAKo5>; Fri, 1 Nov 2002 05:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSKAKo5>; Fri, 1 Nov 2002 05:44:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:53382 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265688AbSKAKo4>;
	Fri, 1 Nov 2002 05:44:56 -0500
Message-ID: <3DC25CA5.B15848E0@digeo.com>
Date: Fri, 01 Nov 2002 02:51:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: kernel-janitor-discuss@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
References: <200211011302.05461.arnd@bergmann-dalldorf.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2002 10:51:18.0095 (UTC) FILETIME=[9B5495F0:01C28194]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> 
> I have been looking for more places in 2.5 that can be marked
> might_sleep() and noticed that all the functions in asm/uaccess.h
> are not marked although they sleep if the memory they access
> has to be paged in.
> 
> After adding might_sleep() in ten places in asm-i386/uaccess.h
> and arch/i386/lib/usercopy.c, I have been running this kernel
> for about two weeks.

This is an excellent point.  If someone is holding a lock
across a uaccess function and userspace has passed the address
of a valid but not-present page we will hit the "atomic copy_user"
path.  Userspace will be returned an EFAULT and will be left
scratching its head, wondering what it did wrong.

Or the kernel will deadlock, of course.

I don't think we need to add the check to anything other than
ia32.  That will pick up the great bulk of any problems, and
arch-specific code won't be doing these copies much anyway.

So if you could prepare a patch which adds these checks for
ia32 it would be muchly appreciated.

And if you're feeling really keen, Dave Jones has a patch which
makes the might_sleep check a real config option rather than
overloading CONFIG_DEBUG_KERNEL - would be nice to squeeze that
out of him if poss.

Thanks.
