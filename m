Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbULBHBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbULBHBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbULBHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:01:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261565AbULBHAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:00:52 -0500
Message-ID: <41AEBD95.7030804@pobox.com>
Date: Thu, 02 Dec 2004 02:00:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>	<41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
In-Reply-To: <20041201223441.3820fbc0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> We need an -rc3 yet.  And I need to do another pass through the
> regressions-since-2.6.9 list.  We've made pretty good progress there
> recently.  Mid to late December is looking like the 2.6.10 date.


another for that list, BTW:

I am currently chasing a 2.6.8->2.6.9 SATA regression, which causes 
ata_piix (Intel ICH5/6/7) to not-find some SATA devices on x86-64 SMP, 
but works on UP.  Potentially related to >=4GB of RAM.



Details, in case anyone is interested:
Unless my code is screwed up (certainly possible), PIO data-in [using 
the insw() call] seems to return all zeroes on a true-blue SMP machine, 
for the identify-device command.  When this happens, libata (correctly) 
detects a bad id page and bails.  (problem doesn't show up on single CPU 
w/ HT)

What changed from 2.6.8 to 2.6.9 is

2.6.8:
	bitbang ATA taskfile registers (loads command)
	bitbang ATA data register (read id page)

2.6.9:
	bitbang ATA taskfile registers
	queue_work()
	workqueue thread bitbangs ATA data register (read id page)

So I wonder if <something> doesn't like CPU 0 sending I/O traffic to the 
on-board SATA PCI device, then immediately after that, CPU 1 sending I/O 
traffic.

Anyway, back to debugging...  :)

	Jeff

