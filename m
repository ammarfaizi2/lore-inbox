Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132028AbQL3BAo>; Fri, 29 Dec 2000 20:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132135AbQL3BAf>; Fri, 29 Dec 2000 20:00:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132028AbQL3BAY>; Fri, 29 Dec 2000 20:00:24 -0500
Date: Fri, 29 Dec 2000 16:25:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alexander Viro <aviro@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        "Marco d'Itri" <md@Linux.IT>, Jeff Lightfoot <jeffml@pobox.com>,
        Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: test13-pre6
Message-ID: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there's a test13-pre6 out there now, which does a partial sync with
Alan, in addition to hopefully fixing the innd shared mapping writeback
problem for good.  Thanks to Marcelo Tosatti and others..

I've pounded on the shared dirty page writeback logic quite a bit, and
verified (by doing timings with "strace -ttT") that it should do the right
thing with sync/fsync/fdatasync/msync(MS_ASYNC)/msync(MS_SYNC).

The reason I'm fairly confident that the problem is gone for good is that
the dirty page handling is now quite integral to the whole address space
code, and it fell out rather nicely from some mapping host cleanups.

Al: this changes "mapping->host" to be truly defined as a pointer to the
inode that owns the mapping. That's how every user actually _used_ the
host pointer, so this cleans those up to not need any casts. The main
reason, however, is that we needed to have some FS-level anchor for dirty
pages in order to get the correct sync() semantics. If you think it's
worth it to have a notion of an anonymous host we need to add something
else.

Stephen: mind trying your fsync/etc tests on this one, to verify that the
inode dirty stuff is all done right?

Marco d'Itri and everybody else who has seen innd problems (or other
shared map problems): can you verify that test13-pre6 works for you?

			Linus

----
 - pre6:
   - Marc Joosen: BIOS int15/e820 memory query: don't assume %edx
     unchanged by the BIOS. Fixes at least some IBM ThinkPads.
   - Alan Cox: synchronize
   - Marcelo Tosatti & me: properly sync dirty pages
   - Andreas Dilger: proper ext2 compat flag checking

 - pre5:
   - NIIBE Yutaka: SuperH update
   - Geert Uytterhoeven: m68k update
   - David Miller: TCP RTO calc fix, UDP multicast fix etc
   - Duncan Laurie: ServerWorks PIRQ routing definition.
   - mm PageDirty cleanups, added sanity checks, and don't lose the bit. 

 - pre4:
   - Christoph Rohland: shmfs cleanup
   - Nicolas Pitre: don't forget loop.c flags
   - Geert Uytterhoeven: new-style m68k Makefiles
   - Neil Brown: knfsd cleanups, raid5 re-org
   - Andrea Arkangeli: update to LVM-0.9
   - LC Chang: sis900 driver doc update
   - David Miller: netfilter oops fix
   - Andrew Grover: acpi update

 - pre3:
   - Christian Jullien: smc9194: proper dev_kfree_skb_irq
   - Cort Dougan: new-style PowerPC Makefiles
   - Andrew Morton, Petr Vandrovec: fix run_task_queue
   - Christoph Rohland: shmfs for shared memory handling

 - pre2:
   - Kai Germaschewski: ISDN update (including Makefiles)
   - Jens Axboe: cdrom updates
   - Petr Vandrovec; Matrox G450 support
   - Bill Nottingham: fix FAT32 filesystems on 64-bit platforms
   - David Miller: sparc (and other) Makefile fixup
   - Andrea Arkangeli: alpha SMP TLB context fix (and cleanups)
   - Niels Kristian Bech Jensen: checkconfig, USB warnings
   - Andrew Grover: large ACPI update

 - pre1:
   - me: drop support for old-style Makefiles entirely. Big.
   - me: check b_end_io at the IO submission path
   - me: fix "ptep_mkdirty()" (so that swapoff() works correctly)
   - fix fault case in copy_from_user() with a constant size, where
     ((size & 3) == 3)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
