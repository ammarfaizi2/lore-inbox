Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130121AbQLHKa2>; Fri, 8 Dec 2000 05:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131501AbQLHKaS>; Fri, 8 Dec 2000 05:30:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47049 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130121AbQLHKaA>;
	Fri, 8 Dec 2000 05:30:00 -0500
Date: Fri, 8 Dec 2000 04:58:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [found?] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <18239.976266451@redhat.com>
Message-ID: <Pine.GSO.4.21.0012080410180.24770-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm doing some massive grepping (basically, audit of page locking),
but nothing relevant so far. There was some catch (aside of documenting
the thing and finding several completely unrelated buglets):
	* ramfs_writepage() doesn't UnlockPage(). Deadlock.
	* udf_adinicb_writepage() does extra UnlockPage().
I don't see the fsckup in loop.c, though. On the read path it uses
do_generic_read_file() and on the write it's essentially the simplified
variant of generic_file_write(). Hell knows... It looks like we are
getting dirty buffer inheriting end_buffer_io_async from the previous
life.

	Oh, damn it. Indeed. Look: 

generic_file_write() or lo_send():
lock_page()
->prepare_write()	sets sync ->b_end_io
->commit_write()	puts them on the dirty list
UnlockPage()		releases the page lock
... requests are sent to driver

page_launder():
TryLockPage()		succeeds
block_write_full_page()
	... goes through the bh'es and sets ->b_end_io to end_buffer_io_async()
	at that point the last remaining request completes. It calls
	->b_end_io(), aka. end_buffer_io_async(). And does UnlockPage().

	In the meanwhile, we call ll_rw_block(). Requests are sent again.
	When _they_ complete we get the second UnlockPage()

Now, I might miss some obvious reason why it could never happen. Moreover,
the real problem may be completely different - the race above is not too wide.

However, I'ld really like to hear why the scenario above is impossible. BTW,
the race isn't even that narrow - if ->prepare_write() didn't cover the
whole page we've got a get_block() to call and there's a plenty of time when
shit can hit the fan - it's a blocking operation, after all.

Comments?
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
