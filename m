Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWHDCNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWHDCNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHDCNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:13:47 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9630 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030283AbWHDCNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:13:46 -0400
Date: Fri, 4 Aug 2006 11:15:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       y-goto@jp.fujitsu.com, akpm@osdl.org
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
Message-Id: <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154656472.5925.71.camel@keithlap>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	<1154650396.5925.49.camel@keithlap>
	<20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	<1154656472.5925.71.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 18:54:32 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> > Hmm..Okay. I'll try some check patch today. please review it.
> > Maybe moving ioresouce collision check in early stage of add_memory() is good ?
>   Yea.  I am working a a full patch set for but my sparsemem and reserve
> add-based paths.  It creates a valid_memory_add_range call at the start
> of add_memory. I should be posting the set in the next few hours.
> 
Ah..ok. but I wrote my own patch...and testing it now..

> > Note:
> > I remove pfn_valid() here because pfn_valid() just says section exists or
> > not. When adding seveal small memory chunks in one section, Only the  first
> > small chunk can be added. 
> Hmm... I thought memory add areas needed to be section aligned for the arch?
> 
There are requests for memory-hot-add should allow to hot-add not-aligned memory.
Then, I wrote ioresouce collision check patch (before..but had bug..)
With ioresouce collistion check, alignments are not required at *add*.
(onlining is just for  *offlined section*, now)

>   What protecting is there for calling add_memory on an already present
> memory range?  
> 
For example, considering ia64, which has 1Gbytes section...
hot add following region.
==
(A) 0xc0000000 - 0xd7ffffff  (section 3)
(B) 0xe0000000 - 0xffffffff  (section 3)
==
(A) and (B) will go to the same section, but there is a memory hole between
(A) and (B). Considering memory (B) appears after (A) in DSDT.

After add_memory() against (A) is called, section 3 is ready.
Then, pfn_valid(0xe0000000) and pfn_valid(0xffffffff) returns true because
they are in section 3.
So, checking pfn_valid() for (B) will returns true and memory (B) cannot be
added. ioresouce collision check will help this situation.

The memory hole are not onlined because there are no ioresouce for it.

-Kame


