Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTLDXNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTLDXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:13:20 -0500
Received: from bender1.bawue.de ([193.197.10.1]:62102 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263695AbTLDXNL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:13:11 -0500
From: Thilo Schulz <arny@ats.s.bawue.de>
Reply-To: arny@ats.s.bawue.de
To: linux-kernel@vger.kernel.org
Subject: 2.4.23: postfix oopses on mmap?
Date: Thu, 4 Dec 2003 23:38:54 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312042338.56579.arny@ats.s.bawue.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have installed the new kernel 2.4.23 in order to fix the brk() bug that 
appeared recently.
After about 2 and a half days of uptime the following errors appeared in 
/var/log/syslog:

Dec  4 21:56:08 server master[1371]: about to exec /usr/cyrus/bin/pop3d
Dec  4 21:56:08 server pop3[1371]: executed
Dec  4 21:56:08 server pop3d[1371]: accepted connection
Dec  4 21:56:09 server pop3d[1371]: mystore: starting txn 2147483781
Dec  4 21:56:09 server pop3d[1371]: mystore: committing txn 2147483781
Dec  4 21:56:09 server pop3d[1371]: starttls: TLSv1 with cipher RC4-MD5 
(128/128 bits new) no authentication
Dec  4 21:56:09 server kernel: kernel BUG at page_alloc.c:103!
Dec  4 21:56:09 server kernel: invalid operand: 0000
Dec  4 21:56:09 server kernel: CPU:    0
Dec  4 21:56:09 server kernel: EIP:    0010:[__free_pages_ok+54/672]    Not 
tainted
Dec  4 21:56:09 server kernel: EFLAGS: 00010286
Dec  4 21:56:09 server kernel: eax: 0100000c   ebx: c153fa3c   ecx: c153fa3c   
edx: 00000000
Dec  4 21:56:09 server kernel: esi: 00000000   edi: cc089f40   ebp: dcb63200   
esp: d02c9e94
Dec  4 21:56:09 server kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 21:56:09 server kernel: Process saslauthd (pid: 1367, 
stackpage=d02c9000)
Dec  4 21:56:09 server kernel: Stack: c153fa3c c119a8a8 cc089f40 dcb63200 
dcb63200 cc089f40 c0284b7f c153fa3c
Dec  4 21:56:09 server kernel:        c119a8a8 c0284ce9 c9549000 de898000 
c01240bc c012dedb c01240c8 401aef3c
Dec  4 21:56:09 server kernel:        dcb63200 00000001 cc089f40 c0124182 
dcb63200 cc089f40 401aef3c 00000001
Dec  4 21:56:09 server kernel: Call Trace:    [fast_copy_page+15/224] 
[mmx_copy_page+41/48] [do_no_page+252/368] [__free_pages+27/32] 
[do_no_page+264/368]
Dec  4 21:56:09 server kernel:   [handle_mm_fault+82/176] 
[do_page_fault+355/1156] [do_page_fault+0/1156] [schedule+758/800] 
[syscall_trace+61/96] [error_code+52/60]
Dec  4 21:56:09 server kernel:
Dec  4 21:56:09 server kernel: Code: 0f 0b 67 00 f3 4d 29 c0 83 7b 08 00 74 08 
0f 0b 69 00 f3 4d

These errors appear when postfix starts some of its programs it uses like qmgr 
or pickup, or when cyrus checks for a correct password with saslauthd. I was 
able to strace the saslauthd process that caused the error report in 
/var/log/syslog.

Following is the result:

open("/lib/libnsl.so.1", O_RDONLY)      = 11
read(11, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 ;\0\000"..., 1024) = 
1024
fstat64(11, {st_mode=S_IFREG|0644, st_size=69472, ...}) = 0
old_mmap(NULL, 80988, PROT_READ|PROT_EXEC, MAP_PRIVATE, 11, 0) = 0x401cd000
mprotect(0x401de000, 11356, PROT_NONE)  = 0
old_mmap(0x401de000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 11, 
0x10000) = 0x401de000
old_mmap(0x401df000, 7260, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401df000
close(11)                               = 0
open("/lib/libm.so.6", O_RDONLY)        = 11
read(11, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2007\0"..., 1024) = 
1024
fstat64(11, {st_mode=S_IFREG|0644, st_size=130088, ...}) = 0
old_mmap(NULL, 132708, PROT_READ|PROT_EXEC, MAP_PRIVATE, 11, 0) = 0x401e1000
mprotect(0x40201000, 1636, PROT_NONE)   = 0
old_mmap(0x40201000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 11, 
0x1f000) = 0x40201000
close(11)                               = 0
+++ killed by SIGSEGV +++

What could be causing this? I thought about the possibility, that the server 
could have been compromised, but so far, there is no evidence of that. 
chkrootkit did not bring back anything, and comparing the md5sums in /sbin/ , 
/bin/   and  /lib/   did not return any suspicious results.
Meanwhile, even debsums seems to crash. Here the corresponding syslog entries:

Dec  4 22:14:05 server kernel: kernel BUG at page_alloc.c:103!
Dec  4 22:14:05 server kernel: invalid operand: 0000
Dec  4 22:14:05 server kernel: CPU:    0
Dec  4 22:14:05 server kernel: EIP:    0010:[__free_pages_ok+54/672]    Not 
tainted
Dec  4 22:14:05 server kernel: EFLAGS: 00010286
Dec  4 22:14:05 server kernel: eax: 0100000c   ebx: c153fa3c   ecx: c153fa3c   
edx: 00000000
Dec  4 22:14:05 server kernel: esi: 00000000   edi: 00000000   ebp: de8f5144   
esp: cd03dee8
Dec  4 22:14:05 server kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 22:14:05 server kernel: Process debsums (pid: 1517, stackpage=cd03d000)
Dec  4 22:14:05 server kernel: Stack: c153fa3c 00001000 00000000 de8f5144 
00000000 cd03c000 c0126588 c14044ac
Dec  4 22:14:05 server kernel:        c153fa3c c153fa3c c15fc118 00000000 
de8f5144 c012dedb c0126bd5 cd03df8c
Dec  4 22:14:05 server kernel:        c153fa3c 00000000 00001000 00000000 
dcd388c0 ffffffea 00001000 00001000
Dec  4 22:14:05 server kernel: Call Trace:    [__lock_page+184/192] 
[__free_pages+27/32] [do_generic_file_read+517/1088] 
[generic_file_read+147/400] [file_read_actor+0/144]
Dec  4 22:14:05 server kernel:   [sys_read+150/240] [system_call+51/56]
Dec  4 22:14:05 server kernel:
Dec  4 22:14:05 server kernel: Code: 0f 0b 67 00 f3 4d 29 c0 83 7b 08 00 74 08 
0f 0b 69 00 f3 4d

Please include me in the CC, as I am not subscribed to this list.

- --
 - Thilo Schulz

My public GnuPG key is available at http://home.bawue.de/~arny/public_key.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z7d+Zx4hBtWQhl4RAh8lAJ9inRQA7jKyedggi8XR35gZXyudLACfSh3V
T/8XLKKaAJh5IAVLtZ6kIyU=
=boNd
-----END PGP SIGNATURE-----

