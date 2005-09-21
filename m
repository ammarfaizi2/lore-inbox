Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVIUQR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVIUQR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIUQR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:17:58 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:6491 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751114AbVIUQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:17:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=OUiS92xxPKNAf34n9mDsORryNwCKZYuV35AmUsMRGFw1znfNhIFrJsNkSU1/77U8maaQ71WtaMOlDgw/gnIvXRtlt76fTFnTspq+Hl8r4zphCVOspawCbftKkjlKxtRh4MjHlZNfVf1T0UiJgcs0JbXWo6Ju9R58giiiEB8nI3c=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Remap_file_pages, RSS limits, security implications (was: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3)
Date: Wed, 21 Sep 2005 18:16:36 +0200
User-Agent: KMail/1.8.2
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
References: <200508262023.29170.blaisorblade@yahoo.it> <200509201706.06852.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509211547270.6584@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509211547270.6584@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211816.37512.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 17:16, Hugh Dickins wrote:
> On Tue, 20 Sep 2005, Blaisorblade wrote:
> > On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:

> > Ahh, ok... VM_MAYSHARE is the recorded MAP_SHARED, while VM_SHARED says
> > whether the pages are actually shared and writable.

> That's it (let's say "potentially writable" - VM_SHARED says they're
> shared and already writable or shared and could be mprotected writable).

> It is confusing, but it's been that way for years, and once you grasp it,
> you like to keep it that way, so as to feel superior to everyone else ;)

> > > Though thinking through that again now, the user of the nonlinear vma
> > > is penalized,

> > Where? Not in the page fault path.... it's as penalized as the rest of
> > the system. Or will direct reclaim have a preference for pages of the
> > calling process?

> Not in the page fault path, no; and no, direct reclaim doesn't have that
> preference (sounds quite a good idea, but would need a different way of
> choosing pages to free, and would conflict with the swap token idea?).

> I meant in reclaim: that since try_to_unmap_cluster makes such poor
> choices of what to reclaim, and tries to reclaim more than asked because
> it's unable to target the page in question, I'd expect the user of a
> nonlinear vma to suffer more thrashing under memory pressure.

Other pages in the VMA may be unmapped, yes, but not freed. In fact, they're 
kept in by the pagecache reference; try_to_unmap() (or better its caller, 
shrink_list) will only actually free the page it asked for.

The only real "problem" is that we do ptep_clear_flush_young without 
activating the page. And yes, *this* may penalize who holds a nonlinear VMA. 
But this is probably fair, given that we're going to have trouble in freeing 
those pages.

> > So, it would really be better to actually enforce the RSS rlimit when
> > mapping in pages in *nonlinear* areas (and fallback on setting file PTE's
> > like on NONBLOCK & page not in cache), rather than the "current" Rik's
> > idea of marking pages as inactive on memory-hog processes.

> I'd go mad if I delved into these issues, luckily we have suckers like Rik
> and Nick and Con who are prepared to give their lives to such endless
> tuning.

> > But oh, right in mm/trash.c, the code which should do part of this is
> > fully commented out - and it was in the very first version of the code
> > (looking through bkcvs-git repository).

> mm/trash.c?  I got quite excited,
What would that have meant?
> but now it looks like you just mean 
> mm/thrash.c.
Yes.
> Yawn. 

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
