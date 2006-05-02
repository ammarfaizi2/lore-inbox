Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWEBKPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWEBKPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWEBKPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:15:20 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:50289 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751256AbWEBKPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:15:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VgT9VnpteZAclfCzrXUBJea1VJxw9Xff8h6ZfU1JUTd0JknQwThj3VUyXR6FJEb7bkLs2b+NytL/vOsQbcJ52g7Cuxphbm0wWCN0Cqf7BzVko7HvaJg5lX8DLsAzQ9AVmUeuq4X6svjaVTWGiCkmLME/Z0+WUKkJAzz2XtPIcOQ=  ;
Message-ID: <4456D5ED.2040202@yahoo.com.au>
Date: Tue, 02 May 2006 13:45:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: blaisorblade@yahoo.it
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan>
In-Reply-To: <20060430172953.409399000@zion.home.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:

> The first idea is to use this for UML - it must create a lot of single page
> mappings, and managing them through separate VMAs is slow.

I don't know about this. The patches add some complexity, I guess because
we now have vmas which cannot communicate the protectedness of the pages.
Still, nobody was too concerned about nonlinear mappings doing the same
for addressing. But this does seem to add more overhead to the common cases
in the VM :(

Now I didn't follow the earlier discussions on this much, but let me try
making a few silly comments to get things going again (cc'ed linux-mm).

I think I would rather this all just folded under VM_NONLINEAR rather than
having this extra MANYPROTS thing, no? (you're already doing that in one
direction).

> 
> Additional note: this idea, with some further refinements (which I'll code after
> this chunk is accepted), will allow to reduce the number of used VMAs for most
> userspace programs - in particular, it will allow to avoid creating one VMA for
> one guard pages (which has PROT_NONE) - forcing PROT_NONE on that page will be
> enough.

I think that's silly. Your VM_MANYPROTS|VM_NONLINEAR vmas will cause more
overhead in faulting and reclaim.

It loooks like it would take an hour or two just to code up a patch which
puts a VM_GUARDPAGES flag into the vma, and tells the free area allocator
to skip vm_start-1 .. vm_end+1. What kind of troubles has prevented
something simple and easy like that from going in?

> 
> This will be useful since the VMA lookup at fault time can be a bottleneck for
> some programs (I've received a report about this from Ulrich Drepper and I've
> been told that also Val Henson from Intel is interested about this). I guess
> that since we use RB-trees, the slowness is also due to the poor cache locality
> of RB-trees (since RB nodes are within VMAs but aren't accessed together with
> their content), compared for instance with radix trees where the lookup has high
> cache locality (but they have however space usage problems, possibly bigger, on
> 64-bit machines).

Let's try get back to the good old days when people actually reported
their bugs (togther will *real* numbers) to the mailing lists. That way,
everybody gets to think about and discuss the problem.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
