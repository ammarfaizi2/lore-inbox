Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUKNWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUKNWEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUKNWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:04:40 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:13321 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261354AbUKNWEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:04:37 -0500
Date: Sun, 14 Nov 2004 23:04:31 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Spiegel <lkml@happyjack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with loop devices on 2.6.9
Message-ID: <20041114220431.GA20151@pclin040.win.tue.nl>
References: <20041112104934.GA1711@midgard.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112104934.GA1711@midgard.comcast.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 02:49:34AM -0800, Chris Spiegel wrote:

>   While playing around with loop mounts on kernel 2.6.9 I managed to get
> a kernel panic.  After messing around with it I can reproduce the
> problem reliably.  The sequence I came up with to cause the problem:
> 
> mount -o loop /dev/loop/0 /mnt
> mount -o loop /dev/loop/1 /mnt
> mount -o loop /dev/loop/2 /mnt
> mount /dev/loop/0 /mnt -t ext2
> 
> Unable to handle kernel paging request at virtual address 98858a6f
>  printing eip:
> c011345a
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in:
> CPU     0
> EIP     0060:[<c011345a>]    Not tainted VLI
> EFLAGS  00010083   (2.6.9)
> EIP is at do_page_fault+0x99/0x599
> eax: c9100000   ebx: 65642f3c   ecx: 0000007b   edx: f7d4858b
> esi: 00000000   edi: c01133c1   ebp: 988589ff   esp: c9100108
> ds: 007b   es: 007b   ss: 0068
> Unable to handle kernel NULL pointer dereference at virtual address 00000070
>  printing eip:
> c011345a
> *pde = 00000000

I do not see precisely the same - but I do not use devfs.
What happens for me is: the "mount -o loop /dev/loop0 /mnt"
takes the first unused loop device, /dev/loop0, and then
does "losetup /dev/loop0 /dev/loop0", and then does mount.
But there is a loop in the loop devices and the kernel dies in
infinite recursion.

The easiest fix is saying "don't do that then".
But, on the other hand, maybe it is reasonable to add a check.
Hope to send a patch later this evening.

Andries
