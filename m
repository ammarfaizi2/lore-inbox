Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbTIDVs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbTIDVs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:48:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:3981 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265545AbTIDVsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:48:22 -0400
Date: Thu, 4 Sep 2003 22:48:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
Message-ID: <20030904214810.GG31590@mail.jlokier.co.uk>
References: <1062686960.1829.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062686960.1829.11.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> When mmap MAP_SHARED is done on a file, it gets marked with VM_MAYSHARE
> and, if it's read/write, VM_SHARED.  However, if it is remapped with
> mremap(), the MAP_SHARED is only passed into the new mapping based on
> VM_SHARED.  This means that remapped read only MAP_SHARED mappings lose
> VM_MAYSHARE.  This is causing us a problem on parisc because we have to
> align all shared mappings carefully to mitigate cache aliasing problems.
> 
> The fix is to key passing the MAP_SHARED flag back into the remapped are
> off VM_MAYSHARE not VM_SHARED.

At first I disagreed with your patch.  I was thinking that special
alignment is only really needed to avoid aliasing problems for
_writable_ shared mappings, and VM_SHARED is right for that.  (Which
would indicate that mmap is faulty, not mremap).

But after some thought, I agree with you.

A read-only mapping of a shared segment must be coherent with other,
possibly writable mappings, so far as the architecture can guarantee
that.

That coherence should not disappear if the file handle used for the
mapping was opened O_RDONLY.

One last thought: this is what PROT_SEM is for.  Linux doesn't use
this in any useful way.  But, technically, mmap with MAP_SHARED ad
PROT_SEM should enable cache coherence, and that might include
aligning the address.  Without PROT_SEM an application should not rely
on cache coherence.

-- Jamie
