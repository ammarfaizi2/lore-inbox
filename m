Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUAIRdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUAIRdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:33:21 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8320 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263002AbUAIRdR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:33:17 -0500
Message-Id: <200401091733.i09HXEQa003372@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm1 - OOPs and hangs during modprobe
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1798737534P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jan 2004 12:33:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1798737534P
Content-Type: text/plain; charset=us-ascii

Summary: 2.6.1-mm1 gives an OOPs while doing a modprobe.  Subsequent
references to /proc/modules hang (causing hangs while doing a 'shutdown'
because of scripts trying to rmmod modules.  lsmod and 'cat /proc/modules'
hang as well after the oops.

This one's from trying to load ip_conntrack_ftp:

Module len 6897 truncated
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013040b
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c013040b>]    Not tainted VLI
EFLAGS: 00010002
EIP is at sys_init_module+0x90/0x225
eax: 00000004   ebx: 0807a3e8   ecx: c03d5c30   edx: d187b104
esi: 00000000   edi: cf220000   ebp: cf221fbc   esp: cf221fb0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 172, threadinfo=cf220000 task=cf4606c0)
Stack: 0807a3e8 00000002 080573a0 cf220000 c03548de 0807a3e8 00001af1 0807a088
       00000002 080573a0 bfffe8c0 00000080 0000007b 0000007b 00000080 ffffd41a
       00000073 00000287 bfffe8c0 0000007b
Call Trace:
 [<c03548de>] sysenter_past_esp+0x43/0x65

Code: d8 57 3d c0 ff 05 d8 57 3d c0 0f 8e ac 06 00 00 89 c2 e9 9f 01 00 00 fa bf 00 e0 ff ff 21 e7 ff 47 14 8b 15 e8 57 3d c0 8d 40 04 <89> 56 04 89 42 04 a3 e8 57 3d c0 c7 40 04 e8 57 3d c0 fb 8b 47
 <6>note: modprobe[172] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011b50f>] __might_sleep+0xa4/0xac
 [<c011f16f>] do_exit+0xd9/0x389
 [<c010c5d2>] do_divide_error+0x0/0xad
 [<c011893d>] do_page_fault+0x35f/0x4b2
 [<c014576f>] unmap_vm_area+0x2c/0x73
 [<c0145a81>] vfree+0x25/0x27
 [<c0130354>] load_module+0x790/0x7b7
 [<c01185de>] do_page_fault+0x0/0x4b2
 [<c035535f>] error_code+0x2f/0x38
 [<c013040b>] sys_init_module+0x90/0x225
 [<c03548de>] sysenter_past_esp+0x43/0x65

My original thought was that the ip_conntrack_ftp.ko got corrupted,
but the 6978 is the same size as it's been since at least 2.6.0-mm2,
and this oops is *after* I'd hit one and done an 'rm -rf /lib/modules/2.6.1-mm1'
and 'make modules_install'.  And it isn't just ip_conntrack_ftp:

(this time, while trying to 'modprobe aes':
Module len 19014 truncated
Unable to handle kernel NULL pointer dereference at virtual address 00000004
printing eip:
c013040b
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[sys_init_module+144/549]    Tainted: P   VLI
EFLAGS: 00010002
EIP is at sys_init_module+0x90/0x225 
eax: 00000004   ebx: 08084028   ecx: c03d5c30   edx: d1a30c84
esi: 00000000   edi: c5a80000   ebp: c5a81fbc   esp: c5a81fb0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2446, threadinfo=c5a80000 task=c5bc1340)
Stack: 08084028 bfffe9c8 400972fd c5a80000 c03548de 08084028 00004a46 0807a0d0
bfffe9c8 400972fd bfffe980 00000080 0000007b 0000007b 00000080 ffffd41a
00000073 00000287 bfffe980 0000007b 
Call Trace:
[sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65

Code: d8 57 3d c0 ff 05 d8 57 3d c0 0f 8e ac 06 00 00 89 c2 e9 9f 01 00 00 fa bf 00 e0 ff ff 21 e7 ff 47 14 8b 15 e8 57 3d c0 8d 40 04 <89> 56 04 89 42 04 a3 e8 57 3d c0 c7 40 04 e8 57 3d c0 fb 8b 47 
<6>note: modprobe[2446] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
[__might_sleep+164/172] __might_sleep+0xa4/0xac
[do_acct_process+365/618] do_acct_process+0x16d/0x26a
[acct_process+83/105] acct_process+0x53/0x69
[do_exit+180/905] do_exit+0xb4/0x389
[do_divide_error+0/173] do_divide_error+0x0/0xad
[do_page_fault+863/1202] do_page_fault+0x35f/0x4b2
[unmap_vm_area+44/115] unmap_vm_area+0x2c/0x73
[vfree+37/39] vfree+0x25/0x27
[load_module+1936/1975] load_module+0x790/0x7b7
[do_page_fault+0/1202] do_page_fault+0x0/0x4b2
[error_code+47/56] error_code+0x2f/0x38
[sys_init_module+144/549] sys_init_module+0x90/0x225
[sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65

Yes, this one's nvidia-tainted, the other one wasn't, so it isn't nvidia ;)

Any ideas?



--==_Exmh_1798737534P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE//uXacC3lWbTT17ARAu9xAKCs3Ym5yoQuTF+aRSNMobIXOcgTUwCfUSAw
zpkuwsHaS/uocF/oGM79/34=
=ptCG
-----END PGP SIGNATURE-----

--==_Exmh_1798737534P--
