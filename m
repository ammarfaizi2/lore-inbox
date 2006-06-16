Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWFPPk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWFPPk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFPPk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:40:28 -0400
Received: from ns1.suse.de ([195.135.220.2]:31702 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751457AbWFPPk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:40:27 -0400
From: Andi Kleen <ak@suse.de>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 17:37:06 +0200
User-Agent: KMail/1.9.3
Cc: Jes Sorensen <jes@sgi.com>, Tony Luck <tony.luck@intel.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606161656.40930.ak@suse.de> <4492CEC0.2080102@bull.net>
In-Reply-To: <4492CEC0.2080102@bull.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161737.06132.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 17:31, Zoltan Menyhart wrote:
> Andi Kleen wrote:
> 
> > That is not how user space TLS works. It usually has a base a register.
> 
> Can you please give me a real life (simplified) example?

On x86-64 it's just %fs:offset. gcc is a bit dumb on this and usually
loads the base address from %fs:0 first.

> 
> > This means it cannot be cache colored (because you would need a static
> > offset) and you couldn't share task_structs on a page.
> 
> I do not see the problem.

Your scheme relies on task_struct fields being on a known offset
in the page. But slab cache coloring varies the offset to make the data
spread out better in the caches.

> Can you explain please? 
> E.g. the scheduler pulls a task instead of the current one. The CPU
> will see "current->thread_info.cpu"-s of all the tasks at the same
> offset anyway.

It varies relative to the start of page.

That was one of the bigger wins relative to the task_struct in stack
page of 2.4 had.

> 
> > Also you would make task_struct part of the userland ABI which
> > seems like a very very bad idea to me. It means we couldn't change
> > it anymore.
> 
> We can make some wrapper, e.g.:
> 
> 	user_per_cpu_var(name, offset)

You would need to wrap everything and likely users would like
task_struct so much that they accessed it anyways without your wrappers.
 
> "vgetcpu()" would also be added to the ABI which we couldn't change
> easily either.

Yes, but it's a defined function. No different from a system call.

-Andi

