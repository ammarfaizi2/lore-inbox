Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBGPia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBGPia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVBGPia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:38:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:44244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261156AbVBGPiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:38:23 -0500
Date: Mon, 7 Feb 2005 07:38:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Kasprzak <kas@fi.muni.cz>, Jens Axboe <axboe@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1?
In-Reply-To: <20050207110030.GI24513@fi.muni.cz>
Message-ID: <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz> <20050207110030.GI24513@fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Feb 2005, Jan Kasprzak wrote:
>
>The server has been running 2.6.11-rc2 + patch to fs/pipe.c
>for last 8 days. 
> 
> # cat /proc/meminfo
> MemTotal:      4045168 kB
> Cached:        2861648 kB
> LowFree:         59396 kB
> Mapped:         206540 kB
> Slab:           861176 kB

Ok, pretty much everything there and accounted for: you've got 4GB of 
memory, and it's pretty much all in cached/mapped/slab. So if something is 
leaking, it's in one of those three.

And I think I see which one it is:

> # cat /proc/slabinfo
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> biovec-1          5506200 5506200     16  225    1 : tunables  120   60    8 : slabdata  24472  24472    240
> bio               5506189 5506189    128   31    1 : tunables  120   60    8 : slabdata 177619 177619    180

Whee. You've got 5 _million_ bio's "active". Which account for about 750MB
of your 860MB of slab usage.

Jens, any ideas? Doesn't look like the "md sync_page_io bio leak", since
that would just lose one bio per md suprt block read according to you (and
that's the only one I can find fixed since -rc2). I doubt Jan has caused
five million of those..

Jan - can you give Jens a bit of an idea of what drivers and/or schedulers 
you're using?

		Linus
