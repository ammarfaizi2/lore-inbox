Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVKPIEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVKPIEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVKPIED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:04:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28567 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030215AbVKPIEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:04:02 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:03:32 +0100
Message-Id: <1132128212.2834.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 16:50 -0800, Alex Davis wrote:
> Could someone either list or post a link to someplace that lists
> all the advantages of 4K stacks? 

* less kernel memory (eg lowmem) used for a thread 
   - allows more threads on the same system (java!)
   - increases performance in high-thread systems because more memory
     is available for disk cache etc
* thread stacks are now order 0 not order 1
   - order 0 is easy for the VM, order > 0 is harder (increasingly so
     the higher the order; so the 16Kb/32Kb request is just really
     wrong). For order > 0, fragmentation becomes an issue (just look
     at the entire fragmentation debate from a few weeks ago how bad
     a problem fragmentation can be). Thread stacks are just about the
     last remaining "big" user of order > 0 allocations normally.
     (eg excluding init/setup code)
   - order 0 allocations come from a per cpu "quicklist" of pages, 
     while order>0 allocations need to go to a global allocator pool.
     "global" means "cache line bounces" and "cpu scalability problem".
* less CPU cache footprint due to interrupt stacks
   - interrupt stacks are per cpu now instead of borrowing the per
     thread stack space; this both has less impact on the caches, and
     has more cache hits; the per cpu stack will be in cache more than
     the previously scattered bits and pieces
* more stack space is available for interrupts compared to 2.4 kernels
   - in 2.4 kernels only 2Kb was available for interrupt context (to
     keep 4K available for user context). With complex softirqs such as
     PPP and firewall rules and nested interrupts this wasn't always
     enough. Compared to 2.6-with-8Kstacks is a bit harder; there is
     2Kb extra available there compared to 2.4 and arguably some of that
     extra is for interrupts.




