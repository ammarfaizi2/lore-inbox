Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129081AbQJ2TeR>; Sun, 29 Oct 2000 14:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129153AbQJ2TeH>; Sun, 29 Oct 2000 14:34:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129081AbQJ2Tdu>; Sun, 29 Oct 2000 14:33:50 -0500
Date: Sun, 29 Oct 2000 11:33:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Paul Mackerras <paulus@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0
In-Reply-To: <Pine.LNX.4.10.10010291100030.18939-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10010291118140.19109-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2000, Linus Torvalds wrote:
> 
> Making it policy that we have to re-test page->mapping after aquireing the
> page lock might be the simplest fix for 2.4.x. It still means that we
> might end up allowing people to have a "bad" page in the VM space due to
> the "test->insert" race condition, but it woul dmake that event pretty
> much a harmless bug (and thus move it to the "beauty wart - to be fixed
> later" category).

I'd like to just re-iterate this point: re-testing "page->mapping" fixes
the oops, but is not a full fix for the conceptual problem.

The problem with just re-testing "page->mapping" is that you still have a
nasty potential race where you insert a (bogus) page into the VM space of
a process instead of giving a SIGBUS/SIGSEGV.

Now, I don't think this is really a valid usage pattern, so it's most
likely to be a result of a buggy application, but I can imagine having
some strange kind of user-space VM memory management scheme that depends
on SIGBUS to maintain a file length. I've never heard of such a thing, but
I could imagine somebody doing some kind of persistent data object store
in user space this way.

Does anybody actually know of an application that does something like
this? Because I'm more and more inclined to just going with the half-fix
for now. It would at least guarantee internal kernel data consistency (and
no oopses, of course).

Don't get me wrong - we need to clean this part up, but as far as I can
tell we have never done this "right", so in that sense it's not a new
2.4.x bug and it can't break existing applications.

[ In fact, with the current ordering inside "vmtruncate()" of doing the
  "truncate_inode_pages()" thing before doing the "vmtruncate_list()", I
  have this suspicion that the race might even be impossible to trigger.
  Even when the race "happens" in kernel space, we will end up unmapping
  the page immediately afterwards, and the only effect as far as the user
  is concerned is the disappearance of the SIGBUS.

  And the "disappearing SIGBUS" is actually explainable with a
  _user_level_ race: in order to get the kernel race at all, user level
  itself must have been inherently racing on the truncate/access, and
  depending on which one happened "first" you'd have lost the SIGBUS and
  the data you wrote anyway.

  So it may actually be that we can honestly claim that the half-fix is
  actually a proper fix. I would have to look a lot closer at the issue to
  be able to guarantee this, though. Comments? Anybody? ]

Al?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
