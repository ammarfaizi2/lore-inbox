Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282676AbRK0AYy>; Mon, 26 Nov 2001 19:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282675AbRK0AYh>; Mon, 26 Nov 2001 19:24:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55561 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282676AbRK0AYO>; Mon, 26 Nov 2001 19:24:14 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: 26 Nov 2001 16:24:00 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tumf0$dvr$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011126165920.N730@lynx.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011126165920.N730@lynx.no>
By author:    Andreas Dilger <adilger@turbolabs.com>
In newsgroup: linux.dev.kernel
> 
> The other thing that concerns a journaling fs is write ordering.  If you
> can _guarantee_ that an entire track (or whatever) can be written to disk
> in _all_ cases, then it is OK to reorder write requests within that track
> AS LONG AS YOU DON'T REORDER WRITES WHERE YOU SKIP BLOCKS THAT ARE NOT
> GUARANTEED TO COMPLETE.
> 
> Generally, in Linux, ext3 will wait on all of the journal transaction
> blocks to be written before it writes a commit record, which is its way
> of guaranteeing that everything before the commit is valid.  If you start
> write cacheing the transaction blocks, return, and then write the commit
> record to disk before the other transaction blocks are written, this is
> SEVERELY BROKEN.  If it was guaranteed that the commit record would hit
> the platters at the same time as the other journal transaction blocks,
> that would be the minimum acceptable behaviour.
> 
> Obviously a working TCQ or write barrier would also allow you to optimize
> all writes before the commit block is written, but that should be an
> _enhancement_ above the basic write operations, only available if you
> start using this feature.
> 

Indeed; having explicit write barriers would be a very useful feature,
but the drives MUST default to strict ordering unless reordering (with
write barriers) have been enabled explicitly by the OS.

Furthermore, I would like to add the following constraint to your
writeup:

** For each individual sector, a write MUST either complete or not
   take place at all.  In other words, writes are guaranteed to be
   atomic on a sector-by-sector basis.

	-hpa


P.S. Thanks, Andre, for taking the initiative of getting an actual
commit model into the standardized specification.  Otherwise we'd be
doomed to continue down the path where what operating systems need for
sane operation and what disk drives provide are increasingly
divergent.
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
