Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268562AbRG3Mhz>; Mon, 30 Jul 2001 08:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRG3Mhp>; Mon, 30 Jul 2001 08:37:45 -0400
Received: from [62.116.8.197] ([62.116.8.197]:10624 "HELO
	ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S268562AbRG3Mhm>; Mon, 30 Jul 2001 08:37:42 -0400
Date: Mon, 30 Jul 2001 14:13:59 +0200
From: clemens <therapy@endorphin.org>
To: netdev@oss.sgi.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: final words on udp/ICMP dest unreach issue [+PATCH]
Message-ID: <20010730141359.A450@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi!

concerning the bug discussed in the "missing icmp errors for udp
packets"-thread on netdev a solution has been found.

here comes the bug (see net/ipv4/icmp.c): 

#define XRLIM_BURST_FACTOR 6
int xrlim_allow(struct dst_entry *dst, int timeout)
{
 	unsigned long now;

  	now = jiffies;
  	dst->rate_tokens += now - dst->rate_last;
  	dst->rate_last = now;
#1:  	if (dst->rate_tokens > XRLIM_BURST_FACTOR*timeout)    
#2:  		dst->rate_tokens = XRLIM_BURST_FACTOR*timeout;
#3:  	if (dst->rate_tokens >= timeout) {
   		dst->rate_tokens -= timeout;
                return 1;   
        }
 	return 0;
}

for timeout=0 rate_tokens will be reset to 0 tokens (#2), since #1 always
holds.
(icmp ping does have timeout=0, for instance)
this doesn't cause the packet to be filtered, since in #2
holds, but will cause the following packet to be filtered, if sent
before (now - dst->rate_last) < timeout.
(note: timeout is not 0 in this inequation, since it's the 
timeout of the icmp type of the following packet)

a patch is attached.

thanks to all contributors, especially pekka savola, for discovering
that pinging before udp scanning will cause the troubles, and alexey 
for suppling an alternative patch (for those intrested:
http://therapy.endorphin.org/alexey.patch)

alan, please take care of that. 

greets, clemens

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="icmp-xrlim_allow.patch"

--- linux/net/ipv4/icmp.c~	Thu Jun 21 06:00:55 2001
+++ linux/net/ipv4/icmp.c	Mon Jul 30 13:32:56 2001
@@ -16,6 +16,9 @@
  *	Other than that this module is a complete rewrite.
  *
  *	Fixes:
+ *	Clemens Fruhwirth	:	Fix incorrect limiting in xrlim_allow
+ *					for a packet succedding a packet with 
+ *					timeout==0.
  *		Mike Shaver	:	RFC1122 checks.
  *		Alan Cox	:	Multicast ping reply as self.
  *		Alan Cox	:	Fix atomicity lockup in ip_build_xmit 
@@ -223,11 +226,6 @@
  *	Note that the same dst_entry fields are modified by functions in 
  *	route.c too, but these work for packet destinations while xrlim_allow
  *	works for icmp destinations. This means the rate limiting information
- *	for one "ip object" is shared.
- *
- *	Note that the same dst_entry fields are modified by functions in 
- *	route.c too, but these work for packet destinations while xrlim_allow
- *	works for icmp destinations. This means the rate limiting information
  *	for one "ip object" is shared - and these ICMPs are twice limited:
  *	by source and by destination.
  *
@@ -241,9 +239,12 @@
 {
 	unsigned long now;
 
+	if (0 == timeout) return 1;
+
 	now = jiffies;
 	dst->rate_tokens += now - dst->rate_last;
 	dst->rate_last = now;
+
 	if (dst->rate_tokens > XRLIM_BURST_FACTOR*timeout)
 		dst->rate_tokens = XRLIM_BURST_FACTOR*timeout;
 	if (dst->rate_tokens >= timeout) {

--lrZ03NoBR/3+SXJZ--
