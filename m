Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWFHKwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWFHKwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWFHKwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:52:18 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:3580 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S964785AbWFHKwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:52:14 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
Subject: [PATCH  2.6.17-rc6-mm1 ]  net: RFC 3828-compliant UDP-Lite support
Date: Thu, 8 Jun 2006 11:50:33 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606081150.34018@this-message-has-been-logged>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is an extension which adds RFC3828 - compliant UDP-Lite functionality 
to the IPv4 networking stack. 

The code has been adapted from our stable kernel patch, which we have been
maintaining and testing extensively over the last 9 months. The attached 
has been tested to run ok so far on i386, dual-processor, and AMD architectures.

Due to the similarities to UDP, a lot of code from net/ipv4/udp.c has been 
reused; whereas checksumming code has been rewritten entirely - in particular
with regard to ensuring correct behaviour in various and unusual cases, such
as fragmentation and split. Use CONFIG_IP_UDPLITE=y to enable, find docs attached.

Please CC: any feedback/discussion to  gerrit.renker@ukuug.org

Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>        
Signed-off-by: William Stanislaus <william@erg.abdn.ac.uk> 
---


 Documentation/networking/udp_lite.txt |  246 ++++
 include/asm-mips/socket.h             |    2
 include/linux/in.h                    |    1
 include/linux/net.h                   |   16
 include/linux/skbuff.h                |   15
 include/linux/snmp.h                  |   18
 include/linux/socket.h                |    1
 include/linux/udplite.h               |   89 +
 include/net/snmp.h                    |    7
 include/net/udplite.h                 |   65 +
 include/net/xfrm.h                    |    2
 net/Kconfig                           |    1
 net/Makefile                          |    1
 net/core/sock.c                       |    7
 net/ipv4/af_inet.c                    |   64 +
 net/ipv4/proc.c                       |   32
 net/udp_lite/Kbuild                   |    1
 net/udp_lite/Kconfig                  |   20
 net/udp_lite/udplitev4.c              | 1730 ++++++++++++++++++++++++++++++++++
 19 files changed, 2296 insertions(+), 22 deletions(-)



diff -Nurp  a/Documentation/networking/udp_lite.txt b/Documentation/networking/udp_lite.txt
--- a/Documentation/networking/udp_lite.txt	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/networking/udp_lite.txt	2006-06-07 22:07:26.000000000 +0100
@@ -0,0 +1,246 @@
+  ===========================================================================
+                      The UDP-Lite protocol (RFC 3828)
+  ===========================================================================
+
+  last modified: Wed 7 Jun 2006
+
+
+  UDP-Lite is a Standards-Track IETF transport protocol which features a
+  variable-length checksum. This has advantages for transport of multimedia
+  (video, VoIP) over wireless networks, as partly damaged packets can still be
+  fed into the codec instead of being discarded due to a failed checksum test.
+
+  This file briefly describes the existing kernel support and the socket API.
+  For in-depth information, you can consult:-
+
+   o The UDP-Lite Homepage: http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/
+       Fom here you can always also pull the latest patch for the stable
+       kernel tree and example application source code.
+
+   o The UDP-Lite HOWTO on
+     http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/UDP-Lite-HOWTO.txt
+
+   o The Ethereal UDP-Lite WiKi (with capture files):
+     http://wiki.ethereal.com/Lightweight_User_Datagram_Protocol
+
+   o The Protocol Spec:  RFC 3828,    http://www.ietf.org/rfc/rfc3828.txt
+
+
+
+  I) APPLICATIONS
+
+  Several applications have ported successfully to UDP-Lite. Ethereal
+  now comes with UDP-Lite support by default. The tarball on
+
+  http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/udplite_linux.tar.gz
+
+  has source code for several client-server and network testing examples.
+
+  Porting applications to UDP-Lite is straightforward: only socket level and
+  IPPROTO need to be changed, senders additionally set the checksum coverage
+  length (default = header length = 8). Details are in the next section.
+
+
+
+  II) PROGRAMMING API
+
+  UDP-Lite introduces a new socket type, the SOCK_LDGRAM (note the L) for
+  lightweight, connection-less services. These are the socket options:
+
+    * Sender checksum coverage: UDPLITE_SOCKOPT_SEND_CSCOV
+
+      For instance,
+
+      int val = 20;
+      setsockopt(s, SOL_UDPLITE, UDPLITE_SOCKOPT_SEND_CSCOV, &val, sizeof(int));
+
+      sets the checksum coverage length to 20 (12b data + 8b header).
+
+
+    * Receiver checksum coverage: UDPLITE_SOCKOPT_RECV_CSCOV
+
+      This option is analogously used at the receiver to set its
+      checksum coverage.
+      While the checksum coverage at the sender means the /actual/
+      length that will be used for the checksum, the receiver
+      checksum coverage stands for the /minimum/ coverage value a
+      receiver is willing to accept; and may drop packets which do
+      not meet this threshold.
+
+  A detailed description of the socket options is in section IV.
+
+
+
+  III) HEADER FILES
+
+  The socket API requires support in header files in /usr/include:
+    * /usr/include/netinet/udplite.h
+    * /usr/include/netinet/in.h
+    * /usr/include/bits/socket.h
+  Changes are minor and replicate the information contained in the patched
+  kernel include files; details and example files for various distros can
+  be found on the UDP-Lite homepage
+
+
+
+  IV) KERNEL BEHAVIOUR WITH REGARD TO THE VARIOUS SOCKET OPTIONS
+
+  To enable debugging messages, the log level must be set to 8, as most
+  messages use the KERN_DEBUG level (7).
+
+
+  1) Sender Socket Options
+
+  If the sender specifies a value of 0 as coverage length, the module
+  assumes full coverage, transmits a packet with coverage length of 0
+  and according checksum.  If the sender specifies a coverage < 8 and
+  different from 0, the kernel assumes 8 as default value.  Finally,
+  if the specified coverage length exceeds the packet length, the packet
+  length is used instead as coverage length.
+
+
+  2) Receiver Socket Options
+
+  The receiver specifies the minimum value of the coverage length it
+  is willing to accept.  A value of 0 here indicates that the receiver
+  always wants the whole of the packet covered. In this case, all
+  partially covered packets are dropped and an error is logged.
+
+  It is not possible to specify illegal values (<0 and <8); in these
+  cases the default of 8 is assumed.
+
+  All packets arriving with a coverage value less than the specified
+  threshold are discarded, these events are also logged.
+
+
+  3) Disabling the Checksum Computation
+
+  On both sender and receiver, trying to disable the UDP Lite checksum
+  (option SO_NO_CHECK) in setsockopt(2) results in an error. Thus
+
+        setsockopt(sockfd,SOL_SOCKET, SO_NO_CHECK, ... );
+
+  will always result in an error, while
+
+        getsockopt(sockfd, SOL_SOCKET, SO_NO_CHECK, &value,...);
+
+  will always return a value of 0 (meaning checksum enabled). Packets
+  with a zero checksum field are silently discarded by the receiver.
+
+
+  4) Fragmentation
+
+  The checksum computation respects both buffersize and MTU. The size
+  of UDP Lite packets is determined by the size of the send buffer. The
+  minimum size of the send buffer is 2048 (defined as SOCK_MIN_SNDBUF
+  in include/net/sock.h), the default value is configurable as
+  net.core.wmem_default or via setting the SO_SNDBUF socket(7)
+  option. The maximum upper bound for the send buffer is determined
+  by net.core.wmem_max.
+
+  Given a payload size larger than the send buffer size, UDP Lite will
+  split the payload into several individual packets, filling up the
+  send buffer size in each case.
+
+  The precise value also depends on the interface MTU. The interface MTU,
+  in turn, may trigger IP fragmentation. In this case, the generated
+  UDP Lite packet is split into several IP packets, of which only the
+  first one contains the header.
+
+  The send buffer size has implications on the checksum coverage length.
+  Consider the following example:
+
+  Payload: 1536 bytes            Send Buffer:     1024 bytes
+  MTU    :   1500 bytes          Coverage Length: 856  bytes
+
+  UDP Lite will ship the 1536 bytes in two separate packets:
+
+  Packet 1: 1024 payload + 8 byte header + 20 byte IP header = 1052 bytes
+  Packet 2:  520 payload + 8 byte header + 20 byte IP header =  528 bytes
+
+  The coverage packet covers the UDP Lite header and 848 bytes of the
+  payload in the first packet, the second packet is fully covered. Note
+  that for the second packet, the coverage length exceeds the packet
+  length. The kernel always re-adjusts the coverage length to the packet
+  length in such cases.
+
+  As an example of what happens when one UDP Lite packet is split into
+  several tiny fragments, consider the following example.
+
+  Payload: 1024 bytes            Send buffer size: 1024 bytes
+  MTU:      300 bytes            Coverage length:   575 bytes
+
+  +-+-----------+--------------+--------------+--------------+
+  |8|    272    |      280     |     280      |     280      |
+  +-+-----------+--------------+--------------+--------------+
+               280            560            840           1032
+                                    ^
+  *****checksum coverage*************
+
+  The UDP Lite module generates one 1032 byte packet (1024 + 8 byte
+  header). According to the interface MTU, these are split into 4 IP
+  packets (280 byte IP payload + 20 byte IP header). The kernel module
+  sums the contents of the entire first two packets, plus 15 bytes of
+  the last packet before releasing the fragments to the IP module.
+
+
+
+  V) UDP-LITE RUNTIME STATISTICS AND THEIR MEANING
+
+  Exceptional and error conditions are logged to syslog at the KERN_DEBUG
+  level.  Live statistics about UDP-Lite are available in /proc/net/snmp
+  and can--with newer versions of netstat--be queried using
+
+                                 netstat -svu
+
+  This displays UDP-Lite statistics variables, whose meaning is as follows.
+
+   InDatagrams:     Total number of received datagrams (as in UDP).
+
+   InPartialCov:    Number of received datagrams with csum coverage < length.
+
+   NoPorts:         Number of packets received to an unknown port (as in UDP).
+                    These cases are counted separately (not as InErrors).
+
+   InErrors:        Number of erroneous UDP-Lite packets. Errors include:
+                      * internal socket queue receive errors
+                      * packet too short (less than 8 bytes or stated
+                        coverage length exceeds received length)
+                      * no socket available for ICMP error condition
+                      * xfrm4_policy_check returned error
+                      * application has specified larger min. coverage
+                        length than that of incoming packet (cf. below)
+                      * checksum coverage violated          (InBadCoverage)
+                      * bad checksum                        (InBadChecksum)
+
+   InBadCoverage:   Datagrams with invalid checksum coverage (also InErrors):
+                      * coverage length is less than the minimum 8
+                      * coverage length exceeds actual datagram length
+
+   InBadChecksum:   Datagrams with wrong checksum (also InErrors).
+
+   OutDatagrams:    Total number of sent datagrams.
+
+   OutPartialCov:   Number of sent datagrams  with csum coverage < length.
+
+  If a receiving application has specified a  minimum coverage length and
+  received a packet with a smaller coverage value than this, or if it has
+  specified full coverage (UDP mode) and received a partially covered packet,
+  this counts as error (under InErrors), and an error message is logged.
+
+
+
+  VI) OPEN ISSUES
+
+  At the University of Aberdeen (where this patch was developed), much work
+  has gone into making sure that the UDP-Lite v4 variant behaves according
+  to spec. We have been maintaining and updating a patch for the stable
+  kernel tree since 2.6.12.4 and have run extensive experiments to verify
+  the protocol behaviour. As a result, there was no time left to develop an
+  IPv6 extension with the same degree of testing.
+  Secondly, the statistics variables detailed in the previous section are
+  not standardized. A MIB for UDP-Lite does not (yet) exist. For a person
+  familiar with SNMP/ASN.1 it would be a trivial task to turn the above
+  variable definitions into a MIB, in the same manner as per e.g. RFC 2013.
+  Anyone interested in helping with these two issues should contact us at
+  <gerrit@erg.abdn.ac.uk>.
diff -Nurp  a/include/asm-mips/socket.h b/include/asm-mips/socket.h
--- a/include/asm-mips/socket.h	2006-06-05 21:52:55.000000000 +0100
+++ b/include/asm-mips/socket.h	2006-06-07 21:28:09.000000000 +0100
@@ -80,6 +80,7 @@ To add: #define SO_REUSEPORT 0x0200	/* A
  *
  * @SOCK_DGRAM - datagram (conn.less) socket
  * @SOCK_STREAM - stream (connection) socket
+ * @SOCK_LDGRAM - UDP Lite (conn.less) datagram socket (see RFC 3828)
  * @SOCK_RAW - raw socket
  * @SOCK_RDM - reliably-delivered message
  * @SOCK_SEQPACKET - sequential packet socket
@@ -93,6 +94,7 @@ enum sock_type {
 	SOCK_RDM	= 4,
 	SOCK_SEQPACKET	= 5,
 	SOCK_DCCP	= 6,
+	SOCK_LDGRAM	= 7,
 	SOCK_PACKET	= 10,
 };
 
diff -Nurp  a/include/linux/in.h b/include/linux/in.h
--- a/include/linux/in.h	2006-06-07 20:44:01.000000000 +0100
+++ b/include/linux/in.h	2006-06-07 21:28:09.000000000 +0100
@@ -44,6 +44,7 @@ enum {
 
   IPPROTO_COMP   = 108,                /* Compression Header protocol */
   IPPROTO_SCTP   = 132,		/* Stream Control Transport Protocol	*/
+  IPPROTO_UDPLITE = 136,	/* UDP-Lite Protocol (RFC 3828)	        */
 
   IPPROTO_RAW	 = 255,		/* Raw IP packets			*/
   IPPROTO_MAX
diff -Nurp  a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h	2006-06-07 20:49:51.000000000 +0100
+++ b/include/linux/net.h	2006-06-07 21:28:09.000000000 +0100
@@ -67,6 +67,7 @@ typedef enum {
  * enum sock_type - Socket types
  * @SOCK_STREAM: stream (connection) socket
  * @SOCK_DGRAM: datagram (conn.less) socket
+ * @SOCK_LDGRAM: UDP Lite datagram  socket (see RFC 3828)
  * @SOCK_RAW: raw socket
  * @SOCK_RDM: reliably-delivered message
  * @SOCK_SEQPACKET: sequential packet socket
@@ -79,13 +80,14 @@ typedef enum {
  * overrides this enum for binary compat reasons.
  */
 enum sock_type {
-	SOCK_STREAM	= 1,
-	SOCK_DGRAM	= 2,
-	SOCK_RAW	= 3,
-	SOCK_RDM	= 4,
-	SOCK_SEQPACKET	= 5,
-	SOCK_DCCP	= 6,
-	SOCK_PACKET	= 10,
+	SOCK_STREAM	    =  1,
+	SOCK_DGRAM	    =  2,
+	SOCK_RAW	    =  3,
+	SOCK_RDM     	=  4,
+	SOCK_SEQPACKET	=  5,
+	SOCK_DCCP	    =  6,
+	SOCK_LDGRAM	    =  7,
+	SOCK_PACKET	    = 10,
 };
 
 #define SOCK_MAX (SOCK_PACKET + 1)
diff -Nurp  a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	2006-06-07 20:49:51.000000000 +0100
+++ b/include/linux/skbuff.h	2006-06-07 21:28:09.000000000 +0100
@@ -223,13 +223,14 @@ struct sk_buff {
 	struct net_device	*input_dev;
 
 	union {
-		struct tcphdr	*th;
-		struct udphdr	*uh;
-		struct icmphdr	*icmph;
-		struct igmphdr	*igmph;
-		struct iphdr	*ipiph;
-		struct ipv6hdr	*ipv6h;
-		unsigned char	*raw;
+		struct tcphdr	  *th;
+		struct udphdr	  *uh;
+		struct udplitehdr *ulh;                 /* UDP-Lite (RFC 3828) */
+		struct icmphdr	  *icmph;
+		struct igmphdr	  *igmph;
+		struct iphdr	  *ipiph;
+		struct ipv6hdr	  *ipv6h;
+		unsigned char	  *raw;
 	} h;
 
 	union {
diff -Nurp  a/include/linux/snmp.h b/include/linux/snmp.h
--- a/include/linux/snmp.h	2006-06-05 21:52:55.000000000 +0100
+++ b/include/linux/snmp.h	2006-06-07 21:28:09.000000000 +0100
@@ -158,6 +158,24 @@ enum
 	__UDP_MIB_MAX
 };
 
+/*
+ *   UDP Lite (RFC 3828) runtime statistics.
+ *   A MIB does not exist yet, but these statistics are useful nevertheless.
+ */
+enum
+{
+	UDPLITE_MIB_NUM = 0,
+	UDPLITE_MIB_INDATAGRAMS,	        /* total received datagramns             */
+	UDPLITE_MIB_INDATAGRAMS_PARTIAL_CHECK,	/* rcvd datagrams with partial coverage  */
+	UDPLITE_MIB_NOPORTS,			/* rcvd datagrams with port errors       */
+	UDPLITE_MIB_INERRORS,			/* total erroneous rcvd datagrams        */
+	UDPLITE_MIB_INERRORS_CHECKSUM_COVERAGE,	/* checksum coverage errors              */
+	UDPLITE_MIB_INERRORS_CHECKSUMMING,      /* checksum itself did not qualify       */
+	UDPLITE_MIB_OUTDATAGRAMS,		/* total sent datagrams                  */
+	UDPLITE_MIB_OUTDATAGRAMS_PARTIAL_CHECK,	/* sent datagrams with partial coverage  */
+	__UDPLITE_MIB_MAX
+};
+
 /* sctp mib definitions */
 /*
  * draft-ietf-sigtran-sctp-mib-07.txt
diff -Nurp  a/include/linux/socket.h b/include/linux/socket.h
--- a/include/linux/socket.h	2006-06-07 20:49:51.000000000 +0100
+++ b/include/linux/socket.h	2006-06-07 21:28:09.000000000 +0100
@@ -264,6 +264,7 @@ struct ucred {
 #define SOL_IPV6	41
 #define SOL_ICMPV6	58
 #define SOL_SCTP	132
+#define SOL_UDPLITE	136     /* UDP-Lite (RFC 3828) */
 #define SOL_RAW		255
 #define SOL_IPX		256
 #define SOL_AX25	257
diff -Nurp  a/include/linux/udplite.h b/include/linux/udplite.h
--- a/include/linux/udplite.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/udplite.h	2006-06-07 21:27:36.000000000 +0100
@@ -0,0 +1,89 @@
+/*
+ *                    Header file for UDP Lite (RFC 3828),
+ *                    see net/udp_lite for further details.
+ */
+#ifndef _LINUX_UDPLITE_H
+#define _LINUX_UDPLITE_H
+#include <linux/types.h>
+
+/**
+ *   struct udplitehdr  -  UDP-Lite header re-interpreting UDP (RFC 768) fields
+ *
+ *   @source:   source port number      (as in UDP)
+ *   @dest:     destination port number (as in UDP)
+ *   @checklen: checksum coverage length
+ *   @check:    checksum field (as in UDP)
+ *
+ *   For the detailed header semantics see RFC 3828.
+ */
+struct udplitehdr {
+	__u16 source;
+	__u16 dest;
+	__u16 checklen;
+	__u16 check;
+};
+
+
+/* UDP Lite socket options:
+ *   Sender specifies actual coverage length.
+ *   Receiver specifies _minimal_ coverage length.  */
+#define UDPLITE_SOCKOPT_SEND_CSCOV   10	   /* sender    */
+#define UDPLITE_SOCKOPT_RECV_CSCOV   11	   /* receiver  */
+
+#define UDPLITE_CORK                  1	   /* Never send part. complete segm. */
+
+
+
+/* checksum coverage set flags */
+#define UDPLITE_SEND_CHCKFLAG        0x1
+#define UDPLITE_RECV_CHCKFLAG        0x2
+
+
+/* FIXME: UDP-Lite encapsulation types ??? */
+#define UDPLITE_ENCAP                       100	  /* accept encapsulated pkts */
+#define UDPLITE_ENCAP_ESPINUDPLITE_NON_IKE    1
+#define UDPLITE_ENCAP_ESPINUDPLITE            2
+
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <net/sock.h>
+#include <linux/ip.h>
+/**
+ *   struct udplite_sock - unreliable UDP-Lite datagram service
+ *
+ *   @inet:       has to be the first member
+ *   @pending:    any pending frames?
+ *   @corkflag:   when cork is required
+ *   @encap_type: is this an encapsulation socket?
+ *   @len: total  length of pending frames
+ *   @pcslen:     partial checksum coverage length for sending socket
+ *   @pcrlen:     partial checksum coverage length for receiving socket
+ *   @pcflag:     partial checksum coverage flag
+ *
+ *   NOTE: Checksum coverage length has different semantics for sending and
+ *   receiving sockets.
+ *
+ */
+struct udplite_sock {
+	struct inet_sock  inet;
+	int               pending;
+	unsigned int      corkflag;
+	__u16             encap_type;
+	/*  The following members retain the information to create a
+	 *  UDP-Lite header when the socket is uncorked.  */
+	__u16             len;
+	__u16             pcslen;
+	__u16             pcrlen;
+	__u8              pcflag;
+};
+
+static inline struct udplite_sock *udplite_sk(const struct sock *sk)
+{
+	return (struct udplite_sock *)sk;
+}
+
+#endif				/*  __KERNEL__      */
+
+#endif				/* _LINUX_UDPLITE_H */
diff -Nurp  a/include/net/snmp.h b/include/net/snmp.h
--- a/include/net/snmp.h	2006-06-05 21:52:55.000000000 +0100
+++ b/include/net/snmp.h	2006-06-07 21:28:09.000000000 +0100
@@ -100,6 +100,13 @@ struct udp_mib {
 	unsigned long	mibs[UDP_MIB_MAX];
 } __SNMP_MIB_ALIGN__;
 
+
+/* UDP Lite (RFC 3828) */
+#define UDPLITE_MIB_MAX	__UDPLITE_MIB_MAX
+struct udplite_mib {
+	unsigned long	mibs[UDPLITE_MIB_MAX];
+} __SNMP_MIB_ALIGN__;
+
 /* SCTP */
 #define SCTP_MIB_MAX	__SCTP_MIB_MAX
 struct sctp_mib {
diff -Nurp  a/include/net/udplite.h b/include/net/udplite.h
--- a/include/net/udplite.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/net/udplite.h	2006-06-07 21:16:56.000000000 +0100
@@ -0,0 +1,65 @@
+/*
+ *            Header file for UDP Lite (RFC 3828)
+ */
+#ifndef _UDPLITE_H
+#define _UDPLITE_H
+
+#include <linux/udplite.h>
+#include <linux/seq_file.h>
+#include <linux/list.h>
+#include <linux/ip.h>
+#include <net/sock.h>
+#include <net/snmp.h>
+
+/* In_UDP Lite the checksum MUST always be computed, hence in contrast to UDP,
+ * there is no  UDPLITE_CSUM_DEFAULT and no UDPLITE_CSUM_NOXMIT  */
+#define UDPLITE_HTABLE_SIZE             128
+
+
+/* net/udp_lite/udplitev4.c */
+extern struct proto udplite_prot;
+
+extern void udplite_err(struct sk_buff *, u32);
+extern int  udplite_sendmsg(struct kiocb *iocb, struct sock *sk,
+	 		    struct msghdr *msg, size_t len);
+extern int  udplite_rcv(struct sk_buff *skb);
+extern int  udplite_ioctl(struct sock *sk, int cmd, unsigned long arg);
+extern int  udplite_disconnect(struct sock *sk, int flags);
+extern unsigned int udplite_poll(struct file *file, struct socket *sock,
+				 poll_table * wait);
+
+/*
+ *   SNMP MIB for the UDP-Lite layer
+ */
+DECLARE_SNMP_STAT(struct udplite_mib, udplite_statistics);
+#define UDPLITE_INC_STATS(f)        SNMP_INC_STATS(udplite_statistics, f)
+#define UDPLITE_INC_STATS_BH(f)     SNMP_INC_STATS_BH(udplite_statistics, f)
+#define UDPLITE_INC_STATS_USER(f)   SNMP_INC_STATS_USER(udplite_statistics, f)
+
+
+#ifdef CONFIG_PROC_FS
+/*
+ *      /proc
+ */
+struct udplite_seq_afinfo {
+	struct module          *owner;
+	char                   *name;
+	sa_family_t             family;
+	int                   (*seq_show) (struct seq_file *m, void *v);
+	struct file_operations *seq_fops;
+};
+
+struct udplite_iter_state {
+	sa_family_t           family;
+	int                   bucket;
+	struct seq_operations seq_ops;
+};
+
+extern int  udplite_proc_register(struct udplite_seq_afinfo *afinfo);
+extern void udplite_proc_unregister(struct udplite_seq_afinfo *afinfo);
+
+extern int  udplite4_proc_init(void);
+extern void udplite4_proc_exit(void);
+#endif                          /* CONFIG_PROC_FS */
+
+#endif				/* _UDPLITE_H */
diff -Nurp  a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	2006-06-07 20:49:52.000000000 +0100
+++ b/include/net/xfrm.h	2006-06-07 21:28:09.000000000 +0100
@@ -501,6 +501,7 @@ u16 xfrm_flowi_sport(struct flowi *fl)
 	switch(fl->proto) {
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
 	case IPPROTO_SCTP:
 		port = fl->fl_ip_sport;
 		break;
@@ -521,6 +522,7 @@ u16 xfrm_flowi_dport(struct flowi *fl)
 	switch(fl->proto) {
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
 	case IPPROTO_SCTP:
 		port = fl->fl_ip_dport;
 		break;
diff -Nurp  a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2006-06-07 20:49:53.000000000 +0100
+++ b/net/Kconfig	2006-06-07 21:28:09.000000000 +0100
@@ -164,6 +164,7 @@ endif
 
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
+source "net/udp_lite/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
 source "net/bridge/Kconfig"
diff -Nurp  a/net/Makefile b/net/Makefile
--- a/net/Makefile	2006-06-05 21:52:55.000000000 +0100
+++ b/net/Makefile	2006-06-07 21:28:09.000000000 +0100
@@ -44,6 +44,7 @@ obj-$(CONFIG_ECONET)		+= econet/
 obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_IP_UDPLITE)	+= udp_lite/
 obj-$(CONFIG_IEEE80211)		+= ieee80211/
 obj-$(CONFIG_TIPC)		+= tipc/
 
diff -Nurp  a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	2006-06-07 20:49:52.000000000 +0100
+++ b/net/core/sock.c	2006-06-07 21:28:09.000000000 +0100
@@ -426,7 +426,12 @@ set_rcvbuf:
 			break;
 
 	 	case SO_NO_CHECK:
-			sk->sk_no_check = valbool;
+			/* UDP-Lite (RFC 3828) mandates checksumming,
+			 * hence user must not enable this option.   */
+			if (sk->sk_protocol == IPPROTO_UDPLITE)
+				ret = -EOPNOTSUPP;
+			else
+				sk->sk_no_check = valbool;
 			break;
 
 		case SO_PRIORITY:
diff -Nurp  a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	2006-06-07 20:44:09.000000000 +0100
+++ b/net/ipv4/af_inet.c	2006-06-07 21:28:09.000000000 +0100
@@ -15,6 +15,8 @@
  * Changes (see also sock.c)
  *
  *		piggy,
+ *		W. Stanislaus	:	Added the UDP-Lite protocol (RFC 3828),
+ *					(maintainer: <gerrit@erg.abdn.ac.uk>)
  *		Karl Knutson	:	Socket protocol table
  *		A.N.Kuznetsov	:	Socket death error in accept().
  *		John Richardson :	Fix non blocking error in connect()
@@ -104,6 +106,7 @@
 #include <net/inet_connection_sock.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#include <net/udplite.h>                        /* UDP Lite (RFC 3828) */
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/raw.h>
@@ -838,6 +841,30 @@ const struct proto_ops inet_dgram_ops = 
 };
 
 /*
+ * For SOCK_LDGRAM sockets, these support the UDP Lite protocol (RFC 3828).
+ */
+struct proto_ops inet_ldgram_ops = {
+	.family     =	PF_INET,
+	.owner      =	THIS_MODULE,
+	.release    =	inet_release,
+	.bind       =	inet_bind,
+	.connect    =	inet_dgram_connect,
+	.socketpair =	sock_no_socketpair,
+	.accept     =	sock_no_accept,
+	.getname    =	inet_getname,
+	.poll       =	udplite_poll,
+	.ioctl      =	inet_ioctl,
+	.listen     =	sock_no_listen,
+	.shutdown   =	inet_shutdown,
+	.setsockopt =	sock_common_setsockopt,
+	.getsockopt =	sock_common_getsockopt,
+	.sendmsg    =	inet_sendmsg,
+	.recvmsg    =	sock_common_recvmsg,
+	.mmap       =	sock_no_mmap,
+	.sendpage   =	inet_sendpage,
+};
+
+/*
  * For SOCK_RAW sockets; should be the same as inet_dgram_ops but without
  * udp_poll
  */
@@ -898,6 +925,15 @@ static struct inet_protosw inetsw_array[
                 .flags =      INET_PROTOSW_PERMANENT,
        },
         
+       {
+                .type       =  SOCK_LDGRAM,           /* UDP-Lite (RFC 3828) */
+                .protocol   =  IPPROTO_UDPLITE,
+                .prot       =  &udplite_prot,
+                .ops        =  &inet_ldgram_ops,
+                .capability = -1,
+                .no_check   =  0,                     /* checksum mandatory */
+                .flags      =  INET_PROTOSW_PERMANENT,
+       },
 
        {
                .type =       SOCK_RAW,
@@ -1114,6 +1150,12 @@ static struct net_protocol udp_protocol 
 	.no_policy =	1,
 };
 
+static struct net_protocol udplite_protocol = {     /* UDP-Lite (RFC 3828) */
+	.handler     =	udplite_rcv,
+	.err_handler =	udplite_err,
+	.no_policy   =	1,
+};
+
 static struct net_protocol icmp_protocol = {
 	.handler =	icmp_rcv,
 };
@@ -1130,11 +1172,13 @@ static int __init init_ipv4_mibs(void)
 	tcp_statistics[1] = alloc_percpu(struct tcp_mib);
 	udp_statistics[0] = alloc_percpu(struct udp_mib);
 	udp_statistics[1] = alloc_percpu(struct udp_mib);
-	if (!
-	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
-	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
-	     && udp_statistics[0] && udp_statistics[1]))
-		return -ENOMEM;
+	udplite_statistics[0] = alloc_percpu(struct udplite_mib);
+	udplite_statistics[1] = alloc_percpu(struct udplite_mib);
+	if (!(net_statistics[0] && net_statistics[1] && ip_statistics[0]
+		&& ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
+		&& udp_statistics[0] && udp_statistics[1]
+		&& udplite_statistics[0] && udplite_statistics[1]) )
+			return -ENOMEM;
 
 	(void) tcp_mib_init();
 
@@ -1172,6 +1216,10 @@ static int __init inet_init(void)
 	if (rc)
 		goto out_unregister_tcp_proto;
 
+	rc = proto_register(&udplite_prot, 1);    /* UDP Lite (RFC 3828) */
+	if (rc)
+		goto out_unregister_udp_proto;    /* XXX: not entirely sure --gr */
+
 	rc = proto_register(&raw_prot, 1);
 	if (rc)
 		goto out_unregister_udp_proto;
@@ -1190,6 +1238,8 @@ static int __init inet_init(void)
 		printk(KERN_CRIT "inet_init: Cannot add ICMP protocol\n");
 	if (inet_add_protocol(&udp_protocol, IPPROTO_UDP) < 0)
 		printk(KERN_CRIT "inet_init: Cannot add UDP protocol\n");
+	if (inet_add_protocol(&udplite_protocol, IPPROTO_UDPLITE) < 0)
+		printk(KERN_CRIT "inet_init: Cannot add UDP-Lite protocol\n");
 	if (inet_add_protocol(&tcp_protocol, IPPROTO_TCP) < 0)
 		printk(KERN_CRIT "inet_init: Cannot add TCP protocol\n");
 #ifdef CONFIG_IP_MULTICAST
@@ -1272,6 +1322,8 @@ static int __init ipv4_proc_init(void)
 		goto out_tcp;
 	if (udp4_proc_init())
 		goto out_udp;
+	if (udplite4_proc_init())
+		goto out_udplite;
 	if (fib_proc_init())
 		goto out_fib;
 	if (ip_misc_proc_init())
@@ -1281,6 +1333,8 @@ out:
 out_misc:
 	fib_proc_exit();
 out_fib:
+	udplite4_proc_exit();
+out_udplite:
 	udp4_proc_exit();
 out_udp:
 	tcp4_proc_exit();
diff -Nurp  a/net/ipv4/proc.c b/net/ipv4/proc.c
--- a/net/ipv4/proc.c	2006-06-07 20:44:12.000000000 +0100
+++ b/net/ipv4/proc.c	2006-06-07 21:28:09.000000000 +0100
@@ -14,6 +14,10 @@
  *		Fred Baumgarten, <dc6iq@insu1.etec.uni-karlsruhe.de>
  *		Erik Schoenfelder, <schoenfr@ibr.cs.tu-bs.de>
  *
+ * Changes:
+ *		William Stanislaus: added support for UDP-Lite protocol (RFC 3828),
+ *		code maintained by Gerrit Renker <gerrit@erg.abdn.ac.uk>
+ *
  * Fixes:
  *		Alan Cox	:	UDP sockets show the rxqueue/txqueue
  *					using hint flag for the netinfo.
@@ -38,6 +42,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#include <net/udplite.h>              /* UDP Lite (RFC 3828) */
 #include <linux/inetdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -66,9 +71,10 @@ static int sockstat_seq_show(struct seq_
 		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
 		   atomic_read(&tcp_memory_allocated));
 	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
+	seq_printf(seq, "UDPLITE: inuse %d\n", fold_prot_inuse(&udplite_prot));
 	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
-	seq_printf(seq,  "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
-		   atomic_read(&ip_frag_mem));
+	seq_printf(seq, "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
+		             atomic_read(&ip_frag_mem));
 	return 0;
 }
 
@@ -176,6 +182,18 @@ static const struct snmp_mib snmp4_udp_l
 	SNMP_MIB_SENTINEL
 };
 
+static struct snmp_mib snmp4_udplite_list[] = {  /* UDP Lite (gerrit@erg.abdn.ac.uk) */
+	SNMP_MIB_ITEM("InDatagrams",   UDPLITE_MIB_INDATAGRAMS),
+	SNMP_MIB_ITEM("InPartialCov",  UDPLITE_MIB_INDATAGRAMS_PARTIAL_CHECK),
+	SNMP_MIB_ITEM("NoPorts",       UDPLITE_MIB_NOPORTS),
+	SNMP_MIB_ITEM("InErrors",      UDPLITE_MIB_INERRORS),
+	SNMP_MIB_ITEM("InBadChecksum", UDPLITE_MIB_INERRORS_CHECKSUMMING),
+	SNMP_MIB_ITEM("InBadCoverage", UDPLITE_MIB_INERRORS_CHECKSUM_COVERAGE),
+	SNMP_MIB_ITEM("OutDatagrams",  UDPLITE_MIB_OUTDATAGRAMS),
+	SNMP_MIB_ITEM("OutPartialCov", UDPLITE_MIB_OUTDATAGRAMS_PARTIAL_CHECK),
+	SNMP_MIB_SENTINEL
+};
+
 static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("SyncookiesSent", LINUX_MIB_SYNCOOKIESSENT),
 	SNMP_MIB_ITEM("SyncookiesRecv", LINUX_MIB_SYNCOOKIESRECV),
@@ -302,6 +320,16 @@ static int snmp_seq_show(struct seq_file
 			   fold_field((void **) udp_statistics, 
 				      snmp4_udp_list[i].entry));
 
+    seq_puts(seq, "\nUdpLite:");                           /* UDP Lite (RFC 3828) */
+	for (i = 0; snmp4_udplite_list[i].name != NULL; i++)
+		seq_printf(seq, " %s", snmp4_udplite_list[i].name);
+
+	seq_puts(seq, "\nUdpLite:");
+	for (i = 0; snmp4_udplite_list[i].name != NULL; i++)
+		seq_printf(seq, " %lu",
+			   fold_field((void **) udplite_statistics,
+				      snmp4_udplite_list[i].entry));
+
 	seq_putc(seq, '\n');
 	return 0;
 }
diff -Nurp  a/net/udp_lite/Kbuild b/net/udp_lite/Kbuild
--- a/net/udp_lite/Kbuild	1970-01-01 01:00:00.000000000 +0100
+++ b/net/udp_lite/Kbuild	2006-06-07 21:16:56.000000000 +0100
@@ -0,0 +1 @@
+obj-$(CONFIG_IP_UDPLITE) += udplitev4.o
diff -Nurp  a/net/udp_lite/Kconfig b/net/udp_lite/Kconfig
--- a/net/udp_lite/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ b/net/udp_lite/Kconfig	2006-06-07 21:38:56.000000000 +0100
@@ -0,0 +1,20 @@
+config IP_UDPLITE
+	bool "The UDP-Lite Protocol (EXPERIMENTAL)"
+	depends on INET && EXPERIMENTAL
+        default n
+	---help---
+	  The UDP Lite Protocol (RFC 3828, <http://tools.ietf.org/html/rfc3828>)
+
+	  UDP-Lite is a Standards-Track IETF transport protocol. It features a
+	  variable-length checksum, which allows partially damaged packets to be
+	  forwarded to media codecs, rather than being discarded due to invalid
+	  (UDP) checksum values. This can have advantages for the transport of
+	  multimedia (e.g. video/audio) over wireless networks.
+
+	  The socket API resembles that of UDP. Applications must indicate their
+	  wish to utilise the partial checksum coverage feature offered by UDP-
+	  Lite by setting a socket option.
+
+	  More information can be found in Documentation/networking/udp_lite.txt
+
+	  If in doubt, say N.
diff -Nurp  a/net/udp_lite/udplitev4.c b/net/udp_lite/udplitev4.c
--- a/net/udp_lite/udplitev4.c	1970-01-01 01:00:00.000000000 +0100
+++ b/net/udp_lite/udplitev4.c	2006-06-07 21:32:28.000000000 +0100
@@ -0,0 +1,1730 @@
+/*
+ *  UDPLITE     An implementation of the UDP-Lite protocol as standardised in
+ *              RFC 3828. UDP-Lite is based on UDP: this code is a revision of
+ *              the original udp.c code with regard to all those aspects in
+ *              which UDP-Lite differs from UDP.
+ *
+ *  Version:    $Id: udplitev4.c,v 1.3 2006/05/25 13:57:06 root Exp root $
+ *
+ *  Authors:    Gerrit Renker       <gerrit@erg.abdn.ac.uk>
+ *              William Stanislaus  <william@erg.abdn.ac.uk>
+ *
+ *              based on original code from udp.c, by Ross Biro, Fred N. van
+ *              Kempen, Arnt Gulbrandsen, Alan Cox, and Hirokazu Takahashi
+ *
+ * Changes:
+ *
+ */
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <asm/ioctls.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/module.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
+#include <linux/igmp.h>
+#include <linux/in.h>
+#include <linux/errno.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/config.h>
+#include <linux/inet.h>
+#include <linux/ipv6.h>
+#include <linux/netdevice.h>
+#include <net/snmp.h>
+#include <net/ip.h>
+#include <net/tcp_states.h>
+#include <net/protocol.h>
+#include <linux/skbuff.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <net/sock.h>
+#include <net/udplite.h>
+#include <net/icmp.h>
+#include <net/route.h>
+#include <net/inet_common.h>
+#include <net/checksum.h>
+#include <net/xfrm.h>
+
+/*
+ * SNMP MIB for the UDP-Lite layer
+ */
+DEFINE_SNMP_STAT(struct udplite_mib, udplite_statistics);
+
+/*
+ * Global variables
+ */
+int    udplite_port_rover;
+struct hlist_head udplite_hash[UDPLITE_HTABLE_SIZE];
+DEFINE_RWLOCK(udplite_hash_lock);
+
+
+
+static inline int udplite_lport_inuse(u16 num)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+
+	sk_for_each(sk, node, &udplite_hash[num & (UDPLITE_HTABLE_SIZE - 1)])
+	    if (inet_sk(sk)->num == num)
+		return 1;
+	return 0;
+}
+
+/* The following function is identical to the one used in udp.c: */
+
+static int udplite_v4_get_port(struct sock *sk, unsigned short snum)
+{
+	struct hlist_node *node;
+	struct sock *sk2;
+	struct inet_sock *inet = inet_sk(sk);
+
+	write_lock_bh(&udplite_hash_lock);
+	if (snum == 0) {
+		int best_size_so_far, best, result, i;
+
+		if (udplite_port_rover > sysctl_local_port_range[1] ||
+		    udplite_port_rover < sysctl_local_port_range[0])
+			udplite_port_rover = sysctl_local_port_range[0];
+		best_size_so_far = 32767;
+		best = result = udplite_port_rover;
+		for (i = 0; i < UDPLITE_HTABLE_SIZE; i++, result++) {
+			struct hlist_head *list;
+			int size;
+
+			list =
+			    &udplite_hash[result & (UDPLITE_HTABLE_SIZE - 1)];
+			if (hlist_empty(list)) {
+				if (result > sysctl_local_port_range[1])
+					result = sysctl_local_port_range[0] +
+					    ((result -
+					      sysctl_local_port_range[0]) &
+					     (UDPLITE_HTABLE_SIZE - 1));
+				goto gotit;
+			}
+			size = 0;
+			sk_for_each(sk2, node, list)
+			    if (++size >= best_size_so_far)
+				goto next;
+			best_size_so_far = size;
+			best = result;
+		      next:;
+		}
+		result = best;
+		for (i = 0; i < (1 << 16) / UDPLITE_HTABLE_SIZE;
+		     i++, result += UDPLITE_HTABLE_SIZE) {
+			if (result > sysctl_local_port_range[1])
+				result = sysctl_local_port_range[0]
+				    + ((result - sysctl_local_port_range[0]) &
+				       (UDPLITE_HTABLE_SIZE - 1));
+			if (!udplite_lport_inuse(result))
+				break;
+		}
+		if (i >= (1 << 16) / UDPLITE_HTABLE_SIZE)
+			goto fail;
+	      gotit:
+		udplite_port_rover = snum = result;
+	} else {
+		sk_for_each(sk2, node,
+			    &udplite_hash[snum & (UDPLITE_HTABLE_SIZE - 1)]) {
+			struct inet_sock *inet2 = inet_sk(sk2);
+
+			if (inet2->num == snum &&
+			    sk2 != sk &&
+			    !ipv6_only_sock(sk2) &&
+			    (!sk2->sk_bound_dev_if ||
+			     !sk->sk_bound_dev_if ||
+			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
+			    (!inet2->rcv_saddr ||
+			     !inet->rcv_saddr ||
+			     inet2->rcv_saddr == inet->rcv_saddr) &&
+			    (!sk2->sk_reuse || !sk->sk_reuse))
+				goto fail;
+		}
+	}
+	inet->num = snum;
+	if (sk_unhashed(sk)) {
+		struct hlist_head *h =
+		    &udplite_hash[snum & (UDPLITE_HTABLE_SIZE - 1)];
+
+		sk_add_node(sk, h);
+		sock_prot_inc_use(sk->sk_prot);
+	}
+	write_unlock_bh(&udplite_hash_lock);
+	return 0;
+
+      fail:
+	write_unlock_bh(&udplite_hash_lock);
+	return 1;
+}
+
+static void udplite_v4_hash(struct sock *sk)    /* Identical to udp.c */
+{
+	BUG();
+}
+
+static void udplite_v4_unhash(struct sock *sk)  /* Identical to udp.c */
+{
+	write_lock_bh(&udplite_hash_lock);
+	if (sk_del_node_init(sk)) {
+		inet_sk(sk)->num = 0;
+		sock_prot_dec_use(sk->sk_prot);
+	}
+	write_unlock_bh(&udplite_hash_lock);
+}
+
+
+/* The following function is identical to the one used in udp.c: */
+
+static struct sock *udplite_v4_lookup_longway(u32 saddr, u16 sport,
+					      u32 daddr, u16 dport, int dif)
+{
+	struct sock       *sk,
+	                  *result  = NULL;
+	struct hlist_node *node;
+	unsigned short     hnum    = ntohs(dport);
+	int                badness = -1;
+
+	sk_for_each(sk, node, &udplite_hash[hnum & (UDPLITE_HTABLE_SIZE - 1)]) {
+		struct inet_sock *inet = inet_sk(sk);
+
+		if (inet->num == hnum && !ipv6_only_sock(sk)) {
+			int score = (sk->sk_family == PF_INET ? 1 : 0);
+			if (inet->rcv_saddr) {
+				if (inet->rcv_saddr != daddr)
+					continue;
+				score += 2;
+			}
+			if (inet->daddr) {
+				if (inet->daddr != saddr)
+					continue;
+				score += 2;
+			}
+			if (inet->dport) {
+				if (inet->dport != sport)
+					continue;
+				score += 2;
+			}
+			if (sk->sk_bound_dev_if) {
+				if (sk->sk_bound_dev_if != dif)
+					continue;
+				score += 2;
+			}
+			if (score == 9) {
+				result = sk;
+				break;
+			} else if (score > badness) {
+				result = sk;
+				badness = score;
+			}
+		}
+	}
+	return result;
+}
+
+/* The following function is identical to the one used in udp.c: */
+
+static __inline__ struct sock *udplite_v4_lookup(u32 saddr, u16 sport,
+						 u32 daddr, u16 dport, int dif)
+{
+	struct sock *sk;
+
+	read_lock(&udplite_hash_lock);
+	sk = udplite_v4_lookup_longway(saddr, sport, daddr, dport, dif);
+	if (sk)
+		sock_hold(sk);
+	read_unlock(&udplite_hash_lock);
+	return sk;
+}
+
+/* The following function is identical to the one used in udp.c: */
+
+static inline struct sock *udplite_v4_mcast_next(struct sock *sk,
+						 u16 loc_port, u32 loc_addr,
+						 u16 rmt_port, u32 rmt_addr,
+						 int dif)
+{
+	struct hlist_node *node;
+	struct sock *s = sk;
+	unsigned short hnum = ntohs(loc_port);
+
+	sk_for_each_from(s, node) {
+		struct inet_sock *inet = inet_sk(s);
+
+		if (inet->num != hnum ||
+		    (inet->daddr && inet->daddr != rmt_addr) ||
+		    (inet->dport != rmt_port && inet->dport) ||
+		    (inet->rcv_saddr && inet->rcv_saddr != loc_addr) ||
+		    ipv6_only_sock(s) ||
+		    (s->sk_bound_dev_if && s->sk_bound_dev_if != dif))
+			continue;
+		if (!ip_mc_sf_allow(s, loc_addr, rmt_addr, dif))
+			continue;
+		goto found;
+	}
+	s = NULL;
+      found:
+	return s;
+}
+
+/**
+ *   udplite_err  -  handle error conditions (taken from udp.c)
+ *   @skb:
+ *   @info:
+ *
+ *   This routine is called by the ICMP module when it gets some
+ *   sort of error condition.  If err < 0 then the socket should
+ *   be closed and the error returned to the user.  If err > 0
+ *   it's just the icmp type << 8 | icmp code.
+ *   Header points to the ip header of the error packet. We move
+ *   on past this. Then (as it used to claim before adjustment)
+ *   header points to the first 8 bytes of the UDP-Lite header.
+ *   We need to find the appropriate port.
+ */
+
+void udplite_err(struct sk_buff *skb, u32 info)
+{
+	struct inet_sock  *inet;
+	struct iphdr      *iph  = (struct iphdr *)skb->data;
+	struct udplitehdr *uh   = (struct udplitehdr *)
+	                          (skb->data + (iph->ihl << 2));
+	int                type = skb->h.icmph->type,
+	                   code = skb->h.icmph->code;
+	struct sock       *sk;
+	int                harderr, err;
+
+	sk = udplite_v4_lookup(iph->daddr, uh->dest, iph->saddr, uh->source,
+			       skb->dev->ifindex);
+	if (sk == NULL) {
+		ICMP_INC_STATS_BH(ICMP_MIB_INERRORS);
+		return;		                 /* No socket for error */
+	}
+
+	err = 0;
+	harderr = 0;
+	inet = inet_sk(sk);
+
+	switch (type) {
+	default:
+	case ICMP_TIME_EXCEEDED:
+		err = EHOSTUNREACH;
+		break;
+	case ICMP_SOURCE_QUENCH:
+		goto out;
+	case ICMP_PARAMETERPROB:
+		err = EPROTO;
+		harderr = 1;
+		break;
+	case ICMP_DEST_UNREACH:
+		if (code == ICMP_FRAG_NEEDED) {	 /* Path MTU discovery */
+			if (inet->pmtudisc != IP_PMTUDISC_DONT) {
+				err = EMSGSIZE;
+				harderr = 1;
+				break;
+			}
+			goto out;
+		}
+		err = EHOSTUNREACH;
+		if (code <= NR_ICMP_UNREACH) {
+			harderr = icmp_err_convert[code].fatal;
+			err = icmp_err_convert[code].errno;
+		}
+		break;
+	}
+
+	/*
+	 *   This is handled as in UDP (cf. RFC 1122, sec. 4.1.3.3),
+         *   ICMP errors are passed back to the application.
+	 */
+	if (!inet->recverr) {
+		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
+			goto out;
+	} else {
+		ip_icmp_error(sk, skb, err, uh->dest, info, (u8 *) (uh + 1));
+	}
+	sk->sk_err = err;
+	sk->sk_error_report(sk);
+      out:
+	sock_put(sk);
+}
+
+/**
+ *   udplite_flush_pending_frames   -   taken from udp.c
+ *
+ *   Throw away all pending data and cancel the corking. Socket is locked.
+ */
+static void udplite_flush_pending_frames(struct sock *sk)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+
+	if (up->pending) {
+		up->len = 0;
+		up->pending = 0;
+		ip_flush_pending_frames(sk);
+	}
+}
+
+/**
+ *   udplite_push_pending_frames  -  send pending data
+ *
+ *   Push out all pending data as one UDP-Lite datagram. Socket is locked.
+ *   This code is modelled after the original in udp.c, but has been heavily
+ *   modified in all parts that relate to (partial) checksum computation.
+ */
+static int udplite_push_pending_frames(struct sock *sk, struct udplite_sock *up)
+{
+	struct inet_sock  *inet = inet_sk(sk);
+	struct flowi      *fl = &inet->cork.fl;
+	struct sk_buff    *skb;
+	struct udplitehdr *uh;
+	int                offset,      /* within skb structure         */
+	                   err  = 0;
+	unsigned short     clen = 0,	/* checksum coverage length     */
+	                   len;
+	unsigned int       csum = 0;	/* Intermediate checksum value. */
+
+	/* Grab the skbuff where UDP-Lite header space exists. */
+	if ((skb = skb_peek(&sk->sk_write_queue)) == NULL)
+		goto out;
+
+	/*
+	 * Create a UDP-Lite header
+	 */
+	uh         = skb->h.ulh;
+	uh->source = fl->fl_ip_sport;
+	uh->dest   = fl->fl_ip_dport;
+	uh->check  = 0;
+
+	offset     = (unsigned char *)uh - skb->data;
+
+
+	if (up->pcflag & UDPLITE_SEND_CHCKFLAG) {
+	        /* Sender has requested partial coverage via sockopts. */
+		if (up->pcslen < up->len) {
+			if (up->pcslen == 0)	/* Full coverage (RFC 3828)  */
+				clen = up->len;
+			else {	                /* Genuine partial coverage  */
+				clen = up->pcslen;
+				UDPLITE_INC_STATS_BH
+				    (UDPLITE_MIB_OUTDATAGRAMS_PARTIAL_CHECK);
+			}
+			uh->checklen = htons(up->pcslen);
+
+		} else {      /* up->pcslen >= up->len  */
+			/*
+			 * Causes for up->pcslen > up->len (error):
+			 * (i)  Sender error (will not be penalized).
+			 * (ii) Payload too big for send buffer: data is split
+			 * into several packets, each with its own header. In
+			 * this case (e.g. last fragment), coverage length may
+			 * exceed packet length.
+			 * Since packets with coverage length > packet length
+			 * are illegal, we adjust in both cases to the maximum
+			 * upper bound.
+			 */
+			clen = up->len;
+			uh->checklen = htons(clen);
+		}
+	} else {              /* No flag: emulate UDP.  */
+		clen = up->len;
+		uh->checklen = htons(clen);
+	}
+
+	/*
+	 * Checksum computation: is mandatory in UDP-Lite (RFC 3828).
+	 * There are no known drivers which would allow HW offloading of csum.
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	if (skb_queue_len(&sk->sk_write_queue) == 1) {
+	        /* Only one fragment on the socket. */
+		csum = csum_partial(skb->data + offset, clen, 0);
+
+	} else {        /* Packet is fragmented. */
+
+		if (clen <= (skb->len - offset)) {
+		        /* Coverage lies within the first frame. */
+			csum = csum_partial(skb->data + offset, clen, 0);
+
+		} else { /* Collect the checksum over the fragments */
+			skb_queue_walk(&sk->sk_write_queue, skb) {
+				offset = (unsigned char*)skb->h.raw - skb->data;
+				len    = skb->len - offset;
+
+				skb->csum =
+				    csum_partial(skb->data + offset,
+						 (clen > len) ? len : clen, 0);
+				csum = csum_add(csum, skb->csum);
+
+				if (clen < len)	   /* Enough seen. */
+					break;
+				clen -= len;
+			}
+		}
+	}
+	/* Finalise the checksum by adding the pseudo-header. */
+	uh->check = csum_tcpudp_magic(fl->fl4_src, fl->fl4_dst, up->len,
+				      IPPROTO_UDPLITE, csum);
+
+        /* RFC 3828: if computed checksum is 0, transmit it as all ones.
+         * The transmitted checksum MUST NOT be all zeroes (sec. 3.1).    */
+	if (uh->check == 0)
+		uh->check = -1;
+
+	err = ip_push_pending_frames(sk);  /* Send the datagram (fragments). */
+out:
+	up->len = 0;
+	up->pending = 0;
+	return err;
+}
+
+/**
+ *   udplite_sendmsg  -  send function
+ *
+ *   Code taken from udp.c but modified with regard to UDP-Lite specifics.
+ */
+int udplite_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+		    size_t len)
+{
+	struct inet_sock    *inet = inet_sk(sk);
+	struct udplite_sock *up   = udplite_sk(sk);
+	struct ipcm_cookie   ipc;
+	struct rtable       *rt   = NULL;
+	int                  free = 0, err,
+	                     connected = 0,
+                             ulen = len;          /* UDP-Lite length */
+	u32                  daddr, faddr, saddr;
+	u16                  dport;
+	u8                   tos;
+	int corkreq = up->corkflag || msg->msg_flags & MSG_MORE;
+
+	if (len > 0xFFFF)
+		return -EMSGSIZE;
+
+	/*
+	 *    Check the flags.
+	 */
+	if (msg->msg_flags & MSG_OOB) /* BSD error message compatibility */
+		return -EOPNOTSUPP;
+
+	ipc.opt = NULL;
+
+	if (up->pending) {
+		/*
+		 * There are pending frames.
+		 * The socket lock must be held while it's corked.
+		 */
+		lock_sock(sk);
+		if (likely(up->pending)) {
+			if (unlikely(up->pending != AF_INET)) {
+				release_sock(sk);
+				return -EINVAL;
+			}
+			goto do_append_data;
+		}
+		release_sock(sk);
+	}
+	ulen += sizeof(struct udplitehdr);
+
+	/*
+	 *  Get and verify the address.
+	 */
+	if (msg->msg_name) {
+		struct sockaddr_in *usin = (struct sockaddr_in *)msg->msg_name;
+		if (msg->msg_namelen < sizeof(*usin))
+			return -EINVAL;
+		if (usin->sin_family != AF_INET) {
+			if (usin->sin_family != AF_UNSPEC)
+				return -EAFNOSUPPORT;
+		}
+
+		daddr = usin->sin_addr.s_addr;
+		dport = usin->sin_port;
+		if (dport == 0)
+			return -EINVAL;
+	} else {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+		daddr = inet->daddr;
+		dport = inet->dport;
+		/* Open fast path for connected socket.
+		 * Route will not be used, if at least one option is set.
+		 */
+		connected = 1;
+	}
+	ipc.addr = inet->saddr;
+
+	ipc.oif = sk->sk_bound_dev_if;
+	if (msg->msg_controllen) {
+		err = ip_cmsg_send(msg, &ipc);
+		if (err)
+			return err;
+		if (ipc.opt)
+			free = 1;
+		connected = 0;
+	}
+	if (!ipc.opt)
+		ipc.opt = inet->opt;
+
+	saddr = ipc.addr;
+	ipc.addr = faddr = daddr;
+
+	if (ipc.opt && ipc.opt->srr) {
+		if (!daddr)
+			return -EINVAL;
+		faddr = ipc.opt->faddr;
+		connected = 0;
+	}
+	tos = RT_TOS(inet->tos);
+	if (sock_flag(sk, SOCK_LOCALROUTE) ||
+	    (msg->msg_flags & MSG_DONTROUTE) ||
+	    (ipc.opt && ipc.opt->is_strictroute)) {
+		tos |= RTO_ONLINK;
+		connected = 0;
+	}
+
+	if (MULTICAST(daddr)) {
+		if (!ipc.oif)
+			ipc.oif = inet->mc_index;
+		if (!saddr)
+			saddr = inet->mc_addr;
+		connected = 0;
+	}
+
+	if (connected)
+		rt = (struct rtable *)sk_dst_check(sk, 0);
+
+	if (rt == NULL) {
+		struct flowi fl = {
+			.oif = ipc.oif,
+			.nl_u = {.ip4_u =
+				 {.daddr = faddr,.saddr = saddr,.tos = tos}},
+			.proto = IPPROTO_UDPLITE,
+			.uli_u = {.ports =
+			             {.sport = inet->sport,.dport = dport}}
+		};
+
+		err =
+		    ip_route_output_flow(&rt, &fl, sk,
+					 !(msg->msg_flags & MSG_DONTWAIT));
+		if (err)
+			goto out;
+
+		err = -EACCES;
+		if ((rt->rt_flags & RTCF_BROADCAST) &&
+		    !sock_flag(sk, SOCK_BROADCAST))
+			goto out;
+		if (connected)
+			sk_dst_set(sk, dst_clone(&rt->u.dst));
+	}
+
+	if (msg->msg_flags & MSG_CONFIRM)
+		goto do_confirm;
+
+back_from_confirm:
+
+	saddr = rt->rt_src;
+	if (!ipc.addr)
+		daddr = ipc.addr = rt->rt_dst;
+
+	lock_sock(sk);
+	if (unlikely(up->pending)) {
+		/* The socket is already corked while preparing it. */
+		/* ... which is an evident application bug. --ANK   */
+		release_sock(sk);
+
+		LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: cork app bug 2\n");
+		err = -EINVAL;
+		goto out;
+	}
+	/*
+	 *    Now cork the socket to pend data.
+	 */
+	inet->cork.fl.fl4_dst     = daddr;
+	inet->cork.fl.fl_ip_dport = dport;
+	inet->cork.fl.fl4_src     = saddr;
+	inet->cork.fl.fl_ip_sport = inet->sport;
+	up->pending = AF_INET;
+
+do_append_data:
+	up->len += ulen;
+	err = ip_append_data(sk, ip_generic_getfrag, msg->msg_iov, ulen,
+			     sizeof(struct udplitehdr), &ipc, rt,
+			     corkreq ? msg->msg_flags | MSG_MORE
+                                     : msg->msg_flags);
+	if (err)
+		udplite_flush_pending_frames(sk);
+	else if (!corkreq)
+		err = udplite_push_pending_frames(sk, up);
+	release_sock(sk);
+
+out:
+	ip_rt_put(rt);
+	if (free)
+		kfree(ipc.opt);
+	if (!err) {
+		UDPLITE_INC_STATS_USER(UDPLITE_MIB_OUTDATAGRAMS);
+		return len;
+	}
+	return err;
+
+do_confirm:
+	dst_confirm(&rt->u.dst);
+	if (!(msg->msg_flags & MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto out;
+}
+
+/* as in udp.c */
+static int udplite_sendpage(struct sock *sk, struct page *page, int offset,
+			    size_t size, int flags)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int                  ret;
+
+	if (!up->pending) {
+		struct msghdr msg = {.msg_flags = flags | MSG_MORE };
+
+		/* Call udplite_sendmsg to specify destination address which
+		 * sendpage interface can't pass.
+		 * This will succeed only when the socket is connected.
+		 */
+		ret = udplite_sendmsg(NULL, sk, &msg, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	lock_sock(sk);
+
+	if (unlikely(!up->pending)) {
+		release_sock(sk);
+
+		LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: cork app bug 3\n");
+		return -EINVAL;
+	}
+
+	ret = ip_append_page(sk, page, offset, size, flags);
+	if (ret == -EOPNOTSUPP) {
+		release_sock(sk);
+		return sock_no_sendpage(sk->sk_socket, page, offset,
+					size, flags);
+	}
+	if (ret < 0) {
+		udplite_flush_pending_frames(sk);
+		goto out;
+	}
+
+	up->len += size;
+	if (!(up->corkflag || (flags & MSG_MORE)))
+		ret = udplite_push_pending_frames(sk, up);
+	if (!ret)
+		ret = size;
+out:
+	release_sock(sk);
+	return ret;
+}
+
+/**
+ *   udplite_ioctl  -  taken from udp.c
+ *
+ *   IOCTL requests applicable to the UDP-Lite protocol
+ */
+int udplite_ioctl(struct sock *sk, int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case SIOCOUTQ:
+		{
+			int amount = atomic_read(&sk->sk_wmem_alloc);
+			return put_user(amount, (int __user *)arg);
+		}
+
+	case SIOCINQ:
+		{
+			struct sk_buff *skb;
+			unsigned long amount;
+
+			amount = 0;
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb != NULL) {
+				/*
+				 * We will only return the amount
+				 * of this packet since that is all
+				 * that will be read.
+				 */
+				amount = skb->len - sizeof(struct udplitehdr);
+			}
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+			return put_user(amount, (int __user *)arg);
+		}
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return (0);
+}
+
+/*---------------------------------------------------------------------------
+ * Checksumming functions used for receiving and polling events.
+ *---------------------------------------------------------------------------*/
+/**
+ *   __udplite_checksum_complete  -  UDP-Lite csum workhorse
+ *
+ *   Returns 1 on error, 0 if checksum is fine.
+ */
+static __inline__ int __udplite_checksum_complete(struct sk_buff *skb)
+{
+	struct udplitehdr *uh;
+	unsigned short len,        /* Total length of the UDP-Lite packet.   */
+	               clen;       /* Coverage length as stated in header.   */
+	int            offset;     /* Offset of UDP-Lite header within buff. */
+
+	uh     = skb->h.ulh;
+	clen   = ntohs(uh->checklen);
+	offset = (unsigned char *)uh - skb->data;
+	len    = skb->len - offset;
+
+	if (clen == 0)		   /* Honour full packet coverage. */
+		clen = len;
+
+	/* Don't checksum if we have illegal coverage lengths (RFC 3828).
+	 * FIXME: The syslog messages are really there to flag bug conditions,
+	 * illegal checksum coverage length problems should have been resolved
+	 * before this routine is called.                   */
+	if (clen < 8 || clen > len) {	/* Using clen > len leads to crash! */
+		LIMIT_NETDEBUG(KERN_WARNING
+		       "UDPLITE: Illegal coverage length %d (length %d).\n",
+		       clen, len);
+		return 1;
+	} else if (uh->check == 0) {
+		LIMIT_NETDEBUG(KERN_WARNING
+                               "UDPLITE: Illegal packet - zero checksum.\n");
+		return 1;
+	} else  /* packet is law-abiding, so checksum it */
+		return (unsigned short)
+		    csum_fold(skb_checksum(skb, offset, clen, skb->csum));
+}
+
+
+/**
+ *   udplite_checksum_complete  -  finalise UDP-Lite csum computation
+ *
+ *   Return 0 if no checksum required or checksum computes ok.
+ */
+static __inline__ int udplite_checksum_complete(struct sk_buff *skb)
+{
+	return skb->ip_summed != CHECKSUM_UNNECESSARY
+	    && __udplite_checksum_complete(skb);
+}
+
+/**
+ *   udplite_recvmsg  -  receive a message (taken from udp.c)
+ */
+static int udplite_recvmsg(struct kiocb *iocb,
+			   struct sock *sk,
+			   struct msghdr *msg,
+			   size_t len, int noblock, int flags, int *addr_len)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct sockaddr_in *sin = (struct sockaddr_in *)msg->msg_name;
+	struct sk_buff *skb;
+	int copied, err;
+
+	/*
+	 *  Check any passed addresses
+	 */
+	if (addr_len)
+		*addr_len = sizeof(*sin);
+
+	if (flags & MSG_ERRQUEUE)
+		return ip_recv_error(sk, msg, len);
+
+      try_again:
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
+		goto out;
+
+	copied = skb->len - sizeof(struct udplitehdr);
+	if (copied > len) {
+		copied = len;
+		msg->msg_flags |= MSG_TRUNC;
+	}
+
+	if (udplite_checksum_complete(skb))	 /* Checksum validation */
+		goto csum_copy_err;
+
+	err =
+	    skb_copy_datagram_iovec(skb, sizeof(struct udplitehdr),
+				    msg->msg_iov, copied);
+	if (err)
+		goto out_free;
+
+	sock_recv_timestamp(msg, sk, skb);
+
+	if (sin) {		                 /* Copy the address. */
+		sin->sin_family      = AF_INET;
+		sin->sin_port        = skb->h.uh->source;
+		sin->sin_addr.s_addr = skb->nh.iph->saddr;
+		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+	}
+	if (inet->cmsg_flags)
+		ip_cmsg_recv(msg, skb);
+
+	err = copied;
+	if (flags & MSG_TRUNC)
+		err = skb->len - sizeof(struct udplitehdr);
+
+      out_free:
+	skb_free_datagram(sk, skb);
+      out:
+	return err;
+
+      csum_copy_err:
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: csum error in recvmsg.\n");
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS_CHECKSUMMING);
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+	if (flags & MSG_PEEK) {	                 /* Clear queue. */
+		int clear = 0;
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+		if (skb == skb_peek(&sk->sk_receive_queue)) {
+			__skb_unlink(skb, &sk->sk_receive_queue);
+			clear = 1;
+		}
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		if (clear)
+			kfree_skb(skb);
+	}
+
+	skb_free_datagram(sk, skb);
+
+	if (noblock)
+		return -EAGAIN;
+	goto try_again;
+}
+
+/* The following function is identical to the one used in udp.c: */
+
+int udplite_disconnect(struct sock *sk, int flags)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	/*
+	 *    1003.1g - break association.
+	 */
+	sk->sk_state        = TCP_CLOSE;
+	sk->sk_bound_dev_if = 0;
+	inet->daddr = 0;
+	inet->dport = 0;
+	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
+		inet_reset_saddr(sk);
+
+	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
+		sk->sk_prot->unhash(sk);
+		inet->sport = 0;
+	}
+	sk_dst_reset(sk);
+	return 0;
+}
+
+
+static void udplite_close(struct sock *sk, long timeout)
+{
+	sk_common_release(sk);
+}
+
+/**
+ *   udplite_encap_rcv  -  taken from udp.c
+ *
+ *   Return:
+ *     1  if the the UDP-Lite system should process it
+ *     0  if we should drop this packet
+ *    -1  if it should get processed by xfrm4_rcv_encap
+ */
+
+static int udplite_encap_rcv(struct sock *sk, struct sk_buff *skb)
+{
+#ifndef CONFIG_XFRM
+	return 1;
+#else
+	struct udplite_sock *up = udplite_sk(sk);
+	struct udplitehdr   *uh = skb->h.ulh;
+	struct iphdr        *iph;
+	int                  iphlen, len;
+
+	__u8  *udplitedata   = (__u8 *) uh + sizeof(struct udplitehdr);
+	__u32 *udplitedata32 = (__u32 *) udplitedata;
+	__u16  encap_type    = up->encap_type;
+
+	/* if we're overly short, let UDP-Lite handle it */
+	if (udplitedata > skb->tail)
+		return 1;
+
+	/* if this is not encapsulated socket, then just return now */
+	if (!encap_type)
+		return 1;
+
+	len = skb->tail - udplitedata;
+
+	switch (encap_type) {
+	default:
+	case UDPLITE_ENCAP_ESPINUDPLITE:
+		/* Check if this is a keepalive packet.  If so, eat it. */
+		if (len == 1 && udplitedata[0] == 0xff) {
+			return 0;
+		} else if (len > sizeof(struct ip_esp_hdr)
+			   && udplitedata32[0] != 0) {
+			/* ESP Packet without Non-ESP header */
+			len = sizeof(struct udplitehdr);
+		} else
+			/* Must be an IKE packet.. pass it through */
+			return 1;
+		break;
+	case UDPLITE_ENCAP_ESPINUDPLITE_NON_IKE:
+		/* Check if this is a keepalive packet.  If so, eat it. */
+		if (len == 1 && udplitedata[0] == 0xff) {
+			return 0;
+		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
+			   udplitedata32[0] == 0 && udplitedata32[1] == 0) {
+
+			/* ESP Packet with Non-IKE marker */
+			len = sizeof(struct udplitehdr) + 2 * sizeof(u32);
+		} else
+			/* Must be an IKE packet.. pass it through */
+			return 1;
+		break;
+	}
+
+	/* At this point we are sure that this is an ESP-in-UDP-Lite packet,
+	 * so we need to remove 'len' bytes from the packet (the UDP-Lite
+	 * header and optional ESP marker bytes) and then modify the
+	 * protocol to ESP, and then call into the transform receiver.
+	 */
+	if (skb_cloned(skb) && pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+		return 0;
+
+	/* Now we can update and verify the packet length... */
+	iph = skb->nh.iph;
+	iphlen = iph->ihl << 2;
+	iph->tot_len = htons(ntohs(iph->tot_len) - len);
+	if (skb->len < iphlen + len) {
+		/* packet is too small!?! */
+		return 0;
+	}
+
+	/* pull the data buffer up to the ESP header and set the
+	 * transport header to point to ESP.  Keep UDP-Lite on the stack
+	 * for later.
+	 */
+	skb->h.raw = skb_pull(skb, len);
+
+	/* modify the protocol (it's ESP!) */
+	iph->protocol = IPPROTO_ESP;
+
+	/* and let the caller know to send this into the ESP processor... */
+	return -1;
+#endif
+}
+
+/**
+ *   udplite_queue_rcv  -  same code as in udp.c
+ *
+ *   Returns:
+ *    -1: error
+ *     0: success
+ *    >0: "UDP-Lite encap" protocol resubmission
+ *
+ *   Note that in the success and error cases, the skb is assumed to
+ *   have either been requeued or freed.
+ */
+
+static int udplite_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+
+	/*
+	 *    Charge it to the socket, dropping if the queue is full.
+	 */
+	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
+		kfree_skb(skb);
+		return -1;
+	}
+
+	if (up->encap_type) {
+		/*
+		 * This is an encapsulation socket, so let's see if this is
+		 * an encapsulated packet.
+		 * If it's a keepalive packet, then just eat it.
+		 * If it's an encapsulateed packet, then pass it to the
+		 * IPsec xfrm input and return the response
+		 * appropriately.  Otherwise, just fall through and
+		 * pass this up the UDP-Lite socket.
+		 */
+		int ret;
+
+		ret = udplite_encap_rcv(sk, skb);
+		if (ret == 0) {
+			/* Eat the packet .. */
+			kfree_skb(skb);
+			return 0;
+		}
+		if (ret < 0) {
+			/* process the ESP packet */
+			ret = xfrm4_rcv_encap(skb, up->encap_type);
+			UDPLITE_INC_STATS_BH(UDPLITE_MIB_INDATAGRAMS);
+			return -ret;
+		}
+		/* FALLTHROUGH -- it's a UDP-Lite Packet */
+	}
+	/*
+	 * FIXME: The use of encapsulated packets has not yet been tested. The
+	 * code below reflects the common-sense options, but may have to check
+	 * whether it works in all possible cases. -- gr
+	 */
+	if (sk->sk_filter && skb->ip_summed != CHECKSUM_UNNECESSARY) {
+		if (__udplite_checksum_complete(skb)) {
+			UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS_CHECKSUMMING);
+			UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+			kfree_skb(skb);
+			return -1;
+		}
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	if (sock_queue_rcv_skb(sk, skb) < 0) {
+		UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+		kfree_skb(skb);
+		return -1;
+	}
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INDATAGRAMS);
+	return 0;
+}
+
+/*
+ *   udplite_v4_mcast_deliver  -  code taken from udp.c
+ *
+ *   Multicasts and broadcasts go to each listener.
+ *   Note: called only from the BH handler context,
+ *   so we don't need to lock the hashes.
+ */
+static int udplite_v4_mcast_deliver(struct sk_buff *skb, struct udplitehdr *uh,
+				    u32 saddr, u32 daddr)
+{
+	struct sock *sk;
+	int dif;
+
+	read_lock(&udplite_hash_lock);
+	sk = sk_head(&udplite_hash
+		     [ntohs(uh->dest) & (UDPLITE_HTABLE_SIZE - 1)]);
+	dif = skb->dev->ifindex;
+	sk = udplite_v4_mcast_next(sk, uh->dest, daddr, uh->source, saddr, dif);
+	if (sk) {
+		struct sock *sknext = NULL;
+
+		do {
+			struct sk_buff *skb1 = skb;
+
+			sknext =
+			    udplite_v4_mcast_next(sk_next(sk), uh->dest, daddr,
+						  uh->source, saddr, dif);
+			if (sknext)
+				skb1 = skb_clone(skb, GFP_ATOMIC);
+
+			if (skb1) {
+				int ret = udplite_queue_rcv_skb(sk, skb1);
+				if (ret > 0)
+					/* we should probably re-process instead
+					 * of dropping packets here. */
+					kfree_skb(skb1);
+			}
+			sk = sknext;
+		} while (sknext);
+	} else
+		kfree_skb(skb);
+	read_unlock(&udplite_hash_lock);
+	return 0;
+}
+
+/**
+ *   udplite_checksum_init  -  Initialize UDP-Lite checksum.
+ *
+ *   If exited with zero value (success), CHECKSUM_UNNECESSARY means that
+ *   no more checks are required. Otherwise, csum completion requires to
+ *   checksum packet body plus UDP-Lite header, and folding it to skb->csum.
+ */
+static int udplite_checksum_init(struct sk_buff *skb,
+				 struct udplitehdr *uh,
+				 unsigned short clen, u32 saddr, u32 daddr)
+{
+        /* In UDPv4 a zero checksum means that the transmitter generated no
+         * checksum. UDP-Lite (like IPv6) mandates checksums, hence packets
+         * with a zero checksum field are illegal.  */
+	if (uh->check == 0) {
+		return 1;
+	} else if (skb->ip_summed == CHECKSUM_HW) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		if (csum_tcpudp_magic
+		    (saddr, daddr, clen, IPPROTO_UDPLITE, skb->csum) == 0)
+			return 0;
+		LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: hw csum failure.\n");
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+	if (skb->ip_summed != CHECKSUM_UNNECESSARY)
+		skb->csum =
+		    csum_tcpudp_nofold(saddr, daddr, clen, IPPROTO_UDPLITE, 0);
+	return 0;
+}
+
+/**
+ *   udplite_rcv  -  receive packets
+ *
+ *   This code is modelled after the one in udp.c, but heavily modified
+ *   with regard to the differences in computing the checksum.
+ */
+int udplite_rcv(struct sk_buff *skb)
+{
+	struct sock         *sk;
+	struct udplitehdr   *uh;
+	u32                  saddr = skb->nh.iph->saddr,
+	                     daddr = skb->nh.iph->daddr;
+	int                  len   = skb->len;	/* total packet length  */
+	unsigned short       clen;	        /* csum coverage length */
+	struct udplite_sock *up;
+	struct rtable       *rt    = (struct rtable *)skb->dst;
+
+	/*
+	 *    Validate the packet and the UDP-Lite length.
+	 */
+	if (!pskb_may_pull(skb, sizeof(struct udplitehdr)))
+		goto drop;	       /* No header. */
+
+	uh = skb->h.ulh;
+	sk = udplite_v4_lookup(saddr, uh->source, daddr, uh->dest,
+			       skb->dev->ifindex);
+	up   = udplite_sk(sk);
+	clen = ntohs(uh->checklen);
+
+	if (sk == NULL)
+		goto no_port;
+
+	if (len < sizeof(*uh))	          /* Unlike udp.c, pskb_trim makes   */
+		goto short_packet;        /* no sense, since len = skb->len  */
+
+	if (clen == 0)		/* Indicates that full coverage is required. */
+		clen = len;
+	else if (clen < 8 ||	/* Illegal coverage length, 8 is minimum.    */
+		 clen > len)	/* Coverage length exceeds datagram length.  */
+		goto csumlen_error;
+	else if (clen < len)	/* Normal: partial coverage required.        */
+		UDPLITE_INC_STATS_BH(UDPLITE_MIB_INDATAGRAMS_PARTIAL_CHECK);
+
+	if (up->pcflag & UDPLITE_RECV_CHCKFLAG) {   /* min. coverage was set */
+		/*
+		 * MIB statistics other than incrementing the error count are
+		 * disabled for the following two types of errors: these depend
+		 * on the application settings, not on the functioning of the
+		 * protocol stack as such.
+		 *
+		 * RFC 3828 here recommends (sec 3.3): "There should also be a
+		 * way ... to ... at least let the receiving application block
+		 * delivery of packets with coverage values less than a value
+		 * provided by the application."
+		 */
+		if (clen < len) {
+			if (up->pcrlen == 0) {
+				LIMIT_NETDEBUG(KERN_WARNING
+                                     "UDPLITE: partial coverage %d, but "
+                                               "full coverage %d requ. "
+               			     "(IP %d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n",
+				     clen, len, NIPQUAD(saddr),
+				     ntohs(uh->source), NIPQUAD(daddr),
+				     ntohs(uh->dest));
+				goto drop;
+			}
+		} else if (clen < up->pcrlen) {	/* here: clen=len */
+			LIMIT_NETDEBUG(KERN_WARNING
+			       "UDPLITE: coverage %d too small, need min. %d "
+			       "(IP %d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n", clen,
+			       up->pcrlen, NIPQUAD(saddr), ntohs(uh->source),
+			       NIPQUAD(daddr), ntohs(uh->dest));
+			goto drop;
+		}
+	}
+	/* Compute initial checksum, including pseudo-header. */
+	if (udplite_checksum_init(skb, uh, len, saddr, daddr) < 0)
+		goto csum_error;
+
+	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		return udplite_v4_mcast_deliver(skb, uh, saddr, daddr);
+
+	if (sk != NULL) {
+		int ret = udplite_queue_rcv_skb(sk, skb);
+		sock_put(sk);
+
+		/*
+		 * A return value > 0 means to resubmit the input, but
+		 * it wants the return to be -protocol, or 0.
+		 *
+		 */
+		if (ret > 0)
+			return -ret;
+		return 0;
+	}
+	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
+		goto drop;
+
+	/* No socket. Drop packet silently, if checksum is wrong */
+	if (udplite_checksum_complete(skb))
+		goto csum_error;
+
+no_port:
+	/*
+	 * Got a UDP-Lite packet to a port to which we don't wanna listen.
+         * Ignore it and increment the count of `NoPort' messages.
+	 */
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_NOPORTS);
+	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
+	kfree_skb(skb);
+	return (0);
+
+short_packet:
+	LIMIT_NETDEBUG(KERN_NOTICE "UDPLITE: short packet, %d/%d bytes "
+               "(%u.%u.%u.%u:%u -> %u.%u.%u.%u:%u\n)\n",
+	       len, clen, NIPQUAD(saddr), ntohs(uh->source),
+                          NIPQUAD(daddr), ntohs(uh->dest)   );
+	goto drop;
+
+csumlen_error:
+	/*
+	 * Coverage length violates RFC 3828: log and discard silently.
+	 */
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad csum coverage %d "
+               "(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d, len %d)\n",
+	       clen, NIPQUAD(saddr), ntohs(uh->source),
+                     NIPQUAD(daddr), ntohs(uh->dest), len);
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS_CHECKSUM_COVERAGE);
+	goto drop;
+
+csum_error:
+	/*
+	 * Checksum violated: proceed as per RFC 1122/3828.
+	 */
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad checksum "
+                "(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n", NIPQUAD(saddr),
+                     ntohs(uh->source), NIPQUAD(daddr), ntohs(uh->dest));
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS_CHECKSUMMING);
+
+drop:
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+	kfree_skb(skb);
+	return (0);
+}
+
+static int udplite_destroy_sock(struct sock *sk)
+{
+	lock_sock(sk);
+	udplite_flush_pending_frames(sk);
+	release_sock(sk);
+	return 0;
+}
+
+/**
+ *   udplite_setsocktopt  -  set UDP-Lite socket options
+ *
+ *   This function is very similar to udp.c, the only difference being
+ *   the two new socket options for setting receiver/sender csum coverage.
+ */
+static int udplite_setsockopt(struct sock *sk,
+			      int level,
+			      int optname, char __user * optval, int optlen)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int val;
+	int err = 0;
+
+	if (level != SOL_UDPLITE)
+		return ip_setsockopt(sk, level, optname, optval, optlen);
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
+
+	switch (optname) {
+	case UDPLITE_CORK:
+		if (val != 0) {
+			up->corkflag = 1;
+		} else {
+			up->corkflag = 0;
+			lock_sock(sk);
+			udplite_push_pending_frames(sk, up);
+			release_sock(sk);
+		}
+		break;
+
+	case UDPLITE_ENCAP:
+		switch (val) {
+		case 0:
+		case UDP_ENCAP_ESPINUDP:
+		case UDP_ENCAP_ESPINUDP_NON_IKE:
+			up->encap_type = val;
+			break;
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+		break;
+	/* Sender sets actual checksum coverage length via this option.
+	   The case coverage > packet length is handled by send module. */
+	case UDPLITE_SOCKOPT_SEND_CSCOV:
+		if (val != 0 && val < 8) /* Illegal coverage: use default (8) */
+			val = 8;
+		up->pcslen = val;
+		up->pcflag |= UDPLITE_SEND_CHCKFLAG;
+		break;
+
+        /* The receiver specifies a minimum checksum coverage value. To make
+         * sense, this should be set to 8 (as done below).                    */
+	case UDPLITE_SOCKOPT_RECV_CSCOV:
+		if (val != 0 && val < 8)    /* Disallow silly minimal values. */
+			val = 8;
+		up->pcrlen = val;
+		up->pcflag |= UDPLITE_RECV_CHCKFLAG;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	};
+
+	return err;
+}
+
+/**
+ *   udplite_getsockopt  -  as per udp.c
+ */
+static int udplite_getsockopt(struct sock *sk, int level, int optname,
+			      char __user * optval, int __user * optlen)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int                  val, len;
+
+	if (level != SOL_UDPLITE)
+		return ip_getsockopt(sk, level, optname, optval, optlen);
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(int));
+
+	if (len < 0)
+		return -EINVAL;
+
+	switch (optname) {
+	case UDPLITE_CORK:
+		val = up->corkflag;
+		break;
+
+	case UDPLITE_ENCAP:
+		val = up->encap_type;
+		break;
+
+	case UDPLITE_SOCKOPT_SEND_CSCOV:
+		val = up->pcslen;
+		break;
+
+	case UDPLITE_SOCKOPT_RECV_CSCOV:
+		val = up->pcrlen;
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	};
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &val, len))
+		return -EFAULT;
+	return 0;
+}
+
+/**
+ *    udplite_poll - wait for a UDP-Lite event (agrees mostly with udp.c)
+ *
+ *    @file: file struct
+ *    @sock: socket
+ *    @wait: poll table
+ *
+ *    This is same as datagram poll, except for the special case of
+ *    blocking sockets. If application is using a blocking fd
+ *    and a packet with checksum error is in the queue;
+ *    then it could get return from select indicating data available
+ *    but then block when reading it. Add special case code
+ *    to work around these arguably broken applications.
+ */
+
+unsigned int udplite_poll(struct file *file, struct socket *sock,
+			  poll_table  *wait)
+{
+	unsigned int  mask = datagram_poll(file, sock, wait);
+	struct sock  *sk   = sock->sk;
+
+	/* Check for false positives due to checksum errors */
+	if ((mask & POLLRDNORM) &&
+	    !(file->f_flags & O_NONBLOCK) &&
+	    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
+		struct sk_buff_head *rcvq = &sk->sk_receive_queue;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&rcvq->lock);
+		while ((skb = skb_peek(rcvq)) != NULL) {
+			if (udplite_checksum_complete(skb)) {
+                                /* checksum invalidated */
+				UDPLITE_INC_STATS_BH
+				    (UDPLITE_MIB_INERRORS_CHECKSUMMING);
+				UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+				__skb_unlink(skb, rcvq);
+				kfree_skb(skb);
+			} else {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				break;
+			}
+		}
+		spin_unlock_bh(&rcvq->lock);
+
+		if (skb == NULL)	/* Nothing to see, move along. */
+			mask &= ~(POLLIN | POLLRDNORM);
+	}
+
+	return mask;
+
+}
+
+
+struct proto udplite_prot = {
+	.name        = "UDPLITE",
+	.owner       = THIS_MODULE,
+	.close       = udplite_close,
+	.connect     = ip4_datagram_connect,
+	.disconnect  = udplite_disconnect,
+	.ioctl       = udplite_ioctl,
+	.destroy     = udplite_destroy_sock,
+	.setsockopt  = udplite_setsockopt,
+	.getsockopt  = udplite_getsockopt,
+	.sendmsg     = udplite_sendmsg,
+	.recvmsg     = udplite_recvmsg,
+	.sendpage    = udplite_sendpage,
+	.backlog_rcv = udplite_queue_rcv_skb,
+	.hash        = udplite_v4_hash,
+	.unhash      = udplite_v4_unhash,
+	.get_port    = udplite_v4_get_port,
+	.obj_size    = sizeof(struct udplite_sock),
+};
+
+/*-------------------------------------------------------------------------
+ * Operations related to the proc filesystem. These are are all taken
+ * (modulo name change) from udp.c
+ *-------------------------------------------------------------------------*/
+#ifdef CONFIG_PROC_FS
+static struct sock *udplite_get_first(struct seq_file *seq)
+{
+	struct sock               *sk;
+	struct udplite_iter_state *state = seq->private;
+
+	for (state->bucket = 0; state->bucket < UDPLITE_HTABLE_SIZE;
+	     ++state->bucket) {
+		struct hlist_node *node;
+		sk_for_each(sk, node, &udplite_hash[state->bucket]) {
+			if (sk->sk_family == state->family)
+				goto found;
+		}
+	}
+	sk = NULL;
+found:
+	return sk;
+}
+
+static struct sock *udplite_get_next(struct seq_file *seq, struct sock *sk)
+{
+	struct udplite_iter_state *state = seq->private;
+
+	do {
+		sk = sk_next(sk);
+try_again:
+		;
+	} while (sk && sk->sk_family != state->family);
+
+	if (!sk && ++state->bucket < UDPLITE_HTABLE_SIZE) {
+		sk = sk_head(&udplite_hash[state->bucket]);
+		goto try_again;
+	}
+	return sk;
+}
+
+static struct sock *udplite_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct sock *sk = udplite_get_first(seq);
+
+	if (sk)
+		while (pos && (sk = udplite_get_next(seq, sk)) != NULL)
+			--pos;
+	return pos? NULL : sk;
+}
+
+static void *udplite_seq_start(struct seq_file *seq, loff_t * pos)
+{
+	read_lock(&udplite_hash_lock);
+	return *pos ? udplite_get_idx(seq, *pos - 1) : (void *)1;
+}
+
+static void *udplite_seq_next(struct seq_file *seq, void *v, loff_t * pos)
+{
+	struct sock *sk;
+
+	if (v == (void *)1)
+		sk = udplite_get_idx(seq, 0);
+	else
+		sk = udplite_get_next(seq, v);
+
+	++*pos;
+	return sk;
+}
+
+static void udplite_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&udplite_hash_lock);
+}
+
+static int udplite_seq_open(struct inode *inode, struct file *file)
+{
+	struct udplite_seq_afinfo *afinfo = PDE(inode)->data;
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct udplite_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+
+	if (!s)
+		goto out;
+	memset(s, 0, sizeof(*s));
+	s->family        = afinfo->family;
+	s->seq_ops.start = udplite_seq_start;
+	s->seq_ops.next  = udplite_seq_next;
+	s->seq_ops.show  = afinfo->seq_show;
+	s->seq_ops.stop  = udplite_seq_stop;
+
+	rc = seq_open(file, &s->seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq = file->private_data;
+	seq->private = s;
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
+}
+
+/* ------------------------------------------------------------------------ */
+int udplite_proc_register(struct udplite_seq_afinfo *afinfo)
+{
+	struct proc_dir_entry *p;
+	int                    rc = 0;
+
+	if (!afinfo)
+		return -EINVAL;
+	afinfo->seq_fops->owner   = afinfo->owner;
+	afinfo->seq_fops->open    = udplite_seq_open;
+	afinfo->seq_fops->read    = seq_read;
+	afinfo->seq_fops->llseek  = seq_lseek;
+	afinfo->seq_fops->release = seq_release_private;
+
+	p = proc_net_fops_create(afinfo->name, S_IRUGO, afinfo->seq_fops);
+	if (p)
+		p->data = afinfo;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+
+void udplite_proc_unregister(struct udplite_seq_afinfo *afinfo)
+{
+	if (!afinfo)
+		return;
+	proc_net_remove(afinfo->name);
+	memset(afinfo->seq_fops, 0, sizeof(*afinfo->seq_fops));
+}
+
+
+static void udplite4_format_sock(struct sock *sp, char *tmpbuf, int bucket)
+{
+	struct inet_sock *inet  = inet_sk(sp);
+	unsigned int      dest  = inet->daddr;
+	unsigned int      src   = inet->rcv_saddr;
+	__u16             destp = ntohs(inet->dport);
+	__u16             srcp  = ntohs(inet->sport);
+
+	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
+		bucket, src, srcp, dest, destp, sp->sk_state,
+		atomic_read(&sp->sk_wmem_alloc),
+		atomic_read(&sp->sk_rmem_alloc),
+		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
+		atomic_read(&sp->sk_refcnt), sp);
+}
+
+static int udplite4_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == SEQ_START_TOKEN)
+		seq_printf(seq, "%-127s\n",
+			   "  sl  local_address rem_address   st tx_queue "
+			   "rx_queue tr tm->when retrnsmt   uid  timeout "
+			   "inode");
+	else {
+		char tmpbuf[129];
+		struct udplite_iter_state *state = seq->private;
+
+		udplite4_format_sock(v, tmpbuf, state->bucket);
+		seq_printf(seq, "%-127s\n", tmpbuf);
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------------ */
+static struct file_operations udplite4_seq_fops;
+
+static struct udplite_seq_afinfo udplite4_seq_afinfo = {
+	.owner    = THIS_MODULE,
+	.name     = "udplite",
+	.family   = AF_INET,
+	.seq_show = udplite4_seq_show,
+	.seq_fops = &udplite4_seq_fops,
+};
+
+
+int __init udplite4_proc_init(void)
+{
+	return udplite_proc_register(&udplite4_seq_afinfo);
+}
+
+void udplite4_proc_exit(void)
+{
+	udplite_proc_unregister(&udplite4_seq_afinfo);
+}
+#endif				/* CONFIG_PROC_FS */
+/* ------------------------------------------------------------------------ */
+
+EXPORT_SYMBOL(udplite_disconnect);
+EXPORT_SYMBOL(udplite_hash);
+EXPORT_SYMBOL(udplite_hash_lock);
+EXPORT_SYMBOL(udplite_ioctl);
+EXPORT_SYMBOL(udplite_port_rover);
+EXPORT_SYMBOL(udplite_prot);
+EXPORT_SYMBOL(udplite_sendmsg);
+EXPORT_SYMBOL(udplite_poll);
+
+#ifdef CONFIG_PROC_FS
+EXPORT_SYMBOL(udplite_proc_register);
+EXPORT_SYMBOL(udplite_proc_unregister);
+#endif

