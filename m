Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTICUIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTICUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:06:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:7598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264315AbTICUE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:04:57 -0400
Date: Wed, 3 Sep 2003 13:04:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309032016550.2555-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309031300070.31853-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Sep 2003, Hugh Dickins wrote:
> 
> Maybe, but, if the file was opened for writing as well as reading, the
> shared read-only mapping can be mprotected to read-write at any point,
> which does lead to differences: which is why Linux is very careful
> about deciding VM_SHARED, and it's quite difficult to explain.

And that's why the kernel does this:

	case MAP_SHARED:
		....

		vm_flags |= VM_SHARED | VM_MAYSHARE;
		if (!(file->f_mode & FMODE_WRITE))
			vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
		...

ie it only degenerates the shared mapping to a private mapping if it 
_also_ removes the MAYWRITE bit.

So if the mapping is a shared mapping and read-only - but the file was 
opened read-write and the mapping may later be changed to a writable one - 
then Linux will keep the mapping VM_SHARED.

> If we document how sys_futex (which does not dirty a page, doesn't
> even need a page there) behaves when placed within different kinds
> of mmaps, it's easier for the reader to understand if we don't get
> into such sophistications - hence choice of VM_MAYSHARE equivalent
> to MAP_SHARED, never mind the readwriteness.

I'd be very very nervous about anything that documents a read-only
MAP_SHARED as anythign but a MAP_PRIVATE. That just is fundamentally not 
right, and it _will_ bite us at some point, since all of the rest of the 
VM thinks that they are the same.

		Linus

