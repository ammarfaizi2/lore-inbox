Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUCFIji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 03:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUCFIji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 03:39:38 -0500
Received: from palrel10.hp.com ([156.153.255.245]:20460 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261619AbUCFIje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 03:39:34 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16457.36414.613402.726173@napali.hpl.hp.com>
Date: Sat, 6 Mar 2004 00:39:26 -0800
To: davidm@hpl.hp.com
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <16457.31740.99944.563029@napali.hpl.hp.com>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
	<16457.26208.980359.82768@napali.hpl.hp.com>
	<16457.31740.99944.563029@napali.hpl.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 5 Mar 2004 23:21:32 -0800, David Mosberger <davidm@linux.hpl.hp.com> said:

  David>  (1) Start of Frame -> (2) update HccaFrameNumber -> (3)
  David> trigger SF interrupt

  David> Now, suppose you get a WDH interrupt between (1) and (2).
  David> You'd read the old frame-number yet by the time the interrupt
  David> from (3) arrives the HC might already be accessing the ED
  David> that you're about to remove.

Sorry for the monologue---trying to learn how this is all supposed to
work...

The OHCI spec says that HccaFrameNumber is updated in this fashion:

 (a) send Start-of-Frame
 (b) HccaFrameNumber <- HcFmNumber.StartingFrame
 (c) start processing ED (& post SF intr if requested)

Since start_ed_unlink() uses the following sequence:

 (1) ed->hwINFO |= ED_DEQUEUE
 (2) ed->tick = OHCI_FRAME_NO(ohci->hcca) + 1

Then as long as (1) is observed by the HC before (2) (which it should
be), the race I described isn't possible: if (2) read the "old"
frame-number, then the HC wouldn't have started step (c) yet and hence
the HC would observe step (1) and notice that the ED is being
dequeued.  Converseley, if the HC started to process the ED before (1)
completed (i.e., it missed the ED_DEQUEUE flag), then step (2) must
have been reading the the new frame-number.

OK, I see now the conundrum...

BTW: does the value 0xf0000000 bear any special meaning in USB?  We
already considered whether this would be a NULL-pointer after I/O MMU
translation but it is not: the I/O MMU window is at
0x40000000-0x80000000 on the machines in question.

	--david
