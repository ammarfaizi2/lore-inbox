Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030680AbWJKQ5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbWJKQ5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWJKQ5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:57:20 -0400
Received: from mail.suse.de ([195.135.220.2]:2253 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030680AbWJKQ5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:57:19 -0400
Date: Wed, 11 Oct 2006 18:57:18 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SPAM: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-ID: <20061011165717.GB5259@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org> <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org> <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 09:21:16AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 10 Oct 2006, Andrew Morton wrote:
> >
> > On Wed, 11 Oct 2006 15:39:22 +1000
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > > But I see that it does read twice. Do you want that behaviour retained? It
> > > seems like at this level it would be logical to read it once and let lower
> > > layers take care of any retries?
> > 
> > argh.  Linus has good-sounding reasons for retrying the pagefault-path's
> > read a single time, but I forget what they are.  Something to do with
> > networked filesystems?  (adds cc)
> 
> Indeed. We _have_ to re-try a failed IO that we didn't start ourselves.
> 
> The original IO could have been started by a person who didn't have 
> permissions to actually carry it out successfully, so if you enter with 
> the page locked (because somebody else started the IO), and you wait for 
> the page and it's not up-to-date afterwards, you absolutely _have_ to try 
> the IO, and can only return a real IO error after your _own_ IO has 
> failed.

Sure, but we currently try to read _twice_, don't we?

> There is another issue too: even if the page was marked as having an error 
> when we entered (and no longer locked - maybe the IO failed last time 
> around), we should _still_ re-try. It might be a temporary error that has 
> since gone away, and if we don't re-try, we can end up in the totally 
> untenable situation where the kernel makes a soft error into a hard one. 

Yes, and in that case I think the page should be !Uptodate, so no
problem there.
