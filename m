Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTBJGVz>; Mon, 10 Feb 2003 01:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTBJGVz>; Mon, 10 Feb 2003 01:21:55 -0500
Received: from unthought.net ([212.97.129.24]:59016 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S263256AbTBJGVy>;
	Mon, 10 Feb 2003 01:21:54 -0500
Date: Mon, 10 Feb 2003 07:31:38 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210063138.GG1109@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210051007.GE1109@unthought.net> <200302100606.h1A66SOf023514@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302100606.h1A66SOf023514@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 01:06:27AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 10 Feb 2003 06:10:08 +0100, Jakob Oestergaard said:
> 
> > In stock 2.4.20 the interaction is horrible - whatever was done there is
> > not optimal.    A 'tar xf' on the client will neither load the network
> > nor the server - it seems to be network latency bound (readahead not
> > doing it's job - changing min-readahead and max-readahead on the client
> > doesn't seem to make a difference). However, my desktop (running on the
> 
> This sounds like the traditional NFS suckage that has been there for decades.
> The problem is that 'tar xf' ends up doing a *LOT* of NFS calls - a huge
> stream of stat()/open()/chmod()/utime() calls.  On a local disk, most of
> this gets accelerated by the in-core inode cache, but on an NFS mount, you're
> looking at lots and lots of synchronous calls.
> 
> In 'man 5 exports':
> 
>        async  This option allows the NFS server to violate  the  NFS  protocol
>               and  reply  to  requests before any changes made by that request
>               have been committed to stable storage (e.g. disc drive).
> 
>               Using this option usually improves performance, but at the  cost
>               that  an unclean server restart (i.e. a crash) can cause data to
>               be lost or corrupted.
> 
>               In releases of nfs-utils upto and including 1.0.0,  this  option
>               was  the  default.   In  this  and  future releases, sync is the
>               default, and async must be explicit  requested  if  needed.   To
>               help  make system adminstrators aware of this change, 'exportfs'
>               will issue a warning if neither sync nor async is specified.
> 
> Does this address your NFS issue?

No.  Tried it in the past, just tried it again to make sure.

The caching should be done client-side, I guess, to be effective. Even
if the server acknowledges operations before they hit the disks, the
client is still bound by the RPC call latency.

I'm sure there are problems preventing such caching...  Hmm... Seems
like the only way out is a multi-threaded tar   ;)   Or tar using AIO.

Btw. nocto on the client doesn't really seem to help matters much
either.

Thanks for the suggestion,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
