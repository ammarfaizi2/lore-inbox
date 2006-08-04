Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWHDDLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWHDDLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWHDDLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:11:22 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21465 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030304AbWHDDLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:11:22 -0400
Date: Fri, 4 Aug 2006 12:13:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       y-goto@jp.fujitsu.com, akpm@osdl.org
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
Message-Id: <20060804121308.e9720b49.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154660408.5925.79.camel@keithlap>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	<1154650396.5925.49.camel@keithlap>
	<20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	<1154656472.5925.71.camel@keithlap>
	<20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
	<1154660408.5925.79.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 20:00:08 -0700
keith mannthey <kmannth@us.ibm.com> wrote:


> > >   What protecting is there for calling add_memory on an already present
> > > memory range?  
> > > 
> > For example, considering ia64, which has 1Gbytes section...
> 
> Maybe 1gb sections is too large?  
> 
ia64 machines sometimes to have crazy big memory...so 1gb section is requested.
Configurable section_size for small machines was rejected in old days.


> > hot add following region.
> > ==
> > (A) 0xc0000000 - 0xd7ffffff  (section 3)
> > (B) 0xe0000000 - 0xffffffff  (section 3)
> > ==
> > (A) and (B) will go to the same section, but there is a memory hole between
> > (A) and (B). Considering memory (B) appears after (A) in DSDT.
> > 
> > After add_memory() against (A) is called, section 3 is ready.
> > Then, pfn_valid(0xe0000000) and pfn_valid(0xffffffff) returns true because
> > they are in section 3.
> > So, checking pfn_valid() for (B) will returns true and memory (B) cannot be
> > added. ioresouce collision check will help this situation.
> 
> With iommus out there throwing aliment all off way the flexability is
> good. 
> 
> My question is this.
> 
> Assuming 0-0xbfffffff is present.
> 
> What keeps 0xa0000000 to 0xa1000000 from being re-onlined by a bad call
> to add_memory?

Usual sparsemem's add_memory() checks whether there are sections in
sparse_add_one_section(). then add_pages() returns -EEXIST (nothing to do).
And ioresouce collision check will finally find collision because 0-0xbffffff
resource will conflict with 0xa0000000 to 0xa10000000 area.
But, x86_64 's (not sparsemem) add_pages() doen't do collision check, so it panics.
I posted patch to catch collision before calling arch_add_memory(), I think it will
help x86_64 users. and no-re-online.

-Kame


