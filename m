Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132957AbRAaCCo>; Tue, 30 Jan 2001 21:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRAaCCf>; Tue, 30 Jan 2001 21:02:35 -0500
Received: from smtp2.kolumbus.fi ([193.229.0.37]:29805 "EHLO smtp2.kolumbus.fi")
	by vger.kernel.org with ESMTP id <S132957AbRAaCCa> convert rfc822-to-8bit;
	Tue, 30 Jan 2001 21:02:30 -0500
Message-Id: <200101310202.EAA11357@smtp2.kolumbus.fi>
Date: Wed, 31 Jan 2001 4:10 +0200
From: jukka.santala@kolumbus.fi
Subject: 2.4.X inode cache bug
To: linux-kernel@vger.kernel.org
Cc: jukka.santala@kolumbus.fi
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me for the lack of patch in this mail, but I'm currently
suffering some connection-troubles... Please Cc replies to me.

In 2.4.x, linux/fs/inode.c has a hash() function with a small slip-up.
The inode hash-value is initialized with "unsigned long tmp = i_ino |
((unsigned long) sb / L1_CACHE_BYTES);".

The intention seems to be to take some cache-affinity from the extra
operations, but it isn't working. I believe this is a slip-up, because you
should NEVER use bitwise-or in a hash formula. This creates a
slanted distribution, and depending on the address of the superblock
block, can cause severe inefficiency in the code.

Just replacing the | with ^ imroves hash-table efficiency noticeably,
making a clear difference in system profiling and seems to improve
system responsiveness during disk-I/O tremendously. Ofcourse, this is
not perfect for cache coverage, but I doubt the cache-coverage for
bucket heads has any practical effect with the extra instructions
calculating it requires. Might be a good excuse to look into that
quadratic hash too ;)

Please correct this asap, as it can cause severe performance
degradation for things like news-servers compared to 2.2 series.

Ps. speaking of function profiling,
linux/drivers/char/console.c:do_con_write() prohibits the IRQ's for far
too long while. This makes it impossible to tell if the code within is
inefficient by profiling, but also wreaks havoc with any timing critical
code (Such as, network routing...)  because something as innocent as
writing long strings to console can lock things for while. On top of
that the spin-lock logic for this fuction is solid, since some nominally
non-re-entrant code remains outside the spinlock! Hopefully
somebody more knowledgeabe in the console control-flow will take a
swipe at making the (IRQ-masked) critical-section one-character long
at most.

 -Donwulff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
