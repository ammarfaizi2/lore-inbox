Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUCDDD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUCDDDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:03:25 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:58123 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S261346AbUCDDDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:03:19 -0500
Subject: 2.6.4-rc1-bk3 knfsd V3 readdir problems  (missing files) and OOPS
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: nk@iname.com
Content-Type: text/plain
Organization: TBD Networks
Message-Id: <1078369397.1677.25.camel@defiant>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 
Date: Wed, 03 Mar 2004 19:03:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have problems with knfsd and large directories.  I have a directory
containing 2038 files on my Linux server which is mounted from a Solaris
server.  If mounting with -o 'vers=3', "ls | wc -l" only reports 639 of
these files.  Mounting with 'vers=2' works fine.  'proto=udp' or
'proto=tcp' does not make a difference. I sniffed on the network and I
don't see the missing filenames in the datastream sent, so I assume it's
really a Linux problem. "cat" of these missing files works.

Environment is Linux version 2.6.4-rc1-bk3 (nkiesel@defiant) (gcc
version 3.3.3 (Debian)), self-compiled unpatched kernel,
# grep NFS /boot/config-2.6.4-rc1-bk3
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y

Small directories (<100 files) work fine.  While trying to find the
exact number of files where it breaks, I started removing and adding
files to  large test directory.  This resulted in the following OOPS
(sorry my stupid mailer insists on breaking long lines):

Mar  3 18:55:01 defiant kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Mar  3 18:55:01 defiant kernel:  printing eip:
Mar  3 18:55:01 defiant kernel: c025e201
Mar  3 18:55:01 defiant kernel: *pde = 00000000
Mar  3 18:55:01 defiant kernel: Oops: 0002 [#1]
Mar  3 18:55:01 defiant kernel: PREEMPT
Mar  3 18:55:01 defiant kernel: CPU:    0
Mar  3 18:55:01 defiant kernel: EIP:    0060:[do_tcp_sendpages+401/2752]
Not tainted
Mar  3 18:55:01 defiant kernel: EFLAGS: 00010287
Mar  3 18:55:01 defiant kernel: EIP is at do_tcp_sendpages+0x191/0xac0
Mar  3 18:55:01 defiant kernel: eax: ddced108   ebx: f7dd7500   ecx:
00000008   edx: 00000000
Mar  3 18:55:01 defiant kernel: esi: 00000001   edi: ddced100   ebp:
d8498bc0   esp: f5873e28
Mar  3 18:55:01 defiant kernel: ds: 007b   es: 007b   ss: 0068
Mar  3 18:55:01 defiant kernel: Process nfsd (pid: 9693,
threadinfo=f5872000 task=f724ad40)
Mar  3 18:55:01 defiant kernel: Stack: 00008000 ea1e4740 c014dc4c
c02f0b20 d2bd5534 f5873e6c ddced110 d8498c14
Mar  3 18:55:01 defiant kernel:        00000008 00000000 00000000
00000000 000005b4 d8498d8c 00000000 f5873e88
Mar  3 18:55:01 defiant kernel:        00007530 00000000 d8498bc0
00000000 00000008 c025eba2 00000008 00000000
Mar  3 18:55:01 defiant kernel: Call Trace:
Mar  3 18:55:01 defiant kernel:  [open_private_file+28/144]
open_private_file+0x1c/0x90
Mar  3 18:55:01 defiant kernel:  [tcp_sendpage+114/128] tcp_sendpage
+0x72/0x80
Mar  3 18:55:01 defiant kernel:  [__crc_utf8_wctomb+6328041/6417782]
svc_sendto+0x142/0x260 [sunrpc]
Mar  3 18:55:01 defiant kernel:  [__crc_utf8_wctomb+6332027/6417782]
svc_tcp_sendto+0x44/0xa0 [sunrpc]
Mar  3 18:55:01 defiant kernel:  [__crc_utf8_wctomb+6334016/6417782]
svc_send+0xa9/0xf0 [sunrpc]
Mar  3 18:55:01 defiant kernel:  [__crc_pm_idle+1084711/1453519] fh_put
+0x136/0x180 [nfsd]
Mar  3 18:55:01 defiant kernel:  [__crc_utf8_wctomb+6336324/6417782]
svc_authenticate+0x4d/0x80 [sunrpc]
Mar  3 18:55:01 defiant kernel:  [__crc_pm_idle+1132257/1453519]
nfs3svc_encode_readdirres+0x0/0xa0 [nfsd]
Mar  3 18:55:01 defiant kernel:  [__crc_utf8_wctomb+6325284/6417782]
svc_process+0x18d/0x5e0 [sunrpc]
Mar  3 18:55:01 defiant kernel:  [need_resched+39/50] need_resched
+0x27/0x32
Mar  3 18:55:01 defiant kernel:  [__crc_pm_idle+1074595/1453519] nfsd
+0x1c2/0x370 [nfsd]
Mar  3 18:55:01 defiant kernel:  [__crc_pm_idle+1074145/1453519] nfsd
+0x0/0x370 [nfsd]
Mar  3 18:55:01 defiant kernel:  [kernel_thread_helper+5/16]
kernel_thread_helper+0x5/0x10
Mar  3 18:55:01 defiant kernel:
Mar  3 18:55:01 defiant kernel: Code: ff 42 04 8b 7c 24 28 8b 83 a4 00
00 00 8d 04 f0 8d 50 10 89


