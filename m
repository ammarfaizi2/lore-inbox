Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSJPHEo>; Wed, 16 Oct 2002 03:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSJPHEo>; Wed, 16 Oct 2002 03:04:44 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:16005
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264950AbSJPHEm>; Wed, 16 Oct 2002 03:04:42 -0400
Date: Wed, 16 Oct 2002 02:57:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: sfrench@us.ibm.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] CIFS invalid UNC oops fix
Message-ID: <Pine.LNX.4.44.0210160247480.1460-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No username specified <1>Unable to handle kernel NULL pointer dereference 
at virtual address 00000000
 printing eip:
c01f5b29
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c01f5b29>]    Not tainted
EFLAGS: 00010202
EIP is at inet_addr+0x19/0xc0
eax: 00000004   ebx: 00000000   ecx: c7bae800   edx: c7bae800
esi: c5757da8   edi: c5757da8   ebp: 0000000c   esp: c5757da8
ds: 0068   es: 0068   ss: 0068
Process mount (pid: 1349, threadinfo=c5756000 task=c5ec2680)
Stack: 00000000 c7bae800 c7bae800 c569e000 0000000c c01ee12d 00000000 00000000 
       00000000 00000000 c5756000 c5756000 00000001 c58fc000 c0126586 00000546 
       00000000 00000000 00000000 c0109767 00000546 00000000 80000000 c5756000 
Call Trace:
 [<c01ee12d>] cifs_mount+0xed/0x900
 [<c0126586>] sys_waitpid+0x16/0x260
 [<c0109767>] syscall_call+0x7/0xb
 [<c0131f55>] request_module+0x205/0x2d0
 [<c014365a>] __kmem_cache_alloc+0xea/0x1d0
 [<c01e8577>] cifs_read_super+0x37/0x110
 [<c01e8866>] cifs_get_sb+0x56/0xb0
 [<c015c5af>] do_kern_mount+0x3f/0xb0
 [<c017321a>] do_add_mount+0x5a/0x150
 [<c01734ec>] do_mount+0x13c/0x190
 [<c0140068>] do_mremap+0x1f8/0x3f0
 [<c017335d>] copy_mount_options+0x4d/0xa0
 [<c0173976>] sys_mount+0xe6/0x120
 [<c01199a0>] do_page_fault+0x0/0x489
 [<c0109767>] syscall_call+0x7/0xb

Code: 8a 0b 31 c0 31 ed 88 c8 8a 80 c0 cd 4b c0 83 e0 04 84 c0 74 

Index: linux-2.5.43/fs/cifs/connect.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/connect.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 connect.c
--- linux-2.5.43/fs/cifs/connect.c	16 Oct 2002 06:18:33 -0000	1.1.1.2
+++ linux-2.5.43/fs/cifs/connect.c	16 Oct 2002 06:52:27 -0000
@@ -610,7 +610,7 @@
 {
 	int rc = 0;
 	int xid;
-    int ntlmv2_flag = FALSE;
+	int ntlmv2_flag = FALSE;
 	struct socket *csocket;
 	struct sockaddr_in sin_server;
 /*	struct sockaddr_in6 sin_server6; */
@@ -627,7 +627,10 @@
 	xid = GetXid();
 	cFYI(0, ("\nEntering cifs_mount. Xid: %d with: %s\n", xid, mount_data));
 
-	parse_mount_options(mount_data, devname, &volume_info);
+	if (parse_mount_options(mount_data, devname, &volume_info)) {
+		FreeXid(xid);
+		return -EINVAL;
+	}
 
 	if (volume_info.username) {
 		cFYI(1, ("\nUsername: %s ", volume_info.username));
@@ -645,7 +648,7 @@
 		cERROR(1,
 		       ("\nCIFS mount error: No UNC path (e.g. -o unc=//192.168.1.100/public) specified  "));
 		FreeXid(xid);
-		return -ENODEV;
+		return -EINVAL;
 	}
 	/* BB add support to use the multiuser_mount flag BB */
 	existingCifsSes =
@@ -816,7 +819,7 @@
 								 "",
 								 cifs_sb->
 								 local_nls);
-					return -ENODEV;
+					return -EINVAL;
 				} else {
 					rc = CIFSTCon(xid, pSesInfo,
 						      volume_info.UNC,
-- 
function.linuxpower.ca

