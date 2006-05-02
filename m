Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWEBRPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWEBRPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEBRPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:15:21 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:37028 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S964899AbWEBRPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:15:20 -0400
Subject: Re: [patch 00/14] remap_file_pages protection support
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: blaisorblade@yahoo.it, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <4456D5ED.2040202@yahoo.com.au>
References: <20060430172953.409399000@zion.home.lan>
	 <4456D5ED.2040202@yahoo.com.au>
Content-Type: text/plain
Organization: HP/OSLO
Date: Tue, 02 May 2006 13:16:46 -0400
Message-Id: <1146590207.5202.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 13:45 +1000, Nick Piggin wrote:
> blaisorblade@yahoo.it wrote:
> 
> > The first idea is to use this for UML - it must create a lot of single page
> > mappings, and managing them through separate VMAs is slow.
> 
> I don't know about this. The patches add some complexity, I guess because
> we now have vmas which cannot communicate the protectedness of the pages.
> Still, nobody was too concerned about nonlinear mappings doing the same
> for addressing. But this does seem to add more overhead to the common cases
> in the VM :(
> 
> Now I didn't follow the earlier discussions on this much, but let me try
> making a few silly comments to get things going again (cc'ed linux-mm).
> 
> I think I would rather this all just folded under VM_NONLINEAR rather than
> having this extra MANYPROTS thing, no? (you're already doing that in one
> direction).
<snip>

One way I've seen this done on other systems is to use something like a
prio tree [e.g., see the shared policy support for shmem] for sub-vma
protection ranges.  Most vmas [I'm guessing here] will have only the
original protections or will be reprotected in toto.  So, one need only
allocate/populate the protection tree when sub-vma protections are
requested.   Then, one can test protections via the vma, perhaps with
access/check macros to hide the existence of the protection tree.  Of
course, adding a tree-like structure could introduce locking
complications/overhead in some paths where we'd rather not [just
guessing again].  Might be more overhead than just mucking with the ptes
[for UML], but would keep the ptes in sync with the vma's view of
"protectedness".

Lee

