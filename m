Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUHXOXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUHXOXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUHXOXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:23:42 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:51405 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267881AbUHXOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:23:35 -0400
To: Andi Kleen <ak@muc.de>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E50240619DA25@orsmsx404.amr.corp.intel.com>
	<20040823233920.GA29854@muc.de>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 24 Aug 2004 07:19:36 -0700
In-Reply-To: <20040823233920.GA29854@muc.de> (Andi Kleen's message of "24
 Aug 2004 01:39:20 +0200, Tue, 24 Aug 2004 01:39:20 +0200")
Message-ID: <52acwksjnr.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Aug 2004 14:19:36.0755 (UTC) FILETIME=[62934030:01C489E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> Yes, the flag word is 0x8b after the call. And
    Andi> pci_enable_msi returns 0.

Actually I bet the problem is that the driver is doing request_irq()
on the wrong IRQ.  In s2io.c, s2io_init_nic() does

	sp->irq = pdev->irq;

and then sometime later s2io_open() does

	err =
	    request_irq((int) sp->irq, s2io_isr, SA_SHIRQ, sp->name, dev);

If you put the call to pci_enable_msi() after sp->irq is assigned, the
driver will request the original irq (which will still be in INTx
mode, of course), rather than the new vector assigned by the MSI core.

 - Roland
