Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbTCGMFZ>; Fri, 7 Mar 2003 07:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCGMFZ>; Fri, 7 Mar 2003 07:05:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:38537 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261550AbTCGMFY>;
	Fri, 7 Mar 2003 07:05:24 -0500
Date: Fri, 7 Mar 2003 04:15:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 and jiffies wrap
Message-Id: <20030307041558.6112425c.akpm@digeo.com>
In-Reply-To: <20030307130504.GA903@suse.de>
References: <20030307130504.GA903@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 12:15:52.0056 (UTC) FILETIME=[4BB21780:01C2E4A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Hi,
> 
> The patch doesn't look right, why is INITIAL_JIFFIES being cast to
> unsigned int? This breaks x86_64 at least.
> 
> ...
> -#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))

This sets the initial jiffies value to 0x00000000fffb6c20, which can trigger
32-bit wraparound bugs: if some random jiffy counter wraps from
0x00000000ffffffff to 0x0000000000000000 then things fail.

davem was bitten by at least one such bug in the qlogicfc driver.  It would
have caused 64-bit machines to fail after 49 days.

It turns out that it is more valuable to test for this than to test for
64-bit wraparound bugs.
