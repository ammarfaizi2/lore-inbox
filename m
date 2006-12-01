Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759089AbWLAFlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089AbWLAFlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759095AbWLAFlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:41:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:30616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759088AbWLAFlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:41:14 -0500
Date: Thu, 30 Nov 2006 21:41:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Loic Prylli <loic@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: mask/unmasking while servicing MSI(-X) unnecessary?
Message-Id: <20061130214103.7ed090e9.akpm@osdl.org>
In-Reply-To: <456E0DAF.90507@myri.com>
References: <456E0DAF.90507@myri.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 17:46:07 -0500
Loic Prylli <loic@myri.com> wrote:

> While looking into using MSI-X for our myri10ge driver, we have seen
> that the msi(x) code (driver/pci/msi.c) masks the MSI(-X) vector while
> servicing an interrupt. We are not sure why this masking is needed (for
> instance no such thing is done for "edge IOAPIC" interrupts). There
> seems to be already several mechanisms each individually protecting
> against "loosing an interrupt" without masking:
> - the "x86" architecture is able to queue 2 interrupt messages. That
> guarantees an interrupt handler will always start after the last MSI
> received (even in the case of a big burst of MSI messages).
> - Even if there wasn't that interrupt queuing, ack_APIC_irq() could be
> moved in the ack() method. Then things would work without masking even
> on a hypothetical platform where a new interrupt is completely ignored
> (with no IRR-like register) while servicing the same vector (anyway
> since this "msi" code is already tied to "x86" architecture
> specificities, that hypothetical platform might not be relevant).
> - Almost every driver/device have their own way of acknowledging
> interrupts anyway, which also by itself makes the masking/unmasking
> unnecessary.
> - The masking by itself is racy unless the driver interrupt handler
> starts by making sure the masking request has reached the device with
> some kind of MMIO-read. Such a MMIO-read is normally the kind of costly
> requests you are happy to get rid of in the MSI model.
> 
> So if it is not useful, it might be better to avoid that systematic
> mask/unmask pair. This masking has a small but measurable performance
> impact for our device/driver combo.
> 
> Would you agree to suppress that masking (sample patch following)? Or
> otherwise, is there is a possibility of making it optional on a
> per-device basis.
> 

Your patch appears to be against the prehistoric 2.6.18 kernel.  MSI
got changed a lot - please test 2.6.19 and see if that needs fixing.
