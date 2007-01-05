Return-Path: <linux-kernel-owner+w=401wt.eu-S1749667AbXAEUCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1749667AbXAEUCz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbXAEUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:02:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39227 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1749667AbXAEUCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:02:54 -0500
Date: Fri, 5 Jan 2007 12:02:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
In-Reply-To: <Pine.LNX.4.64.0701051122040.3661@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701051147090.28519@schroedinger.engr.sgi.com>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net>
 <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net>
 <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051109300.28395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0701051122040.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Linus Torvalds wrote:

> However, a lot of the code isn't really amenable to it as it stands now. 
> We very much tend to call it in critical sections, and you have to move 
> them all out of the locks they are now.

It looks as if most code handling the dirty bits already uses the page 
lock?

> "Artistic". Good word. That said, most of the code in there needs its own 
> locks for other reasons (ie the reason __set_page_dirty_nobuffers() ends 
> up taking the tree-lock is because of the radix tree bits, which can NOT 
> be protected by per-page locks _anyway_).

According to the comments: Most callers of __set_page_dirty_nobuffers hold 
the page lock. The only exception seems to be zap_pte_range where we 
transfer the dirty information from the pte to the page. This is now much 
rarer since the dirty mmap tracking patches make the fault handler deal 
with it.

Still, the page dirtying in zap_pte_range remains a potential trouble spot 
for the remaining cases in which we need to dirty pages there since it is 
not rate limited. There is a potential cause for creating deadlocks 
because too many pages were dirtied and the file system cannot allocate 
enough memory for writeout.

