Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTJMBuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTJMBuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 21:50:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:42693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbTJMBuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 21:50:05 -0400
Date: Sun, 12 Oct 2003 18:49:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] report user-readable fixmap area in /proc/PID/maps
In-Reply-To: <200310130135.h9D1Zajj008309@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0310121845100.12190-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Oct 2003, Roland McGrath wrote:
> 
> I always assumed that people (i.e. Linus) wouldn't like it because of
> the overhead in memory and setup time for an extra vma that is identical
> in every process.  Given the constraint that the fixmap area is the last
> thing in the address space, I imagine that can be mitigated by some
> magic using a single shared fixmap_vma at the end of everybody's chain.

That would be a nice trick and works fine for the regular sorted list, but
it would be nasty for the rb-tree handling.

If you really want /proc/PID/maps to look right, add a new vm_area_struct,
see if you can allocate it as part of the "struct mm_struct" so that we
don't get yet another (unnecessary) allocation on fork time. I hate how
fork()  has slowed down due to other issues (mainly rmap).

Being _guaranteed_ to always have a "end marker" on the vma list would 
potentially actually simplify some of the code, but since this would be 
architecture-dependent, it wouldn't help right now. How ugly does the code 
end up being?

		Linus

