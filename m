Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTCJXaS>; Mon, 10 Mar 2003 18:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbTCJXaS>; Mon, 10 Mar 2003 18:30:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261907AbTCJXaQ>; Mon, 10 Mar 2003 18:30:16 -0500
Date: Mon, 10 Mar 2003 15:33:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: akpm@digeo.com, <george@mvista.com>, <cobra@compuserve.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
In-Reply-To: <20030310230539.30103.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Felipe Alfaro Solana wrote:
>  
> why not sleep(0)? 

I think a much more likely (and correct) usage for big sleep values is 
more something like this:

	do_with_timeout(xxx, int timeout)
	{
		struct timespec ts;

		... set up some async event ..
		ts.tv_nsec = 0;
		ts.tv_sec = timeout;
		while (nanosleep(&ts, &ts)) {
			if (async event happened)
				return happy;
		}
		.. tear down the async event if it didn't happen ..
	}

and here the natural thing to do in user space is to just make the "no 
timeout" case be a huge value.

At which point it is a _bug_ in the kernel if we return early with some 
random error code.

		Linus

