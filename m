Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUC3CnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 21:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUC3CnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 21:43:20 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:60643 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263130AbUC3CnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 21:43:16 -0500
Date: Mon, 29 Mar 2004 17:46:37 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040329174637.3aa16260.pj@sgi.com>
In-Reply-To: <20040330020637.GA791@holomorphy.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	<1080601576.6742.43.camel@arrakis>
	<20040329235233.GV791@holomorphy.com>
	<20040329154330.445e10e2.pj@sgi.com>
	<20040330020637.GA791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> akpm, this is needed for mainline.

How urgent to you consider this fix (masking unused bits in the
arithmetic (single unsigned long word) cpumask implementation?

So far as I know, the only way to get high bits set with correct
invocations is by using cpus_complement(), which I don't see anyone
doing.

So I believe that this patch fixes latent bugs, not current bugs.

And it would be my preference (not surprisingly) to fix this in a way
that is consistent with my mask ADT proposal (avoid setting unused bits
on proper calls; don't filter on Boolean/scalar predicate evaluations):

+#if NR_CPUS % BITS_PER_LONG
+#define __CPU_VALID_MASK__		(~((1UL<< (NR_CPUS%BITS_PER_LONG) - 1))
+#else
+#define __CPU_VALID_MASK__		(~0UL)
+#endif

-#define cpus_complement(map)		do { map = ~(map); } while (0)
+#define cpus_complement(map)		\
+	do { map = ~(map) & __CPU_VALID_MASK__; } while (0)

_instead_ of changing the several other macros to follow the
bitmap convention (let the unused bits remain dont-care, until
resolving a Boolean or scalar predicate).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
