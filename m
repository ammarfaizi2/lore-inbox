Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbULCWrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbULCWrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbULCWrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:47:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:11463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262450AbULCWqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:46:44 -0500
Date: Fri, 3 Dec 2004 14:50:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: franz_pletz@t-online.de (Franz Pletz)
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, ludoschmidt@web.de
Subject: Re: [PATCH] loopback device can't act as its backing store
Message-Id: <20041203145056.541308d1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412032028220.10184@sgx.home>
References: <Pine.LNX.4.61.0412032028220.10184@sgx.home>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

franz_pletz@t-online.de (Franz Pletz) wrote:
>
> The patch below fixes a bug in loop which apparently causes the kernel to call
> the initialization routine of a loopback device recursively while trying to set
> the backing store to the loopback device it's being mapped to.

Your patch addresses direct loop0-on-loop0 recursion, but does it fix the
more complex loop-stacks which Chris Spiegel identified?

I don't think there's any actual infinite recursion in Chris's example - in
his case we simply stacked loop deveces too deep.  But a fix for Chris's
scenario will also fix the one which you identify, I think.  Andries posted
such a patch but I have not yet got around to looking at it.




Begin forwarded message:

Date: Fri, 12 Nov 2004 02:49:34 -0800
From: Chris Spiegel <lkml@happyjack.org>
To: linux-kernel@vger.kernel.org
Subject: Oops with loop devices on 2.6.9


Hi,
  While playing around with loop mounts on kernel 2.6.9 I managed to get
a kernel panic.  After messing around with it I can reproduce the
problem reliably.  The sequence I came up with to cause the problem:

mount -o loop /dev/loop/0 /mnt
mount -o loop /dev/loop/1 /mnt
mount -o loop /dev/loop/2 /mnt
mount /dev/loop/0 /mnt -t ext2

I know the above is silly and contrived.

An example oops is as follows (I copied this down on paper and then
back, so hopefully I made no transcription errors):

Unable to handle kernel paging request at virtual address 98858a6f
 printing eip:
c011345a
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in:
CPU     0
EIP     0060:[<c011345a>]    Not tainted VLI
EFLAGS  00010083   (2.6.9)
EIP is at do_page_fault+0x99/0x599
eax: c9100000   ebx: 65642f3c   ecx: 0000007b   edx: f7d4858b
esi: 00000000   edi: c01133c1   ebp: 988589ff   esp: c9100108
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel NULL pointer dereference at virtual address 00000070
 printing eip:
c011345a
*pde = 00000000

I ran this through ksymoops, but it just spit it back at me with the
following tacked on:

Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; c9100000 <pg0+8b9f000/3fa9d400>
>>edx; f7d4858b <pg0+377e758b/3fa9d400>
>>edi; c01133c1 <do_page_fault+0/599>
>>esp; c9100108 <pg0+8b9f108/3fa9d400>


1 warning issued.  Results may not be reliable.


So I'm not sure if that's useful.  I could also get my system to lock up
if I did the above, but without the loop1 and 2 devices.  One time it
just froze, no messages.  Another time I got:
double fault, gdt at c1408260 [255 bytes]

I'm attaching my kernel config if that's of any help.  If you'd like me
to reply to the list, please CC me so I can set the In-Reply-To header
properly.

Chris

