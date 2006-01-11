Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWAKUbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWAKUbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWAKUbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:31:14 -0500
Received: from mail01.fortunecookiestudios.com ([209.208.125.101]:7080 "EHLO
	mail01.fortunecookiestudios.com") by vger.kernel.org with ESMTP
	id S964828AbWAKUbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:31:13 -0500
Message-ID: <43C56B08.2000908@cfl.rr.com>
Date: Wed, 11 Jan 2006 15:31:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: David Lloyd <dmlloyd@tds.net>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is user-space AIO dead?
References: <20060111192056.67364.qmail@web34113.mail.mud.yahoo.com>
In-Reply-To: <20060111192056.67364.qmail@web34113.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to use non blocking IO with O_DIRECT, because the 
kernel does not buffer the data, and once the write() call returns, the 
kernel can not touch the caller's buffer any more.  The idea of O_DIRECT 
is that the hardware can directly DMA from the caller's buffer, so if 
you want to keep the hardware busy, you need to use async IO so the 
hardware always has some work to do. 

I actually hacked up dd to use async IO ( via io_submit ) in conjunction 
with O_DIRECT and it did noticeably improve ( ~10% ish ) both throughput 
and cpu utilization.  I have an OO.o spreadsheet showing the results of 
some simple benchmarking with various parameters I did at home, which I 
will post later this evening. 

Of course, dd is a simplistic case of sequential IO.  If you have 
something like a big database that needs to concurrently handle dozens 
or hundreds of random IO requests at once, O_DIRECT async IO is 
definitely going to be a clear winner. 

Kenny Simpson wrote:
> Right, but I'm not sure O_DIRECT implies stable storage, only data sent out to the device, not
> held up in the page cache (I could be wrong).
>
> AIO is implemented for O_DIRECT according to the paper, but they observed it not having benefit.
>
> AIO being implemented to O_SYNC would be nice for my use, as it would also eliminate the extra
> alignment restrictions brought on by O_DIRECT.
>
> -Kenny
>
>   

