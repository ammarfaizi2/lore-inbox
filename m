Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264396AbRFGKrC>; Thu, 7 Jun 2001 06:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264395AbRFGKqx>; Thu, 7 Jun 2001 06:46:53 -0400
Received: from 196-41-175-253.citec.net ([196.41.175.253]:18883 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S264394AbRFGKqp>; Thu, 7 Jun 2001 06:46:45 -0400
Date: Thu, 7 Jun 2001 12:46:22 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010607124621.A30328@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
NotDashEscaped: You need GnuPG to verify this message

First things first: 1) Please Cc: me when responding, 2) apologies for
dropping any References: headers, 3) sorry for bad formatting

"Jeffrey W. Baker" wrote:
> On Tue, 5 Jun 2001, Derek Glidden wrote: 
> > This isn't trying to test extreme low-memory pressure, just how the 
> > system handles recovering from going somewhat into swap, which is
> > a real 
> > day-to-day problem for me, because I often run a couple of apps
> > that 
> > most of the time live in RAM, but during heavy computation runs,
> > can go 
> > a couple hundred megs into swap for a few minutes at a time.
> > Whenever 
> > that happens, my machine always starts acting up afterwards, so I 
> > started investigating and found some really strange stuff going on. 

Has anyone else noticed the difference between
 dd if=/dev/zero of=bigfile bs=16384k count=1
and
 dd if=/dev/zero of=bigfile bs=8k count=2048
deleting 'bigfile' each time before use?  (You with lots of memory may
(or may not!) want to try bs=262144k)

Once, a few months ago, I thought I traced this to the loop at line ~2597
in linux/mm/filemap.c:generic_file_write
  2593          remove_suid(inode);
  2594          inode->i_ctime = inode->i_mtime = CURRENT_TIME;
  2595          mark_inode_dirty_sync(inode);
  2596  
  2597          while (count) {
  2598                  unsigned long index, offset;
  2599                  char *kaddr;
  2600                  int deactivate = 1;
...
  2659  
  2660                  if (status < 0)
  2661                          break;
  2662          }
  2663          *ppos = pos;
  2664  
  2665          if (cached_page)

It appears to me that pseudo-spins (it *does* do useful work) in this
loop for as long as there are pages available.

BTW while the big-bs dd is running, the disk is active.  I assume that
writes are indeed scheduled and start happening even while we're still
dirtying pages?

Does this freezing effect occur on SMP machines too?  Oops, had access
to one until this morning :(  Would an SMP box still have a 'spare'
cpu which isn't dirtying pages like crazy, and can therefore do things
like updating mouse cursors, etc.?

Bernd Jendrissek

P.S. here's my patch that cures this one symptom; it smells and looks
ugly, I know, but at least my mouse cursor doesn't jump across the whole
screen when I do the dd=torture.

I have no idea if this is right or not, whether I'm allowed to call
schedule inside generic_file_write or not, etc.  And the '256' is
just random - small enough to let the cursor move, but large enough
to do work between schedule()s.

If this solves your problem, use it; if your name is Linus or Alan,
ignore or do it right please.

diff -u -r1.1 -r1.2
--- linux-hack/mm/filemap.c     2001/06/06 21:16:28     1.1
+++ linux-hack/mm/filemap.c     2001/06/07 08:57:52     1.2
@@ -2599,6 +2599,11 @@
                char *kaddr;
                int deactivate = 1;
 
+               /* bernd-hack: give other processes a chance to run */
+               if (count % 256 == 0) {
+                       schedule();
+               }
+
                /*
                 * Try to find the page in the cache. If it isn't there,
                 * allocate a free page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7H1tb/FmLrNfLpjMRAguAAJ0fYInFbAa6LjFC/CWZbRPQxzZwrwCeNqT0
/Kod15Nx7AzaM4v0WhOgp88=
=pyr6
-----END PGP SIGNATURE-----
