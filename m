Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269396AbUI3SWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269396AbUI3SWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUI3SWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:22:39 -0400
Received: from gw.goop.org ([64.81.55.164]:24273 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S269396AbUI3SVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:21:47 -0400
Subject: Re: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: scott.feldman@intel.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1096319558.3859.5.camel@deimos.microgate.com>
References: <1096313095.2601.20.camel@deimos.microgate.com>
	 <1096319558.3859.5.camel@deimos.microgate.com>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 11:21:46 -0700
Message-Id: <1096568506.3995.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 16:12 -0500, Paul Fulghum wrote:
> On Mon, 2004-09-27 at 14:24, Paul Fulghum wrote:
> > The e100 module is generating a warning:
> > 
> > Sep 27 13:30:29 deimos kernel: e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
> > Sep 27 13:30:29 deimos kernel: e100: Copyright(c) 1999-2004 Intel Corporation
> > Sep 27 13:30:29 deimos kernel: e100: eth0: e100_probe: addr 0xfecfc000, irq 16, MAC addr 00:90:27:3A:C5:E3
> > Sep 27 13:30:29 deimos kernel: enable_irq(16) unbalanced from ec83ff33
> > Sep 27 13:30:29 deimos kernel:  [<c010923f>] enable_irq+0xcf/0xe0
> > Sep 27 13:30:29 deimos kernel:  [<ec83ff33>] e100_up+0xf3/0x1f0 [e100]
> 
> The following patch works for me and removes the warning.
> 
> The disable_irq/enable_irq is not needed because
> the ISR can't be called before calling request_irq,
> the hardware is initialized before calling request_irq,
> and request_irq itself enables the interrupt if needed.
> 
> Comments?

Hi,

That change was my fault, to address a problem with doing a resume from
suspend.  The e100 in my laptop seems to emit a spurious interrupt on
resume, and the intention was to block interrupts until the handler had
been installed - otherwise I get a "got interrupt X and nobody cared"
message.

While this works for me (probably because IRQ11 is heavily shared), it's
apparently pretty bogus.  But it did achieve the goal of getting the
problem looked at...

	J

