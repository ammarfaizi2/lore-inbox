Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUI2NQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUI2NQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUI2NQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:16:02 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:62857 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268382AbUI2NPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:15:50 -0400
Subject: RE: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096427180.6003.49.camel@at2.pipehead.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF6375@orsmsx402.amr.corp.intel.com>
	 <1096427180.6003.49.camel@at2.pipehead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096460004.15905.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 13:13:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 04:06, Paul Fulghum wrote:
> It is interesting behavior for request_irq.
> I don't know if it was planned that way,
> or is an unexpected artifact.
> It makes the effect of the disable_irq call
> indeterminate (to the driver) if made
> before registering with the interrupt.

Essentially the code believes that you cannot use
disable_irq() until you've requested it. You can 
however in 2.6 call request_irq with local interrupts
disabled.

We have a fundamental API design problem going back to
day one. The API IMHO should really be

	struct irq *irq;
	irq = allocate_irq(5, ...)
	enable_irq(irq);

That would fix
- Drivers failing to load/init under freak low memory situations
- How to cleanly report irqs (because each irq can now have ->name)
- How to tell which shared irq users are disabled/enabled for the irq
  poll/recovery code I posted (and is testing in -mm).

Unfortunately it would require changes to rather a lot of code.

