Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266902AbRGMAAt>; Thu, 12 Jul 2001 20:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266589AbRGMAAj>; Thu, 12 Jul 2001 20:00:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17045 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266902AbRGMAA0>;
	Thu, 12 Jul 2001 20:00:26 -0400
Date: Thu, 12 Jul 2001 20:00:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [initramfs] wait_for_keypress() and ->wait_key()
Message-ID: <Pine.GSO.4.21.0107121851430.15756-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, I'm playing with untar-to-ramfs stuff right now and it looks
like I've stumbled upon an interesting wart.

	We have a function in tty_io.c - wait_for_keypress(). All callers
can be converted to one function - change_floppy(fmt, ...); it tries to
eject floppy, prints a message and waits for user to press a key. So far
so well.

	However, the thing needs to be callable from userland if we want
to evict that code out of kernel. Well, it's not a big deal - at that
point I have /dev/root (on ramfs) being an appropriate device node, so
ejecting is trivial (FDEJECT) and waiting for keypress also shouldn't
be hard. After all, it should be the same as turning ICANON off and doing
read().

	The problem being, wait_for_keypress() actually does something
almost, but not entirely unlike that. It calls a method of your console
- wait_key(). To start with, nothing else uses it. That in itself wouldn't
be a big deal. However, the method itself has different semantics for
different console drivers. On some of them (e.g. serial console) it actually
eats the character it had receieved. On some (e.g. normal VC) it just sits
and waits to be woken up by arrival of any keypress. Said arrival is
processed in a normal way - i.e. it's _not_ eaten.

	Better yet, attach a VT220 to serial console and press any key that
would send multiple characters. Yup, that will eat one of them. Have fun
if you call wait_for_keypress() more than once. (On a normal keyboard
the effect will differ - next call will block).

	IOW, this stuff looks like a big mess, just asking to be killed.
Proposed solution:
in wait_for_keypress() (userland variant):
	* turn ICANON off
	* flush the input
	* read
	* restore settings
in kernel:
	* kill wait_for_keypress(9)
	* kill ->wait_key() and all its instances
	* kill the keypress_wait - AFAICS we will end up removing everyone who
sleeps on it.

	Are you OK with that variant? It's obviously a 2.5 stuff, but I'm
going to add that (eviction of late boot into userland and uncpio-to-ramfs)
into namespace patch and put it out for testing.

