Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUF1OWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUF1OWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUF1OWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:22:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54258 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264562AbUF1OWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:22:41 -0400
Date: Mon, 28 Jun 2004 15:22:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] expandable anonymous shared mappings
In-Reply-To: <40D55D13.20803@aknet.ru>
Message-ID: <Pine.LNX.4.44.0406281403270.13239-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope my lightning responses don't catch you unawares ;)

On Sun, 20 Jun 2004, Stas Sergeev wrote:
> Hugh Dickins wrote:
> >> I disagree with this. The way I am using it may look horrible,
> >> but yes, I do use it without the fork().
> > Then I think you have no reason to use MAP_SHARED: use MAP_PRIVATE
> > and you should get the behaviour you require, without kernel change.
> Hugh, I think you misunderstood me because
> once again I wrote something, said nothing -
> happens to me sometimes.
> The trick is that I am setting the old_len arg
> of mremap() to 0.

Yes, I did indeed overlook that, sorry.  You're quite right that you
need MAP_SHARED for this use, and my dismissal was wrong.  Thanks
for forcing me to understand at last how mremap old_len 0 behaves!

>From time to time in the last week I've reconsidered your feature
(faulting on mremap-expanded area of shared anonymous object expands
the object itself instead of SIGBUS): I still _like_ it, but cannot
shake off my unease with it.

I like the few lines of code in shmem.c, and I don't mind that it's
a bit of a hack that ought really to be done at mremap time -
I'm happier with the fewness of lines as you have it.

But I'm still uneasy how children (not in your usage) could expand
the object without the parent knowing, all the object remaining in
use until all mms have unmapped all portions.  Plus I've realized
we've no complementary interface to shrink the object (we cannot
redefine the behaviour of mremap with new_len less than old_len).

Both those could be dealt with, by adding a new MAP_flag
and a new MREMAP_flag - but just for you?

I'm wary of a feature without its complement; and I'm wary of
adding rather odd neat new features which just _might_ cause
difficulty down the line.  mremap is itself a rather odd neat
feature, and shared anonymous is another rather odd neat feature.

You're only trying to get them to play better together, but
extending a file (at fault time or within mremap) is something
new, which could be troublesome to go on supporting if we change
other things around it (odd cases often end up being a nuisance
when it comes to lock ordering, for example).

> and there seems to be no way of doing that:
> creating the larger pool and mremap'ing old
> one to the beginning of the new one, leaves the
> VMAs unmerged; creating the larger pool and
> mamcpy() the content of the old one to it,
> doesn't preserve the already created "aliases".
> The only thing I can do, is to expand the
> initial pool with mremap(), which doesn't work.
> So I have to resort to the more heavyweight
> things like shm_open(), while otherwise the
> expandable anonymous shared mapping can suit
> very well for my needs.

I don't see how shm helps you, that's fixed-size objects too, isn't it?

Can't you use a tmpfs file?  Create it, unlink it, mmap a page of it,
ftruncate and mremap together whenever you need?  That's then using
standard interfaces without any kernel change - provided CONFIG_TMPFS=y.

> > Shared anonymous is peculiar: although mapping is anonymous (nothing
> > shared with unrelated mms), modifications are shared between parent
> > and children.  It's half-way between anonymous and file-backed.
> > We agree that it might be nice to let the object used to support that
> > be extended if mremap extends the mapping.  But it might instead just
> > be needless feature creep. 
> But then I beleive the entire idea of anonymous
> shared mapping is also a crap. But since it is
> already there, I would like to have it fully
> functional, so that I can avoid the things like
> shm_open() when possible. I just don't see the
> reason of keeping something partially implemented.

Shared anonymous is fully implemented; you have a natural
and useful extension to its behaviour with mremap, I agree it
seems reasonable, but I think we're safer not to make the change.

> > Sorry, your case does not persuade me yet.
> Well, I beleive perhaps you missed the fact
> that I was setting the old_len to 0 in mremap(),
> which doesn't work as I want to, when you use
> MAP_PRIVATE.
> You'll probably call it a horrible hack, but
> here's where that technique comes from:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/1351.html
> And since it comes from here, I beleive it
> must be fully supported.

Linus was arguing for back-compatibility, that we must continue
to support old_len 0: he wasn't asking for new features here.

I don't oppose your patch - except in the details, please stick
with my version if you continue with it.  Your second version
of shmem_zero_nopage remained incorrect (accounting for a size
change without holding the lock against another making a change
at the same time); and in removing the double shmem_nopage you
were optimizing for the very rare (newly allowed) case, at the
expense of every normal use (which go through the size tests
twice with yours).

If you want to persuade Andrew or Linus directly with the patch,
that's fine by me, but my own opinion is to let caution rule.

Hugh

