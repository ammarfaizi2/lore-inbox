Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWFMRWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWFMRWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWFMRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:22:37 -0400
Received: from rtr.ca ([64.26.128.89]:8358 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932194AbWFMRWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:22:37 -0400
Message-ID: <448EF45B.2080601@rtr.ca>
Date: Tue, 13 Jun 2006 13:22:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       jheffner@psc.edu, davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca> <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca>
In-Reply-To: <448EEE9D.10105@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> ..
>> The site www.everymac.com is still not browseable until
>> setting /proc/sys/net/ipv4/tcp_window_scaling===0.
>>
>> There's one other difference I see in the tcpdump traces.
>> The first packets from each trace below show different
>> values for "wscale".  The old (working) kernels use "wscale 2",
>> whereas 2.6.17 uses "wscale 6".  In both cases, the value
>> seen in /proc/sys/net/ipv4/tcp_adv_win_scale is 2.
> 
> Okay.  More progress here.  The calculation of the "wscale" values
> is based on the "tcp_rmem" sysctl numbers.
> 
> The defaults for these *differ* between 2.6.16.18 and 2.6.17-rc*.
> 
> 2.6.16: 4096    87380    174760
> 2.6.17: 4096    87380   2097152
> 
> If I change the tcp_rmem setting on 2.6.17 to match the old value,
> then the website www.everymac.com becomes accessible again:
> 
> echo 4096 87380 174760 > /proc/sys/net/ipv4/tcp_rmem
> 
> Looking at diffs between 2.6.16 and 2.6.17, I see a big rework
> of the tcp_rmem code in linux/net/ipv4/tcp.c
> 
> Looks like something got broken there, or possibly the wscale
> calculations have a bug that is only triggered by the new rmem values ??
> 

Okay, here's the blob that broke it.

> [TCP]: Set default max buffers from memory pool size
> author	John Heffner <jheffner@psc.edu>
> 	Sat, 25 Mar 2006 09:34:07 +0000 (01:34 -0800)
> committer	David S. Miller <davem@davemloft.net>
> 	Sat, 25 Mar 2006 09:34:07 +0000 (01:34 -0800)
> commit	7b4f4b5ebceab67ce440a61081a69f0265e17c2a
> tree	ac02c685ce23f2440fecbebaa5b55cd47947c03e	tree
> parent	2babf9daae4a3561f3264638a22ac7d0b14a6f52	commit | commitdiff
> [TCP]: Set default max buffers from memory pool size
> 
> This patch sets the maximum TCP buffer sizes (available to automatic
> buffer tuning, not to setsockopt) based on the TCP memory pool size.
> The maximum sndbuf and rcvbuf each will be up to 4 MB, but no more
> than 1/128 of the memory pressure threshold.
> 
> Signed-off-by: John Heffner <jheffner@psc.edu>
> Signed-off-by: David S. Miller <davem@davemloft.net>

John / David:  Any ideas on what's gone awry here?



