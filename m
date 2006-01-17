Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWAQMo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWAQMo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWAQMo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:44:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53962 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932462AbWAQMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:44:59 -0500
Date: Tue, 17 Jan 2006 12:43:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Ulrich Drepper <drepper@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dvhltc@us.ibm.com,
       linux-mm@kvack.org, blaisorblade@yahoo.it, jdike@addtoit.com,
       akpm@osdl.org
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
Message-ID: <20060117124315.GA7754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nicholas Miell <nmiell@comcast.net>,
	Suleiman Souhlal <ssouhlal@FreeBSD.org>,
	Ulrich Drepper <drepper@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	hugh@veritas.com, dvhltc@us.ibm.com, linux-mm@kvack.org,
	blaisorblade@yahoo.it, jdike@addtoit.com
References: <20051111174309.5d544de4.akpm@osdl.org> <43757263.2030401@us.ibm.com> <20060116130649.GE15897@opteron.random> <43CBC37F.60002@FreeBSD.org> <20060116162808.GG15897@opteron.random> <43CBD1C4.5020002@FreeBSD.org> <20060116172449.GL15897@opteron.random> <m1r777rgq4.fsf@ebiederm.dsl.xmission.com> <43CC3922.2070205@FreeBSD.org> <1137459847.2842.6.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137459847.2842.6.camel@entropy>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 05:04:07PM -0800, Nicholas Miell wrote:
> On Mon, 2006-01-16 at 16:24 -0800, Suleiman Souhlal wrote:
> > Eric W. Biederman wrote:
> > > As I recall the logic with DONTNEED was to mark the mapping of
> > > the page clean so the page didn't need to be swapped out, it could
> > > just be dropped.
> > > 
> > > That is why they anonymous and the file backed cases differ.
> > > 
> > > Part of the point is to avoid the case of swapping the pages out if
> > > the application doesn't care what is on them anymore.
> > 
> > Well, imho, MADV_DONTNEED should mean "I won't need this anytime soon", 
> > and MADV_FREE "I will never need this again".
> > 
> 
> POSIX doesn't have a madvise(), but it does have a posix_madvise(), with
> flags defined as follows:
> 
> POSIX_MADV_NORMAL
>    Specifies that the application has no advice to give on its behavior
> with respect to the specified range. It is the default characteristic if
> no advice is given for a range of memory.
> POSIX_MADV_SEQUENTIAL
>    Specifies that the application expects to access the specified range
> sequentially from lower addresses to higher addresses.
> POSIX_MADV_RANDOM
>    Specifies that the application expects to access the specified range
> in a random order.
> POSIX_MADV_WILLNEED
>    Specifies that the application expects to access the specified range
> in the near future.
> POSIX_MADV_DONTNEED
>    Specifies that the application expects that it will not access the
> specified range in the near future.
> 
> Note that glibc forwards posix_madvise() directly to madvise(2), which
> means that right now, POSIX conformant apps which use
> posix_madvise(addr, len, POSIX_MADV_DONTNEED) are silently corrupting
> data on Linux systems.

Does our MAD_DONTNEED numerical value match glibc's POSIX_MADV_DONTNEED?

In either case I'd say we should backout this patch for now.  We should
implement a real MADV_DONTNEED and rename the current one to MADV_FREE,
but that's 2.6.17 material.
