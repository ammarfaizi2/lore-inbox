Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVBZA47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVBZA47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBZA47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:56:59 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14407
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262148AbVBZA4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:56:23 -0500
Date: Sat, 26 Feb 2005 01:56:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, hugh@veritas.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
Message-ID: <20050226005620.GN20715@opteron.random>
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net> <20050225220543.GC15867@shell0.pdx.osdl.net> <421FA61B.9050705@us.ibm.com> <20050225233806.GD15867@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225233806.GD15867@shell0.pdx.osdl.net>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 03:38:06PM -0800, Chris Wright wrote:
> I don't have a good sampling of applications.  The one's I've used are
> temporal like gpg, or they mlockall the whole thing and never look back.
> But I did a quick benchmark since I was curious, a simple loop of a
> million lock/unlock cycles of a page that could trigger a merge:
> 
> vanilla
> (no merge): 659706 usecs
> 
> patched
> (merge):    3567020 usecs
> 
> Heh, I was surprised to see it that much slower.

The object of the merge is to save memory, and to reduce the size of the
rbtree that might payoff during other operations (with a smaller tree,
lookups will be faster too). If you only measure the time of creating
and removing a mapping then it should be normal that you see a slowdown
since merging involves more work than non-merging. The payoff is
supposed to be in the other operations.

The reason mlock doesn't merge is that nobody asked for it yet, but it
was originally supposed to merge too (I stopped at mremap since mlock
wasn't high prio to fixup). But the long term plan was to eventually add
merging to mlock too and it's good that you're optimizing it now.
