Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVITSFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVITSFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVITSFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:05:37 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:25937 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964785AbVITSFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:05:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QhIvXqfY6yGRrLXDuZpVs00njsp+A76SBni9c0+MjxnpEjrQH8ye7rpQXmxdWPqEfs7ynoUACBOf/GN0X4LW1OpZiMKQYjwyiMbkvP/U65ivl8NN3DOyH3NyxkyEmAfXsQEsh32DC7OXq7/FRlDCNufJiJQt/G/3xAGjS5eXSyc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@redhat.com>
Subject: Remap_file_pages, RSS limits, security implications (was: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3)
Date: Tue, 20 Sep 2005 17:06:05 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <200508262023.29170.blaisorblade@yahoo.it> <200509042110.01968.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201706.06852.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:
> On Sun, 4 Sep 2005, Blaisorblade wrote:
> > On Friday 02 September 2005 23:02, Hugh Dickins wrote:
> > > On Fri, 26 Aug 2005, Blaisorblade wrote:
> > > > Subject: [patch 06/18] remap_file_pages protection support: support
> > > > private vma for MAP_POPULATE

> > > [...]
> > > you're just letting private maps
> > > be populated linearly, that's fine.

> > Would that be a real problem, when limited to readonly mappings?

> Regarding nonlinear readonly.  I never asked Ingo why he excluded it -
> suspect he didn't intend to, but missed the peculiar treatment of VM_SHARED
> versus VM_MAYSHARE - my apologies, Ingo, if I'm underestimating you!
Ahh, ok... VM_MAYSHARE is the recorded MAP_SHARED, while VM_SHARED says 
whether the pages are actually shared and writable.
> But 
> I was glad he had because it demands write access to the file being mapped
> nonlinear.  Therefore the ordinary user cannot map libc.so nonlinear, and
> condemn all users to the sledgehammer fashion of try_to_unmap_cluster.

> Though thinking through that again now, the user of the nonlinear vma
> is penalized,

Where? Not in the page fault path.... it's as penalized as the rest of the 
system. Or will direct reclaim have a preference for pages of the calling 
process?
> and the whole system is penalized by the difficulty in 
> reclaiming efficiently, but I don't see the other users of the library
> particularly penalized (they might be unfairly advantaged by having its
> pages stay unnaturally long in memory).
Those pages would be either needed (and wouldn't be swapped anyway) or 
unneeded (and thus they'd waste memory).

But the waste is possible even currently. If not having rmap were a local DoS, 
well, an unprivileged user may well mmap and remap nonlinearly some really 
big files.

So, it would really be better to actually enforce the RSS rlimit when mapping 
in pages in *nonlinear* areas (and fallback on setting file PTE's like on 
NONBLOCK & page not in cache), rather than the "current" Rik's idea of 
marking pages as inactive on memory-hog processes.

But oh, right in mm/trash.c, the code which should do part of this is fully 
commented out - and it was in the very first version of the code (looking 
through bkcvs-git repository).

And the RLIMIT_RSS is totally unused - I bet Rik's patch didn't manage to go 
in, or it's me missing something?
> Either I was wrong before, or 
> I'm missing another aspect of it now: I don't know which.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
