Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUC2HgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUC2HgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 02:36:18 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:58640 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262730AbUC2HgN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 02:36:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Wim Coekaerts <wim.coekaerts@oracle.com>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 09:32:30 +0200
X-Mailer: KMail [version 1.4]
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <20040329005502.GG3039@dualathlon.random> <20040329042912.GI18054@ca-server1.us.oracle.com>
In-Reply-To: <20040329042912.GI18054@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403290932.30246.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 March 2004 06:29, Wim Coekaerts wrote:
> > In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
> > didn't help in my measurements.  1M maybe these days is needed (as Jens
> > suggested) but >1M still sounds overkill and I completely agree with
> > Jens about that.
>
> at least 1Mb... more than 1mb (I doubt 32mb is really necessarily
> useful) is nice for flushing contiguous journal data to disk. between
> 1-8mb in one io.
>
> at least 1mb is good when you have to process massive amounts of data,
> just read huge chunks of files, we tend to do 1mb. anyway,
> as you said, at some point it's a bit overkill . I thinkg 1-8mb makes
> sense.

It makes sense *today*. Do you want to return to this discussion
ad infinitum?

Andrea is right, block layer can be coded to detect such a (per-device)
request size increasing which does not give you any more throughput,
or increasing which hurts your latency too much, and stick with it.

More detailed:

1. size = 1 sector
2  measure throughput and latency
3. size *= 2
4. measure new_throughput and new_latency
5. if(new_throughput<=throughput*1.01 || new_latency>50ms) break
6. throughput = new_throughput; latency = new_latency; goto 3

Real code will have admin overrides (start from N sectors,
never go higher than M sectors etc), but you got the idea.
-- 
vda
