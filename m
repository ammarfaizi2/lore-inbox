Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310719AbSBRPRb>; Mon, 18 Feb 2002 10:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310720AbSBRPRV>; Mon, 18 Feb 2002 10:17:21 -0500
Received: from dinadan.u-strasbg.fr ([130.79.74.10]:1694 "EHLO
	dinadan.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S310719AbSBRPRG>; Mon, 18 Feb 2002 10:17:06 -0500
To: linux-kernel@vger.kernel.org
Subject: [bug+patch] negative inode number in /proc/net/udp
From: Arnaud Giersch <giersch@icps.u-strasbg.fr>
Organization: ICPS
X-Face: &yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date: 18 Feb 2002 16:16:58 +0100
Message-ID: <87g03yq0ph.fsf@dinadan.u-strasbg.fr>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Hi,

I was playing this morning with the netstat command and had a segfault
when doing `netstat -ulp'. My kernel version is 2.4.17 on an i686.

I first searched for a bug in netstat and I discovered that it was a
negative inode number in /proc/net/udp that confused netstat:

$ cat /proc/net/udp
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                               
[...]
  80: 00000000:02D0 00000000:0000 07 00000000:00000000 00:00000000 00000000     0        0 -2127935727 2 ca5dd060              
[...]


(Before continuing, I want to tell you that it is the first time I
look so precisely in the kernel source so please tell me if I'm
wrong or I missed something.)


If I understand the kernel source, an inode number is an unsigned
value ("typedef unsigned long __kernel_ino_t;" in
linux/include/asm-i386/posix_types.h) so it shouldn't be negative.

I tried to find where /proc/net/udp is created and I found the
function get_udp_sock in linux/net/ipv4/udp.c responsible of
generating the lines.

There, the sprintf call uses %ld instead of %lu to print the inode
number. I propose the following patch:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=udp_proc.patch

diff -Naur linux.orig/net/ipv4/udp.c linux/net/ipv4/udp.c
--- linux.orig/net/ipv4/udp.c	Wed Oct 17 23:16:39 2001
+++ linux/net/ipv4/udp.c	Mon Feb 18 15:49:49 2002
@@ -957,7 +957,7 @@
 	destp = ntohs(sp->dport);
 	srcp  = ntohs(sp->sport);
 	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %ld %d %p",
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
 		i, src, srcp, dest, destp, sp->state, 
 		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
 		0, 0L, 0,

--=-=-=


I don't know how to generate this kind of information in /proc, so I
didn't test it.

I also looked the 2.4.18-rc1 and 2.5.5-pre1 kernels and the bug still
exist.

-- 
Arnaud

--=-=-=--
