Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWGKEUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWGKEUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWGKEU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:20:29 -0400
Received: from pool-72-66-204-177.ronkva.east.verizon.net ([72.66.204.177]:1221
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965136AbWGKEU2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:20:28 -0400
Message-Id: <200607110420.k6B4KMZM013584@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm1 - VPN chewing CPU like crazy..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152591622_4450P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 00:20:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152591622_4450P
Content-Type: text/plain; charset=us-ascii

(This is *NOT* new with 2.6.18-rc1-mm1, I've seen it a few times before, no
idea when it started... I think I've seen it as far back as 2.6.16-mm2 or so).

Most of the time, the VPN comes up just fine.

Jul 10 22:44:28 turing-police kernel: [ 7180.696000] CSLIP: code copyright 1989 Regents of the University of California
Jul 10 22:44:28 turing-police kernel: [ 7180.701000] PPP generic driver version 2.4.2
Jul 10 23:00:26 turing-police kernel: [ 8137.903000] PPP MPPE Compression module registered

However, sometimes (usually when restarting after the VPN gets dropped due to
a network burp, etc), it will start up, get connected, and then the the first
(or one of the first) data packets over the VPN will suddenly spike the
CPU to 100% (about 50% userspace and 50% kernel).  A quick oprofile check
shows the kernel CPU getting sucked:

samples  %        image name               app name                 symbol name
10901    18.2805  arc4.ko                  arc4                     .text
5046      8.4619  ppp_async.ko             ppp_async                ppp_async_push
4865      8.1584  pptp                     pptp                     (no symbols)
4382      7.3484  arc4.ko                  arc4                     arc4_set_key
4331      7.2629  vmlinux                  vmlinux                  sha_transform
4203      7.0482  libfb.so                 libfb.so                 fbCopyAreammx
3342      5.6044  vmlinux                  vmlinux                  ecb_process
1324      2.2203  libgdk_imlib.so.1.9.13   libgdk_imlib.so.1.9.13   (no symbols)
1149      1.9268  ip_tables.ko             ip_tables                ipt_do_table
1071      1.7960  vmlinux                  vmlinux                  local_bh_enable
848       1.4221  vmlinux                  vmlinux                  acpi_pm_read
816       1.3684  vmlinux                  vmlinux                  __local_bh_disable
698       1.1705  vmlinux                  vmlinux                  n_tty_receive_buf
651       1.0917  vmlinux                  vmlinux                  do_page_fault

(pptp is the userspace control process)

gkrellm reports that about 4 mbytes/sec is being sent on ppp0 - but shows
zero traffic on eth0 (the underlying interface).  When working properly,
both ppp0 and eth0 show the traffic.

This continues until I get fed up and manually take the VPN down, at which
point it happily gets rid of ppp0 and CPU load returns to normal.

I haven't found a clean way to reproduce it - sometimes I won't see it for
2-3 weeks, then it will pop up several times in an evening.

Any suggestions/hints (besides rebuilding the implicated .ko with debugging
symbols so oprofile can be more granular - that's already on the to-do list)?

--==_Exmh_1152591622_4450P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEsycGcC3lWbTT17ARApBXAJ9gh4RB5n26Xonpo/EYNOK9Gd8ywgCgvZnt
qbQsM6cXTnEAu7rZO81Co+g=
=vr0g
-----END PGP SIGNATURE-----

--==_Exmh_1152591622_4450P--
