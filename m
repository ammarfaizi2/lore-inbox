Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267416AbSLETz5>; Thu, 5 Dec 2002 14:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbSLETz5>; Thu, 5 Dec 2002 14:55:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:410 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267416AbSLETzf>;
	Thu, 5 Dec 2002 14:55:35 -0500
Message-ID: <3DEFB0EB.9893DB9@digeo.com>
Date: Thu, 05 Dec 2002 12:02:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2002 20:02:54.0999 (UTC) FILETIME=[4CAADA70:01C29C99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> Hi Andrew,
> 
> On Wed, Dec 04, 2002 at 08:32:58PM -0800, Andrew Morton wrote:
> > Where in the kernel is such a large number of 4-, 8- or 16-byte
> > objects being used?
> 
> Well, kernel objects may not be that small, but one would expect
> the per-cpu parts of the kernel objects to be sometimes small, often down to
> a couple of counters counting statistics.

Sorry, "one would expect" is not sufficient grounds for incorporation of
a new allocator.  As far as I can tell, all the proposed users are in
fact allocating decent-sized aggregates, and that will remain the usual
case.

The code exists, great.  We can pull it in when there is a demonstrated
need for it.  But until that need is shown, this is overdesign.

> >
> > The slab allocator will support caches right down to 1024 x 4-byte
> > objects per page.  Why is that not appropriate?
> 
> Well, if you allocated 4-byte objects directly from the slab allocator,
> you aren't guranteed to *not* share a cache line with another object
> modified by a different cpu.

If that's a problem it can be addressed in the slab head arrays - make
sure that they are always filled and emptied in multiple-of-cacheline-sized
units for objects which are smaller than a cacheline.  That benefits all
slab users.
 
> >
> > Sorry, but you have what is basically a brand new allocator in
> > there, and we need a very good reason for including it.  I'd like
> > to know what that reason is, please.
> 
> The reason is concern about per-cpu allocation for small per-CPU
> parts (typically counters) of objects. If a driver has two counters
> counting reads and writes, you don't want to eat up a whole cacheline
> for them for each CPU per instance of the device.
> 

I don't buy it.

- If the driver has two counters per device then the storage is
  infinitesimal.

- If it has multiple counters per device (always the case) then
  the driver will aggregate them anyway.

I am not aware of any situations in which a driver has a large
(or even medium) number of small, discrete counters of this nature.
Sufficiently large to justify a new allocator.

I'd suggest that you drop the new allocator until a compelling
need for it (in real, live 2.5/2.6 code) has been demonstrated.
