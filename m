Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbTEONem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTEONem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:34:42 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:14382 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264010AbTEONel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:34:41 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053006338.2025.13.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 08:45:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 15:52, Alan Stern wrote:
> Below is a patch that addresses both of the issues raised in this thread.  
> The delay time is moved out of the interrupt handler, and the
> wakeup/suspend transitions are de-bounced.  To do this, I needed to add a
> mildly elaborate state mechanism.  State transitions are polled during the
> stall-timer callback.
> 
> There is no protection against simultaneous access from multiple threads,
> such as a PCI suspend occurring at the same time as a normal suspend or
> resume.  The original driver didn't have any either; it's probably not
> worth worrying too much about.  The patch works okay on my system.  Try it
> and see how it works on yours.
> 
> Johannes, please look over this code and verify that I haven't screwed 
> anything up.
> 
> Alan Stern

I tested the patch, and it solves the IRQ latency problems by moving
the delay outside of the ISR. The debouncing period reduces the
rate of thrashing back and forth between wake and suspend, but
the cycle does continue forever:

May 15 08:27:27 diemos kernel: suspend_hc():UHCI_RUNNING_GRACE
May 15 08:27:27 diemos kernel: suspend_hc():UHCI_RUNNING
May 15 08:27:28 diemos kernel: suspend_hc():UHCI_SUSPENDING_GRACE
May 15 08:27:28 diemos kernel: wakeup_hc():UHCI_SUSPENDED
May 15 08:27:28 diemos kernel: wakeup_hc():UHCI_RESUMING_1
May 15 08:27:28 diemos kernel: suspend_hc():UHCI_RESUMING_2
May 15 08:27:29 diemos kernel: suspend_hc():UHCI_RUNNING_GRACE
May 15 08:27:29 diemos kernel: suspend_hc():UHCI_RUNNING
May 15 08:27:30 diemos kernel: suspend_hc():UHCI_SUSPENDING_GRACE
May 15 08:27:30 diemos kernel: wakeup_hc():UHCI_SUSPENDED
May 15 08:27:30 diemos kernel: wakeup_hc():UHCI_RESUMING_1
May 15 08:27:30 diemos kernel: suspend_hc():UHCI_RESUMING_2
May 15 08:27:31 diemos kernel: suspend_hc():UHCI_RUNNING_GRACE

This patch removes my complaint, but I do wonder why this
unused controller continually generates the USBSTS_RD
indications. I would hope HP used pull-ups/downs on unused
input signals of the PIIX3 chipset, but maybe not.

I also can't vouch for the correct operation of this patch
for fully functional USB implementations.

If you have other tests you want me to do to try and figure
out a sane way of dealing with such unused controllers,
just ask.

Thanks,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


