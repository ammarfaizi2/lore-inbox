Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbTIDRiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbTIDRit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:38:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:35262 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265318AbTIDRin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:38:43 -0400
Date: Thu, 4 Sep 2003 10:38:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <20030904171609.GA30394@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309041025470.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Jamie Lokier wrote:
> 
> Yes it can.  See sys_mprotect().  If that's not intended, it's a bug
> in mprotect().

Oh. I see. Yes - it's accessing "vm_flags" with "MAP_SEM". That's really 
wrong, since it's not even the same _domain_. 

"vm_flags" should use the "VM_xxxx" bits. Trying to use "PROT_xxx" bits is 
totally improper, but it so happens that the low three bits 
(READ|WRITE|EXEC) are supposed to be the same.

Good catch.

It really should do what mmap() does, and translate from the "PROT_xxx" 
domain to the "VM_xxx" domain:

	flag = _trans(prot, PROT_READ, VM_READ) |
		_trans(prot, PROT_WRITE, VM_WRITE) |
		_trans(prot, PROT_EXEC, VM_EXEC);

and the only reason sys_mprotect _looks_ like it is working is that those 
three bits (but _not_ MAP_SEM) happen to be the same anyway.

I'm inclined to be lazy, and say "we know the low three bits of "prot" and 
"flags" are the same, and leave it as-is, but remove the MAP_SEM, which 
clearly is a bug.

But the proper thing is to move that part of calc_vm_flags() to a header 
file. Does anybody want to take that on?

		Linus

