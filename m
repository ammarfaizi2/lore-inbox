Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSKJDth>; Sat, 9 Nov 2002 22:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSKJDth>; Sat, 9 Nov 2002 22:49:37 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:3458 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S263986AbSKJDtf>;
	Sat, 9 Nov 2002 22:49:35 -0500
Date: Sat, 9 Nov 2002 21:56:16 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: conman@kolivas.net, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-Id: <20021109215616.53da6ab5.arashi@arashi.yi.org>
In-Reply-To: <20021110024451.GE2544@x30.random>
References: <200211091300.32127.conman@kolivas.net>
	<20021110024451.GE2544@x30.random>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Purely for information's sake ...

On Sun, 10 Nov 2002 03:44:51 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> On Sat, Nov 09, 2002 at 01:00:19PM +1100, Con Kolivas wrote:
> > xtar_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.18 [3]              150.8   49      2       8       2.11
> > 2.4.19 [1]              132.4   55      2       9       1.85
> > 2.4.19-ck9 [2]          138.6   58      2       11      1.94
> > 2.4.20-rc1 [3]          180.7   40      3       8       2.53
> > 2.4.20-rc1aa1 [3]       166.6   44      2       7       2.33
> 
> these numbers doesn't make sense. Can you describe what xtar_load is
> doing?

Repeatedly extracting tars while compiling kernels.

Andrea, I think you mixed up what the descriptions go to. They come *under*
the numbers, not above, commenting on only the test directly above them.
(eg, "First noticeable difference" is about "xtar_load")

Yes, these are kind of meaningless without descriptions. You can find those
at the webpage, http://contest.kolivas.net/ ... This will make more sense with
that, of course how meaningful it is is always up to debate :)

All of these benchmark the kernel compile while doing something else in the
background.

> In short if somebody runs fast in something like this:
> 
> 	cp /dev/zero . & time cp bigfile /dev/null
> 
> he will win your whole contest too.

That's practically one of the loads, actually.

"IO Load - copies /dev/zero continually to a file the size of
	the physical memory."

Which dds blocks the size of MemTotal in /proc/meminfo to a file
in /tmp in a shell script as long as the kernel compile is running.

> please show the difff between
> 2.4.19-ck9/drivers/block/{ll_rw_blk,elevator}.c and
> 2.4.19/drivers/block/...

elevator.c is untouched, ll_rw_blk.c follows. The full patch is here:
http://members.optusnet.com.au/con.man/ck9_2.4.19.patch.bz2

diff -bBdaurN linux-2.4.19/drivers/block/ll_rw_blk.c linux-2.4.19-ck9/drivers/bl
ock/ll_rw_blk.c
--- linux-2.4.19/drivers/block/ll_rw_blk.c      2002-08-03 13:14:45.000000000 +1
000
+++ linux-2.4.19-ck9/drivers/block/ll_rw_blk.c  2002-10-14 17:21:18.000000000 +1
000
@@ -1112,6 +1112,9 @@
        if (!test_bit(BH_Lock, &bh->b_state))
                BUG();
 
+       if (buffer_delay(bh) || !buffer_mapped(bh))
+               BUG();
+
        set_bit(BH_Req, &bh->b_state);
        set_bit(BH_Launder, &bh->b_state);
 
@@ -1132,6 +1135,7 @@
                        kstat.pgpgin += count;
                        break;
        }
+       conditional_schedule();
 }
 
 /**
@@ -1270,7 +1274,8 @@
 
        req->errors = 0;
        if (!uptodate)
-               printk("end_request: I/O error, dev %s (%s), sector %lu\n",
+               printk(KERN_INFO "end_request: I/O error, dev %s (%s)," 
+                      " sector %lu\n",
                        kdevname(req->rq_dev), name, req->sector);
 
        if ((bh = req->bh) != NULL) {

.
> Either that or change the name of your project,

It's called "contest" because it's a reasonably arbitrary test of what
the kernel does under some circumstances that's put out by Con Kolivas.
Con's test. Contest. It's not supposed to actually mean anything.

Matt
