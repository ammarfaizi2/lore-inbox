Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279589AbRKRWiv>; Sun, 18 Nov 2001 17:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279603AbRKRWil>; Sun, 18 Nov 2001 17:38:41 -0500
Received: from rly-ip01.mx.aol.com ([205.188.156.49]:13297 "EHLO
	rly-ip01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S279589AbRKRWi2>; Sun, 18 Nov 2001 17:38:28 -0500
Message-ID: <3BF837F9.C7424E5C@cs.com>
Date: Sun, 18 Nov 2001 15:36:41 -0700
From: Charles Marslett <cmarslett9@cs.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,zh-TW,ja
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: James A Sutherland <jas88@cam.ac.uk>, war <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <E165ZRi-000718-00@mauve.csi.cam.ac.uk> <20011118230540.A2042@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Apparently-From: Cimarslett@cs.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> On 20011118 James A Sutherland wrote:
> >On Sunday 18 November 2001 9:12 pm, war wrote:
> >> It is amazing that I could run all of that stuff, because:
> >>
> >> When I have swap on, and if I run all of those programs, 200-400MB of
> >> swap is used.
> >
> >Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out
> >to disk - even without "swap space". Disabling swapspace simply forces the
> >kernel to swap out more code, since it cannot swap out any data.
> 
> Sure ??? Where ?? What disk space uses it to swap pages to ?

The code is "swapped" to the original file it was loaded from.  You just
free up the pages for someone else to use until you get a page fault in that
task, then reload it from the original executable.  That may have something
to do with the fact that he gets better performance without a swap file allocated,
since code swaps never write, only read (half as much disk I/O).  I could see
some workloads that essentially use every bit of data all the time, and swapping
code only is an optimization.  Nothing I've ever profiled worked that way,
though.  And I thought even in this case the system would tend to swap code
in preference to dirty data (I have to go back and look at the code to say
for sure, though).

> >(This is why you can still get "disk thrashing" without any swap - in fact,
> >it's more likely in this case than it is with some swap added - you are just
> >forcing your binaries to take more of the swapping load instead.)
> >
> 
> You get thrashing because you don have anything cached. So you can get a point
> (fill all your space with apps and data) where each file read is _REALLY_ a
> disk read, not just a transfer from cache (that is what usually happens).

But that would never run faster than enabling the cache (unless the cache code
was competitive with Microsoft's).

> >So: with swapspace, the kernel swaps out a few hundred Mb of unused data, to
> >make room for more code. Without it, the kernel is forced to swap out code
> >pages instead. The big news here is...?
> >
> 
> You swap out pages, not data or code. Kernel does not care if the page contains
> code or data. Try (on a swap enabled box) this: open mozilla or staroffice (a
> big gui app), let it open and don't use it, fill your ram with other apps and
> try to pull down a menu from mozilla. It has an unusual delay, the time to get
> mozilla CODE pages back from swap. That is why a system with no swap is more
> responsive.

Check out the thread entitled "Executing binaries on new filesystem" -- they talk
quite a bit about mmap() and how it is used in loading code space.  You are right
about swapping out pages, not data or code, but the pages are written only if
they are dirty.  A page that is not dirty does not need to be written to be swapped
out, and code pages are almost never dirty (I think).  So they can be "swapped" out
without any place to write them, unlike data pages that have anything but zeros
in them.

> Yes, a box without swap runs faster, but if you *don't do anything* with it. The test
> shown in previous mails had a ton of apps opened *doing nothing*. Try do do
> a grep several times on the kernel source tree for example in that scenario.
> Or a kernel build. They will be dog slow (all the tries). Try the same on
> a box with swap, the second time much things are cached and it flies.

Ah!  This may well be the explanation for the apparent performance boost.  Now I'm
really interested in digging into the paging algorithms....

> --
> J.A. Magallon                           #  Let the source be with you...
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.15-pre6-beo #1 SMP Sun Nov 18 10:25:01 CET 2001 i686

--Charles
