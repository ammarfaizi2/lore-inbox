Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbWI2DUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWI2DUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWI2DUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:20:30 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:48579
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932518AbWI2DU3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:20:29 -0400
Message-Id: <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: Your message of "Thu, 28 Sep 2006 01:46:23 PDT."
             <20060928014623.ccc9b885.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060928014623.ccc9b885.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159499951_2840P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 23:19:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159499951_2840P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Sep 2006 01:46:23 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/

Yowza.  This has been one of the most unstable -mm I've personally tried since
2.6.0 came out (and I've tried to give each and every single one a shot).

Something is giving cache_alloc_refill() massive indigestion, I'm taking
lots of oopsen in it.  Usually within 5-10 minutes I'm dead in the water.

>From an untainted kernel:

Sep 28 21:51:59 turing-police kernel: [  526.046000] BUG: unable to handle kernel paging request at virtual address 00100104
Sep 28 21:51:59 turing-police kernel: [  526.046000]  printing eip:
Sep 28 21:51:59 turing-police kernel: [  526.046000] c0150c43
Sep 28 21:51:59 turing-police kernel: [  526.046000] *pde = 00000000

as far as it got logging it to disk - at that point the machine locked up
hard, even alt-sysrq was dead, had to power-cycle. Long time since that
happened.  Admittedly, that's not much to go on, but it shows that I'm having
issues in cache_alloc_refill() even when untainted.  I'll probably get more
complete untainted traces while playing  bisect-the-mm tomorrow....

Another few traces, more complete, almost same EIP (inside cache_alloc_refill
both times), but admittedly nvidia-tainted:

Sep 28 21:40:07 turing-police kernel: [  825.672000] BUG: unable to handle kernel paging request at virtual address 646c617a 
Sep 28 21:40:07 turing-police kernel: [  825.672000]  printing eip:
Sep 28 21:40:07 turing-police kernel: [  825.672000] c0150f9b
Sep 28 21:40:07 turing-police kernel: [  825.672000] *pde = 00000000
Sep 28 21:40:07 turing-police kernel: [  825.672000] Oops: 0002 [#1]
Sep 28 21:40:07 turing-police kernel: [  825.672000] PREEMPT 
Sep 28 21:40:07 turing-police kernel: [  825.672000] last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
Sep 28 21:40:07 turing-police kernel: [  825.672000] Modules linked in: aes cryptomgr xt_SECMARK xt_CONNSECMARK ip6table_
mangle iptable_mangle nf_conntrack_ftp xt_pkttype ipt_REJECT nf_conntrack_ipv4 ipt_LOG iptable_filter ip_tables xt_tcpudp
 nf_conntrack_ipv6 xt_state nf_conntrack ip6t_LOG xt_limit ip6table_filter ip6_tables x_tables thermal sony_acpi processo
r fan button battery ac nfnetlink i8k floppy nvram orinoco_cs orinoco hermes pcmcia firmware_class nvidia yenta_socket oh
ci1394 ieee1394 rsrc_nonstatic intel_agp pcmcia_core agpgart iTCO_wdt rtc
Sep 28 21:40:07 turing-police kernel: [  825.672000] CPU:    0
Sep 28 21:40:07 turing-police kernel: [  825.672000] EIP:    0060:[<c0150f9b>]    Tainted: P      VLI
Sep 28 21:40:07 turing-police kernel: [  825.672000] EFLAGS: 00210002   (2.6.18-mm2 #1)
Sep 28 21:40:07 turing-police kernel: [  825.672000] EIP is at cache_alloc_refill+0x12a/0x453
Sep 28 21:40:07 turing-police kernel: [  825.672000] eax: effdf4d0   ebx: effdfa40   ecx: 00000001   edx: 646c6176
Sep 28 21:40:07 turing-police kernel: [  825.672000] esi: dffedd00   edi: effdf4c0   ebp: def37f0c   esp: def37ec8
Sep 28 21:40:07 turing-police kernel: [  825.672000] ds: 007b   es: 007b   ss: 0068  
Sep 28 21:40:07 turing-police kernel: [  825.672000] Process badpost (pid: 3474, ti=def36000 task=dfe9aaa0 task.ti=def36000) 
Sep 28 21:40:07 turing-police kernel: [  825.672000] Stack: effe03e0 66666174 000000d0 effe18c0 00000003 effdfa40 00000000 ffffffff 
Sep 28 21:40:07 turing-police kernel: [  825.672000]        00000000 ffffffff 00000001 def37fbc 01200011 00000000 00200286 fffffff4 
Sep 28 21:40:07 turing-police kernel: [  825.672000]        dfe9aaa0 def37f18 c0150e68 def37fbc def37f5c c0111b6a def37fbc bfda5158 
Sep 28 21:40:07 turing-police kernel: [  825.672000] Call Trace:
Sep 28 21:40:07 turing-police kernel: [  825.672000]  [<c0150e68>] kmem_cache_alloc+0x25/0x2e
Sep 28 21:40:07 turing-police kernel: [  825.672000]  [<c0111b6a>] copy_process+0xa2/0x1183
Sep 28 21:40:07 turing-police kernel: [  825.672000]  [<c0112dbf>] do_fork+0x8d/0x172
Sep 28 21:40:07 turing-police kernel: [  825.672000]  [<c0101216>] sys_clone+0x25/0x2a
Sep 28 21:40:07 turing-police kernel: [  825.672000]  [<c0102d23>] syscall_call+0x7/0xb
Sep 28 21:40:07 turing-police kernel: [  825.672000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
Sep 28 21:40:07 turing-police kernel: [  825.672000] 
Sep 28 21:40:07 turing-police kernel: [  825.672000] Leftover inexact backtrace:
Sep 28 21:40:07 turing-police kernel: [  825.672000]  
Sep 28 21:40:07 turing-police kernel: [  825.672000]  =======================
Sep 28 21:40:07 turing-police kernel: [  825.672000] Code: 9e 1c 89 46 14 8b 5d d0 89 54 8b 10 41 89 0b 8b 46 10 89 45 c0
 8b 55 c8 3b 42 1c 73 09 ff 4d cc 83 7d cc ff 75 bd 8b 16 8b 46 04 <89> 42 04 89 10 c7 06 00 01 10 00 c7 46 04 00 02 20 0
0 83 7e 14 
Sep 28 21:40:07 turing-police kernel: [  825.672000] EIP: [<c0150f9b>] cache_alloc_refill+0x12a/0x453 SS:ESP 0068:def37ec8
Sep 28 21:40:07 turing-police kernel: [  825.672000]  <6>note: badpost[3474] exited with preempt_count 1

And then a second oops at the same exact EIP as the untainted one:

Sep 28 21:40:11 turing-police kernel: [  829.630000] BUG: unable to handle kernel paging request at virtual address 646c617a 
Sep 28 21:40:11 turing-police kernel: [  829.630000]  printing eip:
Sep 28 21:40:11 turing-police kernel: [  829.630000] c0150f9b
Sep 28 21:40:11 turing-police kernel: [  829.630000] *pde = 00000000
Sep 28 21:40:11 turing-police kernel: [  829.630000] Oops: 0002 [#2]
Sep 28 21:40:11 turing-police kernel: [  829.630000] PREEMPT 
Sep 28 21:40:11 turing-police kernel: [  829.630000] last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
Sep 28 21:40:11 turing-police kernel: [  829.630000] Modules linked in: aes cryptomgr xt_SECMARK xt_CONNSECMARK ip6table_
mangle iptable_mangle nf_conntrack_ftp xt_pkttype ipt_REJECT nf_conntrack_ipv4 ipt_LOG iptable_filter ip_tables xt_tcpudp
 nf_conntrack_ipv6 xt_state nf_conntrack ip6t_LOG xt_limit ip6table_filter ip6_tables x_tables thermal sony_acpi processo
r fan button battery ac nfnetlink i8k floppy nvram orinoco_cs orinoco hermes pcmcia firmware_class nvidia yenta_socket oh
ci1394 ieee1394 rsrc_nonstatic intel_agp pcmcia_core agpgart iTCO_wdt rtc
Sep 28 21:40:11 turing-police kernel: [  829.630000] CPU:    0
Sep 28 21:40:11 turing-police kernel: [  829.630000] EIP:    0060:[<c0150f9b>]    Tainted: P      VLI
Sep 28 21:40:11 turing-police kernel: [  829.630000] EFLAGS: 00210002   (2.6.18-mm2 #1)
Sep 28 21:40:11 turing-police kernel: [  829.630000] EIP is at cache_alloc_refill+0x12a/0x453
Sep 28 21:40:11 turing-police kernel: [  829.630000] eax: effdf4d0   ebx: effdfa40   ecx: 00000000   edx: 646c6176
Sep 28 21:40:11 turing-police kernel: [  829.630000] esi: dffedd00   edi: effdf4c0   ebp: e11d3f0c   esp: e11d3ec8
Sep 28 21:40:11 turing-police kernel: [  829.630000] ds: 007b   es: 007b   ss: 0068

I've seen mostly 3 different stack traces for this:

EIP is at cache_alloc_refill+0x12d/0x453
eax: 00000167   ebx: effdfa40   ecx: 00000001   edx: d9eede00
esi: daf19700   edi: effdf4c0   ebp: db237f0c   esp: db237ec8
ds: 007b   es: 007b   ss: 0068
Process procmail (pid: 3206, ti=db236000 task=db299550 task.ti=db236000)
Stack: effe03e0 00000001 000000d0 effe18c0 00000003 effdfa40 00000000 ffffffff
       00000000 ffffffff 00000001 db237fbc 01200011 00000000 00200286 fffffff4
       db299550 db237f18 c0150e68 db237fbc db237f5c c0111b6a db237fbc bfbc3678
Call Trace:
 [<c0150e68>] kmem_cache_alloc+0x25/0x2e
 [<c0111b6a>] copy_process+0xa2/0x1183
 [<c0112dbf>] do_fork+0x8d/0x172
 [<c0101216>] sys_clone+0x25/0x2a
 [<c0102d23>] syscall_call+0x7/0xb

and

EIP is at cache_alloc_refill+0x12d/0x453
eax: 00000167   ebx: effdfa40   ecx: 00000000   edx: d9eede00
esi: daf19700   edi: effdf4c0   ebp: dceedda8   esp: dceedd64
ds: 007b   es: 007b   ss: 0068
Process fetchmail (pid: 2752, ti=dceec000 task=dbfb9aa0 task.ti=dceec000)
Stack: effe03e0 00000001 000000d0 effe18c0 00000004 effdfa40 00000000 e2774500
       dceeddd4 c02fe47b 0000014f 0000014f 0000000f 00000473 00200286 00000f80
       db1c1680 dceeddb4 c015130c db1c1680 dceeddd8 c02d2fb9 00000001 000000d0
Call Trace:
 [<c015130c>] __kmalloc+0x48/0x55
 [<c02d2fb9>] __alloc_skb+0x4f/0xf7
 [<c02f4b2a>] tcp_sendmsg+0x14c/0x965
 [<c030bdf4>] inet_sendmsg+0x3b/0x48
 [<c02cdb8b>] sock_aio_write+0xf5/0x102
 [<c0153691>] do_sync_write+0xae/0xec
 [<c0153e6b>] vfs_write+0xbc/0x157
 [<c01543be>] sys_write+0x3b/0x60
 [<c0102d23>] syscall_call+0x7/0xb

and

EIP is at cache_alloc_refill+0x12d/0x453
eax: 00000167   ebx: effdfa40   ecx: 00000000   edx: d9eede00
esi: daf19700   edi: effdf4c0   ebp: ddb2fdc4   esp: ddb2fd80
ds: 007b   es: 007b   ss: 0068
Process Eterm (pid: 2700, ti=ddb2e000 task=e39ab000 task.ti=ddb2e000)
Stack: effe03e0 00000001 000000d0 effe18c0 00000004 effdfa40 00000000 00000017
       00170001 00200082 ddb2fdd0 00200082 00000000 00000000 00200286 00000f80
       ee80cd80 ddb2fdd0 c015130c ee80cd80 ddb2fdf4 c02d2fb9 00000000 000000d0
Call Trace:
 [<c015130c>] __kmalloc+0x48/0x55
 [<c02d2fb9>] __alloc_skb+0x4f/0xf7
 [<c02cfef1>] sock_alloc_send_skb+0x5a/0x17b
 [<c03258b9>] unix_stream_sendmsg+0x13b/0x2e6
 [<c02cdb8b>] sock_aio_write+0xf5/0x102
 [<c0153691>] do_sync_write+0xae/0xec
 [<c0153e6b>] vfs_write+0xbc/0x157
 [<c01543be>] sys_write+0x3b/0x60
 [<c0102d23>] syscall_call+0x7/0xb

--==_Exmh_1159499951_2840P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHJCvcC3lWbTT17ARAv9NAJ4pbRtNSurBH629QYZOcan9ghwQ+gCgrSk6
OWYZ7k3BVBZdMpYgY32O61k=
=rfNZ
-----END PGP SIGNATURE-----

--==_Exmh_1159499951_2840P--
