Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131815AbRAOEQX>; Sun, 14 Jan 2001 23:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131745AbRAOEQN>; Sun, 14 Jan 2001 23:16:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42826 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131815AbRAOEQF>; Sun, 14 Jan 2001 23:16:05 -0500
Date: Mon, 15 Jan 2001 05:16:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Todd M. Roy" <troy@holstein.com>
Cc: "Heinz J. Mauelshagen" <Heinz.Mauelshagen@t-online.de>,
        linux-kernel@vger.kernel.org,
        Heinz Mauelshagen <mauelshagen@sistina.com>, lvm-devel@sistina.com
Subject: Re: [lvm-devel] Re: lvm 0.9.1-beta1 still segfaults vgexport
Message-ID: <20010115051624.C2207@athlon.random>
In-Reply-To: <3A45192F.8C149F93@softhome.net> <20001227205336.A10446@athlon.random> <200101081918.f08JIrT06681@pcx4168.holstein.com> <20010108234339.F27646@athlon.random> <3A5B3422.F63D7DDD@holstein.com> <20010109170424.A29468@athlon.random> <3A5BBD0E.9F7DA88B@holstein.com> <20010110024743.R29904@athlon.random> <3A61B841.81B1D0F5@holstein.com> <20010114173234.A942@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010114173234.A942@athlon.random>; from andrea@suse.de on Sun, Jan 14, 2001 at 05:32:34PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 05:32:34PM +0100, Andrea Arcangeli wrote:
> BTW, I can easily reproduce. I was near to go into it yesterday but got
> interrupted by other issues (like the merging of the 0.9.1-beta1 kernel driver
> and extraction of the strictly necessary fixes from the 0.9.1-beta1 userspace
> against 0.9).

This looks the right fix for the vgexport segfault trivially reproducible
on 0.9 and 0.9.1_beta1 lvmtools. Now that I see the details of the bug
it was possible to reproduce it also with `vgdisplay -D xxxxxxx' where
xxxxxxx is just a random name of a not existent VG.

--- ./tools/lib/pv_read_all_pv_of_vg.c.~1~	Mon Jan 15 03:35:51 2001
+++ ./tools/lib/pv_read_all_pv_of_vg.c	Mon Jan 15 04:57:00 2001
@@ -137,6 +137,11 @@
          while ( pv_this[np] != NULL) np++;
       }
 
+      if ( np == 0) {
+         ret = -LVM_EPV_READ_ALL_PV_OF_VG_NP;
+         goto pv_read_all_pv_of_vg_end;
+      }
+
       /* avoid multiple access pathes */
       for ( p = 0; pv_this[p] != NULL; p++) {
             /* avoid multiple access pathes for now (2.4.0-test8)

I also got a reminder from Marco d'Itri to integrate this hack for
some more non-x86 platform:

--- ./tools/lib/pv_get_size.c.~1~	Mon Jan 15 03:35:51 2001
+++ ./tools/lib/pv_get_size.c	Mon Jan 15 04:04:03 2001
@@ -58,7 +58,7 @@
 #define read_le(x) (x)
 #endif
 
-#if !defined(__alpha__) && !defined(__s390__)
+#ifdef __i386__
 int pv_get_size ( char *dev_name, struct partition *part_ptr) {
    int i = 0;
    int dir_cache_count = 0;

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
