Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752052AbWCNKdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWCNKdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWCNKdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:33:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11136 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752052AbWCNKdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:33:00 -0500
Date: Tue, 14 Mar 2006 11:32:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Message-ID: <20060314103226.GF10870@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603131144.01462.ncunningham@cyclades.com> <20060313101214.GB2136@elf.ucw.cz> <200603132110.08324.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603132110.08324.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > - It doesn't get the pages compressed, and so makes inefficient use of
> > > the storage and forces more pages to be discarded that would otherwise be
> > > necessary.
> >
> > "more pages to be discarded" is untrue. If you want to argue that swap
> > needs to be compressed, feel free to submit patches for swap
> > compression.
> 
> If I'm trying to store an image of 5000 pages and I have 3000 pages of storage 
> available, I can compress them with LZF and put all 5000 on disk (assuming 
> the common 50% compression), or dicard 2000. More pages are discarded without 
> compression.

Ok, you are right, if user is low on swap space, that's what will
happen. It is uncommon case, so I forgot about it.

> > (Compression is actually not as important as you paint it. Rafael
> > implemented it, only to find out that it is 20 percent speedup in
> > common cases -- and your gzip actually slows things down.)
> 
> I don't use gzip. I agree it slows things down. But 20%? What algorithm did 
> you use? It will also depend on the speed of your cpu and drive. (If the cpu 
> is fast but the drive is slow or you're still only using synchronous I/O, 
> yes, the improvement might only be 20%).

LZF. Problem is not the disk/compression speed; problem is that other
stuff takes way too long. Like copy of memory (I have 1.5G here) and
preparing of drivers... I think it takes about as long as actually
writing it to disk. Then there's the system boot included in
resume... that takes ages.

I'll probably have to figure out which drivers take long to suspend :-(.

> > > - Bringing the pages back in by swap prefetching or swapoffing or
> > > whatever is equally inefficient (I was going to say 'particularly in low
> > > memory situations', but immediately ate my words as I remembered that if
> > > you've just swsusp'd, you've freed at least half of memory anyway).
> >
> > ...but allows you to use machine immediately after resume, which
> > people want, as you have just seen.
> 
> Just?

Well, in the begining of this thread someone wanted fast resume *and*
responsive system after it.

Old swsusp is fast resume (little data loaded), unresponsive system.
suspend 2 is slower resume (more data), responsive system.
swsusp + Con's patch should give:

fast resume to prompt (little data loaded)
unresponsive system at the very begining, but becoming okay as
background thread pulls back swapped pages.

I like his solution:
1) It is good for the user: seeing prompt early means user can start
typing commands etc.
2) It is simple enough for me :-).
								Pavel
-- 
107:        string strHome =
