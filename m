Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWFLQiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWFLQiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWFLQiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:38:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44683 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751006AbWFLQiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:38:03 -0400
Date: Mon, 12 Jun 2006 09:37:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: broken local_t on i386
In-Reply-To: <20060612114857.GA14616@elte.hu>
Message-ID: <Pine.LNX.4.64.0606120921130.18975@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
 <20060610092412.66dd109f.akpm@osdl.org> <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
 <20060610100318.8900f849.akpm@osdl.org> <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
 <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
 <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
 <20060612110537.GA11358@elte.hu> <20060612114857.GA14616@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Ingo Molnar wrote:

> below is an updated patch that includes fixups for i386 - but the real 
> fix should be to properly reduce the per-arch local.h footprint to the 
> bare minimum possible, and to do this fix on the asm-generic headers.

Nak. This is simply evidence of local.t breakage on i386. One cannot 
calculate the address of a per cpu area and then increment without 
disabling preemption. The process may have been moved to another processor 
between those two operations and will then increment the event counter of 
the former processor (which in turn may at the same time increment the 
same counter). The inc is not atomic in the sense that it syncs multiple 
processors. So we will have the race back.

The increment must occur directly through the atomic-vs-interrupt dec/inc 
on the local per cpu area *without* any use of *_smp_processor_id().

As far as I can see x86_64 does the right thing and it increments on the 
local per cpu area. The definition of __get_cpu_var is:

#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))

i386 uses the asm-generic/percpu.h but provides its own 
implementation of local.t. That simply cannot work. i386
must provide a definition of __get_per_var that increments directly 
on the variable in the local per cpu area.

The definition for __get_cpu_var in asm-generic/percpu.h is:

#define __get_cpu_var(var) per_cpu(var, smp_processor_id())

This breaks the cpu_* operations for local.t on i386.

Also we have various forms of __raw_get_cpu_var() around. Is there any 
reason for their existence. The presence of these shows the assumption 
that one can determine the current processor id and then index into an 
array of per cpu areas. That is not possible with preemption enabled.

In the absence of a race free __get_cpu_var() i386 would need to fall 
back to atomic ops by using asm-generic/local.t.

