Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVBLNIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVBLNIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 08:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVBLNHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 08:07:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38093 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261396AbVBLNH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 08:07:26 -0500
Date: Sat, 12 Feb 2005 13:06:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Richard F. Rebel" <rrebel@whenu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
In-Reply-To: <1108161173.32711.41.camel@rebel.corp.whenu.com>
Message-ID: <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005, Richard F. Rebel wrote:
> 
> I can't seem to find clear documentation about the 'share' column
> from /proc/<pid>/statm.
> 
> Does this include pages that are shared with forked children marked as
> copy-on-write?
> 
> Does this only reflect libraries that are dynamically loaded?  What
> about shared memory segments/mmaps (ala shmat or mmmap)?
> 
> If there is a place where I might find documentation that is more clear
> beyond the proc.txt in the kernel docs and then man pages for procfs,
> I'd welcome a pointer.

You may not be entirely happy with this answer.
It is a count of "pages of the process" which are "shared" in some sense.
But precisely what that means has changed from time to time: depending on
our perception of what we can safely afford the overhead of counting.

You may want to look at fs/proc proc_pid_statm() source for the release
of interest, and follow that back to see exactly what is being counted.

Throughout 2.4 (and 2.2 too I think) it was the count of those pages
instantiated in the process address space which currently have a page
count greater than 1.  That would include private pages shared with
forked children, pages from the pagecache (including pages mapped
from executable or library or shared memory or file mmap), those
private pages which currently have swap allocated (so they're also
in the swapcache), and any pages which transitorily have page count
raised for whatever reason (they'd likely already be in one of the
above categories).  A ragbag of meanings, but that's all you can
get from looking at page count.

Counting up that not very meaningful number, at frequent intervals
on large process address spaces, is a waste of valuable time.

>From 2.5.37 to 2.6.9, it's the total extent of file-backed areas
(file including executable or library or shared memory) in the
process address space: a total extent (in pagesize units),
not a count of instantiated pages.  Much quicker to calculate.

But there were complaints about that, and a need to revert from
total extent to count of instantiated pages.

>From 2.6.10 onwards, for the foreseeable future, it is the count
of those pages instantiated in the process address space which are
shared with a file (including executable or library or shared memory)
i.e. those pages which are not anonymous, not private.  That count
does not include private pages shared with forked children, nor
does it include private pages which happen to have swap allocated.

Hugh
