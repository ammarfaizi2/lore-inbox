Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVAYMLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVAYMLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVAYMLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:11:49 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:64638 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261913AbVAYMLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:11:45 -0500
Message-ID: <41F6377B.8030609@yahoo.com.au>
Date: Tue, 25 Jan 2005 23:11:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: tridge@osdl.org
CC: Andrew Morton <akpm@osdl.org>, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org, agruen@suse.de,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: memory leak in 2.6.11-rc2
References: <20050120020124.110155000@suse.de>	<16884.8352.76012.779869@samba.org>	<200501232358.09926.agruen@suse.de>	<200501240032.17236.agruen@suse.de>	<16884.56071.773949.280386@samba.org>	<16885.47804.68041.144011@samba.org>	<41F5BB0D.6090006@osdl.org>	<16885.48502.243516.563660@samba.org>	<16885.53121.883933.986880@samba.org>	<20050124220624.4a8eca97.akpm@osdl.org> <16886.12026.810752.23284@samba.org>
In-Reply-To: <16886.12026.810752.23284@samba.org>
Content-Type: multipart/mixed;
 boundary="------------040706090309050206000006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706090309050206000006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Tridgell wrote:
> Andrew,
> 
>  > So what you should do before generating the leak tool output is to put
>  > heavy memory pressure on the machine to try to get it to free up as much of
>  > that pagecache as possible.  bzero(malloc(lots)) will do it - create a real
>  > swapstorm, then do swapoff to kill remaining swapcache as well.
> 
> As you saw when you logged into the machine earlier tonight, when you
> suspend the dbench processes and run a memory filler the memory is
> reclaimed.
> 
> I still think its a bug though, as the oom killer is being triggered
> when it shouldn't be. I have 4G of ram in this machine, and I'm only
> running a couple of hundred processes that should be using maybe 500M
> in total, so for the oom killer to kick in might mean that the memory
> isn't being reclaimed under normal memory pressure. Certainly a ps
> shows no process using more than a few MB.
> 
> The oom killer report is below. This is with 2.6.11-rc2, with the pipe
> leak fix, and the pgown monitoring patch. It was running one nbench of
> size 50 and one dbench of size 40 at the time.
> 

There are various OOM killer improvements and fixes that have gone
into Andrew's kernel tree which should be included for 2.6.11.

I don't think the OOM killer was ever perfect in 2.6, but recent
tinkering in mm/ probably aggrivated it. *blush*

Here is another small OOM killer improvement. Previously we needed
to reclaim SWAP_CLUSTER_MAX pages in a single pass. That should be
changed so that we need only reclaim that many pages during the
entire try_to_free_pages run, without going OOM.

Andrea? Andrew? Look OK?

--------------040706090309050206000006
Content-Type: text/plain;
 name="less-oom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="less-oom.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~oom-helper mm/vmscan.c
--- linux-2.6/mm/vmscan.c~oom-helper	2005-01-25 23:04:28.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2005-01-25 23:05:06.000000000 +1100
@@ -914,12 +914,12 @@ int try_to_free_pages(struct zone **zone
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
 		}
-		if (sc.nr_reclaimed >= SWAP_CLUSTER_MAX) {
+		total_scanned += sc.nr_scanned;
+		total_reclaimed += sc.nr_reclaimed;
+		if (total_reclaimed >= SWAP_CLUSTER_MAX) {
 			ret = 1;
 			goto out;
 		}
-		total_scanned += sc.nr_scanned;
-		total_reclaimed += sc.nr_reclaimed;
 
 		/*
 		 * Try to write back as many pages as we just scanned.  This

_

--------------040706090309050206000006--

