Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUCIR6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUCIR6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:58:43 -0500
Received: from palrel12.hp.com ([156.153.255.237]:59345 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261930AbUCIR6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:58:23 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16462.1463.686711.622754@napali.hpl.hp.com>
Date: Tue, 9 Mar 2004 09:58:15 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Grant Grundler <iod00d@hp.com>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404E00B5.5060603@pacbell.net>
References: <20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
	<16457.26208.980359.82768@napali.hpl.hp.com>
	<4049FE57.2060809@pacbell.net>
	<20040308061802.GA25960@cup.hp.com>
	<16460.49761.482020.911821@napali.hpl.hp.com>
	<404CEA36.2000903@pacbell.net>
	<16461.35657.188807.501072@napali.hpl.hp.com>
	<404E00B5.5060603@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 09 Mar 2004 09:36:53 -0800, David Brownell <david-b@pacbell.net> said:

  David.B> David Mosberger wrote:
  >> How about something along the following lines?  The patch is
  >> relative to 2.6.4-rc1.  What it does is add a new state
  >> ED_DESCHEDULED, which is treated exactly like ED_IDLE, except
  >> that in this state, the HC may still be referring to the ED in
  >> question.  Thus, if

  David.B> Sounds exactly like ED_UNLINK -- except maybe that it's not
  David.B> been put onto ed_rm_list (with ED_DEQUEUE set).

  David.B> Why add another state?

So you can tell them apart.  See ohci_endpoint_disable().

You seem to think small races are OK.  I disagree.  The smaller the
race, the harder it is to debug (and yes, it _will_ bite you
eventually).  With my patch, you're _guaranteed_ that ED_IDLE means
the HC doesn't refer to the ED anymore so you can free the memory and
do whatever you want without worry about potentially causing the HC to
do something bad.

  David.B> But some parts worry me.  Like changing that code to BUG()
  David.B> on a driver behavior that's perfectly reasonable;

With my patch, the only reason you enter ED_UNLINK state is
ohci_endpoint_disable().  If you try to ohci_urb_enqueue() on an ED in
this state, it will fail, so I don't there is a problem (I see now
that I forgot to set the error-code for this case, that's obviously
something that needs to be fixed).  But perhaps you had different
semantics in mind for ED_UNLINK?

  David.B> removing some of the PCI posting, which makes it easier for
  David.B> the HC and its driver to disagree about schedule status.

Meaning what?  Please explain what sequence of events would cause
problems that could be solved by flushing the posted writes.  AFAICT,
the flushes are just expensive NO-OPs in this particular case.

	--david
