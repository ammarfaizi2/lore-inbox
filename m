Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932952AbWFMH1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbWFMH1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932953AbWFMH1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:27:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19918 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932952AbWFMH1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:27:44 -0400
Date: Tue, 13 Jun 2006 09:26:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060613072646.GA17978@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu> <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com> <20060612192227.GA5497@elte.hu> <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> Hi Ingo,
> 
> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > i dont know - i feel uneasy about the 'any pointer' method - it has a 
> > high potential for false negatives, especially for structures that 
> > contain strings (or other random data), etc.
> 
> Is that a problem in practice?  Structures that contain data are 
> usually allocated from the slab.  There needs to be a link to that 
> struct from the gc roots to get a false negative.  Or am I missing 
> something here?

you should think of this in terms of a 'graph of data', where each node 
is a block of memory. The edges between nodes are represented by 
pointers. The graph roots from .data/bss, but it may go indefinitely 
into dynamically allocated blocks as well - just think of a hash-list 
where the hash list table is in .data, but all the chain entries are in 
allocated blocks and the chaining can be arbitrarily deep.

Furtermore, each block of data has a couple of fields within it that 
contain 'outgoing pointers', and each block of data has a couple of 
addresses associated with it that are valid targets for 'incoming 
pointers'.

The task of kmemleak is to find orphan blocks of memory - the ones that 
are not connected to the graph via any edge. For that it starts scanning 
in .data/bss and recursively searches through the blocks of memory 
(marking all scanned blocks, to avoid circular walking of the graph) 
until it has walked the whole graph. Blocks that were registered but 
were not touched during this recursive walking are the leaks.

Currently kmemleak does not track the per-block position of 'outgoing 
pointers': it assumes that all fields within a block may be an outgoing 
pointer. This is a source of false negatives. (fields that do not 
contain a real pointer might accidentally contain a value that is 
interpreted as a false edge - falsely connecting a leaked block to the 
graph.)

Kmemleak does recognize 'incoming pointers' via the offsetof tracking 
method, but it's limited in that it is not a type-accurate method 
either: it tracks per-size offsets, so two types accidentally having the 
same size merges their 'possible incoming pointer offset' lists, which 
introduces false negatives. (a pointer may be considered an incoming 
edge while in reality the pointer is not validly pointing into this 
structure)

The full matching that was suggested before would further weaken the 
'incoming pointers' logic and would introduce yet another source of 
false negatives: we'd match every block pointer against every possible 
target address that points to within another block.

My suggestion would be to attempt to achieve perfect matches: annotate 
structures to figure out the offset of pointers, and thus to figure out 
the precise source addresses and a precise list of valid target 
addresses. This is a quite elaborate task to pull off though, and i'm 
not sure it's possible without intolerable maintainance overhead, but we 
should consider it nevertheless. It will also be _much_ faster, because 
per block we'd only have to scan a handful of outgoing pointers.

Perhaps a hybrid method could be used: by default we assume the most 
lenient structure: if the block type is 'unknown' (which is the default 
for not-yet-annotated structures) then we'd assume that all fields are 
pointers, and that they could all be targets too.

Once a structure is annotated, the scope of scanning is drastically 
reduced: only the annotated fields are scanned for pointers (and at that 
point we'd also _enforce_ that those pointers do indeed point to valid 
blocks of memory - i.e. this would also serve as a pointer-correctness 
checker), and annotated blocks will also restrict the scope of 'incoming 
pointers'.

Naturally, there would be two types of annotations: one that finetunes 
the scanning of outgoing pointers to happen only for fields that are 
true pointers, and one that finetunes incoming pointer matching to only 
those addresses within the block that program logic allows. All in a 
strictly per-type manner.

This also means that by default we'd have no false positives at all, but 
that there is a capable annotation method to reduce the amount of false 
negatives, in a gradual and managable way - down to zero if everything 
is annotated.

	Ingo
