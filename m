Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUBHCG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 21:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUBHCG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 21:06:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51074
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261837AbUBHCG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 21:06:26 -0500
Date: Sun, 8 Feb 2004 03:06:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Message-ID: <20040208020624.GG31926@dualathlon.random>
References: <200402050941.34155.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402050941.34155.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 10:07:35AM +0800, Michael Frank wrote:
> The question is related to saving the kernel with swsusp.
> 
> Looking at 2.4.24 x86 kernel page flags, kernel memory is flaged reserved 
> the same way as video, BIOS pages.
> 
> Is this a recent change since using the aa vm and should it be like that?

this is the same as 2.2 too, the reserved bit means this isn't a normal
"ram" page, this is either non-ram in the mem_map region or a ram page
being used by a device driver for source/destination dma or similar
special usage.

> If so, should hardware related reserved pages i.e video, BIOS be flaged
> PG_nosave upon init?

the non-ram regions of the physical address space present in the
mem_map_t array are marked as reserved at boot.

About the ram pieces of the mem_map_t, it's by the time the device
driver needs some ram to do dma on it, that you alloc one page with
alloc_pages and you mark it reserved.

marking physical ram pages as reserved is only needed when you want to
make this page visible to userspace via ->mmap/mmap(2). if you only work
with copy_to_user/copy_from_user read(2)/write(2), nothing will change
if the page is reserved or not (same goes for the mmio areas part of the
mem_map_t array).

the PG_reserved plays a role by the time you map the page in userspace,
then a fork() won't copy-on-write, such a page will be shared, since
it's a special page that the hardware "owns", if you would copy-on-write
you couldn't talk with the device anymore on the copied page. After all
references to the device have been released, the release callback is run
by the vfs, so you know the page isn't mapped in userspace anymore and
if it's a ram page you can clear the PG_reserved and then free the page
(if you free the page w/o clearing PG_reserved first you'll leak memory
silenty).

Those regions normally are also marked VM_IO in the vma, to avoid ptrace
or rawio to mess with those dma pages, which isn't guaranteed to be safe
and could lockup the bus.

> What about iomemory?

iomemory (i.e. MMIO) is not ram and normally it doesn't fit by mistake
in the mem_map_t array either, so if there's no page struct they can't
be marked reserved either. The vm will automatically recognize and
threat pages outside the mem_map_t as reserved.

ioremap is needed to access MMIO memory and it's a different matter.

not sure what's the reason of the question though. with regard to
suspend to disk you should probably use the original e820 map to find if
the reserved pages are ram or non ram, the reserved ram pages should
probably be saved/restored, however the saving/restore process should be
probably directed by the device driver owning those reserved ram pages
to be very safe (can suspend to disk be math safe at all? :). the non
ram pages shouldn't need to be saved/restored (as you found there's the
bios in there). Basically you've to differentiate between reserved ram
pages and reserved non-ram (marked as reserved just because their
physical address fits in the mem_map_t array).

I've seen in 2.6 there's a PG_nosave, but it seems to have a different
purpose than a "PG_ram" that tells you if the page is ram or not. From a
quick read of the code it seems all reserved pages are stored except the
ones in the nosave segment (which is also marked protected as part of
the static kernel .text). So in short it looks like we save/restore the
non-ram too, maybe it's ok, dunno but I would find it a lot safer not to
touch that non-ram.
