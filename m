Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVAGAYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVAGAYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVAGAUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:20:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53436 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262048AbVAGAQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:16:11 -0500
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim_T_Murphy@Dell.com
Cc: rmk+lkml@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D32@ausx2kmps304.aus.amer.dell.com>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D32@ausx2kmps304.aus.amer.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105052674.24187.288.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 23:11:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 22:47, Tim_T_Murphy@Dell.com wrote:
> > anything i can do to avoid dropping characters without using 
> > low_latency, which still hangs SMP kernels?
> 
> this patch fixes the problem for me, but its probably an awful hack -- a
> brief interrupt storm occurs until tty processes its buffer, but IMHO
> that's better than dropping characters.

On a PCI device you may never get to process the buffer if you do that.
2.6.10 throws away the other bytes carefully and clears the IRQ.

Presumably this is a device with a fake 8250 that produces sudden large
bursts of data ? If so then for now you -need- to set low_latency and
should probably do it by the PCI vendor subid/device id. The problem is
that the serial layer expects serial data arriving at serial speeds. It
completely breaks down when it hits an emulation of a generic uart that
suddenely receives 32Kbytes of data at ethernet speed.

The longer term fix for this is when the flip buffers go away, and the
same problem gets cleaned up for things like mainframes and some of the
high performance DMA devices. Until then just set low_latency and
comment it as "not your fault" 8)

Alan

