Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTKVUC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 15:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTKVUC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 15:02:28 -0500
Received: from pod.tau.ac.il ([132.66.10.227]:20379 "EHLO pod.tau.ac.il")
	by vger.kernel.org with ESMTP id S262746AbTKVUCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 15:02:22 -0500
Date: Sat, 22 Nov 2003 22:02:19 +0200 (IST)
From: Oded Comay <comay@pod.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Is PACKET_RX_RING broken in 2.6.0-test?
Message-ID: <Pine.LNX.4.44.0311222158400.9419-200000@pod.tau.ac.il>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1116005130-1830029625-1069531339=:9419"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1116005130-1830029625-1069531339=:9419
Content-Type: TEXT/PLAIN; charset=US-ASCII

The PACKET_RX_RING mechanism (enabled by CONFIG_PACKET_MMAP) appears to be 
somewhat broken in 2.6.0-test* (2.6 for short). There are 3 issues:

1. Performance in 2.6 is much lower than in 2.4. As an example, using the 
same hardware and under the same traffic load, the attached sample program 
could process 177K packets/sec in 2.4, but only 70K packets/sec in 2.6.

2. In 2.4 one could call bind() and setsockopt(PACKET_RX_RING) in any 
order.  In 2.6, when calling setsockopt() after calling bind(), no error 
is returned, but also no packet is delivered to the userspace ring.

3. The getsockopt(PACKET_STATISTICS) call returns 0 dropped packets, 
although some packets were apparently dropped. This is assumed since in 
the above test, and although some 100K packets/sec were not processed, the 
call returned no dropped packets.

Steps to reproduce:

The attached program, based on Gianni Tedesco's lincap.c, demonstrates the 
3 issues.

Usage: ./lincap -i device -b -a -p

-i device    device to sniff.
-b           bind before setsockopt.
-a           bind after setsockopt.
-p           print packets.

When invoked with -b (and -p) the program will not process packets under 
2.6, but works fine in 2.4. With -a it works in both 2.6 and 2.4.

The output of the program when run in 2.4.20 and 2.6.0-test4 under heavy 
traffic load is shown below. It shows the performance difference, as well 
as the fact that in 2.6 the packet per poll() ratio is 1, while it is 24 
in 2.4.20. It also shows that no dropped packets are reported in 2.6.

Things to note: The performance tests were run on a dual 2.8GHz Xeon, 
using an Intel e1000 NIC. The NIC drivers included in the corresponding 
kernels are very different.

Oded.
---------------------------- Sample Output ----------------------------
Linux b2 2.4.20-8smp #1 SMP Thu Mar 13 17:45:54 EST 2003 i686 i686 i386 
GNU/Linux
# time /tmp/lincap -b
Creating socket
binding to eth0
Calling setsockopt PACKET_RX_RING
Mmaping ring buffer
Polling for packets (without printing). ^C to quit
pps=177466 mbps=58 packets/poll=24.61
recieved 4054110 packets, dropped 307

real    0m22.846s
user    0m0.460s
sys     0m0.710s
CPU utilization: usr 2% sys 3%

Linux b2 2.6.0-0.test4.1.33smp #1 SMP Fri Sep 5 08:14:16 EDT 2003 i686 
i686 i386 GNU/Linux
[root@b2 root]# time /tmp/lincap -a
Creating socket
Calling setsockopt PACKET_RX_RING
binding to eth0
Mmaping ring buffer
Polling for packets (without printing). ^C to quit
pps=69410 mbps=23 packets/poll=1.00
recieved 1702432 packets, dropped 0

real    0m24.623s
user    0m1.856s
sys     0m6.232s
CPU utilization: usr 7.5% sys 25% 

--1116005130-1830029625-1069531339=:9419
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lincap.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0311222202190.9419@pod.tau.ac.il>
Content-Description: 
Content-Disposition: attachment; filename="lincap.c"

LyogQ29weXJpZ2h0IChjKSAyMDAyIEdpYW5uaSBUZWRlc2NvDQoqIFJlbGVh
c2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTCB2ZXJzaW9uIDIg
Ki8NCg0KI2lmbmRlZiBfX2xpbnV4X18NCiNlcnJvciAiQXJlIHlvdSBsb2Nv
PyBUaGlzIGlzIExpbnV4IG9ubHkhIg0KI2VuZGlmDQoNCiNpbmNsdWRlIDxz
dGRpby5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxp
Yi5oPg0KDQojZGVmaW5lIF9fVVNFX1hPUEVODQojaW5jbHVkZSA8c3lzL3Bv
bGwuaD4NCiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQojaW5jbHVkZSA8c3lz
L21tYW4uaD4NCiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCiNpbmNsdWRlIDxu
ZXQvaWYuaD4NCiNpbmNsdWRlIDxmZWF0dXJlcy5oPiAgICAvKiBmb3IgdGhl
IGdsaWJjIHZlcnNpb24gbnVtYmVyICovDQojaWYgX19HTElCQ19fID49IDIg
JiYgX19HTElCQ19NSU5PUiA+PSAxDQojaW5jbHVkZSA8bmV0cGFja2V0L3Bh
Y2tldC5oPg0KI2luY2x1ZGUgPG5ldC9ldGhlcm5ldC5oPiAgICAgLyogdGhl
IEwyIHByb3RvY29scyAqLw0KI2Vsc2UNCiNpbmNsdWRlIDxhc20vdHlwZXMu
aD4NCiNpbmNsdWRlIDxsaW51eC9pZl9wYWNrZXQuaD4NCiNpbmNsdWRlIDxs
aW51eC9pZl9ldGhlci5oPiAgIC8qIFRoZSBMMiBwcm90b2NvbHMgKi8NCiNl
bmRpZg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KI2luY2x1ZGUgPG5ldGluZXQv
aW4uaD4NCiNpbmNsdWRlIDxhc20vc3lzdGVtLmg+DQojaW5jbHVkZSA8c2ln
bmFsLmg+DQoNCmNoYXIgKm5hbWVzW109ew0KCSI8IiwgLyogaW5jb21pbmcg
Ki8NCgkiQiIsIC8qIGJyb2FkY2FzdCAqLw0KCSJNIiwgLyogbXVsdGljYXN0
ICovDQoJIlAiLCAvKiBwcm9taXNjICovDQoJIj4iLCAvKiBvdXRnb2luZyAq
Lw0KfTsNCg0KaW50IGZkPS0xOw0KY2hhciAqbWFwOw0Kc3RydWN0IHRwYWNr
ZXRfcmVxIHJlcTsNCnN0cnVjdCBpb3ZlYyAqcmluZzsNCg0KZG91YmxlIHBh
Y2tldHM9IDAsIHBvbGxzPSAxZS02LCBieXRlcz0gMDsNCnN0cnVjdCB0aW1l
dmFsIHR2MCwgdHYxOw0KDQp2b2lkIHNpZ3Byb2MoaW50IHNpZykNCnsNCglz
dHJ1Y3QgdHBhY2tldF9zdGF0cyBzdDsNCglpbnQgbGVuPXNpemVvZihzdCk7
DQogICAgICAgIGRvdWJsZSBkdDsNCg0KICAgICAgICBnZXR0aW1lb2ZkYXko
JnR2MSwgTlVMTCk7DQogICAgICAgIGR0PSB0djEudHZfc2VjICsgdHYxLnR2
X3VzZWMqMWUtNi0NCiAgICAgICAgICAgKHR2MC50dl9zZWMgKyB0djAudHZf
dXNlYyoxZS02KTsNCiAgICAgICAgcHJpbnRmKCJwcHM9JS4wZiBtYnBzPSUu
MGYgcGFja2V0cy9wb2xsPSUuMmZcbiIsIA0KICAgICAgICAgICAgcGFja2V0
cy9kdCwgYnl0ZXMqOC9kdC8xZTYsIHBhY2tldHMvcG9sbHMpOw0KDQoJaWYg
KCFnZXRzb2Nrb3B0KGZkLFNPTF9QQUNLRVQsUEFDS0VUX1NUQVRJU1RJQ1Ms
KGNoYXIgKikmc3QsJmxlbikpIHsNCgkJZnByaW50ZihzdGRlcnIsICJyZWNp
ZXZlZCAldSBwYWNrZXRzLCBkcm9wcGVkICV1XG4iLA0KCQkJc3QudHBfcGFj
a2V0cywgc3QudHBfZHJvcHMpOw0KCX0NCgkNCglpZiAoIG1hcCApIG11bm1h
cChtYXAsIHJlcS50cF9ibG9ja19zaXplICogcmVxLnRwX2Jsb2NrX25yKTsN
CglpZiAoIGZkPj0wICkgY2xvc2UoZmQpOw0KCWlmICggcmluZyApIGZyZWUo
cmluZyk7DQoNCglleGl0KDApOw0KfQ0KDQpzdGF0aWMgaW50IGJpbmRfZGV2
KGludCBmZCwgY2hhciAqZGV2aWNlKQ0Kew0KCXN0cnVjdCBzb2NrYWRkcl9s
bCBhZGRyOw0KCXN0cnVjdCBpZnJlcQlpZnI7DQoNCglwcmludGYoIkJpbmRp
bmcgdG8gJXNcbiIsIGRldmljZSk7DQoJbWVtc2V0KCZpZnIsIDAsIHNpemVv
ZihpZnIpKTsNCglzdHJuY3B5KGlmci5pZnJfbmFtZSwgZGV2aWNlLCBzaXpl
b2YoaWZyLmlmcl9uYW1lKSk7DQoNCglpZiAoaW9jdGwoZmQsIFNJT0NHSUZJ
TkRFWCwgJmlmcikgPT0gLTEpIHsNCgkJbXVubWFwKG1hcCwgcmVxLnRwX2Js
b2NrX3NpemUgKiByZXEudHBfYmxvY2tfbnIpOw0KCQlwZXJyb3IoImlvY3Rs
KFNJT0NHSUZJTkRFWCkiKTsNCgkJcmV0dXJuIC0xOw0KCX0NCg0KCS8qIGJp
bmQgdGhlIHBhY2tldCBzb2NrZXQgKi8NCgltZW1zZXQoJmFkZHIsIDAsIHNp
emVvZihhZGRyKSk7DQoJYWRkci5zbGxfZmFtaWx5PUFGX1BBQ0tFVDsNCglh
ZGRyLnNsbF9wcm90b2NvbD1odG9ucygweDAzKTsNCglhZGRyLnNsbF9pZmlu
ZGV4PWlmci5pZnJfaWZpbmRleDsNCglhZGRyLnNsbF9oYXR5cGU9MDsNCglh
ZGRyLnNsbF9wa3R0eXBlPTA7DQoJYWRkci5zbGxfaGFsZW49MDsNCglpZiAo
IGJpbmQoZmQsIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFk
ZHIpKSApIHsNCgkJcGVycm9yKCJiaW5kKCkiKTsNCgkJcmV0dXJuIC0xOw0K
CX0NCn0NCgkNCnN0YXRpYyB2b2lkIHVzYWdlKGNoYXIgKm15bmFtZSkNCnsN
CglmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiAlcyAtaSBkZXZpY2UgLWIgLWEg
LXBcblxuIiwgbXluYW1lKTsNCglmcHJpbnRmKHN0ZGVyciwgIi1pIGRldmlj
ZSAgICBkZXZpY2UgdG8gc25pZmYuXG4iKTsNCglmcHJpbnRmKHN0ZGVyciwg
Ii1iICAgICAgICAgICBiaW5kIGJlZm9yZSBzZXRzb2Nrb3B0LlxuIik7DQoJ
ZnByaW50ZihzdGRlcnIsICItYSAgICAgICAgICAgYmluZCBhZnRlciBzZXRz
b2Nrb3B0LlxuIik7DQoJZnByaW50ZihzdGRlcnIsICItcCAgICAgICAgICAg
cHJpbnQgcGFja2V0cy5cbiIpOw0KfQ0KDQppbnQgbWFpbiAoIGludCBhcmdj
LCBjaGFyICoqYXJndiApIA0Kew0KCXN0cnVjdCBwb2xsZmQgcGZkOw0KCWlu
dCBpOw0KCWNoYXIgb3B0Ow0KICAgICAgICBjaGFyICpkZXZpY2U9IE5VTEw7
DQogICAgICAgIGludCBiZWZvcmU9IDAsIGFmdGVyPSAwLCBwcmludD0gMDsN
CgkNCgl3aGlsZSAoKG9wdD0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJpOmJhcCIp
KSAhPSBFT0YpIHsNCgkJc3dpdGNoIChvcHQpIHsNCgkJCWNhc2UgJ2knOiBk
ZXZpY2U9IG9wdGFyZzsNCgkJCQlicmVhazsNCgkJCWNhc2UgJ2InOiBiZWZv
cmU9IDE7DQoJCQkJYnJlYWs7DQoJCQljYXNlICdhJzogYWZ0ZXI9IDE7DQoJ
CQkJYnJlYWs7DQoJCQljYXNlICdwJzogcHJpbnQ9IDE7DQoJCQkJYnJlYWs7
DQoJCQlkZWZhdWx0Og0KCQkJCXVzYWdlKGFyZ3ZbMF0pOw0KCQkJCWV4aXQo
MSk7DQoJCX0NCgl9DQoJaWYgKG9wdGluZCA8IGFyZ2MpDQoJCXVzYWdlKGFy
Z3ZbMF0pOw0KCWlmIChkZXZpY2UgPT0gTlVMTCkNCgkJZGV2aWNlPSAiZXRo
MCI7DQoNCglzaWduYWwoU0lHSU5ULCBzaWdwcm9jKTsNCg0KCS8qIE9wZW4g
dGhlIHBhY2tldCBzb2NrZXQgKi8NCglwcmludGYoIkNyZWF0aW5nIHNvY2tl
dFxuIik7DQoJaWYgKCAoZmQ9c29ja2V0KFBGX1BBQ0tFVCwgU09DS19ER1JB
TSwgMCkpPDAgKSB7DQoJCXBlcnJvcigic29ja2V0KCkiKTsNCgkJcmV0dXJu
IDE7DQoJfQ0KDQogICAgICAgIGlmIChiZWZvcmUgJiYgYmluZF9kZXYoZmQs
IGRldmljZSkgPCAwKSB7DQogICAgICAgICAgICAgICAgcmV0dXJuIDE7DQog
ICAgICAgIH0NCg0KCS8qIFNldHVwIHRoZSBmZCBmb3IgbW1hcCgpIHJpbmcg
YnVmZmVyICovDQoJcHJpbnRmKCJDYWxsaW5nIHNldHNvY2tvcHQgUEFDS0VU
X1JYX1JJTkdcbiIpOw0KCXJlcS50cF9ibG9ja19zaXplPTQwOTY7DQoJcmVx
LnRwX2ZyYW1lX3NpemU9MTAyNDsNCglyZXEudHBfYmxvY2tfbnI9NjQ7DQoJ
cmVxLnRwX2ZyYW1lX25yPTQqNjQ7DQoJaWYgKCAoc2V0c29ja29wdChmZCwN
CgkJU09MX1BBQ0tFVCwNCgkJUEFDS0VUX1JYX1JJTkcsDQoJCShjaGFyICop
JnJlcSwNCgkJc2l6ZW9mKHJlcSkpKSAhPSAwICkgew0KCQlwZXJyb3IoInNl
dHNvY2tvcHQoKSIpOw0KCQljbG9zZShmZCk7DQoJCXJldHVybiAxOw0KCX07
DQoNCiAgICAgICAgaWYgKGFmdGVyICYmIGJpbmRfZGV2KGZkLCBkZXZpY2Up
IDwgMCkgew0KLy8JCW11bm1hcChtYXAsIHJlcS50cF9ibG9ja19zaXplICog
cmVxLnRwX2Jsb2NrX25yKTsNCgkJcmV0dXJuIDE7DQogICAgICAgIH0NCg0K
CS8qIG1tYXAoKSB0aGUgc3Vja2VyICovDQoJcHJpbnRmKCJNbWFwaW5nIHJp
bmcgYnVmZmVyXG4iKTsNCgltYXA9bW1hcChOVUxMLA0KCQlyZXEudHBfYmxv
Y2tfc2l6ZSAqIHJlcS50cF9ibG9ja19uciwNCgkJUFJPVF9SRUFEfFBST1Rf
V1JJVEV8UFJPVF9FWEVDLCBNQVBfU0hBUkVELCBmZCwgMCk7DQoJaWYgKCBt
YXA9PU1BUF9GQUlMRUQgKSB7DQoJCXBlcnJvcigibW1hcCgpIik7DQoJCWNs
b3NlKGZkKTsNCgkJcmV0dXJuIDE7DQoJfQ0KDQoJLyogU2V0dXAgb3VyIHJp
bmdidWZmZXIgKi8NCglyaW5nPW1hbGxvYyhyZXEudHBfZnJhbWVfbnIgKiBz
aXplb2Yoc3RydWN0IGlvdmVjKSk7DQoJZm9yKGk9MDsgaTxyZXEudHBfZnJh
bWVfbnI7IGkrKykgew0KCQlyaW5nW2ldLmlvdl9iYXNlPSh2b2lkICopKChs
b25nKW1hcCkrKGkqcmVxLnRwX2ZyYW1lX3NpemUpOw0KCQlyaW5nW2ldLmlv
dl9sZW49cmVxLnRwX2ZyYW1lX3NpemU7DQoJfQ0KCQ0KICAgICAgICBnZXR0
aW1lb2ZkYXkoJnR2MCwgTlVMTCk7DQoJcHJpbnRmKCJQb2xsaW5nIGZvciBw
YWNrZXRzICVzIHByaW50aW5nLiBeQyB0byBxdWl0XG4iLCANCgkJcHJpbnQg
PyAiYW5kIiA6ICJ3aXRob3V0Iik7DQoJZm9yKGk9MDs7KSB7DQoJCXdoaWxl
KCoodW5zaWduZWQgbG9uZyopcmluZ1tpXS5pb3ZfYmFzZSkgew0KCQkJc3Ry
dWN0IHRwYWNrZXRfaGRyICpoPXJpbmdbaV0uaW92X2Jhc2U7DQoJCQlzdHJ1
Y3Qgc29ja2FkZHJfbGwgKnNsbD0odm9pZCAqKWggKyBUUEFDS0VUX0FMSUdO
KHNpemVvZigqaCkpOw0KCQkJdW5zaWduZWQgY2hhciAqYnA9KHVuc2lnbmVk
IGNoYXIgKiloICsgaC0+dHBfbWFjOw0KDQoJCQlwYWNrZXRzKys7DQoJCQli
eXRlcys9IGgtPnRwX2xlbjsNCgkJCWlmIChwcmludCkgew0KCQkJCXByaW50
ZigiJXUuJS42dTogaWYldSAlcyAldSBieXRlc1xuIiwNCgkJCQkJaC0+dHBf
c2VjLCBoLT50cF91c2VjLA0KCQkJCQlzbGwtPnNsbF9pZmluZGV4LA0KCQkJ
CQluYW1lc1tzbGwtPnNsbF9wa3R0eXBlXSwNCgkJCQkJaC0+dHBfbGVuKTsN
CgkJCX0NCg0KCQkJLyogdGVsbCB0aGUga2VybmVsIHRoaXMgcGFja2V0IGlz
IGRvbmUgd2l0aCAqLw0KCQkJaC0+dHBfc3RhdHVzPTA7DQoJCQltYigpOyAv
KiBtZW1vcnkgYmFycmllciAqLw0KCQkJDQoJCQlpPShpPT1yZXEudHBfZnJh
bWVfbnItMSkgPyAwIDogaSsxOw0KCQl9DQoNCgkJLyogU2xlZXAgd2hlbiBu
b3RoaW5ncyBoYXBwZW5pbmcgKi8NCgkJcGZkLmZkPWZkOw0KCQlwZmQuZXZl
bnRzPVBPTExJTnxQT0xMRVJSOw0KCQlwZmQucmV2ZW50cz0wOw0KCQlwb2xs
KCZwZmQsIDEsIC0xKTsNCiAgICAgICAgICAgICAgICBwb2xscysrOw0KCX0N
CgkNCglyZXR1cm4gMDsNCn0NCg==
--1116005130-1830029625-1069531339=:9419--
