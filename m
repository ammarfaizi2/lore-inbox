Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWKBXZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWKBXZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWKBXZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:25:10 -0500
Received: from hera.kernel.org ([140.211.167.34]:44723 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751010AbWKBXZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:25:08 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Can Linux live without DMA zone?
Date: Thu, 2 Nov 2006 15:24:33 -0800
Organization: OSDL
Message-ID: <20061102152433.1c01faad@freekitty>
References: <20061102021547.GA1240@srv.junsun.net>
	<454A1D82.7040709@cfl.rr.com>
	<1162486642.14530.64.camel@laptopd505.fenrus.org>
	<454A4237.90106@cfl.rr.com>
	<1162498205.14530.83.camel@laptopd505.fenrus.org>
	<454A627C.1090104@cfl.rr.com>
	<1162505945.14530.98.camel@laptopd505.fenrus.org>
	<20061102231715.GA10902@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1162509875 20564 10.8.0.54 (2 Nov 2006 23:24:35 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 2 Nov 2006 23:24:35 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 15:17:15 -0800
Jun Sun <jsun@junsun.net> wrote:

> On Thu, Nov 02, 2006 at 11:19:05PM +0100, Arjan van de Ven wrote:
> > On Thu, 2006-11-02 at 16:26 -0500, Phillip Susi wrote:
> > > Arjan van de Ven wrote:
> > > > that's for the 32 bit boundary. THe problem is that there are 31, 30, 28
> > > > and 26 bit devices as well, and those are in more trouble, and will
> > > > eventually fall back to GFP_DMA (inside the x86 PCI code; the driver
> > > > just uses the pci dma allocation routines) if they can't get suitable
> > > > memory otherwise....
> > > > 
> > > > It's all nice in theory. But then there is the reality that not all
> > > > devices are nice pci device that implement the entire spec;)
> > > > 
> > > 
> > > Right, but doesn't the bounce/allocation routine take as a parameter the 
> > > limit that the device can handle?  If the device can handle 28 bit 
> > > addresses, then the kernel should not limit it to only 24 bits.
> > 
> > you're right in theory, but the kernel only has a few pools of memory
> > available, but not at every bit boundary. there is a 32 bit pool
> > (GFP_DMA32) on some, a 30-ish bit pool (GFP_KERNEL) on others, and a 24
> > bit pool (GFP_DMA) with basically nothing inbetween.
> >
> 
> Perhaps a better solution is to 
> 
> 1. get rid of DMA zone
> 
> 2. have another alloc funciton (e.g., kmalloc_range()) which takes an
>    extra pair of parameters to indicate the desired range for the
>    allocated memory.  Most DMA buffers are allocated during start-up.
>    So the alloc operations should generally be successful.
> 

Network devices don't allocate buffer until they are brought up.
By then a lot of memory allocation has happened.  You could add an
interface that allows a device to say:
	kmalloc_range_intent(unsigned long mask, unsigned count, unsigned size)
to cause reservation before use.

-- 
Stephen Hemminger <shemminger@osdl.org>
