Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLYKNs>; Mon, 25 Dec 2000 05:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLYKNi>; Mon, 25 Dec 2000 05:13:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129183AbQLYKNa>; Mon, 25 Dec 2000 05:13:30 -0500
Date: Mon, 25 Dec 2000 01:42:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Marco d'Itri" <md@Linux.IT>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.10.10012250049400.5242-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012250131370.5340-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2000, Linus Torvalds wrote:
> 
> Assuming we don't lose any PG_dirty bits, we might of course just lose it
> from the page tables themselves before it ever even gets to "struct page".
> I'm just surprised that it seems to be so repeatable for you - it sounds
> like we _never_ actually write out the dirty pages to disk. It's not that
> we can lose the dirty bit occasionally, we seem to lose it every time in
> your setup.

Nope. I got it.

The thing is even more embarrassing than just losing a dirty bit.

We don't lose any dirty bits (well, we could before, but after adding the
PageDirty() test to reclaim_page() we're ok now).

In fact, we know _exactly_ which pages are dirty, and which pages are not.

We just don't write them out. Because right now the only thing that writes
out dirty pages is memory pressure. "sync()", "fsync()" and "fdatasync()"
will happily ignore dirty pages completely. The thing that made me
overlook that simple thing in testing was that I was testing the new VM
stuff under heavy VM load - to shake out any bugs.

Under heavy VM load, there are no problems, because the memory pressure
will make sure everything gets written out. Under heavy VM load the thing
works just beautifully.

Under _low_, or no, memory pressure, however, the dang thing just stays in
memory. We'll happily reboot with the new contents still cached, in fact.

I bet that if you start something that eats up all your memory, and causes
some nice swapping just before you shut down the machine, your innd active
file will be right as rain after a reboot.

I'm a stupid git. I even remember thinking about the syncing issues at
some point, and then obviously just forgetting about it _completely_.

The simple fix is along the lines of adding code to fsync() that walks the
inode page list and writes out dirty pages.

The clever and clean fix is to split the inode page list into two lists,
one for dirty and one for clean pages, and only walk the dirty list.

Ho ho ho. I _so_ enjoy making a fool out of myself.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
