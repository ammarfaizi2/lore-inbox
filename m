Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274603AbRJYO2i>; Thu, 25 Oct 2001 10:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274426AbRJYO22>; Thu, 25 Oct 2001 10:28:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20681 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S274603AbRJYO2N>; Thu, 25 Oct 2001 10:28:13 -0400
Date: Thu, 25 Oct 2001 15:30:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Steven Butler <stevenb1@bigpond.net.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Paging and fork copy-on-write semantics
In-Reply-To: <3BD7AA3A.8040104@bigpond.net.au>
Message-ID: <Pine.LNX.4.21.0110251506570.1169-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Steven Butler wrote:
> 
> I have been making use of copy-on-write semantics of linux fork to 
> duplicate a process around 100+ times to generate client load against a 
> server.  The copy-on-write allows me to run many more processes without 
> swap thrashing than I'd otherwise be able to.  The client code is in 
> perl, so the process sizes are in the MBs.  Using this technique I only 
> need about 2 MB per user, with around 5.5 MB shared.
> 
> What I've found is that everything works fine, so long as I don't run so 
> many clients that the kernel pages out part of a process.  When this 
> happens, it seems (from looking at top output) that the shared memory is 
> copied when it is paged-out.  What's worse is it seems that it is copied 
> for each process that is sharing it.  The net effect is that one page is 
> gained, but many more pages are created in the other processes that were 
> sharing the memory.  I typically see shared memory in each perl process 
> drop down to less than 2 MB when this occurs, so each process now 
> consumes about 6 MB of unshared memory (or so top tells me).

It's to be expected that "top" (or 3rd field of /proc/pid/statm) will
tell you that under heavy swapout.  It counts a page as "shared" if it's
currently mapped into more than one process (approx. description), and
swapout is doing its best to remove the mappings from processes, to free
up pages later; the usage count of the corresponding data, which would
include the swap usage count, is not being counted here (nor should it be).
If you were to swapoff, ideally you would find those shared counts going
back up to what they were; however, those processes do need that swap, so
in practice swapoff will probably fail or hang or cause OOM kills instead.

Hugh

