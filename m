Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030719AbWI0Tpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030719AbWI0Tpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbWI0Tpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:45:39 -0400
Received: from mga06.intel.com ([134.134.136.21]:29707 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030719AbWI0Tpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:45:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,226,1157353200"; 
   d="scan'208"; a="137202688:sNHT25214987"
Message-ID: <451AE356.5050306@linux.intel.com>
Date: Wed, 27 Sep 2006 13:47:18 -0700
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060911 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len
 + 2 > left : info_element->len+2=28 left=9, id=221.
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>	 <a44ae5cd0609261756w1e82087p60c18ef941657466@mail.gmail.com> <a44ae5cd0609262305p1d0b9aaai9db324aff0b3ba0c@mail.gmail.com>
In-Reply-To: <a44ae5cd0609262305p1d0b9aaai9db324aff0b3ba0c@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------060505070202090304010306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060505070202090304010306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Miles Lane wrote:
> It occurs to me that these messages occured while I was connected to a
> public WIFI AP at the airport in Phoenix.  It may be that the network
> configuration or my distance from the AP had a part to play in the
> messages being triggered.  If so, I may have trouble reproducing the
> problem.  I'll be interested to hear from some of the IEEE80211
> developers on what these messages indicate.
> ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> info_element->len+2=28 left=9, id=221.
> ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> info_element->len+2=28 left=9, id=221.
> ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> info_element->len+2=28 left=9, id=221.

Without the actual full data frame it is difficult to determine the root
cause (faulty AP, wireless attack, or bug in ieee80211_rx.c).  If you
happen to find yourself in a situation where this occurs repeatedly, try
performing a packet capture w/ ethereal or similar to grab the packet.  
If ethereal can parse the frame correctly but you still see the message
from ieee80211, chances are its a bug in ieee80211_parse_info_param.

If you don't have ethereal, you can use the attached untested (beyond
build) patch against ieee80211_rx.c to dump the frame to the kernel log
(borrows the printk_buf function from ipw2200.c).   From that raw frame
dump we should be able to figure out if its a bug
ieee80211_parse_info_param or a bogus over the air packet.

James

--------------060505070202090304010306
Content-Type: text/x-patch;
 name="ieee80211-frame-dump.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ieee80211-frame-dump.patch"

[DEBUG] Add hex dump of Rx'd 802.11 frames if they fail the IE parse tests

This patch just adds a call to do a data hex dump to the kernel log of 
Rx'd data frames when parsing fails.  The code is (more or less) 
borrowed from ipw2200.c.

Signed-off-by: James Ketrenos <jketreno@linux.intel.com>

diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index 72d4d4e..ccde64b 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -1049,6 +1049,59 @@ static const char *get_info_element_stri
 }
 #endif
 
+
+static int snprint_line(char *buf, size_t count,
+			const u8 * data, u32 len, u32 ofs)
+{
+	int out, i, j, l;
+	char c;
+
+	out = snprintf(buf, count, "%08X", ofs);
+
+	for (l = 0, i = 0; i < 2; i++) {
+		out += snprintf(buf + out, count - out, " ");
+		for (j = 0; j < 8 && l < len; j++, l++)
+			out += snprintf(buf + out, count - out, "%02X ",
+					data[(i * 8 + j)]);
+		for (; j < 8; j++)
+			out += snprintf(buf + out, count - out, "   ");
+	}
+
+	out += snprintf(buf + out, count - out, " ");
+	for (l = 0, i = 0; i < 2; i++) {
+		out += snprintf(buf + out, count - out, " ");
+		for (j = 0; j < 8 && l < len; j++, l++) {
+			c = data[(i * 8 + j)];
+			if (!isascii(c) || !isprint(c))
+				c = '.';
+
+			out += snprintf(buf + out, count - out, "%c", c);
+		}
+
+		for (; j < 8; j++)
+			out += snprintf(buf + out, count - out, " ");
+	}
+
+	return out;
+}
+
+static void printk_buf(int level, const u8 * data, u32 len)
+{
+	char line[81];
+	u32 ofs = 0;
+	if (!(ieee80211_debug_level & level))
+		return;
+
+	while (len) {
+		snprint_line(line, sizeof(line), &data[ofs],
+			     min(len, 16U), ofs);
+		printk(KERN_DEBUG "%s\n", line);
+		ofs += 16;
+		len -= min(len, 16U);
+	}
+}
+
+
 static int ieee80211_parse_info_param(struct ieee80211_info_element
 				      *info_element, u16 length,
 				      struct ieee80211_network *network)
@@ -1304,9 +1357,12 @@ static int ieee80211_handle_assoc_resp(s
 	network->rsn_ie_len = 0;
 
 	if (ieee80211_parse_info_param
-	    (frame->info_element, stats->len - sizeof(*frame), network))
+	    (frame->info_element, stats->len - sizeof(*frame), network)) {
+		printk_buf(IEEE80211_DL_MGMT, (u8*)frame,
+			   stats->len);
 		return 1;
-
+	}
+	
 	network->mode = 0;
 	if (stats->freq == IEEE80211_52GHZ_BAND)
 		network->mode = IEEE_A;
@@ -1367,8 +1423,11 @@ static int ieee80211_network_init(struct
 	network->rsn_ie_len = 0;
 
 	if (ieee80211_parse_info_param
-	    (beacon->info_element, stats->len - sizeof(*beacon), network))
+	    (beacon->info_element, stats->len - sizeof(*beacon), network)) {
+		printk_buf(IEEE80211_DL_MGMT, (u8*)beacon,
+			   stats->len);
 		return 1;
+	}
 
 	network->mode = 0;
 	if (stats->freq == IEEE80211_52GHZ_BAND)

--------------060505070202090304010306--
