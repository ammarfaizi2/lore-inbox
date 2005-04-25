Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVDYNPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVDYNPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVDYNPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:15:18 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:60209 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262605AbVDYNPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:15:11 -0400
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 06:15:10 -0700
Message-ID: <52is2bvvz5.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Apr 2005 13:15:10.0468 (UTC) FILETIME=[CEE1AC40:01C54998]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timur> With mlock(), we don't need to use get_user_pages() at all.
    Timur> Arjan tells me the only time an mlocked page can move is
    Timur> with hot (un)plug of memory, but that isn't supported on
    Timur> the systems that we support.  We actually prefer mlock()
    Timur> over get_user_pages(), because if the process dies, the
    Timur> locks automatically go away too.

There actually is another way pages can move, with both
get_user_pages() and mlock(): copy-on-write after a fork().  If
userspace does a fork(), then all PTEs are marked read-only, and if
the original process touches the page after the fork(), a new page
will be allocated and mapped at the original virtual address.

This is actually a pretty big pain, because the only good solution
seems to be for the kernel to mark these registered regions as
VM_DONTCOPY.  Right now this means that driver code ends up monkeying
with vm_flags for user vmas.

Does it seem reasonable to add a new system call to let userspace mark
memory it doesn't want copied into forked processes?  Something like

	long sys_mark_nocopy(unsigned long addr, size_t len, int mark)

which would set VM_DONTCOPY if mark != 0, and clear it if mark == 0.
A better name would be gratefully accepted...

Then to register memory for RDMA, userspace would call
sys_mark_nocopy() (with appropriate accounting to handle possibly
overlapping regions) and the kernel would call get_user_pages().  The
get_user_pages() is of course required because the kernel can't trust
userspace to keep the pages locked.  mlock() would no longer be
necessary.  We can trust userspace to call sys_mark_nocopy() as
needed, because a process can only hurt itself and its children by
misusing the sys_mark_nocopy() call.

If this seems reasonable then I can code a patch.

 - R.
