Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbTIDRRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbTIDRRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:17:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41356 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265290AbTIDRQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:16:37 -0400
Date: Thu, 4 Sep 2003 18:16:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904171609.GA30394@mail.jlokier.co.uk>
References: <20030903173928.GA22555@mail.jlokier.co.uk> <Pine.LNX.4.44.0309031052000.26650-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031052000.26650-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Actually: the VM_SHARED flag will never change, so testing VM_SHARED is 
> actually the _right_ thing from a mm perspective.

Yes it can.  See sys_mprotect().  If that's not intended, it's a bug
in mprotect().  What does PROT_SEM mean for Linux, btw?

See:
	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
		return -EINVAL;

and:
	newflags = prot | (vma->vm_flags & ~(PROT_READ | PROT_WRITE | PROT_EXEC));
	if ((newflags & ~(newflags >> 4)) & 0xf) {
		error = -EACCES;
		goto out;
	}

newflags is than used to index protection_map[], like this:
	newprot = protection_map[newflags & 0xf];

and that is stored in the page tables.

-- Jamie
