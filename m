Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSICRKy>; Tue, 3 Sep 2002 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSICRKy>; Tue, 3 Sep 2002 13:10:54 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:9168 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S318198AbSICRKw>; Tue, 3 Sep 2002 13:10:52 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 3 Sep 2002 10:07:48 -0700 (PDT)
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <200209031641.g83GfnD10219@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0209031003370.1889-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, the thing that you seem to be missing is that direct mode only
works for writes, it doesn't force a filesystem to go to the hardware for
reads.

for many filesystems you cannot turn off their internal caching of data
(metadata for some, all data for others)

so to implement what you are after you will have to modify the filesystem
to not cache anything, since you aren't going to do this for every
filesystem you end up only haivng this option on the one(s) that you
modify.

if you have a single (or even just a few) filesystems that have this
option you may as well include the locking/syncing software in them rather
then modifying the VFS layer.

David Lang


 On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> Date: Tue, 3 Sep 2002 18:41:49 +0200 (MET DST)
> From: Peter T. Breuer <ptb@it.uc3m.es>
> To: Lars Marowsky-Bree <lmb@suse.de>
> Cc: Peter T. Breuer <ptb@it.uc3m.es>,
>      linux kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [RFC] mount flag "direct"
>
> "A month of sundays ago Lars Marowsky-Bree wrote:"
> >    "Peter T. Breuer" <ptb@it.uc3m.es> said:
> >
> > > No! I do not want /A/ fs, but /any/ fs, and I want to add the vfs
> > > support necessary :-).
> > >
> > > That's really what my question is driving at. I see that I need to
> > > make VFS ops communicate "tag requests" to the block layer, in
> > > order to implement locking. Now you and Rik have pointed out one
> > > operation that needs locking. My next question is obviously: can you
> > > point me more or less precisely at this operation in the VFS layer?
> > > I've only started studying it and I am relatively unfamiliar with it.
> >
> > Your approach is not feasible.
>
> But you have to be specific about why not. I've responded to the
> particular objections so far.
>
> > Distributed filesystems have a lot of subtle pitfalls - locking, cache
>
> Yes, thanks, I know.
>
> > coherency, journal replay to name a few - which you can hardly solve at the
>
> My simple suggestion is not to cache. I am of the opinion that in
> principle that solves all coherency problems, since there would be no
> stored state that needs to "cohere". The question is how to identify
> and remove the state that is currently cached.
>
> As to journal replay, there will be no journalling - if it breaks it
> breaks and somebody (fsck) can go fix it. I don't want to get anywhere
> near complicated.
>
> > VFS layer.
> >
> > Good reading would be any sort of entry literature on clustering, I would
>
> Please don't condescend! I am honestly not in need of education :-).
>
> > recommend "In search of clusters" and many of the whitepapers Google will turn
> > up for you, as well as the OpenGFS source.
>
> (Puhleeese!)
>
> We already know that we can have a perfectly fine and arbitrary
> shared file system, shared only at the block level if we
>
>   1) permit no new dirs or files to be made (disable O_CREAT or something
>      like)
>   2) do all r/w on files with O_DIRECT
>   3) do file extensions via a new generic VFS "reserve" operation
>   4) have shared mutexes on all vfs op, implemented by passing
>      down a special "tag" request to the block layer.
>   5) maintain read+write order at the shared resource.
>
> I have already implemented 2,4,5.
>
> The question is how to extend the range of useful operations. For the
> moment I would be happy simply to go ahead and implement 1) and 3),
> while taking serious strong advice on what to do about directories.
>
>
>
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
