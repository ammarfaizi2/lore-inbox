Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQLKLFz>; Mon, 11 Dec 2000 06:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbQLKLFp>; Mon, 11 Dec 2000 06:05:45 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:37638 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S130339AbQLKLFd>; Mon, 11 Dec 2000 06:05:33 -0500
Date: Mon, 11 Dec 2000 12:47:55 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH-2] Re: NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.21.0012102152440.5361-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012111133500.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2000, Tigran Aivazian wrote:
> On Sun, 10 Dec 2000, Szabolcs Szakacsits wrote:
> > - this comment from include/linux/fs.h should be deleted
> >   #define NR_RESERVED_FILES 10 /* reserved for root */
> well, not really -- it is "reserved" right now too, it is just root is
> allowed to use up all the reserved entries in the beginning and then when
> the normal user uses up all the "non-reserved" ones (from slab
> cache) there would be nothing left for the root.

And what real functionality does this provide? Close to nada. This is
why I told you if you are right then it's usefuless. So I think this
is a bug that was introduced accidentaly overlooking NR_RESERVED_FILES
functionality when get_empty_filp was rewritten to use the slab.

> But let us not argue about the above definition of "reserved" -- that is
> not productive.

Agree, this is why I made the patch ;) Also, this stupid
misunderstanding and waste of time between us is a *very* typical
example of the result of the super inferior Linux kernel source code
management. No way to dig up who and why dropped the reserved file
functionality about three years ago. "Hidden", unexplained patches
slip in almost every patch-set. Some developers think they can save a
huge amount of time by this "model", they just ignore other developers
and support people who need to understand what, when, why and by who a
changes happened. And because of lack of enough information [look,
both of us have and I think understand the code, still we don't agree]
the end result is that, apparently by now too many times the ball is
dropped back to these developers who get buried by even more job. This
is just one sign Linux has a hard future and unfortunately there are
others .... In general Linux is still one of the best today but
without addressing and solving current development problems it will
not be true after a couple of years. Linux remains just another Unix
and lose in 1:100 to another OS. The source is with us but it should
be used properly ....

> Let's do something productive -- namely, take your idea to
> the next logical step. Since you have proven that the freelist mechanism
> or concept of "reserve file structures" is not 100% satisfactory as is

This is also a difference between us. You look the problem from a
theoretical point of you, saying it's not 100%, I consider it from
practical point of you and say it gives close to 0% functionality for
users.

> then how about removing the freelist altogether? I.e. what about serving

I'm fine with the current implementation and more interested in bug
fixes. There could be one reason against the patch, performance. The
patch below has the same fix and TUX will give exactly the same
numbers [get_empty_filp code remains ugly but at least fast].

	Szaka

diff -ur linux-2.4.0-test12-pre7/fs/file_table.c linux/fs/file_table.c
--- linux-2.4.0-test12-pre7/fs/file_table.c	Fri Dec  8 08:17:12 2000
+++ linux/fs/file_table.c	Mon Dec 11 10:40:41 2000
@@ -57,7 +57,9 @@
 	/*
 	 * Allocate a new one if we're below the limit.
 	 */
-	if (files_stat.nr_files < files_stat.max_files) {
+	if ((files_stat.nr_files < files_stat.max_files) && (!current->euid ||
+	     NR_RESERVED_FILES - files_stat.nr_free_files <
+	     files_stat.max_files - files_stat.nr_files)) {
 		file_list_unlock();
 		f = kmem_cache_alloc(filp_cachep, SLAB_KERNEL);
 		file_list_lock();
diff -ur linux-2.4.0-test12-pre7/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.0-test12-pre7/include/linux/fs.h  Fri Dec  8 15:06:55 2000
+++ linux/include/linux/fs.h    Sun Dec 10 17:37:52 2000
@@ -57,7 +57,7 @@
 extern int leases_enable, dir_notify_enable, lease_break_time;

 #define NR_FILE  8192  /* this can well be larger on a larger system */
-#define NR_RESERVED_FILES 10 /* reserved for root */
+#define NR_RESERVED_FILES 128 /* reserved for root */
 #define NR_SUPER 256

 #define MAY_EXEC 1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
