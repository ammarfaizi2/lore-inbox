Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132835AbRDXG40>; Tue, 24 Apr 2001 02:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRDXG4P>; Tue, 24 Apr 2001 02:56:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15398 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132835AbRDXG4D>; Tue, 24 Apr 2001 02:56:03 -0400
Date: Tue, 24 Apr 2001 08:56:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: RAWIO-5 and O_DIRECT-3 updates
Message-ID: <20010424085600.A784@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a new bug pointed out by Andrew and discussed on the kiobuf list
(thanks Andrew!) (lock_kiovec was not handling correctly a failed trylockpage
and could unlock pages locked by other people, not a big deal though as such
function is never called in the whole pre6 and I'm wondering if it make sense
at all to allow the pinned pages to be locked down in 2.4 [it certainly is
still necessary in 2.2 for all the reads from disk]). However I didn't killed
that function just in case there's an useful use of it. New updated rawio patch
against vanilla 2.4.4pre6 is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre6/rawio-5.bz2

Then I integrated a new feature in the O_DIRECT support to make possible to
set/unset from fcntl (I delayed that feature intentionally in the first release
because I thought it was low prio but Michael Susæg just asked for it to do I/O
at misaligned offsets sometime). The way I preferred to implement it is to left
the kiobuf allocated all the time, until we destroy the file structure in fput
(the kiobuf is huge thing, even more with my above rawio x2 boost patch that
handles 512k of atomic I/O with everything needed for the I/O just
preallocated, and we don't want to allocate/deallocate the whole thing every
time we switch in/out buffered mode). I'm also abusing the inode->i_sem in
fcntl to serialize the case of two tasks doing the fcntl(O_DIRECT) on two
filedescriptors pointing to the same file at the same time (kiobuf allocation
can sleep, it does even vmalloc...). Abusing it looks safe and we save the
memory of one semaphore per file structure this way. New patch is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre6/o_direct-3

As usual o_direct-3 has to be applied after rawio-5. rawio-5 is recommended for
integration into pre7 as it's not only a performance optimization but includes
strictly necessary fixes for race conditions, mm corruption etc..etc..  (again
credit for some of the stability fixes goes to SCT!)

Andrea
