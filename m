Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266472AbUHPXmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUHPXmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUHPXmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:42:18 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37894 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266472AbUHPXmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:42:12 -0400
Date: Tue, 17 Aug 2004 01:42:10 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Oliver Feiler <kiza@gmx.net>
Cc: Len Brown <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: eth*: transmit timed out since .27
In-Reply-To: <41213D66.1010909@gmx.net>
Message-ID: <Pine.LNX.4.58L.0408170125320.18978@blysk.ds.pg.gda.pl>
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
  <1092678734.23057.18.camel@dhcppc4> <41210098.4080904@gmx.net> 
 <41210649.4090008@gmx.net> <1092685821.23066.39.camel@dhcppc4>
 <41213D66.1010909@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, Oliver Feiler wrote:

> MIS:          8
> 
> What exactly is MIS? Something like "interrupt occured, but I have no 
> idea what device caused it"? I don't know much about it, but it's always 
>  >0 when the problem happens.

 It's a trigger mode MISmatch.  It only happens for level-triggered
interrupts and the problem is they get recorded as edge-triggered ones in
the receiving local APIC.  The two interrupt trigger modes require the
hardware to perform different actions when the software interrupt handler
concludes and such a mismatch would lead to a lock-up of the affected
line.  Specifically, the local APIC involved sends an End Of Interrupt
(EOI) message to the originating I/O APIC for level-triggered interrupts
and for edge-triggered interrupts nothing is sent.  Fortunately just
before sending the final ACK to the hardware at the conclusion of the
handler we can detect that the trigger mode recorded by the local APIC
disagrees with the setup of the corresponding I/O APIC line and if that
happens we execute an (expensive) unlock action at the I/O APIC so that it
resets its logic for the input as if it received an EOI message from a
local APIC for a level-triggered interrupt.

  Maciej
