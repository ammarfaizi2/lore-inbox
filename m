Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbRBQVFB>; Sat, 17 Feb 2001 16:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131634AbRBQVEw>; Sat, 17 Feb 2001 16:04:52 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:9146 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131507AbRBQVEi>; Sat, 17 Feb 2001 16:04:38 -0500
Message-ID: <3A8EE698.8C96413F@sympatico.ca>
Date: Sat, 17 Feb 2001 16:01:12 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multi-sized MMU page support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have been staying up late thinking about this, so I'm writing to clear
my head.
(and get some sleep in the future)

Background:

Under ia32 Pentium and higher, 3 different MMU page sizes are
available in hardware: 4kB, 4MB & 2MB.  Under Alpha (21064), sizes
include 8kB, 4MB for code, 8kB, 64kB, 512kB, and 4MB.  Under ia64,
sizes range (in powers of two) from 4kB to 256MB.

Significance:  a number of important architectures support multi-sized
pages.  For applications with large contiguous code and/or data objects,

this enhanced hardware allows a performance increase.  A prerequisite
for using these features is kernel support.

I am unaware of what order of improvement this will allow, but I can
immagine
the pipeline stalls caused on TLB misses: examples: gimp lightens an
entire 64MB image;
a linear scan read-modify-write.  This access pattern isn't *so* bad.
The X server mmaps a 32MB area (3dfx) or larger of the video card for
linear frame
buffer/mmio and accesses it in a slightly less that random fashion.
 This could benefit much more from
larger pages.  Note that this is completely different that MTRR
support.  Also consider
that the TLB cache must be flushed and reloaded frequently durring
context switches
under an OS with separate memory areas for each process.  The larger the
pages, the
fewer entries which must be reloaded.

Also, not completely unrelated are comments in the kernel 2.3.? slab
allocator
regarding the inabliity of the zoned-buddy allocator to provide more
than
single (or trivially larger) pages for slab-cache.  The code which would

request larger pages when it would be more optimal to do so is commented

with 1's hardcoded instead.

Proposed implementation:

Short term:  allow a special (temporary) mmap argument or syscall and
support
in fault handlers/page table routines, to allow mmap or non-ram areas
with larger
sized pages.  the X server could uses this immediately by adding the
call alongside
the MTRR setting.  This avoids swap / mmaped file issues.

Long term: extend the zoned-buddy allocator to include buddy-lists
up to the largest hardware page size;  page table and fault handlers,
swap code, etc; massive work just for UP.  user-space code
could mmap ANON and get an aligned 4MB area using a single hardware
page...

Egad man! or "stop the madness"?

