Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTJXTsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTJXTsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:48:31 -0400
Received: from neors.cat.cc.md.us ([204.153.79.3]:220 "EHLO
	student.ccbc.cc.md.us") by vger.kernel.org with ESMTP
	id S262558AbTJXTsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:48:22 -0400
Date: Fri, 24 Oct 2003 15:43:35 -0400 (EDT)
From: John R Moser <jmoser5@student.ccbc.cc.md.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Avoid Pagefaults -- Variable Size Pages
Message-ID: <Pine.A32.3.91.1031024153626.27840C-100000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this possible?

NOTATION

I use a notation for ram pages in here that may seem strange (it looks 
like a
stack actually).  Here's how it goes, briefly:

01234
[nXX]

{nXX,1} is 'n'

01234   -- Byte offset from the beginning of the page.  The pages I use 
in this
           document are usually 5 bytes wide.  The kernel usually uses 
4096
           byte wide pages on i386.
[nXX]   -- A page of RAM for process n.  It is order XX, meaning that 
when the
           complete chunk is put together, all XX from 0 to the max will 
be in
           numerical order.
{nXX,Y} -- Set notation to show page nXX position Y.



6~CURRENT

Current method of virtual RAM control:

01234
[A00]
[A01]
[A02]
[A03]

When going beyond {A00,4}, pagefault is incurred via an interrupt.  The
location of A01 is fetched, and {A01,0} is where ram read/write is picked 
up
at.  Going the other way, it will go back to {A00,0} as the left side of 
the
boundry.

This allows for things like:

01234
[A00]
[B01]
[A03]
[A02]
[B00]
[A01]

To happen.



DEFRAGMENTATION

What about:

01234
[A00]
[B01]
[A03]
[A02]
[B00]
[A01]
[xxx] <-- Free RAM

Having a fault going past {A00,4} causing the following:

01234
[A00]
[B01]
[A03]
[A02]
[B00]
[A01]
[xxx]

  V

01234
[A00]
[xxx]
[A03]
[A02]
[B00]
[A01]
[B01]

  V

01234
[A00]
[A01]
[A03]
[A02]
[B00]
[xxx]
[B01]

This would cause a decrease in fragmentation naturally.  Just keep a fair 
size
of free ram around, maybe 100 pages? (400k)  256 pages (1M) would be fine.



VARIABLE SIZE PAGES

(This is the part I'm sketchy on.  I'm not sure you can do this without
rewriting some CPU microcode.)

We could take it a step further and try to decrease pagefaults:

01234
[A00]
[A01]
[A03]
[A02]
[B00]
[xxx]
[B01]

  V

01234
[A00+
+A01]
[A03]
[A02]
[B00]
[xxx]
[B01]

Merging A00 and A01 into one large page.  Thus the diagram becomes:

0123456789
[A00-----]
[A02] (previously A03)
[A01] (previously A02)
[B00]
[xxx]
[B01]

And there is no fault until {A00,9} is passed.  Later, when part of A00 
needs
to be swapped out, it can be split:

0123456789
[A00-----]
[A02]
[A01]
[B00]
[xxx]
[B01]
SWAPFILE: [C00]

  V

0123456789
[A00]
[A01]
[A03] (was A02)
[A02] (was A01)
[B00]
[xxx]
[B01]
SWAPFILE: [C00]

  V

0123456789
[A00]
[xxx]
[A03]
[A02]
[B00]
[xxx]
[B01]
SWAPFILE: [C00][A01]

  V

0123456789
[A00]
[C00]
[A03]
[A02]
[B00]
[xxx]
[B01]
SWAPFILE: [xxx][A01]

Notice there's still a little free ram to play around with for defrag 
purposes.
The sudden overhead incurred when ram is out of order is worth it with the
right algorithms.

-----------------------------------------------------------------------

I'm unsure if TLB allows for this, or if it would be too expensive to do 
a VM implimentation without TLB.  The ideal situation would be that TLB
allows you to do this, OR that you could rewrite the TLB microcode.  The 
next best thing is a hybrid to not use TLB if you're using variable size 
pages.

In any case, the RAM defragmentation shouldn't be too expensive.  It's a 
prerequisite for variable size pages if you want to make pages larger on 
the fly due to usage patters, but will work without rewriting TLB 
probably.

If pagefaults could be decreased, applications might run faster since 
they don't need to run so much code to check where the hell RAM is that 
they need.  At least, I think they might.

--Bluefox Icy
