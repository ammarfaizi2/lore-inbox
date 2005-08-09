Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVHIRvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVHIRvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVHIRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:51:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47262 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932561AbVHIRvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:51:10 -0400
Date: Tue, 9 Aug 2005 10:51:08 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>,
       mark.gross@intel.com
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Message-ID: <20050809175108.GB2766@us.ibm.com>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <200507061414.48764.mgross@linux.intel.com> <200508080835.12431.mgross@linux.intel.com> <200508090956.27686.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200508090956.27686.mgross@linux.intel.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2005 [09:56:27 -0700], Mark Gross wrote:
> On Monday 08 August 2005 08:35, Mark Gross wrote:
> > On Wednesday 06 July 2005 14:14, Mark Gross wrote:
> > > On Wednesday 22 June 2005 08:12, Bouchard, Sebastien wrote:
> > > > Hi,
> > > >
> > > > Here is a driver (only for 2.4.x) I've done to provide support
> > > > of a hardware module (available on some ATCA board) used with
> > > > telecom expension card on the new ATCA platform. This module
> > > > provide redundant reference clock for telecom hardware with
> > > > alarm handling when there is a new event (ex.: one of the ref
> > > > clock is gone).  This char driver provide IOCTL for
> > > > configuration of this module and interrupt handler for
> > > > processing alarm events.
> > > >
> > > > I send this driver so people in this mailing list can do a
> > > > review of the code.
> > > >
> > > > Please reply me directly to my email, i'm not subscribed to the
> > > > mailing list.
> > > >
> > > > Thanks
> > > > Sebastien Bouchard
> > > > Software designer
> > > > Kontron Canada Inc.
> > > > <mailto:sebastien.bouchard@ca.kontron.com>
> > > > <http://www.kontron.com/>
> > > 
> > > I'm helping out a bit with the maintaining of this driver for
> > > Sebastien.   The following is a 2.6.12 port of Sebastien's 2.4
> > > driver.  
> > > 
> > > --mgross
> > 
> > The following is an update to the earlier 2.6 driver that uses a
> > sysfs interface to implement the IOCTL functions.  I put the
> > attributes under /sys/class/misc/tlclk.
> > 
> > I can't say I'm a believer in the "goodness" of using sysfs over the
> > IOCTL's, as it added quite a bit of code bloat to this driver, but
> > hay it should work well enough anyway.
> > 
> > Also, note this device, is accessed / controlled via the FPGA on the
> > ATCA, its function is to synchronize signaling hardware across
> > blades in an ATCA Chassis.  It tends to not talk to the OS. 
> > 
> > Please tell me what you think :)
> Again but with email word wrap turned off :(
> Also fixes my miss use of kcalloc parameter list.

<snip>

> diff -urN -X dontdiff linux-2.6.12.3/drivers/char/tlclk.c linux-2.6.12.3-tlclk/drivers/char/tlclk.c
> --- linux-2.6.12.3/drivers/char/tlclk.c 1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.12.3-tlclk/drivers/char/tlclk.c 2005-08-09 09:37:58.000000000 -0700

<snip>

> +irqreturn_t tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs)

<snip>

> +  switchover_timer.expires = jiffies + 1; /* TIMEOUT in ~10ms */

This is not a 10 millisecond timeout, it is a 1 jiffy timeout. Yes, in
2.4, where HZ=100 by default, or in 2.6 with CONFIG_HZ set to 100, that
corresponds to 10 millseconds (or so ;), but not with HZ=250 or 1000. I
think you want:

switchover_timer.expires = jiffies + msecs_to_jiffies(10);

which will handle rounding correctly.

Also, consider using TIMER_INITIALIZER() for setting these timer fields.

<snip>

Thanks,
Nish
