Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbTIVPMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTIVPMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:12:03 -0400
Received: from cnxt09251.conexant.com ([198.62.9.251]:27633 "EHLO
	smtp1.urprovider.com") by vger.kernel.org with ESMTP
	id S262582AbTIVPL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:11:58 -0400
Subject: IPSEC-TUNNEL gives error messages: ip_finish_output: bad unowned skb = c5b619e0: PRE_ROUTING
 LOCAL_IN FORWARD POST_ROUTING 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF73D4154E.C6C4D37F-ONC1256DA9.005340B9@nice.mindspeed.com>
From: philippe.vivarelli@mindspeed.com
Date: Mon, 22 Sep 2003 17:11:41 +0200
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on SOPHIAM1/Server/Mindspeed(Release 5.0.12  |February
 13, 2003) at 09/22/2003 05:11:45 PM,
	Itemize by SMTP Server on NPBLNH1/Server/Conexant(Release 5.0.12  |February
 13, 2003) at 09/22/2003 08:11:45 AM,
	Serialize by Router on NPBLNH1/Server/Conexant(Release 5.0.12  |February 13, 2003) at
 09/22/2003 08:11:57 AM,
	Serialize complete at 09/22/2003 08:11:57 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does someone has already seen thes messages ?.

Distribution:Redhat 8.0 / kernel 2.6-test5
Hardware Environment:Pentium III / Intel eepro100 NIC
Software Environment:
Problem Description: IPSEC-TUNNEL Error messages in the system log and
tcpdump.

Steps to reproduce:

The network setup follow this scheme:

PC 1(192.168.33.2)<-->(192.168.33.1)PC VPN Gateway 1(192.168.31.66)<-->
(192.168.31.50) PC Router (192.168.32.50)<--->(192.168.32.67)PC VPN Gateway
2
(192.168.34.1)<-->(192.168.34.2)PC 2

Setting up a tunnel using ipsec-tools beetwen Gateway 1 and Gateway 2,
using
this setkey config file:
#!/usr/sbin/setkey -f

# Flush the SAD and SPD
flush;
spdflush;

# ESP SAs doing encryption using 192 bit long keys (168 + 24 parity)
# and authentication using 128 bit long keys
add 192.168.32.67 192.168.31.66 esp 0x201 -m tunnel -E 3des-cbc
0x7aeaca3f87d060a12f4a4487d5a5c3355920fae69a96c831 -A hmac-md5
0xc0291ff014dccdd03874d9e8e4cdf3e6;

add 192.168.31.66 192.168.32.67 esp 0x301 -m tunnel -E 3des-cbc
0xf6ddb555acfd9d77b03ea3843f2653255afe8eb5573965df -A hmac-md5
0x96358c90783bbfa3d7b196ceabe0536b;

# Security policies
spdadd 192.168.34.0/24 192.168.33.0/24 any -P in ipsec
           esp/tunnel/192.168.32.67-192.168.31.66/require;

spdadd 192.168.33.0/24 192.168.34.0/24 any -P out ipsec
           esp/tunnel/192.168.31.66-192.168.32.67/require;

When I ping 192.168.34.2 from 192.168.33.2 I get this messages
in /var/log/messages:

Sep 18 11:03:07 Linux8 kernel: PROTO=1 192.168.33.2:0 192.168.34.2:0 L=84
S=0x00 I=0 F=0x4000 T=63
Sep 18 11:03:07 Linux8 kernel: ip_finish_output: bad unowned skb =
c5b61c20:
PRE_ROUTING LOCAL_IN FORWARD POST_ROUTING
Sep 18 11:03:07 Linux8 kernel: skb: pf=2 (unowned) dev=eth1 len=84
Sep 18 11:03:07 Linux8 kernel: PROTO=1 192.168.33.2:0 192.168.34.2:0 L=84
S=0x00 I=0 F=0x4000 T=62
Sep 18 11:03:08 Linux8 kernel: nf_hook: hook 0 already set.
Sep 18 11:03:08 Linux8 kernel: skb: pf=2 (unowned) dev=eth0 len=84
Sep 18 11:03:08 Linux8 kernel: PROTO=1 192.168.33.2:0 192.168.34.2:0 L=84
S=0x00 I=0 F=0x4000 T=63
Sep 18 11:03:08 Linux8 kernel: ip_finish_output: bad unowned skb =
c5b619e0:
PRE_ROUTING LOCAL_IN FORWARD POST_ROUTING
Sep 18 11:03:08 Linux8 kernel: skb: pf=2 (unowned) dev=eth1 len=84
Sep 18 11:03:08 Linux8 kernel: PROTO=1 192.168.33.2:0 192.168.34.2:0 L=84
S=0x00 I=0 F=0x4000 T=62
Sep 18 11:03:09 Linux8 kernel: nf_hook: hook 0 already set.
Sep 18 11:03:09 Linux8 kernel: skb: pf=2 (unowned) dev=eth0 len=84

And tcpdump gives:
11:03:07.105055 192.168.31.66 > 192.168.32.67: ESP(spi=0x00000301,seq=0x6)
(DF)
11:03:07.105055 truncated-ip - 16 bytes missing!192.168.31.66 > 69.0.0.84:
truncated-ip - 16268 bytes missing!192.168.32.67 > 69.0.0.84: (frag
15876:16364@13040) [tos 0x10]  (ipip)
11:03:07.105519 192.168.32.67 > 192.168.31.66: ESP(spi=0x00000201,seq=0x6)
11:03:08.096943 192.168.31.66 > 192.168.32.67: ESP(spi=0x00000301,seq=0x7)
(DF)
11:03:08.096943 truncated-ip - 16 bytes missing!192.168.31.66 > 69.0.0.84:
truncated-ip - 16268 bytes missing!192.168.32.67 > 69.0.0.84: (frag
15876:16364@13040) [tos 0x10]  (ipip)


