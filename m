Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbTAJV6k>; Fri, 10 Jan 2003 16:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbTAJV6k>; Fri, 10 Jan 2003 16:58:40 -0500
Received: from almesberger.net ([63.105.73.239]:33808 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266417AbTAJV6j>; Fri, 10 Jan 2003 16:58:39 -0500
Date: Fri, 10 Jan 2003 19:07:06 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uaca@alumni.uv.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dveitch@unimelb.edu.au
Subject: Re: How much we can trust packet timestamping
Message-ID: <20030110190706.A6866@almesberger.net>
References: <20021230112838.GA928@pusa.informat.uv.es> <1041253743.13097.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041253743.13097.3.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 30, 2002 at 01:09:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The packet can be timestamped by the hardware receiving as well as by
> the kernel netif_rx code. This is actually intentional and there is
> hardware that supports doing IRQ raise time sampling which the driver
> can then use to get very accurate data.

By the way, the group of Darryl Veitch have done some extremely
interesting work with high-resolution timestamps, in particular
using the TSC on recent ia32:

http://www.cubinlab.ee.mu.oz.au/probing/
http://www.cubinlab.ee.mu.oz.au/~darryl/tscclock_final.pdf.gz

One general issue in this area is what we can do with time
sources that aren't system-wide, e.g. NIC-local timers. The
problem is to calibrate them and to synchronize them to
wall-clock time. I think there are basically two possible
approaches:

 1) driver gives time synchronization system (in user-space)
    access to "raw" running timer value. Timestamps are also
    "raw" timer values, plus a time source ID, which can then
    be used to convert the values to wall-clock time.

 2) user space pushes exact time to kernel space, which then
    does all the math. Timestamps are already converted to
    wall-clock time.

2) is essentially what we can do with today's interfaces (an
event notifier would be useful, though). The big drawback is
that non-trivial math would have to be done in kernel space.
1) is much easier on the kernel, but has the issue of
requiring some API to get time values and time source
characteristics (time representation, range, etc.).

I'm leaning towards solution 1), because it keeps things simple
for the kernel. But perhaps the best approach is to simply
implement both, and then compare ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
