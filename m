Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTDLWPQ (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTDLWPQ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:15:16 -0400
Received: from fmr02.intel.com ([192.55.52.25]:15046 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263398AbTDLWPO convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 18:15:14 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAB47@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev
Date: Sat, 12 Apr 2003 15:26:59 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Tim Hockin [mailto:thockin@hockin.org]
> 
> > The idea of allowing multiple readers was so you can have other actors
> > listening for stuff - although the main one would always be the event
> > daemon (that could even forward the events).
> 
> multiple readers complicates things - look at how acpi does

It didn't do too much [unless I grossly missed anything].

> /proc/acpi/events (or at least glance at it).  One reader, pertial-reads
are
> OK, Poll is supported.  ACPId opens the file and accepts UNIX domain

Poll is not supported right now because I didn't know how to do
it and I didn't have time to investigate (this was a quickie 
hack). Same thing w/ UNIX domain socket - also I wanted to avoid
sockets because I considered it could be done with simple reads
(thus, if for whatever reason you don't compile sockets, you
don't need to make it more complex - this is also the reason
to force reading whole messages and having the length in the
header - it's a poor's man rcvmsg()).

Partial reads are what really complicates the stuff - I didn't see
a point in supporting them because events are supposed to be kind
of limited in size, not a huge thing; I don't think there are too
many cases where you provide a buffer smaller than say, 256 bytes.

And then, providing small buffers is also kind of underperforming;
you want to maximize how much events you get in a single shot per
system call, to minimize the system call overhead - that means a
bigger buffer; your granularity in time is what will determine it.

> Realistically, what you are trying to do has been done for ACPI already.
> Just devise a more generic event struct, and put it in a generic sysfs
file,
> and then convince people to use it.

And the event struct is generic enough. That's why the data[] thing is
there - you include the message format you want: ascii, binary, name it.

What gets propagate to user space is a four byte size and then
the stuff you asked to have delivered. How can it be more generic
on the format realm?

> If there is an FS for this, it's a better way to split subsystemic events
so
> the same event file doesn't become very busy (possibly).

This would not be difficult to do - however, I see a little bit
overkill to have a filesystem for it when the files could be
plugged into, for example /sysfs [add to my stuff a declare message
queue, and export it in /sysfs as a file] - Will look into that
ASAP.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
