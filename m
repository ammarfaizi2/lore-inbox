Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSFSPfz>; Wed, 19 Jun 2002 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317912AbSFSPfy>; Wed, 19 Jun 2002 11:35:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53069 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317911AbSFSPfx>; Wed, 19 Jun 2002 11:35:53 -0400
Date: Wed, 19 Jun 2002 11:35:43 -0400
From: Doug Ledford <dledford@redhat.com>
To: Nick Papadonis <nick@coelacanth.com>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: AIC7XXX + v2.4.18 problems?
Message-ID: <20020619113543.A8854@redhat.com>
Mail-Followup-To: Nick Papadonis <nick@coelacanth.com>,
	linux-kernel@vger.kernel.org, gibbs@scsiguy.com
References: <m3k7ov2tly.fsf@noop.bombay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3k7ov2tly.fsf@noop.bombay>; from nick@coelacanth.com on Wed, Jun 19, 2002 at 11:09:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:09:13AM -0400, Nick Papadonis wrote:
> Is anyone else having problems with the AIC7XXX driver using a AHA-29160
> controller?  I believe my kernel is going into a unrecoverable spin-lock 
> when there is high SCSI load.  I'm assuming this because the keyboard 
> lights still function and network still replies to pings.

A spinlock deadlock causes the machine to be *totally* unresponsive (aka, 
no keyboard led changes and no pings) (at least, this is true of the scsi 
subsystem spinlocks).

> In addition the 'st' driver returns with unrecoverable errors when 
> trying to tar to tape.  This usually occurs after a few hundred 
> megabytes have been pushed through a device.

Hmmm...the tape drive isn't listed in your output below.

> My setup is :
>    - AHA-29160N controller
>    - Internal 50 PIN / SCSI-2 port in use
>    - See below for connected drives

It appears that you have the two hard drives connected to this 50 pin 
port.  That's not good.  The drives should be connected to the LVD port 
via a good LVD cable with LVD terminator, the CD-ROM should be on the 50 
pin port, and the tape (which I'm assuming is external and not a new LVD 
tape drive but an older narrow tape drive using a 50 pin connecter) should 
either be on the same cable as the CD-ROM (via an internal/external cable 
adapter) or on the 50pin port on the back of the card (but only if the 
port on the back of the card is not an LVD capable port, but is instead a 
SE port wired together with the internal 50 pin port).  Hooking them up 
the way you have them is asking for trouble because your high end disks 
are being forced to operate in a very degraded performance state.

> Channel A Target 0 Negotiation Settings
>         User: 40.000MB/s transfers (40.000MHz DT, offset 255)
>         Goal: 20.000MB/s transfers (20.000MHz, offset 31)
>         Curr: 20.000MB/s transfers (20.000MHz, offset 31)

See, disk 1 is being forced all the way fown to narrow, ultra speeds.

> Channel A Target 2 Negotiation Settings
>         User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
>         Goal: 20.000MB/s transfers (20.000MHz, offset 15)
>         Curr: 20.000MB/s transfers (20.000MHz, offset 15)

Same here, narrow ultra speeds.  Both of these disks should likely be 
running in wide ultra2 speeds or better (this second one might not do 
ultra2, I couldn't tell by the model number, but I suspect it does).

> Channel A Target 3 Negotiation Settings
>         User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
>         Goal: 40.000MB/s transfers (40.000MHz, offset 127)
>         Curr: 3.300MB/s transfers

Async transfers (the cd-rom).  This should *not* be on the same cable as 
the disks.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
