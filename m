Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVIONCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVIONCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbVIONCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:02:20 -0400
Received: from [81.2.110.250] ([81.2.110.250]:63956 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030393AbVIONCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:02:19 -0400
Subject: Re: libata sata_sil broken on 2.6.13.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: izvekov@lps.ele.puc-rio.br, linux-kernel@vger.kernel.org
In-Reply-To: <43290893.7070207@pobox.com>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
	 <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
	 <43290893.7070207@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Sep 2005 14:27:39 +0100
Message-Id: <1126790860.19133.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-15 at 01:37 -0400, Jeff Garzik wrote:
> Silicon Image 311x throws interrupts after we told the hardware to 
> disable interrupts, but only for a few certain devices and/or PATA 
> bridges.  I only have theories as to the solution.

Firstly some devices do not honour nIEN.
Secondly IRQ delivery is asynchronous to all other busses (especially on
older SMP boxes)

ata_interrupt checks qc->tf.ctl & ATA_NIEN

Other functions set/reset nIEN in the tf they issue then directly call
ata_tf_load/ata_exec_* so I don't believe qc->tf.ctl is the correct
thing to check for non-interrupt status on older type controllers at
least.

Instead you need to look at ap->last_ctl. But that too looks suspect if
any kind of reset sets it back to an undefined state.

Finally I don't see what locks viewing ->tf.ctl/->last_ctl against
whether it has yet been loaded into the hardware.

Alan

