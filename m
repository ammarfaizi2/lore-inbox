Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVF1VpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVF1VpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVF1VoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:44:24 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:6840 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261668AbVF1VmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:42:06 -0400
Date: Tue, 28 Jun 2005 23:41:57 +0200
From: Michael Becker <michbec@t-online.de>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Michael Becker <michbec@t-online.de>
Organization: Privat
X-Priority: 3 (Normal)
Message-ID: <1267256797.20050628234157@t-online.de>
To: k8 s <uint32@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: IPSec Inbound Processing Basic Doubt
In-Reply-To: <699a19ea05062810087b79f12f@mail.gmail.com>
References: <699a19ea050623105516cd5eb8@mail.gmail.com>
 <506243806.20050627182416@t-online.de>
 <699a19ea05062810087b79f12f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ID: rAid+eZdgewNeEHoaPbEt2F493I8gMfxUbYg+apDZTtvm+1eu7oxsM
X-TOI-MSGID: 32e7b5d8-9a7f-40a3-9c88-cb99455d479a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ks> heard that IPSec is kept in a UDP packet and sent.  How does the tx
ks> side processing happen (the host from which the udp encapsulated ipsec
ks> packet originated). The last call in the stackable destination is
ks> ip_output() as you said.
ks> How does it go back to udp(transport) layer in this case.

It doesn't go back.

UDP encapsulation is done for ...

INPUT:
 - udp_rcv
     |
     --- udp_queue_rcv_skb
           |
           --- udp_encap_rcv (strips of udp)
           |
           --- xfrm4_rcv_encap (usual procedure)


OUTPUT:
  - Done in esp_output as part of a stacked destination
    (e.g. net/ipv4/esp4.c)
    NAT-Traversal does only make sense for ESP, as AH protocol
    authenticates ("hashes") whole IP header including
    IP src / dst address, so you can't manipulate afterwards
    like SNAT / DNAT would do.

    exerpt from  net/ipv4/esp4.c

  /* this is non-NULL only with UDP Encapsulation */
71         if (x->encap) {
72                 struct xfrm_encap_tmpl *encap = x->encap;
..                 ...
81
82                 switch (encap->encap_type) {
83                 default:
84                 case UDP_ENCAP_ESPINUDP:
..                         ....
87                 case UDP_ENCAP_ESPINUDP_NON_IKE:
..                         ....
91                         break;
92                 }
93 
94                 top_iph->protocol = IPPROTO_UDP;
95         } else
96                 top_iph->protocol = IPPROTO_ESP;


As you see input and output processing isn't symetric any way,
with or without UDP encapsulation (NAT-T)

Have a look at http://lxr.linux.no which helps a lot sorting out
different pathes in the code. It's a complete cross reference of
the latest and some previous kernels

Best regards
     Michael Becker

Hochschule Niederrhein - Krefeld, Germany

