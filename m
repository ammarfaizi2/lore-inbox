Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUEYVuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUEYVuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265121AbUEYVsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:48:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31667 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265111AbUEYVq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:46:59 -0400
Date: Tue, 25 May 2004 23:48:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, andrea@suse.de, torvalds@osdl.org,
       phyprabab@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040525214817.GA21112@elte.hu>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525141622.49e86eb9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525141622.49e86eb9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> wrote:

> > Btw, you're right about the VMAs.  Looking through customer
> > stuff a bit more the more common issues are low memory being
> > eaten by dentry / inode cache - which you can't always reclaim
> > due to files being open, and don't always _want_ to reclaim
> > because that could well be a bigger performance hit than the
> > 4:4 split.
> 
> I did some testing a year or two back with the normal zone wound down
> to a few hundred megs - filesytem benchmarks were *severely* impacted
> by the increased turnover rate of fs metadata pagecache and VFS
> caches.  I forget the details, but it was "wow".

and it's not only the normal workloads we know about - people really do
lots of weird stuff with Linux (and we are happy that they use Linux and
that Linux keeps chugging along), and people seem to prefer a 10%
slowdown to a box that locks up or -ENOMEM's. I'm not trying to insert
any unjustified fear, 3:1 can be ok with lots of RAM, but it's _clearly_
wishful thinking that 32 GB x86 will be OK with just 600 MB of lowmem.
600 MB of lowmem means a 1:80 lowmem to RAM ratio, which is insane. Yes,
it will be OK with select workloads and applications. With 4:4 it's 3.4
GB lowmem and the ratio is down to a much saner 1:9, and boxes pushed
against the wall keep up better.

(but i wont attempt to convince Andrea - and i'm not at all unhappy that
he is trying to fix 3:1 to be more usable on big boxes because those
efforts also decrease the RAM footprint of the UP kernel, which is
another sensitive area. These efforts also help sane 64-bit
architectures, so it's a win-win situation even considering our
disagreement wrt. 4:4.)

> I'm suspecting we'll end up needing mempools (or something) of 1- and
> 2-order pages to support large-frame networking.  I'm surprised there
> isn't more pressure to do something about this.  Maybe people are
> increasing min_free_kbytes.

hm, 1.5K pretty much seems to be the standard. Plus large frames can be
scatter-gathered via fragmented skbs. Seldom is there a need for a large
skb to be linear.

	Ingo
