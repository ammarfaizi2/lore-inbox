Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSKEJXO>; Tue, 5 Nov 2002 04:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSKEJXO>; Tue, 5 Nov 2002 04:23:14 -0500
Received: from mhost.enel.ucalgary.ca ([136.159.102.8]:19848 "EHLO
	mhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263207AbSKEJXM>; Tue, 5 Nov 2002 04:23:12 -0500
Date: Tue, 5 Nov 2002 02:29:44 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: reiser <reiser@namesys.com>
Cc: Nikita Danilov <Nikita@namesys.com>, Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021105022944.A14575@munet-d.enel.ucalgary.ca>
Mail-Followup-To: reiser <reiser@namesys.com>,
	Nikita Danilov <Nikita@namesys.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Alexander Zarochentcev <zam@namesys.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Oleg Drokin <green@namesys.com>, umka <umka@namesys.com>
References: <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com> <20021102132421.GJ28803@louise.pinerecords.com> <15814.21309.758207.21416@laputa.namesys.com> <3DC19F61.5040007@namesys.com> <3DC773B0.4070701@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC773B0.4070701@namesys.com>; from reiser@namesys.com on Mon, Nov 04, 2002 at 11:30:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2002  23:30 -0800, reiser wrote:
> The appropriate setting of 
> transaction max age depends on the user.  The setting we chose is 
> appropriate for software developers doing compiles.  It is not clear to 
> me yet what the right setting is.  Perhaps 3 minutes is more 
> appropriate.  I was probably overly influenced by Drew Roselli's 
> statistics on how long the cyle is between rewrites.  Her statistics are 
> probably skewed by having lots of CS students using the machines she got 
> her data from.  5 seconds is too short to perform good layout 
> optimization for subsequent reads.

I think the bdflush defaults are (were?) something like 5 seconds for
metadata, and 30 seconds for file data. reiser4 should (if it doesn't
already) use the parameters set by sys_bdflush() to tune the writeout
intervals.

I would think that either:
a) A file was completely written in under 30 seconds (e.g. untar or gcc
   or whatever else you are doing), so deferring allocation and writing
   to disk does not help you at all.
b) A file is continuing to be written for more than 30 seconds that
   has a very large amount of outstanding data which can be committed
   to disk with (probably) the same read optimization quality as any
   larger amount of data.
c) A file is continuing to be written for more than 30 seconds that
   is growing slowly and no matter how long you defer the write you
   will only get an incremental read layout.  Presumably you could do
   something to pre-allocate/reserve a bunch of space at the end of this
   file as it continues to grow.

So, except for the very unusual case of files with lifespans between 30
seconds and 300 seconds, or files that are written to between those
intervals, I would guess that you are not gaining much extra benefit by
deferring the writes another 270 seconds.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
