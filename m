Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUCJSHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUCJSFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:05:30 -0500
Received: from palrel13.hp.com ([156.153.255.238]:52176 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262751AbUCJSEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:04:42 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16463.22710.230252.777998@napali.hpl.hp.com>
Date: Wed, 10 Mar 2004 10:04:38 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Grant Grundler <iod00d@hp.com>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404F40C2.3080003@pacbell.net>
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
	<16462.1463.686711.622754@napali.hpl.hp.com>
	<404E2B98.6080901@pacbell.net>
	<16462.48341.393442.583311@napali.hpl.hp.com>
	<404F40C2.3080003@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 10 Mar 2004 08:22:26 -0800, David Brownell <david-b@pacbell.net> said:

  David.B> It won't add new BUG_ON calls (WARN at worst)

I put them there mostly as assertions.  What I'd really want there is
a DEBUG_BUG_ON, which is more like assert() in user-land (i.e.,
production code would drop the checks).  WARN_ON() would be fine, too.

  >> The current OHCI relies on the internals of the dma_pool()
  >> implementation.  If the implementation changed to, say, modify
  >> the memory that is free or, heaven forbid, return the memory to
  >> the kernel, you'd get _extremely_ difficult to track down race
  >> conditions.

  David.B> It'd be good if you said _how_ you think it relies on such
  David.B> internals.

I thought I did.  Suppose somebody changed the dma_pool code such that
it would overwrite freed memory with an 0xf00000000000000 pattern.  If
the HC can still hold a reference to a freed ED (it can without my
patch), the HC could see this kind of ED:

 hw=(info=00000000 tailp=f0000000 headp=00000000 nextED=f0000000)

If so, the HC would go ahead and try to interpret the memory at
address 0 as a transfer descriptor.  Depending on the memory contents,
this could cause silent data corruption at an arbitrary address.

  >> - thus you might get a case where hwTailP is 0 but hwHeadP is
  >> non-zero, which would cause the HC to happily start dereferencing
  >> the descriptor

  David.B> If you assume a bug where the ED is freed but still in use,
  David.B> that's hardly the only thing that'd go wrong!!  You can't
  David.B> use such a potential bug to prove something else is broken.

You lost me here.  All I'm saying is that the current code has a
dangerous race that can corrupt memory, crash machines, or have all
sorts of other wild side-effects.  I never claimed this bug had
anything todo with the BTC keyboard problem.

	--david
