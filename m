Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQKUUDp>; Tue, 21 Nov 2000 15:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbQKUUDe>; Tue, 21 Nov 2000 15:03:34 -0500
Received: from 213-1-125-245.btconnect.com ([213.1.125.245]:54533 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129391AbQKUUDV>;
	Tue, 21 Nov 2000 15:03:21 -0500
Date: Tue, 21 Nov 2000 19:35:09 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: deadlock on 4way machine
Message-ID: <Pine.LNX.4.21.0011211932260.1463-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some processes get stuck in page fault handler for ages (like for 10
minutes!). The machine still has plenty (3.5G) of free high memory but
zero (2216K) of free low memory.

here are some traces:

Entering kdb (current=0xc767c000, pid 0) on processor 2 due to Keyboard Entry
[2]kdb> ps
Task Addr    Pid     Parent  [*] cpu  State    Thread   Command
0xc7678000 00000001 00000000  0  003  stop  0xc7678350 init
0xc76fc000 00000002 00000001  0  001  stop  0xc76fc350 eventd
0xc76e2000 00000003 00000001  0  003  stop  0xc76e2350 kswapd
0xc76e0000 00000004 00000001  0  001  stop  0xc76e0350 kreclaimd
0xc76de000 00000005 00000001  0  001  stop  0xc76de350 kflushd
0xc76dc000 00000006 00000001  0  003  stop  0xc76dc350 kupdate
0xf735e000 00000075 00000001  0  003  stop  0xf735e350 voltuned
0xf7352000 00000080 00000001  0  001  stop  0xf7352350 vxiod
0xf734a000 00000081 00000001  0  001  stop  0xf734a350 vxiod
0xf7348000 00000082 00000001  0  001  stop  0xf7348350 vxiod
0xf745e000 00000083 00000001  0  001  stop  0xf745e350 vxiod
0xf7346000 00000084 00000001  0  001  stop  0xf7346350 vxiod
0xf7344000 00000085 00000001  0  001  stop  0xf7344350 vxiod
0xf7342000 00000086 00000001  0  001  stop  0xf7342350 vxiod
0xf7340000 00000087 00000001  0  001  stop  0xf7340350 vxiod
0xf72fe000 00000088 00000001  0  001  stop  0xf72fe350 vxiod
0xf72fc000 00000089 00000001  0  001  stop  0xf72fc350 vxiod
0xf736c000 00000094 00000001  0  003  stop  0xf736c350 vxconfigd
0xf71ee000 00000182 00000001  0  002  stop  0xf71ee350 vxrelocd
0xf71ea000 00000187 00000182  0  003  stop  0xf71ea350 vxnotify
0xf71d6000 00000188 00000182  0  001  stop  0xf71d6350 vxrelocd
[2]more> 
0xf714c000 00000443 00000001  0  003  stop  0xf714c350 syslogd
0xf71b0000 00000453 00000001  0  001  stop  0xf71b0350 klogd
0xf710a000 00000468 00000001  0  000  stop  0xf710a350 portmap
0xf711c000 00000495 00000001  0  002  stop  0xf711c350 rpc.rquotad
0xf70d2000 00000505 00000001  0  003  stop  0xf70d2350 rpc.mountd
0xf70c4000 00000515 00000001  0  001  stop  0xf70c4350 nfsd
0xf70be000 00000516 00000515  0  001  stop  0xf70be350 lockd
0xf70ba000 00000517 00000516  0  001  stop  0xf70ba350 rpciod
0xf70b8000 00000518 00000001  0  001  stop  0xf70b8350 nfsd
0xf70ae000 00000519 00000001  0  001  stop  0xf70ae350 nfsd
0xf70a6000 00000520 00000001  0  003  stop  0xf70a6350 nfsd
0xf70a4000 00000521 00000001  0  001  stop  0xf70a4350 nfsd
0xf709a000 00000522 00000001  0  001  stop  0xf709a350 nfsd
0xf7092000 00000523 00000001  0  003  stop  0xf7092350 nfsd
0xf708a000 00000524 00000001  0  001  stop  0xf708a350 nfsd
0xf7082000 00000539 00000001  0  000  stop  0xf7082350 rpc.statd
0xf74e4000 00000565 00000001  0  003  stop  0xf74e4350 xinetd
0xf701c000 00000601 00000001  0  003  stop  0xf701c350 crond
0xf7574000 00000623 00000001  0  003  stop  0xf7574350 login
0xf720c000 00000624 00000001  0  000  stop  0xf720c350 login
0xf7018000 00000625 00000001  0  002  stop  0xf7018350 login
0xf7004000 00000626 00000001  0  002  stop  0xf7004350 mingetty
0xf6fa6000 00000664 00000623  0  000  stop  0xf6fa6350 bash
[2]more> 
0xf588a000 00000694 00000001  0  002  stop  0xf588a350 vx_sched_thread
0xf6fb4000 00000695 00000001  0  002  stop  0xf6fb4350 vx_worklist_thr
0xf5886000 00000697 00000001  0  002  stop  0xf5886350 vx_worklist_thr
0xf5888000 00000696 00000001  0  002  stop  0xf5888350 vx_worklist_thr
0xf5884000 00000698 00000001  0  002  stop  0xf5884350 vx_worklist_thr
0xf5882000 00000699 00000001  0  002  stop  0xf5882350 vx_worklist_thr
0xf5880000 00000700 00000001  0  002  stop  0xf5880350 vx_worklist_thr
0xf587e000 00000701 00000001  0  002  stop  0xf587e350 vx_worklist_thr
0xf587c000 00000702 00000001  0  002  stop  0xf587c350 vx_worklist_thr
0xf587a000 00000703 00000001  0  002  stop  0xf587a350 vx_worklist_thr
0xf5878000 00000704 00000001  0  002  stop  0xf5878350 vx_worklist_thr
0xf5876000 00000705 00000001  0  002  stop  0xf5876350 vx_worklist_thr
0xf5874000 00000706 00000001  0  002  stop  0xf5874350 vx_worklist_thr
0xf5872000 00000707 00000001  0  002  stop  0xf5872350 vx_worklist_thr
0xf5870000 00000708 00000001  0  002  stop  0xf5870350 vx_worklist_thr
0xf586e000 00000709 00000001  0  002  stop  0xf586e350 vx_worklist_thr
0xf586c000 00000710 00000001  0  002  stop  0xf586c350 vx_worklist_thr
0xf586a000 00000711 00000001  0  002  stop  0xf586a350 vx_worklist_thr
0xf5868000 00000712 00000001  0  002  stop  0xf5868350 vx_worklist_thr
0xf5866000 00000713 00000001  0  002  stop  0xf5866350 vx_worklist_thr
0xf57b0000 00000731 00000624  0  000  stop  0xf57b0350 bash
0xf5798000 00000757 00000731  0  000  stop  0xf5798350 bash
0xcce62000 00001670 00000001  0  001  stop  0xcce62350 login
[2]more> 
0xd1868000 00001836 00000001  0  000  stop  0xd1868350 rsh
0xf55e4000 00001839 00000565  0  000  stop  0xf55e4350 in.rshd
0xec77c000 00001841 00001836  0  003  stop  0xec77c350 rsh
0xf56ba000 00001840 00001839  0  000  stop  0xf56ba350 bash
0xed914000 00001853 00001670  0  003  stop  0xed914350 bash
0xda8fc000 00001878 00000001  0  003  stop  0xda8fc350 bash
0xdb6b8000 00001879 00001878  0  003  stop  0xdb6b8350 sfs_mcr
0xf56cc000 00001907 00001879  0  001  stop  0xf56cc350 sfs_syncd
0xd17fc000 00001909 00001879  0  000  stop  0xd17fc350 sfs3
0xf56aa000 00001910 00001909  0  002  stop  0xf56aa350 sfs3
0xf6e74000 00001911 00001909  0  001  stop  0xf6e74350 sfs3
0xf6ff4000 00001912 00001909  0  001  stop  0xf6ff4350 sfs3
0xe4794000 00001913 00001909  0  003  stop  0xe4794350 sfs3
0xd2520000 00001914 00001909  0  001  stop  0xd2520350 sfs3
0xc7a68000 00001915 00001909  0  001  stop  0xc7a68350 sfs3
0xf6efc000 00001930 00000565  0  000  stop  0xf6efc350 in.telnetd
0xc80fc000 00001931 00001930  0  001  stop  0xc80fc350 login
0xc7c2c000 00001932 00001931  0  001  stop  0xc7c2c350 bash
0xf571c000 00001981 00000565  0  000  stop  0xf571c350 in.telnetd
0xf56bc000 00001982 00001981  0  002  stop  0xf56bc350 login
0xf5740000 00001983 00001982  0  003  stop  0xf5740350 bash
0xf5700000 00002037 00000664  0  000  stop  0xf5700350 strace
0xf5780000 00002031 00002037  1  001  run   0xf5780350 gdb
[2]more> 
0xd1860000 00002038 00000625  0  000  stop  0xd1860350 bash
0xc80fa000 00002043 00002038  0  003  stop  0xc80fa350 bash
0xf6f18000 00002044 00002043  1  000  run   0xf6f18350 id
[2]kdb> bt
    EBP       EIP         Function(args)
0xc767dfa4 0xc010a30f default_idle+0x2f
                               kernel .text 0xc0100000 0xc010a2e0 0xc010a318
0xc767dfb8 0xc010a382 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc010a340 0xc010a398
[2]kdb> cpu 1

Entering kdb (current=0xf5780000, pid 2031) on processor 1 due to cpu switch
[1]kdb> bt
    EBP       EIP         Function(args)
0xf5781c68 0xc010c3dc page_fault_mca (0xf5781e68, 0xf5781fc4, 0xf5781e68)
                               kernel .text 0xc0100000 0xc010c3dc 0xc010c3f8
           0xc01422e8 search_binary_handler+0x68 (0xf5781e68, 0xf5781fc4)
                               kernel .text 0xc0100000 0xc0142280 0xc0142430
0xf5781f9c 0xc0142578 do_execve+0x148 (0xea014000, 0x80fd4ac, 0x80da00c, 0xf5781fc4)
                               kernel .text 0xc0100000 0xc0142430 0xc01425cc
0xf5781fbc 0xc010aa6f sys_execve+0x2f (0x80fd50c, 0x80fd4ac, 0x80da00c, 0x80fd50c, 0x80fd50c)
                               kernel .text 0xc0100000 0xc010aa40 0xc010aa9c
           0xc010c18b system_call+0x33
                               kernel .text 0xc0100000 0xc010c158 0xc010c190
[1]kdb> bt  p 2044
    EBP       EIP         Function(args)
           0xc010c3eb page_fault_mca+0xf (0xf6f19e68, 0xf6f19fc4, 0xf6f19e68)
                               kernel .text 0xc0100000 0xc010c3dc 0xc010c3f8
           0xc01422e8 search_binary_handler+0x68 (0xf6f19e68, 0xf6f19fc4)
                               kernel .text 0xc0100000 0xc0142280 0xc0142430
0xf6f19f9c 0xc0142578 do_execve+0x148 (0xeb435000, 0x80d3c0c, 0x80d270c, 0xf6f19fc4)
                               kernel .text 0xc0100000 0xc0142430 0xc01425cc
0xf6f19fbc 0xc010aa6f sys_execve+0x2f (0x80d3a0c, 0x80d3c0c, 0x80d270c, 0x80d3a0c, 0x80d3a0c)
                               kernel .text 0xc0100000 0xc010aa40 0xc010aa9c
           0xc010c18b system_call+0x33
                               kernel .text 0xc0100000 0xc010c158 0xc010c190
[1]kdb> cpu 0

Entering kdb (current=0xf6f18000, pid 2044) on processor 0 due to cpu switch
[0]kdb> bt
    EBP       EIP         Function(args)
0xf6f19c1c 0xc010c3eb page_fault_mca+0xf (0xf6f19e68, 0xf6f19fc4, 0xf6f19e68)
                               kernel .text 0xc0100000 0xc010c3dc 0xc010c3f8
           0xc01422e8 search_binary_handler+0x68 (0xf6f19e68, 0xf6f19fc4)
                               kernel .text 0xc0100000 0xc0142280 0xc0142430
0xf6f19f9c 0xc0142578 do_execve+0x148 (0xeb435000, 0x80d3c0c, 0x80d270c, 0xf6f19fc4)
                               kernel .text 0xc0100000 0xc0142430 0xc01425cc
0xf6f19fbc 0xc010aa6f sys_execve+0x2f (0x80d3a0c, 0x80d3c0c, 0x80d270c, 0x80d3a0c, 0x80d3a0c)
                               kernel .text 0xc0100000 0xc010aa40 0xc010aa9c
           0xc010c18b system_call+0x33
                               kernel .text 0xc0100000 0xc010c158 0xc010c190
[0]kdb> cpu 3

Entering kdb (current=0xc767a000, pid 0) on processor 3 due to cpu switch
[3]kdb> bt
    EBP       EIP         Function(args)
0xc767bfa4 0xc010a30f default_idle+0x2f
                               kernel .text 0xc0100000 0xc010a2e0 0xc010a318
0xc767bfb8 0xc010a382 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc010a340 0xc010a398
[3]kdb> go

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
