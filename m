Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUCBNCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 08:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCBNBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 08:01:52 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:11980 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261636AbUCBNBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 08:01:44 -0500
Date: Tue, 2 Mar 2004 14:01:39 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1: queue-congestion-dm-implementation patch
Message-ID: <20040302130137.GA9941@cistron.nl>
References: <cistron.200403011400.51008.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403011400.51008.kevcorry@us.ibm.com>
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Kevin Corry:
> Article: 452202 of lists.linux.kernel
> From: Kevin Corry <kevcorry@us.ibm.com>
> Date:	Mon, 1 Mar 2004 14:00:50 -0600
> Newsgroups: lists.linux.kernel
> Approved: news@news.cistron.nl
> 
> The queue-congestion-dm-implementation patch in 2.6.4-rc1-mm1 (included below) 
> allows a DM device to query the lower-level device(s) during the 
> queue-congestion APIs. However, it must wait on an internal semaphore 
> (md->lock) before passing the call down to the lower-level devices. The 
> problem is that the higher-level caller is holding a spinlock at the same 
> time. Here is one such stack-trace I have been seeing:
> 
> Debug: sleeping function called from invalid context at include/linux/
> rwsem.h:43
> in_atomic():1, irqs_disabled():0
> Call Trace:
>  [<c012456b>] __might_sleep+0xab/0xd0
>  [<c03a0771>] dm_any_congested+0x21/0x60

Is there any way to reproduce this? I turned on spinlock and
sleep-spinlock debugging and did lots of I/O but I don't see it.

> I'm not sure how to fix this (or how serious a problem it is)...I'm just 
> throwing this out there for discussion.

Well bdi_write_congested() is racy, ofcourse, so in theory a call
to make_request() could be made which can block (and for dm, locks
the same semaphore) - so this can happen anyway. Only the chance of
it is much lower. I'm not sure how bad it is.

Changing down_read() in dm_any_congested to down_read_trylock() would
probably fix it for bdi_*_congested(). If you can tell me how to
reproduce it I can try a few things..

Mike.
