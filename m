Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWIIOoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWIIOoK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWIIOoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:44:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48065 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932229AbWIIOoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:44:08 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       akpm@osdl.org, segher@kernel.crashing.org, davem@davemloft.net
In-Reply-To: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:06:36 +0100
Message-Id: <1157814396.6877.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 12:03 +1000, ysgrifennodd Paul Mackerras:
> Currently we have a sync instruction after the store in writel() but
> not one before.  The sync after is to keep the writel inside
> spinlocked regions and to ensure that the store is ordered with
> respect to the load in readl() and friends.

The spinlock v writel case is not guaranteed on other platforms and
requires you use mmiowb. The main memory v writel ordering is half
guaranteed for PCI bus only .. viz:

The following is ok

	fooblock->command = 1;
	writel(&fooblock_phys, pci_addr);   /* mem write seen */

The following is not

	fooblock->command = 1;
	writel(&fooblock_phys, pci_addr);
	fooblock->command = 2;		/* could occur before PCI */


Alan
