Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422811AbWBIGFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWBIGFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWBIGFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:05:17 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:31644 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1422811AbWBIGFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:05:15 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: pktcdvd stack usage regression
References: <20060209020932.GY3524@stusta.de>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Feb 2006 07:01:25 +0100
In-Reply-To: <20060209020932.GY3524@stusta.de>
Message-ID: <m3lkwl6pfu.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> Hi Phillip,
> 
> your recent patch "pktcdvd: Allow larger packets" changed 
> PACKET_MAX_SIZE in the pktcdvd driver from 32 to 128.
> 
> Unfortunately, drivers/block/pktcdvd.c contains the following:
> 
> <--  snip  -->
> 
> ...
> static void pkt_start_write(struct pktcdvd_device *pd, struct 
> packet_data *pkt)
> {
>         struct bio *bio;
>         struct page *pages[PACKET_MAX_SIZE];
>         int offsets[PACKET_MAX_SIZE];
> ...
> 
> <--  snip  -->
> 
> With PACKET_MAX_SIZE=128, this allocates more than 1 kB on the stack 

Yes, I know.

> which is not acceptable considering that we might have only 4 kB stack 
> altogether.

Why is it not acceptable? The pkt_start_write() function is only
called from the kcdrwd() kernel thread and the pkt_start_write()
function doesn't call anything else in the kernel that could require
lots of stack space.

The actual I/O is started from pkt_iosched_process_queue(), which
calls generic_make_request(). However pkt_iosched_process_queue() is
on a different call chain than pkt_start_write(), so I don't see how
this could be a problem.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
