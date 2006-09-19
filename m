Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWISOZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWISOZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWISOZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:25:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:6926 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964921AbWISOZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:25:16 -0400
Date: Tue, 19 Sep 2006 10:25:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jiri Kosina <jikos@jikos.cz>
cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       <dbrownell@users.sourceforge.net>, <weissg@vienna.at>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] USB: consolidate error values from
 EHCI, UHCI and OHCI _suspend()
In-Reply-To: <Pine.LNX.4.64.0609191238030.26418@twin.jikos.cz>
Message-ID: <Pine.LNX.4.44L0.0609191021140.6555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Jiri Kosina wrote:

> On Mon, 18 Sep 2006, David Brownell wrote:
> 
> > > EHCI, UHCI and OHCI USB host drivers are not consistent when returining 
> > > error values from their _suspend() functions, in case that the device is 
> > > not in suspended state. This could confuse users, so let all three of them 
> > > return -EBUSY.
> > Shouldn't you also update uhci_suspend()?  Currently it just ignores 
> > hcd->state ...
> 
> You are right that the patch is possibly not fully correct. I was trying 
> to fix the situation I was getting into with the bug in usb_resume_both() 
> (see my "[PATCH] 2.6.18-rc6-mm2 - usb_resume_both() - fix suspend/resume" 
> mail from yesterday), but now it is obvious that the EINVAL from UHCI is 
> of a "different kind" than EBUSY from OHCI and UHCI (though they are 
> triggered in the same situations -- when the previous resume was not done 
> correctly).

Sort of.  The real trigger is that the PM core tries to suspend the 
upper-level PCI device but the lower-level root-hub device has not been 
suspended.  You saw this occurring because during the previous resume, the 
root-hub device's power.power_state.event was not updated, causing the PM 
core to think the root hub was still suspended when in fact it wasn't.

> As far as I can see, the UHCI driver is, strangely enough, not using 
> hcd->state at all. 
> 
> (by the way, EHCI and OHCI seem to have broken (read: missing) locking 
> when accessing the hcd->state. Should I fix it by per-hcd spinlock, or 
> does the patch already exist somewhere?)

Believe it or not, these two paragraphs are closely connected.  The reason 
uhci-hcd doesn't use hcd->state at all is because there is no locking to 
protect it!

My feeling has long been that hcd->state deserves to disappear.  It tries 
to serve too many functions.  Please don't add any code in a futile 
attempt to preserve it.

Alan Stern

