Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUBPUmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUBPUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:42:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42882 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265834AbUBPUmS
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:42:18 -0500
Date: Mon, 16 Feb 2004 15:44:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Coywolf Qi Hunt <coywolf@lovecn.org>
cc: Riley@Williams.Name, davej@suse.de, hpa@zytor.com,
       Linux kernel <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.24] Fix GDT limit in setup.S
In-Reply-To: <403114D9.2060402@lovecn.org>
Message-ID: <Pine.LNX.4.53.0402161504490.15476@chaos>
References: <403114D9.2060402@lovecn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Coywolf Qi Hunt wrote:

> Hello 2.4.xx hackers,
>
> In setup.S, i feel like that the gdt limit 0x8000 is not proper and it
> should be 0x800.  How came 0x800 into 0x8000 in 2.4.xx code?  Is there a
> story?  It shouldn't be a careless typo. 256 gdt entries should be
> enough and since it's boot gdt, 256 is ok even if the code is run on SMP
> with 64 cpus.
>

The first element has nothing to do with the number of GDT entries.
It represents the LIMIT. Because the granularity bit is
set meaning 4 kilobyte pages and 0x8000 * 0x1000  = 0x8000000
                                      |      |
                                      |      |_______ Page size
                                      |______________ GDT value
This is the size of address space that is unity-mapped for boot.

The granularity is also not the number of GDT entries. It
represents the length for which the GDT definition applies.

Because this GDT is used only for booting, somebody decided that
there would never be any boot code beyond 2 GB so there was no
reason to make room for it. If you change the number to 0x0800,
you are declaring that neither the boot code nor any RAM-disk
combination will ever exceed 0x800 * 0x1000 = 0x800000 bytes.
Therefore you broke my imbedded system. Do not do this.

> At least the comment doesn't match the code. Either fix the code or fix
> the comment.  We really needn't so many GDT entries. Let's use the intel
> segmentation in a most limited way. Below follows a patch fixing the code.
>
> I don't have the latest 2.4.24, but setup.S isn't changed from 2.4.23 to
> 2.4.24.
>
> Regards, Coywolf
>


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


