Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCZWzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUCZWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:55:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4320 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261410AbUCZWzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:55:01 -0500
Date: Fri, 26 Mar 2004 14:54:23 -0800
From: "David S. Miller" <davem@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org,
       wli@holomorphy.com
Subject: Re: Sparc64, cpumask_t and struct arguments (was: [PATCH] Introduce
 nodemask_t ADT)
Message-Id: <20040326145423.74c1ce52.davem@redhat.com>
In-Reply-To: <20040326143648.5be0e221.pj@sgi.com>
References: <20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
	<20040322183918.5e0f17c7.pj@sgi.com>
	<20040323031345.GY2045@holomorphy.com>
	<20040322193628.4278db8c.pj@sgi.com>
	<20040323035921.GZ2045@holomorphy.com>
	<20040325012457.51f708c7.pj@sgi.com>
	<20040325101827.GO791@holomorphy.com>
	<20040326143648.5be0e221.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 14:36:48 -0800
Paul Jackson <pj@sgi.com> wrote:

> However, as I recall, you recommend against passing structs on the
> Sparc64 processor and compilation environment.  Am I recalling
> correctly?

It's a problem moreso on sparc32.  Structures there have to be passed
"by reference", which means it gets copied onto the stack and then a
pointer to that data area is passed as the actual parameter.

Sparc64 does the same but only _iff_ the structure does not fit entirely
in the remaining argument registers or the structures size is greater
than 32-bytes.

The cross-call functions you reference are slow path code.  And whats
more currently none of that code supports more than 64 cpus, although
I'll have to add support for larger numbers later.

>  5) The cpu_clear(i, mask) on about line 534 of smp.c confuses me, as it
>     seems to be changing a local copy of 'mask' that no one will examine
>     later.  What purpose does it serve?  See this line annotated with
>     "No affect??" in the changes, below.

No, mask is the top level mask value, we assign it to local variable
in order to do this or that operation on it.  Once we've really send
the XCALL message to the processor, we clear it in 'mask' only then.

