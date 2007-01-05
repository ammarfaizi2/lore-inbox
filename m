Return-Path: <linux-kernel-owner+w=401wt.eu-S1422685AbXAETMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbXAETMz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbXAETMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:12:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38337 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422685AbXAETMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:12:54 -0500
Date: Fri, 5 Jan 2007 11:12:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
In-Reply-To: <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701051109300.28395@schroedinger.engr.sgi.com>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net>
 <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net>
 <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Linus Torvalds wrote:

> And I haven't actually thought about it that much, so I could be full of 
> crap. But I don't see anything that protects against it: we may hold the 
> page lock, but since the code that marks things _dirty_ doesn't 
> necessarily always hold it, that doesn't help us. And we may hold the 
> "private_lock", but we drop it before we do the dirty bit clearing, and in 
> fact on UP+PREEMPT that very dropping could cause an active preemption to 
> take place, so..

Maybe we should require taking the page lock before the dirty bits are 
modified? That way we can avoid all the artistic code in there right now. 
It may be even become comprehensible. The page lock and the dirty bit use 
the same cacheline (same word actually), contention is rare and so there 
is likely only a negligible performance impact.
