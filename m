Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317657AbSGUIIK>; Sun, 21 Jul 2002 04:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317658AbSGUIIK>; Sun, 21 Jul 2002 04:08:10 -0400
Received: from [196.26.86.1] ([196.26.86.1]:64711 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317657AbSGUIIJ>; Sun, 21 Jul 2002 04:08:09 -0400
Date: Sun, 21 Jul 2002 10:29:01 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] user frobbable escd file can cause oops
Message-ID: <Pine.LNX.4.44.0207211027400.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch applies to 2.4-ac but tested on 2.5.26

I don't think this breaks any userland apps so If there aren't any 
objections, Alan, Linus please apply

zwane@mondecino /proc/bus/pnp {0} id
uid=500(zwane) gid=500(zwane) groups=500(zwane)

zwane@mondecino /proc/bus/pnp {0} cat escd
Segmentation fault
PnPBIOS: get_stat_res: Unexpected status 0x8d
Unable to handle kernel paging request at virtual address ffffa00a
 printing eip:
00007138
*pde = 00003063
Oops: 0000
CPU:    0
EIP:    0068:[<00007138>]    Not tainted
EFLAGS: 00010086
eax: 000022ff   ebx: 00806aea   ecx: 00000070   edx: 00000000
esi: 0000000a   edi: 00000000   ebp: ce3e72df   esp: ce3e1e38
ds: 0080   es: 0078   ss: 0018
Process cat (pid: 705, threadinfo=ce3e0000 task=cebc66a0)
Stack: 000a0002 0080ce3e 00060078 72e9711a 00000000 685a0070 6b031e6c 00180000
       00000018 69580000 00860078 00000246 0060000b 00000042 00800078 00000070
       00000000 c025a835 00000010 00000082 00040000 00700000 c0250018 00000018
Call Trace: [<c025a835>] [<c0250018>] [<c0130018>] [<c025a8e0>] [<c025b2b0>]
   [<c0175a4e>] [<c014b9cc>] [<c014bc1a>] [<c01075cb>]

Code:  Bad EIP value.

>>EIP; 00007138 Before first symbol   <=====
Trace; c025a835 <__pnp_bios_read_escd+115/1b0>
Trace; c0250018 <sg_proc_debug_info+408/7d0>
Trace; c0130018 <get_user_pages+1a8/220>
Trace; c025a8e0 <pnp_bios_read_escd+10/30>
Trace; c025b2b0 <proc_read_escd+80/f0>
Trace; c0175a4e <proc_file_read+ce/190>
Trace; c014b9cc <vfs_read+9c/160>
Trace; c014bc1a <sys_read+2a/40>
Trace; c01075cb <syscall_call+7/b>

Index: linux-2.5.26/drivers/pnp//pnpbios_proc.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.26/drivers/pnp/pnpbios_proc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pnpbios_proc.c
--- linux-2.5.26/drivers/pnp//pnpbios_proc.c	17 Jul 2002 16:08:09 -0000	1.1.1.1
+++ linux-2.5.26/drivers/pnp//pnpbios_proc.c	20 Jul 2002 23:00:12 -0000
@@ -210,7 +210,7 @@
 	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
 	create_proc_read_entry("configuration_info", 0, proc_pnp, proc_read_pnpconfig, NULL);
 	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo, NULL);
-	create_proc_read_entry("escd", 0, proc_pnp, proc_read_escd, NULL);
+	create_proc_read_entry("escd", S_IRUSR, proc_pnp, proc_read_escd, NULL);
 	create_proc_read_entry("legacy_device_resources", 0, proc_pnp, proc_read_legacyres, NULL);
 	
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);

-- 
function.linuxpower.ca

