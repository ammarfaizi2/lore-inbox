Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWHDDAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWHDDAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWHDDAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:00:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:42164 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030298AbWHDDAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:00:11 -0400
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, y-goto@jp.fujitsu.com,
       andrew <akpm@osdl.org>
In-Reply-To: <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154650396.5925.49.camel@keithlap>
	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154656472.5925.71.camel@keithlap>
	 <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 20:00:08 -0700
Message-Id: <1154660408.5925.79.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 11:15 +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 03 Aug 2006 18:54:32 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > > Hmm..Okay. I'll try some check patch today. please review it.
> > > Maybe moving ioresouce collision check in early stage of add_memory() is good ?
> >   Yea.  I am working a a full patch set for but my sparsemem and reserve
> > add-based paths.  It creates a valid_memory_add_range call at the start
> > of add_memory. I should be posting the set in the next few hours.
> > 
> Ah..ok. but I wrote my own patch...and testing it now..

Sure that is fine. 
> 
> > > Note:
> > > I remove pfn_valid() here because pfn_valid() just says section exists or
> > > not. When adding seveal small memory chunks in one section, Only the  first
> > > small chunk can be added. 
> > Hmm... I thought memory add areas needed to be section aligned for the arch?
> > 
> There are requests for memory-hot-add should allow to hot-add not-aligned memory.
> Then, I wrote ioresouce collision check patch (before..but had bug..)
> With ioresouce collistion check, alignments are not required at *add*.
> (onlining is just for  *offlined section*, now)
> 
> >   What protecting is there for calling add_memory on an already present
> > memory range?  
> > 
> For example, considering ia64, which has 1Gbytes section...

Maybe 1gb sections is too large?  

> hot add following region.
> ==
> (A) 0xc0000000 - 0xd7ffffff  (section 3)
> (B) 0xe0000000 - 0xffffffff  (section 3)
> ==
> (A) and (B) will go to the same section, but there is a memory hole between
> (A) and (B). Considering memory (B) appears after (A) in DSDT.
> 
> After add_memory() against (A) is called, section 3 is ready.
> Then, pfn_valid(0xe0000000) and pfn_valid(0xffffffff) returns true because
> they are in section 3.
> So, checking pfn_valid() for (B) will returns true and memory (B) cannot be
> added. ioresouce collision check will help this situation.

With iommus out there throwing aliment all off way the flexability is
good. 

My question is this.

Assuming 0-0xbfffffff is present.

What keeps 0xa0000000 to 0xa1000000 from being re-onlined by a bad call
to add_memory?

Thanks,
  Keith 



