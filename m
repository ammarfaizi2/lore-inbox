Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTDMDNF (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbTDMDNF (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:13:05 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56011 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263131AbTDMDND convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:13:03 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAB5E@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Tim Hockin'" <thockin@hockin.org>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev
Date: Sat, 12 Apr 2003 20:24:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Tim Hockin [mailto:thockin@hockin.org]
> 
> > > multiple readers complicates things - look at how acpi does
> >
> > It didn't do too much [unless I grossly missed anything].
> 
> My point was - you don't need to complicate the kernel code with multiple
> readers.  One reader, let userspace deal with multiple readers.  Of
course,
> ACPI throws events away, if there is no reader.

That to some extent makes sense, but then you loose the stuff
that arrived before you start the daemon; it is easy to make
that configurable.

> > don't need to make it more complex - this is also the reason
> > to force reading whole messages and having the length in the
> > header - it's a poor's man rcvmsg()).
> 
> except you're layering it on read() which has very different semantics.
If

It does - however, that is the price to pay to not be dependent
on the socket interface (so you can skip if for example, you
have some system that does not require it).

> I read(1) should I get back a 0-length read or a special ERRNO?  

Hmm, ok, right now I am returning -EFBIG - but you are right, it makes
sense to be able to at least get the size. Now that I think about it,
it should not be too difficult to add an offset by the kue_fd structure
that stores what was the last offset that was read of the current
message, and once you read it all, it advances to the next one - in
the same style, it'd be easy to make that configurable.

> if I want
> to read the length, then read the buffer, how do I?

Simple answer right now is to double the buffer, try again, but
as I said above, it is kind of counterproductive ...

What about this?: If you read less than the next message's full 
size, you get -EFBIG but as much data as buffer is provided is 
copied, and until you provide a buffer big enough for holding the 
whole message, it doesn't consider it read and moves along.

This way you can get the size [by reading the first four bytes].
And it does not make the code more complex [as would do the first
option I suggested].

Or forget -EFBIG - you get the actual length you asked for, but
the read msg pointer only advances when you read the whole msg
in a single shot.

> > And then, providing small buffers is also kind of underperforming;
> > you want to maximize how much events you get in a single shot per
> > system call, to minimize the system call overhead - that means a
> > bigger buffer; your granularity in time is what will determine it.
> 
> Another difference of opinion - you should never deliver more than one
event
> - regardless of how much you have read.

My point here is efficiency - I think it makes sense to assume that
you can get a good rate of msg/second in depending what kind of 
loads (imagine, for example, for network packet inspection), so reading
them all in a single shot instead of one by one is more efficient.
Especially when they are all small messages.

> > plugged into, for example /sysfs [add to my stuff a declare message
> > queue, and export it in /sysfs as a file] - Will look into that
> 
> yeah, sysfs is becoming procfs - just throw everything in there.
> 
> There also exists netlink which does multiple readers in a packetized
format
> already.  It's not too bad.

Need to take a look into that.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
