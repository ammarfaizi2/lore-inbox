Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967800AbWLDXXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967800AbWLDXXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967802AbWLDXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:23:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:39330 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967800AbWLDXXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:23:02 -0500
Message-ID: <4574ADD0.4060803@pobox.com>
Date: Mon, 04 Dec 2006 18:22:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: andersen@codepoet.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make sata_promise PATA ports work
References: <20061204194737.GA24311@codepoet.org> <20061204201601.06933372@localhost.localdomain>
In-Reply-To: <20061204201601.06933372@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Mon, 4 Dec 2006 12:47:37 -0700
> Erik Andersen <andersen@codepoet.org> wrote:
> 
>> This patch vs 2.6.19, based on the not-actually-working-for-me
>> code lurking in libata-dev.git#promise-sata-pata, makes the PATA
>> ports on my promise sata card actually work.  Since the plan as
> 
> Nice, this is pretty much what is needed to polish up the other split
> PATA/SATA cases.

Disagree.  Internal libata is set up so that you can have different 
ata_port::flags and ata_port::ops for each port, which is what enables 
proper hardware sharing between SATA and PATA.

Two things need to happen:

1) probe_ent needs to permit a driver to supply multiple flags/ops 
pairs, not just one for the whole driver, and pass that through to the 
proper data structures during ata_port init.

2) a VERY FEW details like ->irq_clear() are really ata_host level 
hooks, but they live in ata_port_operations because there is no 
ata_host_operations.  Fix these.

Once those issues are fixed, PATA+SATA can be easily support on the 
combinations of hardware that have been desperately wanting it: 
sata_promise, sata_sis, sata_via (sata_uli too?)

	Jeff



