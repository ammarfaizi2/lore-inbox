Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUDDRC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 13:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUDDRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 13:02:58 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32269 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262462AbUDDRC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 13:02:56 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <4041E38F.31264.2D8C0D2E@localhost>
	<4043811B.24524.33DB8886@localhost> <405F57F2.7010308@pobox.com>
	<87n068mr5w.fsf@devron.myhome.or.jp>
	<20040331194244.GB7306@is-root.org>
	<87y8pgpd0i.fsf@ibmpc.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 05 Apr 2004 02:02:22 +0900
In-Reply-To: <87y8pgpd0i.fsf@ibmpc.myhome.or.jp>
Message-ID: <87smfju15t.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Christian Gut <cycloon@is-root.org> writes:
> 
> > On Tue, 23 Mar 2004, OGAWA Hirofumi wrote:
> > 
> > > Jeff Garzik <jgarzik@pobox.com> writes:
> > > > What was the final resolution of the 8139too debugging?
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=107919285122190&w=2
> > > The cause of his problem was BIOS configuration. It was edge-trigger.
> > 
> > not sure if that was the only reason. 2.6.3 and everything up breaks the
> > rtl nic in my laptop and i cant configure anything like edge-trigger in
> > my bios.

This problem was also edge-triggered interrupt. In his case, ACPI
enable fixes it.

Looks like APCI does the following in acpi_pci_irq_enable(),

	/* 
	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
	 */
#ifdef CONFIG_X86
	{
		static u16 irq_mask;
		if ((dev->irq < 16) &&  !((1 << dev->irq) & irq_mask)) {
			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d as level-triggered\n", dev->irq));
			irq_mask |= (1 << dev->irq);
			eisa_set_level_irq(dev->irq);
		}
	}
#endif

This one is useful as workaround. But I think eisa_set_level_irq() is
not enough for doing this, because looks like the some chips needs
additional setting.

Probably we need the proper interface... Ummm..
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
