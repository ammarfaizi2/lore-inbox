Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTIXQsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTIXQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:48:38 -0400
Received: from mivlgu.ru ([81.18.140.87]:9878 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S261503AbTIXQse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:48:34 -0400
Date: Wed, 24 Sep 2003 20:48:32 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] [PATCH 2.4] ieee1394 locking bug in nodemgr
Message-ID: <20030924164832.GB26237@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I have found a locking bug in ieee1394 nodemgr_host_thread() (in
Linux 2.4.22; checked at linux.bkbits.net - the code in question did
not change).

The bug manifests itself in a kudzu hang at system startup.  kudzu
performs "modprobe ohci1394", then reads /proc/bus/ieee1394/devices,
then calls "modprobe -r ohci1394".  At this point the modprobe
process stays in the D state forever (unkillable), and kudzu waits
forever for it to complete.  Alt-SysRq-T shows this about the hung
modprobe process:

modprobe      D C02C8500     0  1435      1          1690  1080 (NOTLB)
Call Trace:    [<dec2a540>] [<c01076c4>] [<dec2a548>] [<dec2a548>] [<c0107810>]
  [<dec2a540>] [<dec26e27>] [<dec2a598>] [<dec2a580>] [<dec233b2>] [<dec30291>]
  [<dec31d40>] [<c01c245f>] [<dec3060a>] [<dec31d40>] [<c011ac5e>] [<c011a10c>]
  [<c0108933>]

Proc;  modprobe

>>EIP; c02c8500 <tasklist_lock+0/0>   <=====

Trace; dec2a540 <[ieee1394]nodemgr_serialize+0/10>
Trace; c01076c4 <__down+54/a0>
Trace; dec2a548 <[ieee1394]nodemgr_serialize+8/10>
Trace; dec2a548 <[ieee1394]nodemgr_serialize+8/10>
Trace; c0107810 <__down_failed+8/c>
Trace; dec2a540 <[ieee1394]nodemgr_serialize+0/10>
Trace; dec26e27 <[ieee1394].text.lock.nodemgr+b9/d2>
Trace; dec2a598 <[ieee1394]nodemgr_highlevel+18/30>
Trace; dec2a580 <[ieee1394]nodemgr_highlevel+0/30>
Trace; dec233b2 <[ieee1394]highlevel_remove_host+22/40>
Trace; dec30291 <[ieee1394]dummy_max_addr+5bf1/a9c0>
Trace; dec31d40 <[ieee1394]dummy_max_addr+76a0/a9c0>
Trace; c01c245f <pci_unregister_driver+3f/60>
Trace; dec3060a <[ieee1394]dummy_max_addr+5f6a/a9c0>
Trace; dec31d40 <[ieee1394]dummy_max_addr+76a0/a9c0>
Trace; c011ac5e <free_module+1e/b0>
Trace; c011a10c <sys_delete_module+11c/1d0>
Trace; c0108933 <system_call+33/40>

This shows that the modprobe process is waiting for the
nodemgr_serialize mutex, which for some reason was never released.
I have found the point where this mutex might not be released; it is
in nodemgr_host_thread().  When the schedule_timeout(HZ/16) call in
this function is interrupted, it jumps out of the loop with (goto
caught_signal), but does not release the lock.  Apparently kudzu
produces just the right timing to trigger this bug.

I have made a simple patch to fix this problem (adding
up(&nodemgr_serialize) before that goto); with this patch the kudzu
hang is no longer occuring.

-- 
Sergey Vlasov

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_ieee1394-nodemgr-lock-fix.patch"

--- kernel-source-2.4.22/drivers/ieee1394/nodemgr.c.ieee1394-lockfix	2003-08-25 15:44:41 +0400
+++ kernel-source-2.4.22/drivers/ieee1394/nodemgr.c	2003-09-24 15:29:14 +0400
@@ -1317,8 +1317,10 @@
 		 * to make sure things settle down. */
 		for (i = 0; i < 4 ; i++) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (schedule_timeout(HZ/16))
+			if (schedule_timeout(HZ/16)) {
+				up(&nodemgr_serialize);
 				goto caught_signal;
+			}
 
 			/* Now get the generation in which the node ID's we collect
 			 * are valid.  During the bus scan we will use this generation

--kXdP64Ggrk/fb43R--

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ccrfW82GfkQfsqIRAoSbAKCFG8MB4Vi4gjy14nGyvITgfQp4dACghq5D
LnPHFgJAJb9nalLvbCd63B8=
=mVsz
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
