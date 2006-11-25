Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967137AbWKYT0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967137AbWKYT0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967139AbWKYT0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:26:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:30421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967137AbWKYT0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:26:41 -0500
Date: Sat, 25 Nov 2006 11:23:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin A. Fink" <fink@mpe.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Message-Id: <20061125112321.1767a53c.akpm@osdl.org>
In-Reply-To: <200611241510.11526.fink@mpe.mpg.de>
References: <200611241407.01210.fink@mpe.mpg.de>
	<20061124133331.6bf0d7cc@localhost.localdomain>
	<200611241510.11526.fink@mpe.mpg.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 15:10:11 +0100
"Martin A. Fink" <fink@mpe.mpg.de> wrote:

> Here some measurement results:
> 
> time dd if=/dev/zero of=test.zero bs=1M count=1000
> results in
> 
> real 0m52.561s
> user 0m0.003s
> sys  0m7.407s
> 
> and strace dd... gives among other information
> 6.84s 1004calls syscall: write
> 
> So I spend 45s of 52s within the kernel. Why so long?

Profiling the kernel will tell.  Preferably with oprofile, but if for some
reason that doesn't work, with the old profiler.

I use this:

#!/bin/sh
sudo opcontrol --stop
sudo opcontrol --shutdown
sudo rm -rf /var/lib/oprofile
sudo opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
sudo opcontrol --start-daemon
sudo opcontrol --start
time $@
sudo opcontrol --stop
sudo opcontrol --shutdown
sudo opreport -l /boot/vmlinux-$(uname -r) | head -50

I have seen PIO and MMIO operations on PCI busses take tremendous amounts
of time when that bus is saturated with DMA transfers.  But that was back
in the old days.
