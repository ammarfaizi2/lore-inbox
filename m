Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWFVIIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWFVIIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWFVIIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:08:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:39133 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932312AbWFVIIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:08:47 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Thu, 22 Jun 2006 10:08:41 +0200
User-Agent: KMail/1.8
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <200606220129.47546.ak@suse.de> <1150937729.6885.112.camel@galaxy.corp.google.com>
In-Reply-To: <1150937729.6885.112.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606221008.41873.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 02:55, Rohit Seth wrote:


> > - Put base address of user exportable part into GDT
> > - Access it using that.
>
> These are the steps that I'm proposing in vgetcpu:
>
> Read the GDT pointer in vgetcpu code path.  This is the base of gdt
> table.
> Read descriptor #20 from base.
> This is the pointer to user visible part of per cpu data structure.

> Please let me know if I'm missing something here.

Ok that would probably work, but you would need to export the GDT too.

I still don't see why we should do it - limit should be enough.

> Just a side note, in your vgetcpu patch, would it be better to return
> the logical CPU number (as printed in /proc/cpuinfo).

The latest code does that already - i dropped the cpuid code
completely and replaced it with LSL.

> Also, I think 
> applications would be interested in knowing the physical package id for
> cores sharing caches.

They can always map that themselves using cpuinfo. I would
prefer to not overload the single call too much.

> > And you can't get at at the base address anyways because they
> > are ignored in long mode (except for fs/gs). For fs/gs you would
> > need to save/restore them to reuse them which would be slow.
> >
> > You can't also just put them into fs/gs because those are
> > already reserved for user space.
>
> That is the reason I'm not proposing to alter existing fs/gs.
>
> > Also I don't know what other information other than cpu/node
> > would be useful, so just using the 20 bits of limit seems plenty to me.
>
> physical id (of the package for exmpale) is another useful field. 

Ok I see that, but it could be as well done by a small user space
library that reads cpuinfo once and maps given vgetcpu()

On the other hand I got people complaining who need some more
topology information (like number of cores/cpus), but /proc/cpuinfo
is quite slow and adds a lot of overhead to fast starting programs.

I've been pondering to put some more information about that
in the ELF aux vector, but exporting might work too. I suppose
exporting would require the vDSO first to give a sane interface.

> would also like to see number of interrupts serviced by this cpu, page
> faults  etc.  But I think that is a separate discussion.

Well, the complex mechanism you're proposing above only makes
sense if it is established more fields are needed (and cannot be satisfied
by reserving a few more segment selectors) I admit I'm not
quite convinced yet.

-Andi
