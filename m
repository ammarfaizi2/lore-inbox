Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132430AbRBRB5I>; Sat, 17 Feb 2001 20:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132541AbRBRB46>; Sat, 17 Feb 2001 20:56:58 -0500
Received: from [206.186.239.254] ([206.186.239.254]:23890 "EHLO
	krypton.netxsys.com") by vger.kernel.org with ESMTP
	id <S132430AbRBRB4m>; Sat, 17 Feb 2001 20:56:42 -0500
Date: Sat, 17 Feb 2001 20:54:03 -0500 (EST)
From: Krzysztof Adamski <k@adamski.org>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.1 with apache nfs and netapp
Message-ID: <Pine.LNX.3.96.1010217202500.2051D-100000@pc.netxsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the setup:
Compaq proliant dual PIII 800 with 1G of memory. Debian potato system with
the 2.4.1 kernel compiled from source (from ftp.kernel.org) SMP enabled.
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.2/specs
gcc version 2.95.2 20000220 (Debian GNU/Linux)
Server version: Apache/1.3.9 (Unix) Debian/GNU
The NFSv3 client is compiled in the kernel

The /usr and /var are mounted on a Network Appliance F740
website root and apache log files are on a local disk, when they are on
the netapp, the lockup happens much faster.

When doing stress testing of apache (with ab -n 1000 -c 300 -k website/ )
I get lockups, before it lockup here is what gets written to syslog:

Feb 17 19:42:27 clientweb2 kernel: Unable to handle kernel paging request at virtual address 000068a8
Feb 17 19:42:27 clientweb2 kernel: Unable to handle kernel paging request at virtual address 000068a8
Feb 17 19:42:27 clientweb2 kernel:  printing eip:
Feb 17 19:42:27 clientweb2 kernel: c0178b18
Feb 17 19:42:27 clientweb2 kernel: *pde = 00000000
Feb 17 19:42:27 clientweb2 kernel: Oops: 0000
Feb 17 19:42:27 clientweb2 kernel: CPU:    1
Feb 17 19:42:27 clientweb2 kernel: EIP:    0010:[nlmclnt_block+120/212]
Feb 17 19:42:27 clientweb2 kernel: EFLAGS: 00010203
Feb 17 19:42:27 clientweb2 kernel: eax: 000068a8   ebx: e34d7ce0   ecx: e34d7ce0   edx: 000068a8
Feb 17 19:42:27 clientweb2 kernel: esi: e5a7e460   edi: 00000000   ebp: e2eaab88   esp: e34d7cd0
Feb 17 19:42:27 clientweb2 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 19:42:27 clientweb2 kernel: Process apache (pid: 690, stackpage=e34d7000)
Feb 17 19:42:27 clientweb2 kernel: Stack: e34d7e24 e5a7e460 e2eaab88 e34d7d4c 00000000 <4>00000001  printing eip:
Feb 17 19:42:27 clientweb2 kernel: e34d7ce8 e34d7ce8 
Feb 17 19:42:27 clientweb2 kernel:        c0178b18
Feb 17 19:42:27 clientweb2 kernel: e5a7e460 <1>*pde = 00000000
Feb 17 19:42:27 clientweb2 kernel: e2eaab88 e34d7d54 00000003 c01796b0 e5a7e460 e2eaab88 e34d7e30 
Feb 17 19:42:27 clientweb2 kernel:        e34d7d60 e4f76b76 e34d7da6 e34d7d4c c01790f6 e34d7d4c e2eaab88 e4f76a20 
Feb 17 19:42:27 clientweb2 kernel: Call Trace: [nlmclnt_lock+100/164] [nlmclnt_proc+674/856] [<fbd7ad39>] [nfs_lock+253/368] [fcntl_setlk+275/444] [do_fcntl+434/712] [sys_fcntl+42/60] 
Feb 17 19:42:27 clientweb2 kernel:        [system_call+51/56] [startup_32+43/203] 
Feb 17 19:42:27 clientweb2 kernel: 
Feb 17 19:42:27 clientweb2 kernel: Code: 8b 02 85 c0 74 0a 39 c8 75 f4 8b 44 24 10 89 02 b8 00 e0 ff 
Feb 17 19:42:27 clientweb2 kernel: Oops: 0000
Feb 17 19:42:27 clientweb2 kernel: CPU:    0
Feb 17 19:42:27 clientweb2 kernel: EIP:    0010:[nlmclnt_block+120/212]
Feb 17 19:42:27 clientweb2 kernel: EFLAGS: 00010203
Feb 17 19:42:27 clientweb2 kernel: eax: 000068a8   ebx: e1923ce0   ecx: e1923ce0   edx: 000068a8
Feb 17 19:42:27 clientweb2 kernel: esi: e5a7e460   edi: 00000000   ebp: e4b824b4   esp: e1923cd0
Feb 17 19:42:27 clientweb2 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 19:42:27 clientweb2 kernel: Process apache (pid: 568, stackpage=e1923000)
Feb 17 19:42:27 clientweb2 kernel: Stack: e1923e24 e5a7e460 e4b824b4 e1923d4c e34d7ce0 00000001 e1923ce8 e1923ce8 
Feb 17 19:42:27 clientweb2 kernel:        e5a7e460 e4b824b4 e1923d54 00000003 c01796b0 e5a7e460 e4b824b4 e1923e30 
Feb 17 19:42:27 clientweb2 kernel:        e1923d60 e4f76b76 e1923da6 e1923d4c c01790f6 e1923d4c e4b824b4 e4f76a20 
Feb 17 19:42:27 clientweb2 kernel: Call Trace: [nlmclnt_lock+100/164] [nlmclnt_proc+674/856] [<fbd7ad39>] [nfs_lock+253/368] [fcntl_setlk+275/444] [do_fcntl+434/712] [sys_fcntl+42/60] 
Feb 17 19:42:27 clientweb2 kernel:        [system_call+51/56] [startup_32+43/203] 
Feb 17 19:42:27 clientweb2 kernel: 
Feb 17 19:42:27 clientweb2 kernel: Code: 8b 02 85 c0 74 0a 39 c8 75 f4 8b 44 24 10 89 02 b8 00 e0 ff 
Feb 17 19:44:57 clientweb2 kernel: Unable to handle kernel paging request at virtual address 000068ce
Feb 17 19:44:57 clientweb2 kernel:  printing eip:
Feb 17 19:44:57 clientweb2 kernel: c0178b18
Feb 17 19:44:57 clientweb2 kernel: *pde = 00000000
Feb 17 19:44:57 clientweb2 kernel: Oops: 0000
Feb 17 19:44:57 clientweb2 kernel: CPU:    0
Feb 17 19:44:57 clientweb2 kernel: EIP:    0010:[nlmclnt_block+120/212]
Feb 17 19:44:57 clientweb2 kernel: EFLAGS: 00010207
Feb 17 19:44:57 clientweb2 kernel: eax: 000068ce   ebx: e1cbbce0   ecx: e1cbbce0   edx: 000068ce
Feb 17 19:44:57 clientweb2 kernel: esi: e5a7e460   edi: 00000000   ebp: e4b820c0   esp: e1cbbcd0
Feb 17 19:44:57 clientweb2 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 19:44:57 clientweb2 kernel: Process apache (pid: 662, stackpage=e1cbb000)
Feb 17 19:44:57 clientweb2 kernel: Stack: e1cbbe24 e5a7e460 e4b820c0 e1cbbd4c e3d01ce0 00000001 e1cbbce8 e1cbbce8 
Feb 17 19:44:57 clientweb2 kernel:        e5a7e460 e4b820c0 e1cbbd54 00000003 c01796b0 e5a7e460 e4b820c0 e1cbbe30 
Feb 17 19:44:57 clientweb2 kernel:        e1cbbd60 e4f76b76 e1cbbda6 e1cbbd4c c01790f6 e1cbbd4c e4b820c0 e4f76a20 
Feb 17 19:44:57 clientweb2 kernel: Call Trace: [nlmclnt_lock+100/164] [nlmclnt_proc+674/856] [<fbd7ad39>] [nfs_lock+253/368] [fcntl_setlk+275/444] [do_fcntl+434/712] [sys_fcntl+42/60] 
Feb 17 19:44:57 clientweb2 kernel:        [system_call+51/56] [startup_32+43/203] 
Feb 17 19:44:57 clientweb2 kernel: 
Feb 17 19:44:57 clientweb2 kernel: Code: 8b 02 85 c0 74 0a 39 c8 75 f4 8b 44 24 10 89 02 b8 00 e0 ff 
Feb 17 19:44:57 clientweb2 kernel: lockd: unexpected server status -506741528
Feb 17 19:57:57 clientweb2 kernel: Unable to handle kernel paging request<1>Unable to handle kernel paging request at virtual address 00006897
Feb 17 19:57:57 clientweb2 kernel:  printing eip:
Feb 17 19:57:57 clientweb2 kernel: c0178b18
Feb 17 19:57:57 clientweb2 kernel:  at virtual address 00006897
Feb 17 19:57:57 clientweb2 kernel:  printing eip:
Feb 17 19:57:57 clientweb2 kernel: c0178b18
Feb 17 19:57:57 clientweb2 kernel: *pde = 00000000
Feb 17 19:57:57 clientweb2 kernel: *pde = 00000000
Feb 17 19:57:57 clientweb2 kernel: Oops: 0000
Feb 17 19:57:57 clientweb2 kernel: CPU:    1
Feb 17 19:57:57 clientweb2 kernel: EIP:    0010:[nlmclnt_block+120/212]
Feb 17 19:57:57 clientweb2 kernel: EFLAGS: 00010207
Feb 17 19:57:57 clientweb2 kernel: eax: 00006897   ebx: e4523ce0   ecx: e4523ce0   edx: 00006897
Feb 17 19:57:57 clientweb2 kernel: esi: e5a7e460   edi: 00000000   ebp: f761c3fc   esp: e4523cd0
Feb 17 19:57:57 clientweb2 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 19:57:57 clientweb2 kernel: Process apache (pid: 608, stackpage=e4523000)
Feb 17 19:57:57 clientweb2 kernel: Stack: e4523e24 e5a7e460 f761c3fc e4523d4c e4999ce0 00000001 e4523ce8 e4523ce8 
Feb 17 19:57:57 clientweb2 kernel:        e5a7e460 f761c3fc e4523d54 00000003 c01796b0 e5a7e460 f761c3fc e4523e30 
Feb 17 19:57:57 clientweb2 kernel:        e4523d60 e4f76b76 e4523da6 e4523d4c c01790f6 e4523d4c f761c3fc e4f76a20 <4>
Feb 17 19:57:57 clientweb2 kernel: Call Trace: [nlmclnt_lock+100/164] [nlmclnt_proc+674/856] [<fbd7ad39>] [nfs_lock+253/368] [fcntl_setlk+275/444] [do_fcntl+434/712] [sys_fcntl+42/60] 
Feb 17 19:57:57 clientweb2 kernel:        [system_call+51/56] [startup_32+43/203] 
Feb 17 19:57:57 clientweb2 kernel: 
Feb 17 19:57:57 clientweb2 kernel: Code: 8b 02 85 c0 74 0a 39 c8 75 f4 8b 44 24 10 89 02 b8 00 e0 ff 
Feb 17 19:57:57 clientweb2 kernel: Oops: 0000
Feb 17 19:57:57 clientweb2 kernel: CPU:    0
Feb 17 19:57:57 clientweb2 kernel: EIP:    0010:[nlmclnt_block+120/212]
Feb 17 19:57:57 clientweb2 kernel: EFLAGS: 00010207
Feb 17 19:57:57 clientweb2 kernel: eax: 00006897   ebx: e1305ce0   ecx: e1305ce0   edx: 00006897
Feb 17 19:57:57 clientweb2 kernel: esi: e5a7e460   edi: 00000000   ebp: e4b82be4   esp: e1305cd0
Feb 17 19:57:57 clientweb2 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 19:57:57 clientweb2 kernel: Process apache (pid: 626, stackpage=e1305000)
Feb 17 19:57:57 clientweb2 kernel: Stack: e1305e24 e5a7e460 e4b82be4 e1305d4c e1701ce0 00000001 e1305ce8 e1305ce8 
Feb 17 19:57:57 clientweb2 kernel:        e5a7e460 e4b82be4 e1305d54 00000003 c01796b0 e5a7e460 e4b82be4 e1305e30 
Feb 17 19:57:57 clientweb2 kernel:        e1305d60 e4f76b76 e1305da6 e1305d4c c01790f6 e1305d4c e4b82be4 e4f76a20 
Feb 17 19:57:57 clientweb2 kernel: Call Trace: [nlmclnt_lock+100/164] [nlmclnt_proc+674/856] [<fbd7ad39>] [nfs_lock+253/368] [fcntl_setlk+275/444] [do_fcntl+434/712] [sys_fcntl+42/60] 
Feb 17 19:57:57 clientweb2 kernel:        [system_call+51/56] 
Feb 17 19:57:57 clientweb2 kernel: 
Feb 17 19:57:57 clientweb2 kernel: Code: 8b 02 85 c0 74 0a 39 c8 75 f4 8b 44 24 10 89 02 b8 00 e0 ff 
Feb 17 19:58:27 clientweb2 kernel: Unable to handle kernel paging request at virtual address 00006897
Feb 17 19:58:27 clientweb2 kernel:  printing eip:
Feb 17 19:58:27 clientweb2 kernel: c0178b18
Feb 17 19:58:27 clientweb2 kernel: *pde = 00000000
Feb 17 19:58:27 clientweb2 kernel: Oops: 0000
Feb 17 19:58:27 clientweb2 kernel: CPU:    0
Feb 17 19:58:27 clientweb2 kernel: EIP:    0010:[nlmclnt_block+120/212]
Feb 17 19:58:27 clientweb2 kernel: EFLAGS: 00010207
Feb 17 19:58:27 clientweb2 kernel: eax: 00006897   ebx: e1701ce0   ecx: e1701ce0   edx: 00006897
Feb 17 19:58:27 clientweb2 kernel: esi: e5a7e460   edi: 00000000   ebp: f761c28c   esp: e1701cd0
Feb 17 19:58:27 clientweb2 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 19:58:27 clientweb2 kernel: Process apache (pid: 580, stackpage=e1701000)
Feb 17 19:58:27 clientweb2 kernel: Stack: e1701e24 e5a7e460 f761c28c e1701d4c e4523ce0 00000001 e1701ce8 e1701ce8 
Feb 17 19:58:27 clientweb2 kernel:        e5a7e460 f761c28c e1701d54 00000003 c01796b0 e5a7e460 f761c28c e1701e30 
Feb 17 19:58:27 clientweb2 kernel:        e1701d60 e4f76b76 e1701da6 e1701d4c c01790f6 e1701d4c f761c28c e4f76a20 
Feb 17 19:58:27 clientweb2 kernel: Call Trace: [nlmclnt_lock+100/164] [nlmclnt_proc+674/856] [<fbd7ad39>] [nfs_lock+253/368] [fcntl_setlk+275/444] [do_fcntl+434/712] [sys_fcntl+42/60] 
Feb 17 19:58:27 clientweb2 kernel:        [system_call+51/56] [startup_32+43/203] 
Feb 17 19:58:27 clientweb2 kernel: 
Feb 17 19:58:27 clientweb2 kernel: Code: 8b 02 85 c0 74 0a 39 c8 75 f4 8b 44 24 10 89 02 b8 00 e0 ff 

Anything else I should provide?

K

