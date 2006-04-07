Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWDGREf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWDGREf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWDGREf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:04:35 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:22582 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964818AbWDGREf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:04:35 -0400
In-Reply-To: <200604070909.08266.david-b@pacbell.net>
References: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org> <200604062222.05661.david-b@pacbell.net> <44362DDE.3010203@gmail.com> <200604070909.08266.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD0F0EAE-B3C0-4C03-BB90-99E65C16EC4F@kernel.crashing.org>
Cc: Vitaly Wool <vitalywool@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: [PATCH] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Fri, 7 Apr 2006 12:04:29 -0500
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 7, 2006, at 11:09 AM, David Brownell wrote:

> On Friday 07 April 2006 2:16 am, Vitaly Wool wrote:
>> Hi,
>>
>>> I guess I'm surprised you're not using txrx_buffers() and having
>>> that whole thing be IRQ driven, so the per-word cost eliminates
>>> the task scheduling.  You already paid for IRQ handling ... why
>>> not have it store the rx byte into the buffer, and write the tx
>>> byte froom the other buffer?  That'd be cheaper than what you're
>>> doing now ... in both time and code.  Only wake up a task at
>>> the end of a given spi_transfer().
>>>
>> I might be completely wrong here, but I was asking myself this very
>> question, and it looks like that's the way to implement full duplex
>> transfers.
>
> Well, not the _only_ way.  The polling-type txrx_word() calls are
> also full duplex.  My point is more that it's bad/inefficient to
> incur both IRQ _and_ task switch overheads per word, when it would
> be a lot simpler to just have the IRQ handler do its normal job.
>
> (And that's even true if you've turned hard IRQ handlers into threads
> for PREEMPT_RT or whatever.  In that case the "IRQ overhead" is a
> task switch, but you're still saving _additional_ task switches.)

This makes more sense about what I'm doing that is wasteful.   
However, I'm not sure exactly where I should plug into things.

I think you are saying to continue using spi_bitbang_transfer &  
spi_bitbang_work, but have spi_bitbang_work call my own bitbang- 
 >txrx_bufs().

- kumar
