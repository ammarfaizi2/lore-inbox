Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSFQU3Q>; Mon, 17 Jun 2002 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSFQU22>; Mon, 17 Jun 2002 16:28:28 -0400
Received: from pc1-camb4-0-cust108.cam.cable.ntl.com ([62.253.133.108]:17284
	"EHLO lain.perlfu.co.uk") by vger.kernel.org with ESMTP
	id <S316982AbSFQU01>; Mon, 17 Jun 2002 16:26:27 -0400
Date: Mon, 17 Jun 2002 21:26:23 +0100 (BST)
From: Carl Ritson <critson@perlfu.co.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: [PATCH][2.5.22] OOPS in tcp_v6_get_port
Message-ID: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809535-1287385206-1024317093=:2496"
Content-ID: <Pine.LNX.4.44.0206172122300.3724@lain.perlfu.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463809535-1287385206-1024317093=:2496
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0206172122301.3724@lain.perlfu.co.uk>


Sorry for the repeat email but this bug is also in 2.5.22 and my patch is still
valid, although I'm not entirely sure it is the correct fix for the problem?

-- From Previous email --
2.5.21 and 2.5.22 OOPS at boot on my test machine, the decoded OOPS is attached.
Also attached is a program that triggers the bug, it emulates the behavior 
of bind on my test machine and binds to two ports one IPv4 and one IPv6 
with the same port number but different IP addresses.

The bug appears to be the IPv6 TCP code, in net/ipv6/tcp_ipv6.c
Line 149:
	struct ipv6_pinfo *np2 = inet6_sk(sk2);

	if (sk != sk2 &&
	    sk->bound_dev_if == sk2->bound_dev_if) {
		if (!sk_reuse	||
		    !sk2->reuse	||
		    sk2->state == TCP_LISTEN) {
			/* NOTE: IPv6 tw bucket have different format */
			if (!inet_sk(sk2)->rcv_saddr ||
			    addr_type == IPV6_ADDR_ANY ||
			    !ipv6_addr_cmp(&np->rcv_saddr,
			    		sk2->state != TCP_TIME_WAIT ?
BUG -->					&np2->rcv_saddr :
					&((struct tcp_tw_bucket*)sk)->v6_rcv_saddr) ||
			    (addr_type==IPV6_ADDR_MAPPED && sk2->family==AF_INET &&
			     inet_sk(sk)->rcv_saddr ==
			     inet_sk(sk2)->rcv_saddr))
				break;
			}
		}
	}

np2 can be NULL if the socket is an IPv4 socket, since IPv6 and IPv4 
share the port address space.  While the test of !inet_sk(sk2-)->rcv_addr 
_should_ prevent this it is not assured in C that the conditions to an if 
statement will be evaluated in the order written?  At least my gcc 
(2.95.4 from compiled from CVS) doesn't think so :-).

I propose a diff similar to the one below to fix the problem maybe?

Many thanks,
Carl Ritson
critson@perlfu.co.uk

--- orig/net/ipv6/tcp_ipv6.c	Sat Jun 15 19:23:44 2002
+++ linux/net/ipv6/tcp_ipv6.c	Sat Jun 15 19:21:46 2002
@@ -156,14 +156,16 @@
 						/* NOTE: IPv6 tw bucket have different format */
 						if (!inet_sk(sk2)->rcv_saddr ||
 						    addr_type == IPV6_ADDR_ANY ||
-						    !ipv6_addr_cmp(&np->rcv_saddr,
-								   sk2->state != TCP_TIME_WAIT ?
-								   &np2->rcv_saddr :
-								   &((struct tcp_tw_bucket*)sk)->v6_rcv_saddr) ||
 						    (addr_type==IPV6_ADDR_MAPPED && sk2->family==AF_INET &&
 						     inet_sk(sk)->rcv_saddr ==
 						     inet_sk(sk2)->rcv_saddr))
 							break;
+						if (np2 != NULL) 
+							if (!ipv6_addr_cmp(&np->rcv_saddr,
+								   sk2->state != TCP_TIME_WAIT ?
+								   &np2->rcv_saddr :
+								   &((struct tcp_tw_bucket*)sk)->v6_rcv_saddr))
+								break;
 					}
 				}
 			}


---1463809535-1287385206-1024317093=:2496
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=decoded-oops
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0206171331330.2496@lain.perlfu.co.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=decoded-oops

a3N5bW9vcHMgMi40LjQgb24gaTY4NiAyLjQuMTktcHJlOC1hYzIuICBPcHRp
b25zIHVzZWQNCiAgICAgLXYgL3Vzci9zcmMvbGludXgtMi41LjIxL3ZtbGlu
dXggKHNwZWNpZmllZCkNCiAgICAgLUsgKHNwZWNpZmllZCkNCiAgICAgLUwg
KHNwZWNpZmllZCkNCiAgICAgLW8gL2xpYi9tb2R1bGVzLzIuNS4yMS8gKHNw
ZWNpZmllZCkNCiAgICAgLW0gL2Jvb3QvU3lzdGVtLm1hcC0yLjUuMjEgKHNw
ZWNpZmllZCkNCg0KTm8gbW9kdWxlcyBpbiBrc3ltcywgc2tpcHBpbmcgb2Jq
ZWN0cw0KVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAxMA0KYzAyNzI0
NGUNCipwZGUgPSAwMDAwMDAwMA0KT29wczogMDAwMA0KQ1BVOiAgICAwDQpF
SVA6ICAgIDAwMTA6WzxjMDI3MjQ0ZT5dICBOb3QgdGFpbnRlZA0KVXNpbmcg
ZGVmYXVsdHMgZnJvbSBrc3ltb29wcyAtdCBlbGYzMi1pMzg2IC1hIGkzODYN
CkVGTEFHUzogMDAwMTAyNDYNCmVheDogY2ZkNjhiMjggICBlYng6IGNlYTYw
MzYwICAgICBlY3g6IDAwMDAwMDEwICAgICAgIGVkeDogY2ZkNjhhMGENCmVz
aTogY2ZkNjhkZTggICBlZGk6IDAwMDAwMDEwICAgICBlYnA6IGNmOWNmMjYw
ICAgICAgIGVzcDogY2U4YTdlOTgNCmRzOiAwMDE4ICAgZXM6IDAwMTggICBz
czogMDAxOA0KU3RhY2s6ICBjZThhN2YxYyBjZmQ2OGFjMCBjZmQ2OGRlOCBj
MDM0MTkwOCBjZmQ2OGRlOCAwMTAwMDA3ZiAwMDAwMDAxMSAwMDAwMDAwMQ0K
ICAgICAgICBjZmQ2OGFjMCBjZmQyMWRjOCAwM2I5Mzg3NCBjMDI2MGY4MSBj
ZmQ2OGFjMCAwMDAwMDNiOSBjZThhN2E0MCBjZThhN2YxNA0KICAgICAgICAw
MDAwMDAxYyA0MDI2Mzg3NCAwMDAwMDAxMSAwM2I5MTljOCAwNjAwMDA3ZiBj
ZmQ2OGRkOCBjZmQ2OGJmOCBjMDIyMjdjMA0KQ2FsbCBUcmFjZTogWzxjMDI2
MGY4MT5dIFs8YzAyMjI3YzA+XSBbYzAyMjM2Mjk+XSBbPGMwMjIxY2Y1Pl0g
WzxjMDIyMmQyZT5dDQogICBbPGMwMjIyZDUwPl0gWzxjMDIyMzJhMD5dIFs8
YzAxMDZhMTc+XQ0KQ29kZTogZjMgYTYgNzQgMmMgODEgN2MgMjQgMTggMDAg
MTAgMDAgMDAgNzUgMTcgNjYgODMgN2IgMWMgMDIgNzUNCg0KPj5FSVA7IGMw
MjcyNDRlIDx0Y3BfdjZfZ2V0X3BvcnQrMWFlLzJkND4gICA8PT09PT0NClRy
YWNlOyBjMDI2MGY4MSA8aW5ldDZfYmluZCsyYjEvM2Q4Pg0KVHJhY2U7IGMw
MjIyN2MwIDxzeXNfYmluZCs1NC83ND4NClRyYWNlOyBjMDIyMmQ1MCA8c3lz
X3NldHNvY2tvcHQrNmMvNzg+DQpUcmFjZTsgYzAyMjMyYTAgPHN5c19zb2Nr
ZXRjYWxsKzc0LzFmYz4NClRyYWNlOyBjMDEwNmExNyA8c3lzY2FsbF9jYWxs
KzcvYj4NCkNvZGU7ICBjMDI3MjQ0ZSA8dGNwX3Y2X2dldF9wb3J0KzFhZS8y
ZDQ+DQowMDAwMDAwMCA8X0VJUD46DQpDb2RlOyAgYzAyNzI0NGUgPHRjcF92
Nl9nZXRfcG9ydCsxYWUvMmQ0PiAgIDw9PT09PQ0KICAgMDogICBmMyBhNiAg
ICAgICAgICAgICAgICAgICAgIHJlcHogY21wc2IgJWVzOiglZWRpKSwlZHM6
KCVlc2kpICAgPD09PT09DQpDb2RlOyAgYzAyNzI0NTAgPHRjcF92Nl9nZXRf
cG9ydCsxYjAvMmQ0Pg0KICAgMjogICA3NCAyYyAgICAgICAgICAgICAgICAg
ICAgIGplICAgICAzMCA8X0VJUCsweDMwPiBjMDI3MjQ3ZSA8dGNwX3Y2X2dl
dF9wb3J0KzFkZS8yZDQ+DQpDb2RlOyAgYzAyNzI0NTIgPHRjcF92Nl9nZXRf
cG9ydCsxYjIvMmQ0Pg0KICAgNDogICA4MSA3YyAyNCAxOCAwMCAxMCAwMCAg
ICAgIGNtcGwgICAkMHgxMDAwLDB4MTgoJWVzcCwxKQ0KQ29kZTsgIGMwMjcy
NDU5IDx0Y3BfdjZfZ2V0X3BvcnQrMWI5LzJkND4NCiAgIGI6ICAgMDAgDQpD
b2RlOyAgYzAyNzI0NWEgPHRjcF92Nl9nZXRfcG9ydCsxYmEvMmQ0Pg0KICAg
YzogICA3NSAxNyAgICAgICAgICAgICAgICAgICAgIGpuZSAgICAyNSA8X0VJ
UCsweDI1PiBjMDI3MjQ3MyA8dGNwX3Y2X2dldF9wb3J0KzFkMy8yZDQ+DQpD
b2RlOyAgYzAyNzI0NWMgPHRjcF92Nl9nZXRfcG9ydCsxYmMvMmQ0Pg0KICAg
ZTogICA2NiA4MyA3YiAxYyAwMiAgICAgICAgICAgIGNtcHcgICAkMHgyLDB4
MWMoJWVieCkNCkNvZGU7ICBjMDI3MjQ2MSA8dGNwX3Y2X2dldF9wb3J0KzFj
MS8yZDQ+DQogIDEzOiAgIDc1IDAwICAgICAgICAgICAgICAgICAgICAgam5l
ICAgIDE1IDxfRUlQKzB4MTU+IGMwMjcyNDYzIDx0Y3BfdjZfZ2V0X3BvcnQr
MWMzLzJkND4NCg0K
---1463809535-1287385206-1024317093=:2496
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ipv6-bind.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0206171331331.2496@lain.perlfu.co.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ipv6-bind.c"

I2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5j
bHVkZSA8c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8c3lzL3NvY2tldC5oPg0K
I2luY2x1ZGUgPG5ldGluZXQvaW4uaD4NCiNpbmNsdWRlIDxhcnBhL2luZXQu
aD4NCg0KY29uc3QgdW5zaWduZWQgc2hvcnQgYmluZF9wb3J0ID0gNDUwMDsN
Cg0KaW50IGRvX2lwdjRfYmluZChjaGFyICppcCwgY29uc3QgdW5zaWduZWQg
c2hvcnQgcG9ydCkgew0KCXN0cnVjdCBzb2NrYWRkcl9pbiBhZGRyOw0KCWlu
dCBzb2NrOw0KCWludCByZXQ7DQoJDQoJbWVtc2V0KCZhZGRyLCAweDAwLCBz
aXplb2YoYWRkcikpOw0KCWFkZHIuc2luX2ZhbWlseSA9IEFGX0lORVQ7DQoJ
YWRkci5zaW5fcG9ydCA9IGh0b25zKHBvcnQpOw0KCWluZXRfcHRvbihBRl9J
TkVULCBpcCwgJihhZGRyLnNpbl9hZGRyKSk7DQoJDQoJcmV0ID0gc29ja2V0
KFBGX0lORVQsIFNPQ0tfU1RSRUFNLCAwKTsNCglpZihyZXQgPT0gLTEpIHsN
CgkJcmV0dXJuIHJldDsNCgl9IGVsc2Ugew0KCQlzb2NrID0gcmV0Ow0KCX0N
CglyZXQgPSBiaW5kKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwg
c2l6ZW9mKGFkZHIpKTsNCglpZihyZXQgPT0gLTEpIHsNCgkJcmV0dXJuIHJl
dDsNCgl9IGVsc2Ugew0KCQlyZXR1cm4gc29jazsNCgl9DQp9DQoNCmludCBk
b19pcHY2X2JpbmQoY2hhciAqaXAsIGNvbnN0IHVuc2lnbmVkIHNob3J0IHBv
cnQpIHsNCglzdHJ1Y3Qgc29ja2FkZHJfaW42IGFkZHI7DQoJaW50IHNvY2s7
DQoJaW50IHJldDsNCgkNCgltZW1zZXQoJmFkZHIsIDB4MDAsIHNpemVvZihh
ZGRyKSk7DQoJYWRkci5zaW42X2ZhbWlseSA9IEFGX0lORVQ2Ow0KCWFkZHIu
c2luNl9wb3J0ID0gaHRvbnMocG9ydCk7DQoJaW5ldF9wdG9uKEFGX0lORVQ2
LCBpcCwgJihhZGRyLnNpbjZfYWRkcikpOw0KCQ0KCXJldCA9IHNvY2tldChQ
Rl9JTkVUNiwgU09DS19TVFJFQU0sIDApOw0KCWlmKHJldCA9PSAtMSkgew0K
CQlyZXR1cm4gcmV0Ow0KCX0gZWxzZSB7DQoJCXNvY2sgPSByZXQ7DQoJfQ0K
DQoJcmV0ID0gYmluZChzb2NrLCAoc3RydWN0IHNvY2thZGRyICopJmFkZHIs
IHNpemVvZihhZGRyKSk7DQoJaWYocmV0ID09IC0xKSB7DQoJCXJldHVybiBy
ZXQ7DQoJfSBlbHNlIHsNCgkJcmV0dXJuIHNvY2s7DQoJfQ0KfQ0KDQppbnQg
bWFpbih2b2lkKSB7DQoJaW50IGlwdjRfc29jayA9IDA7DQoJaW50IGlwdjZf
c29jayA9IDA7DQoJaXB2NF9zb2NrID0gZG9faXB2NF9iaW5kKCIxMjcuMC4w
LjEiLCBiaW5kX3BvcnQpOw0KCWlwdjZfc29jayA9IGRvX2lwdjZfYmluZCgi
OjoxIiwgYmluZF9wb3J0KTsNCglpZihpcHY0X3NvY2sgPCAwKSB7DQoJCXBy
aW50ZigiaXB2NCBiaW5kIGZhaWxlZFxuIik7DQoJfSBlbHNlIHsNCgkJcHJp
bnRmKCJpcHY0IGJpbmQgc3VjY2VlZGVkXG4iKTsNCgkJY2xvc2UoaXB2NF9z
b2NrKTsNCgl9DQoJaWYoaXB2Nl9zb2NrIDwgMCkgew0KCQlwcmludGYoImlw
djYgYmluZCBmYWlsZWRcbiIpOw0KCX0gZWxzZSB7DQoJCXByaW50ZigiaXB2
NiBiaW5kIHN1Y2NlZWRlZFxuIik7DQoJCWNsb3NlKGlwdjZfc29jayk7DQoJ
fQ0KCXJldHVybiAwOw0KfQ0K
---1463809535-1287385206-1024317093=:2496--
