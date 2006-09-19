Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWISSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWISSLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWISSLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:11:03 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:12950 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030290AbWISSLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:11:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=vDwk2jf4li7Rv5Jg8DHrHmJP1qnanmx4fypUyQouXJZAwLKP/ooEAvHsejniRGAMUZF4SkijxTfvOJ1UjNQT5NvXZpAhKAhsmGkqtGCx5Hiy1wyjque8U8mHQu+AzEevxFs0I6OSx4Sp3uo++DzwoLfGaTm2Xn/YwS+5ZxBVvlE=  ;
From: David Brownell <david-b@pacbell.net>
To: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [linux-usb-devel] [PATCH] USB: consolidate error values from EHCI, UHCI and OHCI _suspend()
Date: Tue, 19 Sep 2006 09:13:11 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, dbrownell@users.sourceforge.net,
       weissg@vienna.at, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0609190340310.9787@twin.jikos.cz> <200609181909.53498.david-b@pacbell.net> <Pine.LNX.4.64.0609191238030.26418@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0609191238030.26418@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190913.12563.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 September 2006 3:43 am, Jiri Kosina wrote:

> (by the way, EHCI and OHCI seem to have broken (read: missing) locking 
> when accessing the hcd->state. Should I fix it by per-hcd spinlock, or 
> does the patch already exist somewhere?)

They should only ever access it while holding their internal spinlocks;
which are held during most driver operations, easy to miss.  And except
for hardware faults, the HCD state changes only when usbcore pushes an
HCD through driver model state transitions like probe(), suspend(), and
their inverses.  I see some dodgey code in the OHCI IRQ handler, but
even that shouldn't make trouble.

Admittedly the usbcore access to that field is a bit problematic, since
it doesn't handle the hardware faulting cases very cleanly.  For those
cases, other problems are more severe ... like basic cleanup of all the
pending transactions, and removal of the usb devices, didn't work the
last time I tripped over such cases.


Eventually we want hcd->state to vanish, but until it does it sure seems
like a problem if usbcore can't rely on all HCDs to treat it the same.

- Dave
