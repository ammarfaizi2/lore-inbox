Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVCHQlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVCHQlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVCHQlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:41:36 -0500
Received: from www.rapidforum.com ([80.237.244.2]:40341 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261416AbVCHQlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:41:18 -0500
Message-ID: <422DD5A3.7060202@rapidforum.com>
Date: Tue, 08 Mar 2005 17:41:07 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au> <422D468C.7060900@candelatech.com>
In-Reply-To: <422D468C.7060900@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Initial test setup:  two machines, running connections between them.
> Mostly asymetric (about 50Mbps in one direction,
> GigE in the other).  Each connection is trying some random rate between 
> 128kbps
> and 3Mbps in one direction, and 1kbps in the other direction.
> 
> Sending machine is dual 3.0Ghz xeons, 1MB cache, HT, and emt64 (running 
> 32-bit
> kernel & user space though). 1GB of RAM
> 
> Receiving machine is dual 2.8Ghz xeons, 512 MB cache, HT, 32-bit.  2GB 
> of RAM
> (but only 850Mbps of low memory of course...saw the thing OOM kill me 
> with 1GB of
> free high memory :( )
> 
> 
> Zero latency:
> 
> 2000 TCP connections:  When I first start, I see errors indicating I'm 
> out of low
>         memory..but it quickly recovers.  Probably because my program 
> takes a small
>         bit of time before it starts reading the sockets.
>         986Mbps of ethernet traffic (counting all ethernet headers)
> 
> 3000 TCP connections:  Same memory issue
>         986Mbps of ethernet traffic, about 82kpps
> 
> 4000 TCP connections:  Had to drop max_backlog to 5000 from 10000 to keep
>         the machine from going OOM and killing my traffic generator (on
>         the receiving side).
>     986Mbps of ethernet traffic
> 
> I will work on some numbers with latency tomorrow (had to stop and
> re-write some of my code to better handle managing the 8000 endpoints
> that 4000 connections requires!)
> 
> I think we can assume that the problem is either related to latency,
> or sendfile, since 4000 connections with no latency rocks along just
> fine...

Hmmmm.... can you try to following just to exclude some theories:

Run it with 4000 sockets and then do the following on the server-machine:

dd if=/dev/zero of=file1 bs=1M count=1024
dd if=/dev/zero of=file2 bs=1M count=1024
dd if=/dev/zero of=file3 bs=1M count=1024
cat file1 > /dev/zero & cat file2 > /dev/zero & cat file3 > /dev/zero &

I THINK it might have something to do with caching-pressure or so. See if there is a slow-down on 
the sending if the page-cache gets full and has to be cleared again.

You are running 2.6.11?

Chris
