Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVCaHPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVCaHPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCaHPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:15:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39911 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262018AbVCaHPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:15:13 -0500
Date: Thu, 31 Mar 2005 09:15:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331071504.GA15681@elte.hu>
References: <1112138283.11346.2.camel@lade.trondhjem.org> <1112192778.17365.2.camel@mindpipe> <1112194256.10634.35.camel@lade.trondhjem.org> <20050330115640.0bc38d01.akpm@osdl.org> <1112217299.10771.3.camel@lade.trondhjem.org> <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org> <1112237239.26732.8.camel@mindpipe> <1112240918.10975.4.camel@lade.trondhjem.org> <20050331065942.GA14952@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331065942.GA14952@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i think all it needs now is a lock-breaker in the main radix-lookup 
> loop in nfs_scan_lock_dirty(), or a latency-oriented reduction in the 
> npages argument, to make the loop bounded. [...]

can nfsi->req_lock be dropped within nfs_scan_dirty()? Or does the 
scanning have to restart in that case? My guess would be the scanning 
does not have to be restarted, since we drop the lock after scanning 
anyway, so all it has to take care of is the consistency of the list 
itself, and the fact that the whole index range got scanned in a certain 
point in time.

Such a lock-breaker was hard before because we had a list 'cursor' which 
could move away while we dropped the lock. But with the radix tree it's 
an 'index position' now, which is much more invariant. The patch below 
attempts this, ontop of your patch - but i'm not sure whether ->req_lock 
is the only lock we hold at that point.

	Ingo

--- linux/fs/nfs/pagelist.c.orig
+++ linux/fs/nfs/pagelist.c
@@ -291,6 +291,7 @@ nfs_scan_lock_dirty(struct nfs_inode *nf
 				res++;
 			}
 		}
+		cond_resched_lock(&nfsi->req_lock);
 	}
 out:
 	return res;
