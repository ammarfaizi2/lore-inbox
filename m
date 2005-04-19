Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVDSShN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVDSShN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVDSShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:37:12 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:23952
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261547AbVDSSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:36:56 -0400
Date: Tue, 19 Apr 2005 11:30:44 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Martin Hicks <mort@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, holt@sgi.com
Subject: Re: [PATCH] pgtables: fix GFP_KERNEL allocation with preempt
 disabled
Message-Id: <20050419113044.26911ebf.davem@davemloft.net>
In-Reply-To: <20050419170413.GB21616@localhost>
References: <20050419170413.GB21616@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005 13:04:13 -0400
Martin Hicks <mort@sgi.com> wrote:

> This is a fix to the pgtable_quicklist code.  There is a GFP_KERNEL
> allocation in pgtable_quicklist_alloc(), which spews the usual warnings
> if the kernel is under heavy VM pressure and the reclaim code is
> invoked.
> 
> This patch is against 2.6.12-rc2-mm2

I think you should really drop the preempt disable during this allocation
instead, that's what we do in the sparc64 quicklist code.

It's very simple, change the code to:

		preempt_enable();
	} else {
		preempt_enable();
		ret = (unsigned long *) ...;
	}
	/* preempt_enable() no longer here */
