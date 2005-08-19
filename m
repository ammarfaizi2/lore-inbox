Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbVHSVz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVHSVz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbVHSVz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:55:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31958 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932725AbVHSVz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:55:58 -0400
Date: Fri, 19 Aug 2005 16:55:52 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/2] external interrupts
Message-ID: <20050819160716.U87000@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a set of patches that implements an external interrupt capability
in Linux, along with a device driver for a specific hardware device.  I
submitted the patches several weeks ago, and they drew no comments, which
I take to be a good sign.  Anyway, I'm hoping these can be picked up for
-mm in time for 2.6.14.

External interrupts, in short, encompass the ability to respond quickly
via an interrupt routine to an externally applied voltage signal.  This
finds use primarily in real time systems which must react to an event
generated outside the computer.  External interrupts also encompass
the ability to generate such signals in order to notify other computer
systems (or even the same system, depending on cabling and configuration)
of an event of interest.  This is explained in greater detail in the
Documentation/extint.txt and Documentation/sgi-ioc4.txt files which are
part of these patches.

The first patch implements an abstraction layer which creates a sysfs
class "extint".  This class provides device control via several (hopefully)
common attributes of an external interrupt device.  For example, an
application can control the source of ingested interrupts if multiple
input jacks are present on the specific hardware, or control the output
waveform and repetition period on the output side.  Mechanisms are
provided to allow a low-level driver to enumerate these capabilities
where appropriate.

This first patch is motivated by several factors.  The first is a clean
seperation of device-specific knowledge from the more general concept, thus
isolating applications from needing to be aware of device characteristics.
The second is the simplification of low-level external interrupt drivers
by centralizing the common factors (e.g. a global counter, a list of
actions to invoke at each interrupt, etc) in the abstraction layer.
Finally, it enables easy support for additional or alternative low-level
(i.e. device-specific) external interrupt drivers in the future.

The second patch implements the low-level external interrupt driver for
the SGI IOC4 I/O controller chip.  For the most part this driver simply
registers itself with the extint abstraction layer, and of course takes
care of all the hardware bit-twiddling to effect appropriate operation.
In addition, this driver provides its own character special device which
can be mmap'd directly into the user address space.  This provides the
ability to control interrupt output generation without going through
the abstraction layer's sysfs attribute's read/write routines by directly
poking values in the appropriate hardware register (which lives in its
own page of memory seperate from all others).  This capability enables
the application to more expediently generate output where this bit of
overhead might matter (remember, this is typically used in real time
or near real time systems).

I do realize this whole thing is slightly overengineered if only to enable
the IOC4 device's external interrupt capability.  However, like all
hardware, someday IOC4 will be a long-forgotten memory, and SGI (me in
particular) would like to put a suitable mechanism in place to enable
different types of hardware with similar capabilities in the future.
Hopefully any interested third-party hardware vendors will add their
own low-level external interrupt drivers.

And while I mentioned real time as the primary application of external
interrupts, I'm sure there are other creative uses to be found.  My
imagination, however, is limited. :)

Thanks,
Brent Casavant

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
