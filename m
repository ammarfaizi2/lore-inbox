Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSHOWeW>; Thu, 15 Aug 2002 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSHOWeW>; Thu, 15 Aug 2002 18:34:22 -0400
Received: from modem80-adsl1.cordoba.sinectis.com.ar ([200.59.86.80]:63617
	"EHLO mail.vialibre.org.ar") by vger.kernel.org with ESMTP
	id <S317590AbSHOWeU>; Thu, 15 Aug 2002 18:34:20 -0400
Date: Thu, 15 Aug 2002 19:38:15 -0300
From: John Lenton <john@vialibre.org.ar>
To: linux-kernel@vger.kernel.org
Subject: bug affecting 2.4.x's /proc/stat's disk_io
Message-ID: <20020815223815.GC1095@vialibre.org.ar>
Mail-Followup-To: John Lenton <john@vialibre.org.ar>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in 2.4.x (I've seen it reported in the archives
against 2.4.7, 2.4.17 and 2.4.18) where ide disks on a second
controller don't appear in /proc/stat's disk_io.

Trying to find the source of this I find that
include/linux/kernel_stat.h says

    #define DK_MAX_MAJOR 16

that is used by drivers/block/ll_rw_blck.c's drive_stat_acct()
which returns without doing any accounting if the device's major
is larger than that. Hold on, you might say, 16 should leave hdc
and hdd out of /proc/stat too! Well, it does.

Simply changind that #define doesn't fix the problem, though.
include/linux/genhd.h's disk_index() returns 0 for any but the
first two majors of ide devices. Adding IDE2_MAJOR and IDE3_MAJOR
to the switch is simple, however.

One last problem, and the reason for this mail, is that
increasing DK_MAX_MAJOR to 35 so it included these ide devices
isn't really enough, because looking in devices.txt tells me
there are block devices with major 202, 199, and almost nonstop
from  113 on down. Most people have never seen most of these
devices, but that doesn't mean /proc/stat shouldn't show them
(right?). However, having kernel_stat hold 5*202*16 ints (just
under 64k) is IMHO ridiculous when typically at most 3 of those
202 and 4 of the 16 are used. In fact, spelled out like this I
feel even 5*16*16 is too much. OTOH moving the information into
any kind of datastructure increases the complexity of
drive_stat_acct(). My gut feeling is that something as
straightforward as a linear search in a linked list should be
fast enough, and yet I hesitate...

Help?

-- 
John Lenton (john@vialibre.org.ar) -- Random fortune:
If men acted after marriage as they do during courtship, there would
be fewer divorces -- and more bankruptcies.
		-- Frances Rodman
