Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTEOVTB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264249AbTEOVTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:19:01 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:1104 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264242AbTEOVS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:18:59 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305151709120.1125-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305151709120.1125-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053034205.2025.3.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 16:30:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 16:13, Alan Stern wrote:
> My intention was to avoid resuming if the resume-detect bit is set only 
> on ports in an over-current condition, since that is the case mentioned in 
> the erratum.  Of course, this isn't as failsafe as your suggestion.  Which 
> do you think would work better?

This should be caught on the suspend side so
that you can still service the ports that do not
have the over current condition.

A single port in OC makes resume unreliable,
so the only thing to do is not suspend.

The following worked for me:

static int suspend_allowed(struct uhci_hcd *uhci)
{
	unsigned int io_addr = uhci->io_addr;
	int i;

	if (!uhci->hcd.pdev ||
	    (uhci->hcd.pdev->vendor != PCI_VENDOR_ID_INTEL) ||
	    (uhci->hcd.pdev->device != PCI_DEVICE_ID_INTEL_82371AB_2))
		return 1;

	/* This is a 82371AB/EB/MB USB controller which has a bug that
	 * causes false resume indications if any port has an
	 * over current condition. If we do a global suspend then
	 * the controller thrashes back and forth between suspend and wakeup.
	 *
	 * Some motherboards using the 82371AB/EB/MB (but not the USB portion)
	 * appear to hardwire the over current inputs active to disable
	 * the USB ports..
	 */

	/* check for over current condition on all ports */
	for (i = 0; i < uhci->rh_numports; i++) {
		if (inw(io_addr + USBPORTSC1 + i * 2) & 0x0400)
			return 0;
	}

	return 1;
}

static void suspend_hc(struct uhci_hcd *uhci)
{
	unsigned int io_addr = uhci->io_addr;

	if (!suspend_allowed(uhci))
		return;




-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


