Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUF1StA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUF1StA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUF1StA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:49:00 -0400
Received: from mail.aknet.ru ([217.67.122.194]:48645 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S265127AbUF1SsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:48:05 -0400
Message-ID: <40E067E6.7090500@aknet.ru>
Date: Mon, 28 Jun 2004 22:48:06 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] expandable anonymous shared mappings
References: <Pine.LNX.4.44.0406281403270.13239-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406281403270.13239-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh.

Hugh Dickins wrote:
> I like the few lines of code in shmem.c, and I don't mind that it's
> a bit of a hack that ought really to be done at mremap time -
> I'm happier with the fewness of lines as you have it.
But you also mentioned the per-vma mremap handler.
Have you considered it an overkill after all?

> Plus I've realized
> we've no complementary interface to shrink the object (we cannot
> redefine the behaviour of mremap with new_len less than old_len).
What I was thinking about, is that this inode truncation
mess should be resolved by the kernel completely internally,
and the app should see only the anonymous mapping. From
that point of view I think there is no such a problem.
Program will shrink the mapping with the usual mremap(),
inode will not be trunceted, but so what? The mapping
will be shrunk, the virtual address space will be freed,
so what is to worry about? I might be missing something.

> Both those could be dealt with, by adding a new MAP_flag
> and a new MREMAP_flag - but just for you?
But I think the per-vma mremap() handler, as you
suggested before, can solve everything, isn't it?
And I beleive this will not be usefull only for me
then, while the new flags may indeed be usefull for
me only (which is not good).

> You're only trying to get them to play better together, but
> extending a file (at fault time or within mremap) is something
> new, which could be troublesome to go on supporting if we change
> other things around it
I agree with this completely, but my point is that
we are already deeply in that mess anyway. In particular,
I see basically the same things in shmem_zero_setup()/
shmem_file_setup(). It is absolutely similar as far
as I can tell, so I don't agree that I proposed really
something new to it. The only difference I can see is that
it is being invoked not by the fault handler...

>> So I have to resort to the more heavyweight
>> things like shm_open(), while otherwise the
>> expandable anonymous shared mapping can suit
>> very well for my needs.
> I don't see how shm helps you, that's fixed-size objects too, isn't it?
AFAIK - no, but actually I haven't tried, used a
custom allocator on a single large object instead.
AFAIK you can expand the posix shm objects with
mremap() perfectly well, you just need to
ftruncate() first. No? If no, I may reconsider
the sanity of this my proposal entirely. I thought
mremap() works to expand any kind of shared mapping,
that's why I thought the inability to expand one
particular type of shared mapping is a misbehavoir.
How about this:
http://www.ussg.iu.edu/hypermail/linux/kernel/9603.2/0692.html

> Can't you use a tmpfs file?  Create it, unlink it, mmap a page of it,
> ftruncate and mremap together whenever you need?  That's then using
> standard interfaces without any kernel change - provided CONFIG_TMPFS=y.
The problem is that I need multiple independantly
shared allocations. I can either use multiple tmp
files and track their mapping addresses to their
descriptors by hands if I want to ftruncate(), or
I have to use the custom memory allocator on a single
pool - thats what I do now, but I wanted to make it
simpler. And the shared anon mapping could make it
simpler for me I beleive.
But I am not insisting in case you think it is really
not worth an efforts to do in the kernel. I just
want to point out the potential advantages because
I beleive if it is implemented, it can be usefull
not only for me.

>> shm_open() when possible. I just don't see the
>> reason of keeping something partially implemented.
> Shared anonymous is fully implemented; you have a natural
> and useful extension to its behaviour with mremap
I thought any kinds of mapping should be expandable
with mremap(), esp. the shared ones. This impression
comes to me from the above URL. From that point of
view this is not an extension, but rather the
unimplemented feature. If it is only an extension,
then perhaps it is really not worth the troubles.

> Linus was arguing for back-compatibility, that we must continue
> to support old_len 0: he wasn't asking for new features here.
I feel an inconsistency here. Consider you mmap'ed
10 pages and duplicated 1 page with mremap(,0,).
Then you get this area of one page, which you
actually *can* expand with mremap(). But as soon
as you expanded it more than to original 10 pages -
SIGBUS. And not immediately, but rather when you
get around to access it, i.e. in a completely
unpredictable place:(
And what's worse, is that mremap() perfectly
succeeds, so you don't even expect the failure.
What's even worse, is that your /proc/self/maps
will show that expanded region as being present
and one will never expect the SIGBUS after all this.
If at least /proc/self/maps to reveal the truth,
or mremap() to fail - then yes, the program might
be able to handle the failures. But everything
suggests that the mapping was expanded, but you
just give the SIGBUS in your face at one point.
For some reasons this looks extremely insane and
unreliable to me. My program is rather complex
and it runs the "foreign" code sometimes (say,
third-party plugins), so I have some difficulties
to control everything by hands, when I can't get
the reliable result from the kernel.

> I don't oppose your patch - except in the details, please stick
> with my version if you continue with it. 
Sure, no problems.

> If you want to persuade Andrew or Linus directly with the patch,
No, I won't of course, and besides, this may not
be even remotely possible:)

> that's fine by me, but my own opinion is to let caution rule.
OK, I tried my best to make up my point.
I was not trying to convince you that I need
it, rather I was trying point out that without
this patch, mremap() behaves not the way it is
expected to behave, furthermore, it behaves
unreliably and there is no way to find out
whether it is really succeeded or not.
If you still feel it is only a nice extension
to the otherwise perfectly functional interface,
then there might be no point to include it only
for me. My main point was to avoid the mremap's
unreliability. There are cases where nopage
handler is missing. You get the zero-page mapped
in, in these cases. This is bad, but at least you
don't get a SIGBUS. Here we have a completely
different thing - nopage handler is present, but
doesn't really work, and you get the really
unexpected and unpredictable results. I wanted
to make them both expected and predictable.
With this in mind, I would even feel safer if
this functionality is not available at all, rather
then letting it go the way it is now.

Btw, this small patch about VM_DONTEXPAND in my
previous mail, what do you think about that one?

