Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVKWVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVKWVYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVKWVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:24:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22165
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932525AbVKWVYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:24:40 -0500
Date: Wed, 23 Nov 2005 13:24:40 -0800 (PST)
Message-Id: <20051123.132440.71355611.davem@davemloft.net>
To: arjan@infradead.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org, ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1132737084.2795.20.camel@laptopd505.fenrus.org>
References: <20051123002134.287ff226.akpm@osdl.org>
	<20051123.005530.17893365.davem@davemloft.net>
	<1132737084.2795.20.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Wed, 23 Nov 2005 10:11:24 +0100

> it can.. but only if we start using -ffunction-sections in the CFLAGS
> (or make all of these functions static I suppose and reenable
> -funit-at-a-time, which can be done for gcc 4.x only)

I actually just scanned the tree, and outside of files that
only get built on CONFIG_SMP (namely, arch/${ARCH}/kernel/smp{,boot}.c)
the IPI functions were %99 marked static already and the remaining
%1 should be marked static.  The cases in that %1 group are:

arch/mips/sibyte/sb1250/prom.c:prom_cpu0_exit()
arch/powerpc/kernel/machine_kexec_64.c:kexec_smp_down()

And as stated, those two can just be marked static right now.

So we could very easily remove the CONFIG_SMP ifdefs, but the
-funit-at-a-time requirement to get gcc to not emit unused static
functions is very unfortunate.

Even tricks like marking the IPI function "inline" don't work since
we're taking the address of the function.
