Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130535AbQKXX55>; Fri, 24 Nov 2000 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130566AbQKXX5q>; Fri, 24 Nov 2000 18:57:46 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:63969 "EHLO
        laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
        id <S130535AbQKXX52>; Fri, 24 Nov 2000 18:57:28 -0500
Date: Sat, 25 Nov 2000 00:28:23 +0100
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Address translation
Message-ID: <20001125002822.D2324@storm.local>
Mail-Followup-To: Bjorn Wesen <bjorn@sparta.lu.se>,
        Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001123212315.C4886@storm.local> <Pine.LNX.3.96.1001123214139.14437A-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1001123214139.14437A-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Thu, Nov 23, 2000 at 10:04:18PM +0100
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 10:04:18PM +0100, Bjorn Wesen wrote:
> On Thu, 23 Nov 2000, Andreas Bombe wrote:
> > > I may be wrong on this, but I thought that copy_{to,from}_user are
> > > only necessary if the address range you are accessing might cause a
> > > fault which Linux cannot handle (ie. one which would cause the
> > > application to segfault if it accessed that memory). If it is only a
> > 
> > It is wrong.  copy_*_user handle the page faults, whether they are good
> > faults (swapped out, copy on write) or bad faults (illegal access).
> > Without these macros you get the "unable to handle kernel page fault"
> > oops message if a fault occurs.
> 
> Yes but only if it's a real fault, not if the address range actually is
> a valid VMA which needs paging, COW'ing or related OS ops. copy_*_user
> does not do the access in any different way than a "manual" access or
> memcpy does, it just adds a .fixup section that tells the do_page_fault
> handler that it should not segfault the kernel itself if the copy takes a
> big fault at any point, instead it should jump to the fixup which makes
> the copy routine return an error message.

You're right, I remembered wrong.

> > >  (1) In a "top half" thread, can I now access this memory without the
> > >      access macros (since I know the address range is valid)?
> > 
> > The address is valid, the pages probably aren't.  In fact, extending the
> > address space only creates read-only mappings to the global zeroed page
> > if I remember right.
> 
> But it does not matter that the pages aren't there physically, any kind of
> access (including an access from kernel-mode) will bring about the same
> COW/change-on-write mechanism as copy_to_user or a user-mode access would.

However these faults can let you sleep (swap-in, or swap-out to make
room for a COW page).  That's defined for the uaccess macros, but might
come very unexpected with a memcpy.  Unexpected sleeps alone can make a
crash if the surrounding code does not allow it.

It's a moot point anyway, memcpy with user space is illegal.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
