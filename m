Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129578AbRCAK2T>; Thu, 1 Mar 2001 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRCAK2J>; Thu, 1 Mar 2001 05:28:09 -0500
Received: from mail.zmailer.org ([194.252.70.162]:2317 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129578AbRCAK2D>;
	Thu, 1 Mar 2001 05:28:03 -0500
Date: Thu, 1 Mar 2001 12:27:53 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ivan Stepnikov <iv@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010301122753.S15688@mea-ext.zmailer.org>
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv>; from iv@spylog.com on Thu, Mar 01, 2001 at 12:16:08PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 12:16:08PM +0300, Ivan Stepnikov wrote:
>             Hello!
> 
> I tried to test linux memory allocation. For experiment I used i386
> architecture with Pentium III processor, 512M RAM and 8G swap space. For
> memory allocation libhoard was tried. Linux kernel 2.4.2 with patch
> per-process-3.5G-IA32-no-PAE-1, at
> /pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre5/ on
> ftp.kernel.org (This patch should force memory allocation for one process up
> to 3.5G approximately).

	I tried this with stock 2.4.0.
	(I am sluggish to change things at my workstation.)

> When I try large blocks (about 256K - 1M) everything was ok. More then 3G
> memory was successfully allocated.
> 
> On small blocks result was significantly worse. About 2.3 - 2.4G was
> allocated and system hanged. But it was possible to switch between  local
> consoles, and to receive ping replay by network. Actually it's only one sign
> of life (hard disk didn't work and it was impossible to reboot the machine
> by correct methods). At /var/log/messages was

	That sounds like the system got way too much of memory FRAGMENTS,
	and could no longer track them with the amount of memory space
	available to the Kernel ?   (Kernel needs memory for its internal
	databases, very few (none?) of which can be in PAE areas.)

	...

	Yes, LOTS of fragments with   malloc(1024):
...
48459000-4845a000 rw-p 00159000 00:00 0
4845a000-4845b000 rw-p 0015a000 00:00 0
4845b000-4845c000 rw-p 0015b000 00:00 0
4845c000-4845d000 rw-p 0015c000 00:00 0
4845d000-4845e000 rw-p 0015d000 00:00 0
4845e000-4845f000 rw-p 0015e000 00:00 0
4845f000-48460000 rw-p 0015f000 00:00 0
48460000-48461000 rw-p 00160000 00:00 0
48461000-48462000 rw-p 00161000 00:00 0
48462000-48463000 rw-p 00162000 00:00 0
...


	For 1 G alloc some 16400 lines of  /proc/PID/maps  data.

	The segments are adjacent, but still NOT merged in mapping.


	With   malloc(1M):

...
44089000-4418a000 rw-p 00000000 00:00 0
4418a000-4428b000 rw-p 00000000 00:00 0
4428b000-4438c000 rw-p 00000000 00:00 0
4438c000-4448d000 rw-p 00000000 00:00 0
4448d000-4458e000 rw-p 00000000 00:00 0
4458e000-4468f000 rw-p 00000000 00:00 0
4468f000-44790000 rw-p 00000000 00:00 0
44790000-44891000 rw-p 00000000 00:00 0

	The mmap() allocates them at 1M+64k sized segments.
	(And mere 970 segments for 1G alloc.)

...
> I think, this test shouldn't hang system. System may work slowly, very
> slowly but it shouldn't hang. If system cannot allocate any pages it should
> return correct value.

	I agree, system should not get hung when it runs out of
	memory when constructing mapping tables.  The misbehaving
	client should get malloc/mmap failure.

> And the main thing: it seems the system doesn't use all available swap
> space.
>
> I'm sure if system works properly results must be other.
> 
> --
> Regards,
> Ivan Stepnikov.

/Matti Aarnio
