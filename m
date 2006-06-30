Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbWF3OxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWF3OxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWF3OxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:53:00 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:59385 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1751273AbWF3Ow5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:52:57 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
Subject: [PATCH  2.6  1/3]  net/ipv4|v6: RFC 3828-compliant UDP-Lite support
Date: Fri, 30 Jun 2006 15:51:45 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606301551.45536@strip-the-willow>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an extension which adds RFC3828 - compliant UDP-Lite functionality
to the IPv4 / IPv6 networking stack.  

I have uploaded three IPv6-ready UDP-Lite applications, with install 
instructions, so please give it a test drive if you can spare a few minutes. 

The link and further information is in Documentation/networking/udplite.txt.

I have done extensive testing and am quite confident that the code (derived
from udp.c) is bug-free. Despite earlier ideas to merge udp.c and udplite.c
it was decided against it since this would mess up the udp.c code with many
ifdefs. It compiles and runs without error on AMD, i386/i686, SMP (server and 
desktop PC).  Use CONFIG_IP_UDPLITE=y to enable.


Please CC: any feedback/discussion to  gerrit.renker@ukuug.org

Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Signed-off-by: William Stanislaus <william@erg.abdn.ac.uk>
---

 Documentation/networking/udplite.txt |  339 +++++++++++++++++++++++++++++++++++
 include/linux/in.h                   |    1
 include/linux/skbuff.h               |   15 -
 include/linux/snmp.h                 |   18 +
 include/linux/socket.h               |    1
 include/linux/udplite.h              |   96 +++++++++
 include/net/snmp.h                   |    7
 include/net/udplite.h                |  114 +++++++++++
 include/net/xfrm.h                   |    2
 net/ipv4/Kconfig                     |   21 ++
 10 files changed, 607 insertions(+), 7 deletions(-)


diff -Nurp  a/Documentation/networking/udplite.txt b/Documentation/networking/udplite.txt
--- a/Documentation/networking/udplite.txt	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/networking/udplite.txt	2006-06-30 14:08:04.000000000 +0100
@@ -0,0 +1,339 @@
+  ===========================================================================
+                      The UDP-Lite protocol (RFC 3828)
+  ===========================================================================
+  last modified: 	Fri 30th June 2006
+
+
+  UDP-Lite is a Standards-Track IETF transport protocol whose characteristic
+  is a variable-length checksum. This has advantages for transport of multimedia
+  (video, VoIP) over wireless networks, as partly damaged packets can still be
+  fed into the codec instead of being discarded due to a failed checksum test.
+
+  This file briefly describes the existing kernel support and the socket API.
+  For in-depth information, you can consult:
+
+   o The UDP-Lite Homepage: http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/
+       Fom here you can always also pull the latest patch for the stable
+       kernel tree and example application source code.
+
+   o The UDP-Lite HOWTO on
+       http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/UDP-Lite-HOWTO.txt
+
+   o The Ethereal UDP-Lite WiKi (with capture files):
+       http://wiki.ethereal.com/Lightweight_User_Datagram_Protocol
+
+   o The Protocol Spec, RFC 3828:    http://www.ietf.org/rfc/rfc3828.txt
+
+
+  I) APPLICATIONS
+
+  Several applications have been ported successfully to UDP-Lite. Ethereal
+  (now called wireshark) has UDP-Litev4/v6 support by default. The tarball on
+
+   http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/udplite_linux.tar.gz
+
+  has source code for several v4/v6 client-server and network testing examples.
+
+  Porting applications to UDP-Lite is straightforward: only socket level and
+  IPPROTO need to be changed; senders additionally set the checksum coverage
+  length (default = header length = 8). Details are in the next section.
+  UDP-Lite is not enabled per default, set CONFIG_IP_UDPLITE=y to support it.
+
+
+  II) PROGRAMMING API
+
+  UDP-Lite provides a connectionless, unreliable datagram service and hence
+  uses the same socket type as UDP. In fact, porting from UDP to UDP-Lite is
+  dead easy: simply add `IPPROTO_UDPLITE' as the last argument of the socket(2)
+  call so that the statement looks like:
+
+      s = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDPLITE);
+
+                      or, respectively,
+
+      s = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDPLITE);
+
+  Since both UDP-Litev4 and UDP-Litev6 are supported, the porting process is the
+  same in both occasions. With just this change you are able to run UDP-Lite
+  services or connect to UDP-Lite servers. The kernel will assume that you are
+  not interested in using partial checksum coverage and so emulate UDP mode.
+
+  To make use of the partial checksum coverage facilities requires setting just
+  one socket option which takes an integer specifying the coverage length:
+
+    * Sender checksum coverage: UDPLITE_SEND_CSCOV
+
+      For example,
+
+        int val = 20;
+        setsockopt(s, SOL_UDPLITE, UDPLITE_SEND_CSCOV, &val, sizeof(int));
+
+      sets the checksum coverage length to 20 bytes (12b data + 8b header).
+      Of each packet only the first 20 bytes (plus the pseudo-header) will be
+      checksummed. This is useful for RTP applications which have a 12-byte
+      base header.
+
+
+    * Receiver checksum coverage: UDPLITE_RECV_CSCOV
+
+      This option is the receiver-side analogue. It is truly optional, i.e. not
+      required to enable traffic with partial checksum coverage. Its function is
+      that of a traffic filter: when enabled, it instructs the kernel to drop
+      all packets which have a coverage _less_ than this value. For example, if
+      RTP and UDP headers are to be protected, a receiver can enforce that only
+      packets with a minimum coverage of 20 are admitted:
+
+        int min = 20;
+        setsockopt(s, SOL_UDPLITE, UDPLITE_RECV_CSCOV, &min, sizeof(int));
+
+  The calls to getsockopt(2) are analogous. Being an extension and not a stand-
+  alone protocol, all socket options known from UDP can be used in exactly the
+  same manner as before, e.g. UDP_CORK or UDP_ENCAP.
+
+  A detailed discussion of UDP-Lite checksum coverage options is in section IV.
+
+
+
+  III) HEADER FILES
+
+  The socket API requires support through header files in /usr/include:
+
+    * /usr/include/netinet/in.h
+        to define IPPROTO_UDPLITE
+
+    * /usr/include/netinet/udplite.h
+        for UDP-Lite header fields and protocol constants
+
+  For testing purposes, the following may server as a `mini' header file:
+
+    #define IPPROTO_UDPLITE       136
+    #define SOL_UDPLITE           136
+    #define UDPLITE_SEND_CSCOV     10
+    #define UDPLITE_RECV_CSCOV     11
+
+  Ready-made header files for various distros are in the UDP-Lite tarball.
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
+  On both sender and receiver, trying to disable the UDP-Lite checksum
+  (option SO_NO_CHECK) in setsockopt(2) results in an error. Thus
+
+        setsockopt(sockfd, SOL_SOCKET, SO_NO_CHECK,  ... );
+
+  will always result in an error, while
+
+        getsockopt(sockfd, SOL_SOCKET, SO_NO_CHECK, &value, ...);
+
+  will always return a value of 0 (meaning checksum enabled). Packets
+  with a zero checksum field are silently discarded by the receiver.
+
+
+  4) Fragmentation
+
+  The checksum computation respects both buffersize and MTU. The size
+  of UDP-Lite packets is determined by the size of the send buffer. The
+  minimum size of the send buffer is 2048 (defined as SOCK_MIN_SNDBUF
+  in include/net/sock.h), the default value is configurable as
+  net.core.wmem_default or via setting the SO_SNDBUF socket(7)
+  option. The maximum upper bound for the send buffer is determined
+  by net.core.wmem_max.
+
+  Given a payload size larger than the send buffer size, UDP-Lite will
+  split the payload into several individual packets, filling up the
+  send buffer size in each case.
+
+  The precise value also depends on the interface MTU. The interface MTU,
+  in turn, may trigger IP fragmentation. In this case, the generated
+  UDP-Lite packet is split into several IP packets, of which only the
+  first one contains the L4 header.
+
+  The send buffer size has implications on the checksum coverage length.
+  Consider the following example:
+
+  Payload: 1536 bytes          Send Buffer:     1024 bytes
+  MTU:     1500 bytes          Coverage Length:  856 bytes
+
+  UDP-Lite will ship the 1536 bytes in two separate packets:
+
+  Packet 1: 1024 payload + 8 byte header + 20 byte IP header = 1052 bytes
+  Packet 2:  512 payload + 8 byte header + 20 byte IP header =  540 bytes
+
+  The coverage packet covers the UDP-Lite header and 848 bytes of the
+  payload in the first packet, the second packet is fully covered. Note
+  that for the second packet, the coverage length exceeds the packet
+  length. The kernel always re-adjusts the coverage length to the packet
+  length in such cases.
+
+  As an example of what happens when one UDP-Lite packet is split into
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
+  The UDP-Lite module generates one 1032 byte packet (1024 + 8 byte
+  header). According to the interface MTU, these are split into 4 IP
+  packets (280 byte IP payload + 20 byte IP header). The kernel module
+  sums the contents of the entire first two packets, plus 15 bytes of
+  the last packet before releasing the fragments to the IP module.
+
+  To see the analogous case for IPv6 fragmentation, consider a link
+  MTU of 1280 bytes and a write buffer of 3356 bytes. If the checksum
+  coverage is less than 1232 bytes (MTU minus IPv6/fragment header
+  lengths), only the first fragment needs to be considered. When using
+  larger checksum coverage lengths, each eligible fragment needs to be
+  checksummed. Suppose we have a checksum coverage of 3062. The buffer
+  of 3356 bytes will be split into the following fragments.
+
+    Fragment 1: 1280 bytes carrying  1232 bytes of UDP-Lite data
+    Fragment 2: 1280 bytes carrying  1232 bytes of UDP-Lite data
+    Fragment 3:  948 bytes carrying   900 bytes of UDP-Lite data
+
+  The first two fragments have to be checksummed in full, of the last
+  fragment only 598 (= 3062 - 2*1232) bytes are checksummed.
+
+  While it is important that such cases are dealt with correctly, they
+  are (annoyingly) rare: UDP-Lite is designed for optimising multimedia
+  performance over wireless (or generally noisy) links and thus smaller
+  coverage lenghts are likely to be expected.
+
+
+  V) UDP-LITE RUNTIME STATISTICS AND THEIR MEANING
+
+  Exceptional and error conditions are logged to syslog at the KERN_DEBUG
+  level.  Live statistics about UDP-Lite are available in /proc/net/snmp
+  and can (with newer versions of netstat) be viewed using
+
+                            netstat -svu
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
+                      * xfrm4_policy_check() returned with error
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
+  These statistics variables obey the following relations:
+
+     Total_received_datagrams   =  InDatagrams + InErrors + NoPorts
+
+                     InErrors  >=  InBadCoverage + InBadChecksum
+
+  The `>' includes other errors such as socket queue errors (usually 0). For
+  IPv6, the same statistics variables are used, using the `UdpLite6' prefix,
+  and can be viewed using "grep ^UdpLite6  /proc/net/snmp6". Alternatively,
+  you can use the `nstat' utility found in the iproute2 package.
+
+
+
+  VI) OPEN ISSUES
+
+  1) MIB Standardisation
+
+  A MIB for UDP-Lite does not (yet) exist. For someone who is familiar with
+  SNMP/ASN.1 it would be a trivial task to turn the above variable definitions
+  into a MIB - in the same manner as per e.g. RFC 2013.  Anyone interested in
+  helping with this work should contact us at <gerrit@erg.abdn.ac.uk>.
+
+
+  2) Sharing Code with UDP
+
+  On the mailing list there has been a suggestion to share code between
+  ipv?/udp.c and ipv?/udplite.c. There is indeed a potential for this, but the
+  challenge is not to mess up existing code. A line-by-line comparison between
+  ipv4/udp.c  and ipv4/udplite.c revealed the following similarities:
+
+    * 45 functions appear in udp.c and modified in udplite.c
+    * 26 are used with trivial modifications (sed/perl could do this)
+    * 10 are used with minor changes (structure / sockopt names)
+    *  8 require real modifications (in control flow and algorithm)
+    *  1 function is missing in udplite.c (no equivalent of udp_check())
+
+  A summary of this analysis can be found on
+    http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/udplite-comparison.html
+
+  Further similarities include structure identifiers, e.g. udp_seq_afinfo is
+  reused directly for UDP-Lite; as are several UDP constants. To avoid easier
+  comparison, the udplite.c file has been reverse-engineered to minimise the
+  differences to udp.c (this included re-inserting whitespaces and comments).
+  Since line-lengths have had to be truncated to 80 chars,  use `diff -wEbB'
+  for best results (or KDE's kompare).
+
+  However, I doubt whether merging will make things better. In a lot of cases
+  the code is functionally identical but depends and operates on global data
+  structures and locks which are exported as kernel symbols:
+    * udp(lite)_hash
+    * udp(lite)_hash_lock
+    * udp(lite)_port_rover
+    * udp(lite)_statistics
+  Hence it would be necessary to rename these globals apart in both source code
+  files, which would lead to a lot of #ifdefs in udp.c and introduce a fragile
+  dependency among both. Therefore, it does seem better to stick to the old
+  saying: keep it simple, separate. I would much rather update udplite.c each
+  time a code change is introduced to udp.c than relying on inclusion, which
+  would thereby also include all changes made to udp.c.
diff -Nurp  a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	2006-06-29 16:49:08.000000000 +0100
+++ b/net/ipv4/Kconfig	2006-06-29 18:02:43.000000000 +0100
@@ -591,3 +591,24 @@ config TCP_CONG_BIC
 
 source "net/ipv4/ipvs/Kconfig"
 
+config IP_UDPLITE
+	bool "The UDP-Lite Protocol (EXPERIMENTAL)"
+	depends on INET && EXPERIMENTAL
+        default n
+	---help---
+	  The UDP-Lite Protocol            <http://www.ietf.org/rfc/rfc3828.txt>
+
+	  UDP-Lite is  a Standards-Track IETF  transport protocol (RFC 3828). It
+	  features  a  variable-length checksum;  which allows partially damaged
+	  packets  to  be forwarded to media codecs, rather than being discarded
+	  due to invalid (UDP) checksum values. This can have advantages for the
+	  transport of multimedia (e.g. video/audio) over wireless networks.
+
+	  The protocol runs on both IPv4 and IPv6. The socket API resembles that
+	  of UDP. Applications must indicate their wish to utilise the partial
+	  checksum coverage feature by setting a socket option; UDP-Lite will
+	  otherwise run in (compatible) UDP mode.
+
+	  Detailed documentation in <file:Documentation/networking/udplite.txt>.
+
+	  If in doubt, say N.
diff -Nurp  a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	2006-06-29 16:49:03.000000000 +0100
+++ b/include/net/xfrm.h	2006-06-29 18:02:43.000000000 +0100
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
diff -Nurp  a/include/net/snmp.h b/include/net/snmp.h
--- a/include/net/snmp.h	2006-01-03 03:21:10.000000000 +0000
+++ b/include/net/snmp.h	2006-06-29 18:02:43.000000000 +0100
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
diff -Nurp  a/include/linux/socket.h b/include/linux/socket.h
--- a/include/linux/socket.h	2006-06-29 16:49:02.000000000 +0100
+++ b/include/linux/socket.h	2006-06-29 18:02:43.000000000 +0100
@@ -264,6 +264,7 @@ struct ucred {
 #define SOL_IPV6	41
 #define SOL_ICMPV6	58
 #define SOL_SCTP	132
+#define SOL_UDPLITE	136     /* UDP-Lite (RFC 3828) */
 #define SOL_RAW		255
 #define SOL_IPX		256
 #define SOL_AX25	257
diff -Nurp  a/include/linux/snmp.h b/include/linux/snmp.h
--- a/include/linux/snmp.h	2006-01-03 03:21:10.000000000 +0000
+++ b/include/linux/snmp.h	2006-06-29 18:02:43.000000000 +0100
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
+	UDPLITE_MIB_INDATAGRAMS,     /* total received datagramns             */
+	UDPLITE_MIB_IN_PARTIALCOV,   /* rcvd datagrams with partial coverage  */
+	UDPLITE_MIB_NOPORTS,	     /* rcvd datagrams to wrong ports         */
+	UDPLITE_MIB_INERRORS,	     /* total erroneous received datagrams    */
+	UDPLITE_MIB_IN_BAD_COV,	     /* checksum coverage errors              */
+	UDPLITE_MIB_IN_BAD_CSUM,     /* checksum itself did not qualify       */
+	UDPLITE_MIB_OUTDATAGRAMS,    /* total sent datagrams                  */
+	UDPLITE_MIB_OUT_PARTIALCOV,  /* sent datagrams with partial coverage  */
+	__UDPLITE_MIB_MAX
+};
+
 /* sctp mib definitions */
 /*
  * draft-ietf-sigtran-sctp-mib-07.txt
diff -Nurp  a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	2006-06-29 16:49:02.000000000 +0100
+++ b/include/linux/skbuff.h	2006-06-29 18:02:43.000000000 +0100
@@ -231,13 +231,14 @@ struct sk_buff {
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
+		struct udplitehdr *ulh;
+		struct icmphdr	  *icmph;
+		struct igmphdr	  *igmph;
+		struct iphdr	  *ipiph;
+		struct ipv6hdr	  *ipv6h;
+		unsigned char	  *raw;
 	} h;
 
 	union {
diff -Nurp  a/include/linux/in.h b/include/linux/in.h
--- a/include/linux/in.h	2006-06-19 08:45:25.000000000 +0100
+++ b/include/linux/in.h	2006-06-29 18:02:43.000000000 +0100
@@ -44,6 +44,7 @@ enum {
 
   IPPROTO_COMP   = 108,                /* Compression Header protocol */
   IPPROTO_SCTP   = 132,		/* Stream Control Transport Protocol	*/
+  IPPROTO_UDPLITE = 136,	/* UDP-Lite Protocol (RFC 3828)	        */
 
   IPPROTO_RAW	 = 255,		/* Raw IP packets			*/
   IPPROTO_MAX
diff -Nurp  a/include/linux/udplite.h b/include/linux/udplite.h
--- a/include/linux/udplite.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/udplite.h	2006-06-29 18:02:43.000000000 +0100
@@ -0,0 +1,96 @@
+/*
+ *              Header file for UDP Lite (RFC 3828).
+ *
+ * Version:	see net/ipv4/udplite.c
+ *
+ * Authors:	Gerrit Renker, <gerrit@erg.abdn.ac.uk>
+ *		William Stanislaus, <william@erg.abdn.ac.uk>
+ *
+ * Fixes:
+ * Changes:
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
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
+ *   @check:    checksum field          (as in UDP)
+ *
+ *   For the detailed semantics see RFC 3828.
+ */
+struct udplitehdr {
+	__u16 source;
+	__u16 dest;
+	__u16 checklen;
+	__u16 check;
+};
+
+/* UDP-Lite socket options */
+#define UDPLITE_SEND_CSCOV   10
+#define UDPLITE_RECV_CSCOV   11
+
+
+#ifdef __KERNEL__
+#include <linux/config.h>
+#include <net/sock.h>
+#include <linux/ip.h>
+
+/**
+ *   struct udplite_sock  -  unreliable, connection-less UDP-Lite service
+ *
+ *   @inet:       has to be the first member
+ *   @pending:    any pending frames?
+ *   @corkflag:   when cork is required
+ *   @encap_type: is this an encapsulation socket?
+ *   @len:        total  length of pending frames
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
+/* checksum coverage set indicators used by pcflag */
+#define UDPLITE_SEND_CC   0x1
+#define UDPLITE_RECV_CC   0x2
+	__u8              pcflag;
+};
+
+static inline struct udplite_sock *udplite_sk(const struct sock *sk)
+{
+	return (struct udplite_sock *)sk;
+}
+
+
+struct udplite6_sock {
+	struct udplite_sock  udpl;
+	/*
+	 * ipv6_pinfo has to be the last member of udplite6_sock,
+	 * see inet6_sk_generic.
+	 */
+	struct ipv6_pinfo    inet6;
+};
+#endif		/*  __KERNEL__      */
+
+#endif		/* _LINUX_UDPLITE_H */
diff -Nurp  a/include/net/udplite.h b/include/net/udplite.h
--- a/include/net/udplite.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/net/udplite.h	2006-06-29 18:02:43.000000000 +0100
@@ -0,0 +1,114 @@
+/*
+ *		Definitions for the UDP-Lite (RFC 3828) code.
+ *
+ * Version:	see net/ipv4/udplite.c
+ *
+ * Authors:	Gerrit Renker, <gerrit@erg.abdn.ac.uk>
+ *		William Stanislaus, <william@erg.abdn.ac.uk>
+ *
+ * Fixes:
+ * Changes:
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _UDPLITE_H
+#define _UDPLITE_H
+#include <linux/udplite.h>
+#include <net/udp.h>       	/* for UDP_HTABLE_SIZE and proc structures */
+/*
+ *      NOTE: In UDP-Lite the checksum MUST always be computed, hence there is
+ *      no UDPLITE_CSUM_DEFAULT and no UDPLITE_CSUM_NOXMIT here.
+ */
+
+extern struct proto udplite_prot;
+
+DECLARE_SNMP_STAT(struct udplite_mib, udplite_statistics);
+#define UDPLITE_INC_STATS(f)        SNMP_INC_STATS(udplite_statistics, f)
+#define UDPLITE_INC_STATS_BH(f)     SNMP_INC_STATS_BH(udplite_statistics, f)
+#define UDPLITE_INC_STATS_USER(f)   SNMP_INC_STATS_USER(udplite_statistics, f)
+
+
+/* ipv4/udplite.c: This needs to be shared by v4 and v6 because the lookup
+ *      	   and hashing code needs to work with different AF's yet
+ *            	   the port space is shared.
+ */
+extern struct hlist_head 	udplite_hash[UDP_HTABLE_SIZE];
+extern rwlock_t 		udplite_hash_lock;
+extern int 			udplite_port_rover;
+
+static inline int udplite_lport_inuse(u16 num)
+{
+	struct sock        *sk;
+	struct hlist_node  *node;
+
+	sk_for_each(sk, node, &udplite_hash[num & (UDP_HTABLE_SIZE - 1)])
+	    if (inet_sk(sk)->num == num)
+		return 1;
+	return 0;
+}
+
+/* 	net/ipv4/udplite.c 	*/
+extern unsigned int udplite_poll(struct file *file, struct socket *sock,
+				 poll_table * wait);
+extern int  	    udplite_rcv(struct sk_buff *skb);
+extern void	    udplite_err(struct sk_buff *, u32);
+extern int  	    udplite_disconnect(struct sock *sk, int flags);
+extern int  	    udplite_ioctl(struct sock *sk, int cmd, unsigned long arg);
+extern int  	    udplite_sendmsg(struct kiocb *iocb, struct sock *sk,
+				    struct msghdr *msg, size_t len);
+extern int          udplite_getfrag(void *from, char *to, int off, int len,
+			            int odd, struct sk_buff *skb);
+
+/**
+ *	struct udp_lite_skb  -  UDP-Lite private variables
+ *
+ *	@cscov:   checksum coverage length
+ *	@partial: flag, if set indicates partial csum coverage
+ *	@header:  private variables used by IPv4/v6 (thanks tcp.h!)
+ */
+struct udplite_skb_cb {
+	union {
+		struct inet_skb_parm	h4;
+#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+		struct inet6_skb_parm	h6;
+#endif
+	} header;
+	__u16		cscov;
+	__u8		partial;
+};
+#define UDPLITE_SKB_CB(skb)	((struct udplite_skb_cb *)&((skb)->cb))
+
+
+/*
+ * 	Calculate / check variable-length UDP-Lite checksum
+ */
+static inline u16  __udplite_checksum_complete(struct sk_buff *skb)
+{
+	if (! UDPLITE_SKB_CB(skb)->partial)
+		return __skb_checksum_complete(skb);
+
+	return  csum_fold(skb_checksum(skb, 0, UDPLITE_SKB_CB(skb)->cscov,
+			  skb->csum));
+}
+
+static inline u16  udplite_checksum_complete(struct sk_buff *skb)
+{
+	return skb->ip_summed != CHECKSUM_UNNECESSARY &&
+		__udplite_checksum_complete(skb);
+}
+
+
+
+/* /proc */
+#ifdef CONFIG_PROC_FS
+extern int  udplite_proc_register(struct udp_seq_afinfo *afinfo);
+extern void udplite_proc_unregister(struct udp_seq_afinfo *afinfo);
+
+extern int  udplite4_proc_init(void);
+extern void udplite4_proc_exit(void);
+#endif  /* CONFIG_PROC_FS */
+#endif	/* _UDPLITE_H */
