Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285043AbRLRUaD>; Tue, 18 Dec 2001 15:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285067AbRLRU3o>; Tue, 18 Dec 2001 15:29:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8082 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284958AbRLRU3X>;
	Tue, 18 Dec 2001 15:29:23 -0500
Date: Tue, 18 Dec 2001 12:28:13 -0800 (PST)
Message-Id: <20011218.122813.63057831.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C1FA558.E889A00D@welho.com>
In-Reply-To: <200112181837.VAA10394@ms2.inr.ac.ru>
	<3C1FA558.E889A00D@welho.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Liljeberg <Mika.Liljeberg@welho.com>
   Date: Tue, 18 Dec 2001 22:21:44 +0200
   
   Now that you mention it, tcp_parse_options() in input.c seems to expect
   that the timestamps are word aligned, which is not the case here, and a
   false assumption in any case. I would have expected a bus error for
   that, unless the pointer cast generates code that magically word aligns
   the resulting pointer...

Unaligned kernel loads and stores must be properly handled by the
platform code, and on ARM chips where that is possible it is.

Nevertheless, if you'd like to rule this out, please try the
patch below:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/net/ipv4/tcp_input.c linux/net/ipv4/tcp_input.c
--- vanilla/linux/net/ipv4/tcp_input.c	Tue Oct 30 15:08:12 2001
+++ linux/net/ipv4/tcp_input.c	Tue Nov  6 15:48:01 2001
@@ -1987,6 +1987,18 @@
 	return 0;
 }
 
+static __inline__ __u16 tcp_options_get16(unsigned char *p)
+{
+	return ((__u16) p[0] << 8) | (__u16) p[1];
+}
+
+static __inline__ __u32 tcp_options_get32(unsigned char *p)
+{
+	return (((__u32) p[0] << 24) |
+		((__u32) p[1] << 16) |
+		((__u32) p[2] <<  8) |
+		((__u32) p[3] <<  0));
+}
 
 /* Look for tcp options. Normally only called on SYN and SYNACK packets.
  * But, this can also be called on packets in the established flow when
@@ -2020,7 +2032,7 @@
 	  			switch(opcode) {
 				case TCPOPT_MSS:
 					if(opsize==TCPOLEN_MSS && th->syn && !estab) {
-						u16 in_mss = ntohs(*(__u16 *)ptr);
+						u16 in_mss = tcp_options_get16(ptr);
 						if (in_mss) {
 							if (tp->user_mss && tp->user_mss < in_mss)
 								in_mss = tp->user_mss;
@@ -2047,8 +2059,8 @@
 						if ((estab && tp->tstamp_ok) ||
 						    (!estab && sysctl_tcp_timestamps)) {
 							tp->saw_tstamp = 1;
-							tp->rcv_tsval = ntohl(*(__u32 *)ptr);
-							tp->rcv_tsecr = ntohl(*(__u32 *)(ptr+4));
+							tp->rcv_tsval = tcp_options_get32(ptr);
+							tp->rcv_tsecr = tcp_options_get32(ptr + 4);
 						}
 					}
 					break;
