Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965505AbWJBXAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965505AbWJBXAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965508AbWJBXAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:00:30 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:16821 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965505AbWJBXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:00:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=03ASqeWmfBP3VuP5+cEq04hkSpk7BqCR6DaGwSduYi5T4x/m/qH15stsK+C6gDEYmQI9j44/T5oWP93P+G1E6WEetl0GiZRRDC7R22izx0ljEYgrt6th532BX1H5sxpeQR2hgRTXirNhBhCMcc1lC24FpchwbQiEkKUBRvrtsNo=  ;
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Mon, 2 Oct 2006 16:00:22 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0610021729490.8219-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610021729490.8219-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021600.24477.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 2:34 pm, Alan Stern wrote:
> On Mon, 2 Oct 2006, David Brownell wrote:
> 
> > > >  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
> > > >      something different depending on whether it's been supplied with a regs
> > > >      pointer or not.
> > 
> > gaak!  where did that come from?  I'll be surprised if removing
> > that causes any problem at all.
> 
> Here's the statement in question:
> 
> 	if (likely (regs && HC_IS_RUNNING(ohci_to_hcd(ohci)->state))) {

Where as I said, removing the "regs &&" should be just fine.
(Is the plan that David Howells re-issue that patch?  If so, I'l
expect e will just fix it that way...)

> 		...
> 
> Notice another questionable use of hcd->state. 

Questionable in what way?  When that code is called to clean up
after driver death, that loop must be ignored ... every pending I/O
can safely be scrubbed.  That's the main point of that particular
HC_IS_RUNNING() test.  In other cases, it's essential not to touch
DMA queue entries that the host controller is still using.

- Dave

