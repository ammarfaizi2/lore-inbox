Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVCWAFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVCWAFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVCWAEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:04:44 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:31185
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262507AbVCWACT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:02:19 -0500
Date: Tue, 22 Mar 2005 16:00:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322160042.13e55944.davem@davemloft.net>
In-Reply-To: <4240AAFA.1040206@yahoo.com.au>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
	<20050322123301.090cbfa6.davem@davemloft.net>
	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
	<4240AAFA.1040206@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here are (finally, I've been debugging this so much purely
to see these things) some lmbench numbers with Hugh's base
patch on sparc64.

Ignore my previous comments about shell performance getting
worse, it's some difference that makes things run more slowly
in single user mode compared to a fully brought up system.

First, for 32-bit tasks.

BEFORE
Process fork+exit: 171.4483 microseconds
Process fork+exit: 171.9688 microseconds
Process fork+exit: 169.2727 microseconds
Process fork+exit: 169.0333 microseconds
Process fork+exit: 165.8065 microseconds
Process fork+execve: 555.7000 microseconds
Process fork+execve: 556.6000 microseconds
Process fork+execve: 552.6000 microseconds
Process fork+execve: 557.1000 microseconds
Process fork+execve: 552.3333 microseconds
Process fork+/bin/sh -c: 2207.3333 microseconds
Process fork+/bin/sh -c: 2183.0000 microseconds
Process fork+/bin/sh -c: 2179.6667 microseconds
Process fork+/bin/sh -c: 2190.0000 microseconds
Process fork+/bin/sh -c: 2197.6667 microseconds

AFTER
Process fork+exit: 142.9487 microseconds
Process fork+exit: 147.8649 microseconds
Process fork+exit: 139.0250 microseconds
Process fork+exit: 138.9250 microseconds
Process fork+exit: 136.9268 microseconds
Process fork+execve: 478.3333 microseconds
Process fork+execve: 479.1667 microseconds
Process fork+execve: 479.9091 microseconds
Process fork+execve: 480.1667 microseconds
Process fork+execve: 479.9091 microseconds
Process fork+/bin/sh -c: 2026.0000 microseconds
Process fork+/bin/sh -c: 2029.6667 microseconds
Process fork+/bin/sh -c: 2044.6667 microseconds
Process fork+/bin/sh -c: 2037.6667 microseconds
Process fork+/bin/sh -c: 2028.6667 microseconds

Pretty good, now for 64-bit processes.

BEFORE
Process fork+exit: 226.5200 microseconds
Process fork+exit: 230.0417 microseconds
Process fork+exit: 223.8800 microseconds
Process fork+exit: 226.4091 microseconds
Process fork+exit: 219.3043 microseconds
Process fork+execve: 799.8571 microseconds
Process fork+execve: 806.1429 microseconds
Process fork+execve: 799.5714 microseconds
Process fork+execve: 800.8571 microseconds
Process fork+execve: 788.7143 microseconds
Process fork+/bin/sh -c: 2655.0000 microseconds
Process fork+/bin/sh -c: 2668.5000 microseconds
Process fork+/bin/sh -c: 2649.0000 microseconds
Process fork+/bin/sh -c: 2662.5000 microseconds
Process fork+/bin/sh -c: 2642.0000 microseconds

AFTER
Process fork+exit: 165.1212 microseconds
Process fork+exit: 159.4571 microseconds
Process fork+exit: 160.3714 microseconds
Process fork+exit: 158.9091 microseconds
Process fork+exit: 157.2188 microseconds
Process fork+execve: 536.4545 microseconds
Process fork+execve: 542.0909 microseconds
Process fork+execve: 536.3000 microseconds
Process fork+execve: 540.6364 microseconds
Process fork+execve: 537.1818 microseconds
Process fork+/bin/sh -c: 2275.0000 microseconds
Process fork+/bin/sh -c: 2272.0000 microseconds
Process fork+/bin/sh -c: 2275.6667 microseconds
Process fork+/bin/sh -c: 2270.3333 microseconds
Process fork+/bin/sh -c: 2284.0000 microseconds

Quite nice.  It makes the 64-bit numbers on par with
the 32-bit numbers.
