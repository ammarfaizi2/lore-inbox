Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTLLT4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTLLT4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:56:05 -0500
Received: from fairchild-196.adsl.newnet.co.uk ([213.131.187.196]:52626 "HELO
	pinus.navaho") by vger.kernel.org with SMTP id S261885AbTLLT4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:56:01 -0500
X-Sender-Local: 10.0.0.42
Date: Fri, 12 Dec 2003 19:55:55 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: steve@sorbus2.navaho
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ebtables-devel@lists.sourceforge.net>,
       <netfilter-devel@lists.netfilter.org>
Subject: memory leak related to bridging, conntrack and frags in 2.6.0
Message-ID: <Pine.LNX.4.44.0312121948321.8670-200000@sorbus2.navaho>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-863298270-1071258955=:8670"
X-Navaho-ID: 7e84510e
X-Domain-Forwarded-By: pinus.navaho
X-Navaho-Spam-Rating: 0.000000
X-Spam-Override: Local user [steve@navaho.co.uk]
X-Navaho-Spam: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-863298270-1071258955=:8670
Content-Type: TEXT/PLAIN; charset=US-ASCII


Sorry for the cross-post - I thought this would be of interest to all the 
lists and also wasn't sure where the best people to help hang out.

With both conntrack and bridging turned on in the 2.6.0test11 kernel, 
sending fragmented packets over the bridge reveals a memory leak 
(specifically, forwarding packets from any interface to a bridge).  The 
memory that is leaking seems to be being allocated on line 299 on 
net/bridge/br_netfilter.c:

        if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
                return NF_DROP;
  
Only the first fragment gets freed later on.

The patch attached fixes the problem by freeing nf_bridge when the 
packets are defragmented, however I am sure this is not the right place 
to do this.  Where would the skb's for the fragments usually get freed?

-- 

- Steve Hill
Senior Software Developer                        Email: steve@navaho.co.uk
Navaho Technologies Ltd.                           Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


--8323328-863298270-1071258955=:8670
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bridge-memleak.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0312121955550.8670@sorbus2.navaho>
Content-Description: 
Content-Disposition: attachment; filename="bridge-memleak.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNi4wLXRlc3QxMS52YW5pbGxhL25ldC9pcHY0
L2lwX2ZyYWdtZW50LmMgbGludXgtMi42LjAtdGVzdDExLmJyaWRnZS9uZXQv
aXB2NC9pcF9mcmFnbWVudC5jDQotLS0gbGludXgtMi42LjAtdGVzdDExLnZh
bmlsbGEvbmV0L2lwdjQvaXBfZnJhZ21lbnQuYwkyMDAzLTEyLTEyIDE5OjI3
OjA3LjAwMDAwMDAwMCArMDAwMA0KKysrIGxpbnV4LTIuNi4wLXRlc3QxMS5i
cmlkZ2UvbmV0L2lwdjQvaXBfZnJhZ21lbnQuYwkyMDAzLTEyLTEyIDE5OjQy
OjUwLjAwMDAwMDAwMCArMDAwMA0KQEAgLTU5Miw2ICs1OTIsMTIgQEANCiAJ
YXRvbWljX3N1YihoZWFkLT50cnVlc2l6ZSwgJmlwX2ZyYWdfbWVtKTsNCiAN
CiAJZm9yIChmcD1oZWFkLT5uZXh0OyBmcDsgZnAgPSBmcC0+bmV4dCkgew0K
KyNpZmRlZiBDT05GSUdfQlJJREdFX05FVEZJTFRFUg0KKwkJaWYgKGZwLT5u
Zl9icmlkZ2UpIHsNCisJCQluZl9icmlkZ2VfcHV0KGZwLT5uZl9icmlkZ2Up
Ow0KKwkJCWZwLT5uZl9icmlkZ2UgPSBOVUxMOw0KKwkJfTsNCisjZW5kaWYN
CiAJCWhlYWQtPmRhdGFfbGVuICs9IGZwLT5sZW47DQogCQloZWFkLT5sZW4g
Kz0gZnAtPmxlbjsNCiAJCWlmIChoZWFkLT5pcF9zdW1tZWQgIT0gZnAtPmlw
X3N1bW1lZCkNCg==
--8323328-863298270-1071258955=:8670--

