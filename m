Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWFYHfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWFYHfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 03:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWFYHfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 03:35:40 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:36031 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932086AbWFYHfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 03:35:40 -0400
Date: Sun, 25 Jun 2006 09:35:34 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, ck@vds.kolivas.org
Subject: 2.6.17-ck1: fcache problem...
Message-ID: <20060625093534.1700e8b6@localhost>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to get fcache (2.6.17-ck1) working on my machine, but it
works just once ;)

In Gentoo the root fs is remounted rw in "checkroot" init script, so
I've done this:

--- /etc/init.d/checkroot.orig  2006-06-24 18:47:41.000000000 +0200
+++ /etc/init.d/checkroot       2006-06-25 09:17:52.000000000 +0200
@@ -70,8 +70,10 @@
        if mount -vf -o remount / 2> /dev/null | \
           awk '{ if ($6 ~ /rw/) exit 0; else exit 1; }'
        then
-               ebegin "Remounting root filesystem read/write"
-               mount -n -o remount,rw / &> /dev/null
+               ebegin "Remounting root filesystem read/write (FCACHE)"
+               # try with fcache
+               mount -n -o remount,rw,fcache_dev=8/10,fcache_prime=0 / &> /dev/null || \
+                       mount -n -o remount,rw / &> /dev/null
                if [[ $? -ne 0 ]] ; then
                        eend 2 "Root filesystem could not be mounted read/write :("
                        if [[ ${RC_FORCE_AUTO} != "yes" ]] ; then


1) priming - it works

[  167.488268] fcache: ios r/w 8304/4747, hits 0, misses 0, overwrites 1217
[  167.882597] fcache: wrote 8304 extents, holding 347648 sectors of data
[  167.899555] fcache: wrote header (extents=8304,serial=33)

"remounting with priming=0"

[  167.905498] fcache: header looks valid (extents=8304 extents, serial=33)
[  167.928273] fcache: loaded 8304 extents
[  167.928320] fcache: sda10 opened successfully (not priming)


2) first boot with priming=0 - it works! Great speedup :)

[   37.845964] fcache: header looks valid (extents=8304 extents, serial=33)
[   37.874101] fcache: loaded 8304 extents
[   37.874105] fcache: sda10 opened successfully (not priming)


3) reboot - it doesn't work anymore :(

[   26.673525] fcache: found serial 33, expected 34.
[   26.673529] fcache: reprime the cache!
[   26.673535] ext3: failed to open fcache (err=-22)



I'm doing something wrong?

-- 
	Paolo Ornati
	Linux 2.6.17-ck1 on x86_64
