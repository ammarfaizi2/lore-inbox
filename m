Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSGLTKC>; Fri, 12 Jul 2002 15:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSGLTKB>; Fri, 12 Jul 2002 15:10:01 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:8424 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S316397AbSGLTJ7>; Fri, 12 Jul 2002 15:09:59 -0400
Date: Fri, 12 Jul 2002 14:12:47 -0500 (CDT)
From: Matt Stegman <matts@ksu.edu>
X-X-Sender: <matts@unix2.cc.ksu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 64 bit netdev stats counter
Message-ID: <Pine.GSO.4.33L.0207101323220.19313-100000@unix2.cc.ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a linux fileserver that wraps around the 'RX bytes' and 'TX bytes'
counters once every couple of days.  Since these variables are "unsigned
long" in the kernel (32 bits on x86) it wraps at four gigabytes.  I
patched a kernel (2.4.19-pre10-ac2) to make these two variables, along
with RX and TX packet counters, "unsigned long long"  which is 64 bits on
x86.

This seems to work OK.  The "ifconfig" command (from RedHat net-tools-1.60
RPM) already defines these values as "unsigned long long", so I don't have
any problems with ifconfig reporting weird numbers.

I did notice that different classes of network devices seem to use
different structs, so I guess this would only work for ethernet devices.

This is the first hacking of any kind I've done on the kernel.  Any
comments would be appreciated.



The patch I used:
diff -urN linux-orig/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux-orig/include/linux/netdevice.h	Tue Jul  9 13:28:43 2002
+++ linux/include/linux/netdevice.h	Tue Jul  9 13:48:05 2002
@@ -96,10 +96,10 @@

 struct net_device_stats
 {
-	unsigned long	rx_packets;		/* total packets received	*/
-	unsigned long	tx_packets;		/* total packets transmitted	*/
-	unsigned long	rx_bytes;		/* total bytes received 	*/
-	unsigned long	tx_bytes;		/* total bytes transmitted	*/
+	unsigned long long rx_packets;		/* total packets received	*/
+	unsigned long long tx_packets;		/* total packets transmitted	*/
+	unsigned long long rx_bytes;		/* total bytes received 	*/
+	unsigned long long tx_bytes;		/* total bytes transmitted	*/
 	unsigned long	rx_errors;		/* bad packets received		*/
 	unsigned long	tx_errors;		/* packet transmit problems	*/
 	unsigned long	rx_dropped;		/* no space in linux buffers	*/
diff -urN linux-orig/net/core/dev.c linux/net/core/dev.c
--- linux-orig/net/core/dev.c	Tue Jul  9 13:28:44 2002
+++ linux/net/core/dev.c	Tue Jul  9 13:45:03 2002
@@ -1689,7 +1689,7 @@
 	int size;

 	if (stats)
-		size = sprintf(buffer, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu %8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
+		size = sprintf(buffer, "%6s:%8llu %7llu %4lu %4lu %4lu %5lu %10lu %9lu %8llu %7llu %4lu %4lu %4lu %5lu %7lu %10lu\n",
  		   dev->name,
 		   stats->rx_bytes,
 		   stats->rx_packets, stats->rx_errors,

$ cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    lo:   25660      71    0    0    0     0          0         0    25660      71    0    0    0     0       0          0
  eth0:7208362840 12115561    0    0    0     0          0         0 3171323568 5493455    0    0    0     0       0          0
$ ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          inet addr:a.b.c.d  Bcast:a.b.e.f  Mask:255.255.248.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12115561 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5493455 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:7208362840 (6874.4 Mb)  TX bytes:3171323568 (3024.4 Mb)
          Interrupt:5 Base address:0x2000


-- 
      -Matt Stegman


