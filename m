Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSFPSnQ>; Sun, 16 Jun 2002 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316523AbSFPSnQ>; Sun, 16 Jun 2002 14:43:16 -0400
Received: from ns.suse.de ([213.95.15.193]:50699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316512AbSFPSnN>;
	Sun, 16 Jun 2002 14:43:13 -0400
Date: Sun, 16 Jun 2002 20:43:06 +0200
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
Message-ID: <20020616204305.A32022@wotan.suse.de>
References: <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com> <20020614062754.A11232@wotan.suse.de> <20020614112849.A22888@redhat.com> <20020614181328.A18643@wotan.suse.de> <20020614173133.GH2314@inspiron.paqnet.com> <20020614200537.A5418@wotan.suse.de> <m17kkzv8lq.fsf@frodo.biederman.org> <20020616184801.A15227@wotan.suse.de> <m13cvnun7o.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13cvnun7o.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2002 at 11:50:51AM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Sun, Jun 16, 2002 at 04:08:49AM -0600, Eric W. Biederman wrote:
> > > 
> > > Don't allow the change_page_attr if page->count > 1 is an easy solution,
> > > and it probably suffices.  Beyond that anything mmaped can be found
> > 
> > Erm, what should it do then? Fail the AGP map ?
> 
> Why not.  If user-space has already mapped the memory one way, turning
> around and using it another way is a problem.  If the memory is
> dynamically allocated for AGP I don't even see how this case
> could occur.

It's a random error. AGP randomly gets some page that is already mapped
by /dev/mem somewhere. There is nothing that it can do to avoid this.
As /dev/mem is root only and root can already cause much damage it is
probably not worth avoiding the particular breakage.

Now if someone used change_page_attr as a more general call and used
it on random memory that could be already mapped to user space in a more
legitimate way then he or she has to do much more work anyways (avoiding
alias etc.). Part of that more work would be to check the page count.
I don't think it should be done by the low level routine.


> 
> The kernel already exposes through /proc/mtrr the ability to
> arbitrarily change the caching of pages.  And since this is a case
> of physical aliasing we need to make certain the mtrr's don't
> conflict.  So much of this is already exposed to user space already.

MTRRs work on physical, not virtual memory, so they have no aliasing
issues.

> > You can already use WT. DRM does that already in fact. 
> > Newer Intel/AMD CPUs allow to set up a more general PAT table with some
> > more modis, but to be honest I don't see the point in most of them,
> > except perhaps WC. Unfortunately there is no 'weak ordering like alpha/sparc64'
> > mode that could be used in the kernel :-)
> 
> With the PAT table only write-back, write-combining, uncached interest
> me.  Given the number of BIOS's that don't set all of RAM to
> write-back and the major performance penalty of running on uncached
> RAM having the kernel fix it, would reduce a lot of headaches long
> term. 

Fixing the MTRRs is fine, but it is really outside the scope of my patch.
Just changing the kernel map wouldn't be enough to fix wrong MTRRs,
because it wouldn't cover highmem. 

-Andi
