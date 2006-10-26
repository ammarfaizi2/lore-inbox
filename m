Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945964AbWJZWoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbWJZWoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945965AbWJZWoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:44:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57339 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1945964AbWJZWon convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:44:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 6/13] KVM: memory slot management
Date: Fri, 27 Oct 2006 00:44:31 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com> <20061026172756.D0649A0209@cleopatra.q>
In-Reply-To: <20061026172756.D0649A0209@cleopatra.q>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610270044.31382.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 October 2006 19:27, Avi Kivity wrote:
> kvm defines memory in "slots", more or less corresponding to the DIMM
> slots.
>
> this allows us to:
>  - avoid the VGA hole at 640K
>  - add a pci framebuffer at runtime
>  - hotplug memory
>
> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
> Signed-off-by: Avi Kivity <avi@qumranet.com>

To bring up the discussion about guest memory allocation again,
I'd like to make a case for using defining guest real memory
as host user, not a special in-kernel address space.

You're probably aware of many of these points, but I'd like
to list all that I can think of, in case you haven't thought
of them:

- no need to preallocate memory that the guest doesn't actually use.
- guest memory can be paged to disk.
- you can mmap files into multiple guest for fast communication
- you can use mmap host files as backing store for guest blockdevices,
  including ext2 with the -o xip mount option to avoid double paging
- you can mmap packet sockets or similar to provide virtual networking
  devices.
- you can use hugetlbfs inside of guests
- you can mmap simple devices (e.g. frame buffer) directly into
  trusted guests without HW emulation.
- you can use gdb to debug the running guest address space
- no need for ioctl to access or allocate guest memory
- you can mmap a kernel image (MAP_PRIVATE) into multiple guests
  and share instruction cache lines.
- the kernel code doesn't need special accessors, but can use
  asm/uaccess.h.
- may be able to avoid a bunch of TLB flushes with nested page tables.

On the downside, I can see these points:

- As you mentioned guest size on 32 bit hosts is limited to around 1G.
- you probably have to rewrite your virtual MMU from scratch
- for optimal performance, pageable guests need something like the s390
  pagex/pfault mechanism in the guest kernel.
- if you want a guest not to be paged out, you need privileges to do mlock.
- you can't use swap space in the guest if you want to avoid the
  double paging problem (host needs to read a page from disk for the guest
  to swap it out), or you'd have to implement a mechanism like Martin
  Schwidefsky's page hints (cmm2) for s390.

	Arnd <><
