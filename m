Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUCIXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUCIXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:34:15 -0500
Received: from palrel13.hp.com ([156.153.255.238]:2703 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262469AbUCIXcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:32:21 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16462.21505.526926.903904@napali.hpl.hp.com>
Date: Tue, 9 Mar 2004 15:32:17 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Grant Grundler <iod00d@hp.com>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404E2B98.6080901@pacbell.net>
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
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David B.,

I'll respond to your concerns about my OHCI changes later on.  I
wanted to make progress on the BTC HID issue first so we have the full
picture.

Remember how I was asking what's so special about 0xf00000 because
that's the address the OHCI HC was reading from that caused the crash?
Well, looky here what you get when you interpret the memory at address
0 as an ED:

 hw=(info=f0000000 tailp=f0000000 headp=f0000000 nextED=f0000000)

D'oh!

(I suspect this strange memory pattern is a left-over from the
memory-testing done by the firmware; I should say thanks to whoever
invented this pattern; the problem would have been much harder to
debug if the address hadn't convenently fallen on a write-only region
of the address-space.)

Anyhow, I have been wondering since about Sunday whether it's really
safe to write HcControlHeadED (and HcBulkHeadED) with 0.  The register
description itself is ambiguous.  Now I'm finding that Figure 6-5
"List Service Flow" and Section 6.4.2.2 "Locating Endpoint
Descriptors" are outright contradictory!

The flow-chart suggests that after loading CurrentED with the contents
of HeadED, the HC checks whether CurrentED is 0 and, if so, does nothing.
However, the text in Section 6.4.2.2 says:

 ... At this point, the Host Controller checks the BulkListFilled bit
 or ControlListFilled bit of the HcCommandStatus register.  If the
 respective "Filled" bit is set to 1, there is at least one Endpoint
 Descriptor on the list which needs service.  In this case, the
 HostController will copy the value of HcControlHeadED or HcBulkHeadED
 into HcControlCurrentED or HcBulkCurrentED respectively, clear the
 "Filled" bit to 0, and attempt to process the Endpoint Descriptor now
 present in the CurrentED register. ...

So, if the HC behaves as described in the text, then there is an
obvious race:

  HC						HCD

  - start new frame
  - find list enabled (CLE/BLE set)
  - find "Filled" bit enabled (CLF/BLF set)
						- ed_deschedule() gets called
						- turn off "list-enabled" bit
						- store 0 into *HeadED
  - read *HeadED and store in *CurrentEd
  - clear "Filled" bit to 0
  - process ED at "Current"

In other words, whenever de-scheduling the first ED on the control or
bulk list, there is a risk that with the right timing, you'll end up
processing the "ED" at address zero!

So I changed ohci-q.c from donig this:

	if (ed->ed_prev == NULL) {
		if (!ed->hwNextED) {
			ohci->hc_control &= ~OHCI_CTRL_CLE;
			writel (ohci->hc_control, &ohci->regs->control);
		}
		writel (le32_to_cpup (&ed->hwNextED),
			&ohci->regs->ed_controlhead);
	} else ...

to this:

	if (ed->ed_prev == NULL) {
		if (!ed->hwNextED) {
			ohci->hc_control &= ~OHCI_CTRL_CLE;
			writel (ohci->hc_control, &ohci->regs->control);
		} else
			writel (le32_to_cpup (&ed->hwNextED),
				&ohci->regs->ed_controlhead);
	} else ...

and now there are no more crashes when plugging in the BTC keyboard.
(Note: the change is safe only if the ED being removed remains valid
until the clearing of the CLE is observed, i.e, until the next start
of frame, which is the case with my patch from yesterday.)

Now the next problem is to figure out why one of the URBs submitted by
the HID consistently times out the first time round.  (Oh, and there
is an infinite loop in hidinput_connect() which is trivial to fix.)

	--david

PS: It would have been nice if I had been smart enough to check the
    memory at address 0 upfront (as described above), but in truth, I
    found the problem in the reverse order by noticing that the
    machine died right after/during the ed_deschedule() and the
    clearing of the *HeadED register was just about the only thing
    left that could cause the crash.
