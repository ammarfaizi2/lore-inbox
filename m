Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUF1Vpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUF1Vpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUF1Vpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:45:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58092 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265247AbUF1VpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:45:09 -0400
Date: Mon, 28 Jun 2004 22:44:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] expandable anonymous shared mappings
In-Reply-To: <40E067E6.7090500@aknet.ru>
Message-ID: <Pine.LNX.4.44.0406282242320.14234-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Stas Sergeev wrote:
> Hugh Dickins wrote:
> > I like the few lines of code in shmem.c, and I don't mind that it's
> > a bit of a hack that ought really to be done at mremap time -
> > I'm happier with the fewness of lines as you have it.

> But you also mentioned the per-vma mremap handler.
> Have you considered it an overkill after all?

Yes, that's what I meant: on balance, in the absence of further uses
for a new .mremap vm_operations method, I do consider it overkill,
and prefer your little addition of shmem_zero_nopage.

> > Plus I've realized
> > we've no complementary interface to shrink the object (we cannot
> > redefine the behaviour of mremap with new_len less than old_len).

> What I was thinking about, is that this inode truncation
> mess should be resolved by the kernel completely internally,
> and the app should see only the anonymous mapping. From
> that point of view I think there is no such a problem.
> Program will shrink the mapping with the usual mremap(),
> inode will not be trunceted, but so what? The mapping
> will be shrunk, the virtual address space will be freed,
> so what is to worry about? I might be missing something.

The underlying "object" is not shrunk, /proc/meminfo Committed_AS
is not shrunk, /proc/sys/vm/overcommit_memory 2 will still consider
the memory in reserved, it'll still be taking up memory+swap - and
must be, in case an mremap expand follows to make it accessible again.

None of which is an issue within a single mm, it's all normal.
And someone with a more reliable security instinct than I may be
able to assure us that it's not an issue within a group of mms,
forked from each other.

But to me it does look like a new situation, that before the change
the parent of all the forked anonymous shared mappings imposed the
upper limit on their memory usage, but with the change any child
could change that irreversibly (irreversibly until all have unmapped
all or exited).  Danger of memory going missing mysteriously (perhaps
equivalent to existing danger, but I've not been convinced of that).

> > Both those could be dealt with, by adding a new MAP_flag
> > and a new MREMAP_flag - but just for you?

> But I think the per-vma mremap() handler, as you
> suggested before, can solve everything, isn't it?
> And I beleive this will not be usefull only for me
> then, while the new flags may indeed be usefull for
> me only (which is not good).

Either way, without someone else speaking up, it does seem just for you.

> > You're only trying to get them to play better together, but
> > extending a file (at fault time or within mremap) is something
> > new, which could be troublesome to go on supporting if we change
> > other things around it

> I agree with this completely, but my point is that
> we are already deeply in that mess anyway. In particular,
> I see basically the same things in shmem_zero_setup()/
> shmem_file_setup(). It is absolutely similar as far
> as I can tell, so I don't agree that I proposed really
> something new to it. The only difference I can see is that
> it is being invoked not by the fault handler...

Shared anonymous is (and has to be) implemented quite differently
from private anonymous.  You rightly resent that the implementation
is imposing a surprising limitation on the user-visible semantics
(surprising compared with private; expected compared with shared
file, but then we hit that there's no ftruncate to extend anon).

I sympathise.  But I've never heard that complained of before, 
you're exaggerating to say we're deeply in a mess here.  I'd
like to change it, but pathetic caution tells me to beware,
the change might cause trouble down the line.

> >> So I have to resort to the more heavyweight
> >> things like shm_open(), while otherwise the
> >> expandable anonymous shared mapping can suit
> >> very well for my needs.
> > I don't see how shm helps you, that's fixed-size objects too, isn't it?

> AFAIK - no, but actually I haven't tried, used a
> custom allocator on a single large object instead.
> AFAIK you can expand the posix shm objects with
> mremap() perfectly well, you just need to
> ftruncate() first. No? If no, I may reconsider

Sorry, I was talking SysV shm there.  POSIX shm, as I understand it,
simply works with the tmpfs mounted at /dev/shm: I never think of
POSIX shm, just of tmpfs.  Yes, you can use ftruncate on an fd
created with shm_open.

> the sanity of this my proposal entirely. I thought
> mremap() works to expand any kind of shared mapping,
> that's why I thought the inability to expand one
> particular type of shared mapping is a misbehavoir.
> How about this:
> http://www.ussg.iu.edu/hypermail/linux/kernel/9603.2/0692.html

Hey, (no offence!) are you a lawyer?  You're very good at looking
up past history to support your case.  But I'm afraid this does
not actually add support to your case (certainly doesn't subtract
from it either) - it's about using mremap to track extensions
to a file extended by other means.

> > Can't you use a tmpfs file?  Create it, unlink it, mmap a page of it,
> > ftruncate and mremap together whenever you need?  That's then using
> > standard interfaces without any kernel change - provided CONFIG_TMPFS=y.

> The problem is that I need multiple independantly
> shared allocations. I can either use multiple tmp
> files and track their mapping addresses to their
> descriptors by hands if I want to ftruncate(), or
> I have to use the custom memory allocator on a single
> pool - thats what I do now, but I wanted to make it
> simpler. And the shared anon mapping could make it
> simpler for me I beleive.

Yes, it would make it simpler, but not significantly simpler.
You could ask instead for an mtruncate system call (similarly
to save having to keep track of fds with addresses), but the
need does not seem compelling.

> But I am not insisting in case you think it is really
> not worth an efforts to do in the kernel. I just
> want to point out the potential advantages because
> I beleive if it is implemented, it can be usefull
> not only for me.

Nobody else has spoken up yet.

> >> shm_open() when possible. I just don't see the
> >> reason of keeping something partially implemented.
> > Shared anonymous is fully implemented; you have a natural
> > and useful extension to its behaviour with mremap

> I thought any kinds of mapping should be expandable
> with mremap(), esp. the shared ones. This impression
> comes to me from the above URL. From that point of
> view this is not an extension, but rather the
> unimplemented feature. If it is only an extension,
> then perhaps it is really not worth the troubles.

It's an extension, a natural extension in principle (seen
from the private anon side), but in implementation less natural.

> > Linus was arguing for back-compatibility, that we must continue
> > to support old_len 0: he wasn't asking for new features here.
> I feel an inconsistency here. Consider you mmap'ed
> 10 pages and duplicated 1 page with mremap(,0,).

[snip surprise at SIGBUS beyond end of shared object]

We're just repeating our acknowledged positions.

> Btw, this small patch about VM_DONTEXPAND in my
> previous mail, what do you think about that one?

This one?  I overlooked it before: it seems to be a slight
redefinition of VM_DONTEXPAND, and I don't see what bug it fixes.

--- linux-2.6.6/mm/mremap.c.old	2004-06-14 19:48:36.000000000 +0400
+++ linux-2.6.6/mm/mremap.c	2004-06-19 11:54:28.508681472 +0400
@@ -320,7 +320,7 @@
 	if (old_len > vma->vm_end - addr)
 		goto out;
 	if (vma->vm_flags & VM_DONTEXPAND) {
-		if (new_len > old_len)
+		if (new_len > vma->vm_end - addr)
 			goto out;
 	}
 	if (vma->vm_flags & VM_LOCKED) {

Hugh

