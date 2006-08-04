Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWHDDXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWHDDXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWHDDXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:23:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:1417 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030308AbWHDDXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:23:49 -0400
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, y-goto@jp.fujitsu.com,
       andrew <akpm@osdl.org>
In-Reply-To: <20060804121308.e9720b49.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154650396.5925.49.camel@keithlap>
	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154656472.5925.71.camel@keithlap>
	 <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154660408.5925.79.camel@keithlap>
	 <20060804121308.e9720b49.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 20:23:46 -0700
Message-Id: <1154661826.5925.92.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 12:13 +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 03 Aug 2006 20:00:08 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> 
> > > >   What protecting is there for calling add_memory on an already present
> > > > memory range?  
> > > > 
> > > For example, considering ia64, which has 1Gbytes section...
> > 
> > Maybe 1gb sections is too large?  
> > 
> ia64 machines sometimes to have crazy big memory...so 1gb section is requested.
> Configurable section_size for small machines was rejected in old days.

My HW supports about 512gb...... 

What if you add a partial section.  Then online in sysfs and add another
section?  messy....
> 
> > > hot add following region.
> > > ==
> > > (A) 0xc0000000 - 0xd7ffffff  (section 3)
> > > (B) 0xe0000000 - 0xffffffff  (section 3)
> > > ==
> > > (A) and (B) will go to the same section, but there is a memory hole between
> > > (A) and (B). Considering memory (B) appears after (A) in DSDT.
> > > 
> > > After add_memory() against (A) is called, section 3 is ready.
> > > Then, pfn_valid(0xe0000000) and pfn_valid(0xffffffff) returns true because
> > > they are in section 3.
> > > So, checking pfn_valid() for (B) will returns true and memory (B) cannot be
> > > added. ioresouce collision check will help this situation.
> > 
> > With iommus out there throwing aliment all off way the flexability is
> > good. 
> > 
> > My question is this.
> > 
> > Assuming 0-0xbfffffff is present.
> > 
> > What keeps 0xa0000000 to 0xa1000000 from being re-onlined by a bad call
> > to add_memory?
> 
> Usual sparsemem's add_memory() checks whether there are sections in
> sparse_add_one_section(). then add_pages() returns -EEXIST (nothing to do).
> And ioresouce collision check will finally find collision because 0-0xbffffff
> resource will conflict with 0xa0000000 to 0xa10000000 area.
> But, x86_64 's (not sparsemem) add_pages() doen't do collision check, so it panics.

I have paniced with your 5 patches while doing SPARSMEM....  I think
your 6th patch address the issues I was seeing.  

Thanks,
  Keith 

