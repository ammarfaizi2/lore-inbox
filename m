Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265328AbSJaTPI>; Thu, 31 Oct 2002 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSJaTPH>; Thu, 31 Oct 2002 14:15:07 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38410 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265328AbSJaTPE>; Thu, 31 Oct 2002 14:15:04 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.33461.464279.572848@laputa.namesys.com>
Date: Thu, 31 Oct 2002 22:21:25 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [0/8] overview
In-Reply-To: <200210311931.08347.m.c.p@wolk-project.de>
References: <200210311910.48774.m.c.p@wolk-project.de>
	<15809.29694.883782.811063@laputa.namesys.com>
	<200210311931.08347.m.c.p@wolk-project.de>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Tom-Swifty: "We're all out of flowers," Tom said lackadaisically.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen writes:
 > On Thursday 31 October 2002 19:18, Nikita Danilov wrote:
 > 
 > Hi Nikita,
 > 
 > >  > Forbidden
 > >  > You don't have permission to access
 > >  > /snapshots/2002.10.31/reiser4progs-0.1.0.tar.gz on this server.
 > >  > Apache/1.3.23 Server at thebsh.namesys.com Port 80
 > >  > The directory itself does _not_ contain any reiserfs progs.
 > > Fixed.
 > thank you :)
 > 
 > ok, here we go: 2.5.45, Reiser4 patches from today.
 > 
 > Mounting newly created Reiser4 partition:
 > 
 > Debug: sleeping function called from illegal context at mm/page_alloc.c:409
 > Call Trace:
 >  [<c01152b4>] __might_sleep+0x54/0x60
 >  [<c01326ac>] __alloc_pages+0x24/0x278
 >  [<c0132928>] __get_free_pages+0x28/0x60
 >  [<c0115563>] dup_task_struct+0x47/0xbc
 >  [<c0115f28>] copy_process+0xa0/0xa40
 >  [<c01e10f0>] ide_do_request+0x2d4/0x334
 >  [<c01168eb>] do_fork+0x23/0xa8
 >  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 >  [<c0105574>] kernel_thread+0x74/0x8c
 >  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 >  [<e4a209a0>] ktxnmgrd+0x0/0x1e4 [reiser4]
 >  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 >  [<c01054f4>] kernel_thread_helper+0x0/0xc

kernel_thread() is called under spin-lock.

 >  [<e4a20c33>] ktxnmgrd_attach+0x53/0x88 [reiser4]

[...]

 >  [<c0106f13>] syscall_call+0x7/0xb
 > 
 > /dev/hda7 on /opt/squid/cache type reiser4 
 > (rw,noexec,nosuid,nodev,noatime,nodiratime)
 > 
 > After creating 100,000 files (time seq -f "%06.0f" 1 100000  | xargs touch),
 > I got _TONS_ of this:
 > 
 > Debug: sleeping function called from illegal context at 
 > include/asm/semaphore.h:119
 > Call Trace:
 >   [__might_sleep+84/96] __might_sleep+0x54/0x60
 >   [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
 >   [<e4a3347c>] load_and_lock_bnode+0x14/0x1a4 [reiser4]

missed spin_unlock()/spin_lock() in flush_one_atom().

 >   [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]

[...]

 >  [<c01054f9>] kernel_thread_helper+0x5/0xc
 >  [<e4a4f380>] kdaemon+0x0/0x40 [reiser4]
 > 
 > 
 > and also _TONS_ of this:
 > 
 > Debug: sleeping function called from illegal context at 
 > include/asm/semaphore.h:119
 > Call Trace:
 >  [<c01152b4>] __might_sleep+0x54/0x60
 >  [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
 >  [<e4a3347c>] load_and_lock_bnode+0x14/0x1a4 [reiser4]

This is unclear.

 >  [<e4a42a76>] ABSOLUTE_MIN_OID+0x13e/0x580 [reiser4]
 >  [<e4a33e07>] bitmap_pre_commit_hook+0x12f/0x2b7 [reiser4]

[...]

 > 
 > Does not occur with ReiserFS 3 from 2.5.45 nor with any other FS doing those 
 > small stress test. My personal impression is that Reiser4 is slower than 3 but 
 > that might be because of above debugging.

Run-time checks usually make reiser4 orders of magnitude slower.

 > 
 > I hope this helps.

Yes. Thanks a lot.

 > 
 > ciao, Marc
 > 

Nikita.

 > 
