Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUB0WNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbUB0WKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:10:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:7059 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263167AbUB0WJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:09:59 -0500
Date: Fri, 27 Feb 2004 16:09:21 -0600 (CST)
From: olof@austin.ibm.com
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>, <niv@us.ibm.com>,
       <anton@samba.org>, <milliner@us.ibm.com>
Subject: [PATCH] NULL pointer deref in tcp_do_twkill_work()
Message-ID: <Pine.A41.4.44.0402271256450.50098-200000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="154490139-1198053911-1077914028=:32282"
Content-ID: <Pine.A41.4.44.0402271522240.88840@forte.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--154490139-1198053911-1077914028=:32282
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.A41.4.44.0402271522241.88840@forte.austin.ibm.com>

This bug has been encountered before (ref http://bugme.osdl.org/show_bug.cgi?id=1627),
but that time it went away by itself. We're now seeing it again with
another heavy network load on 2.6.3.

Recap:

We're crashing in tcp_do_twkill_work():

        tw_for_each_inmate(tw, node, safe,
                           &tcp_tw_death_row[slot]) {
                __tw_del_dead_node(tw);
                spin_unlock(&tw_death_lock);
                tcp_timewait_kill(tw);
                tcp_tw_put(tw);
                killed++;
                spin_lock(&tw_death_lock);
                if (killed > quota) {
                        ret = 1;
                        break;
                }
        }


The crash is in __tw_del_dead_node, where tw is taken off of the
tw_death_node list. At the time of the crash, the pprev list pointer is
NULL, which indicates that tw is no longer on the list.

I'm suspicious of the fact that the tw_death_lock is released, and since
it's released, the "safe" inmate could be descheduled on another CPU. Once
the lock is reaquired and the loop is redone, the new tw (old safe) is
now already taken off the list so we go astray.

Shouldn't the loop always restart from the beginning instead of using the
(not thread-)"safe" list iteration? Since it keeps taking the entries off
the list, the behaviour should be identical but it wouldn't be racy.

The alternative is to not drop the lock, but I'm guessing we need to do
that to avoid deadlocks. I don't know the TCP code well enough to tell for
sure.

Proposed patch is attached. We've given it a bit of runtime here but the
crashes happen randomly so it'll take a while to gain full confidence that
it's fixed. But the above reasoning around the patch seems to make sense.


Thanks,

Olof

Olof Johansson                                        Office: 4E002/905
Linux on Power Development                            IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM



--154490139-1198053911-1077914028=:32282
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=twpatch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.A41.4.44.0402271522300.88840@forte.austin.ibm.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=twpatch

LS0tIG5ldC9pcHY0L3RjcF9taW5pc29ja3MuYy5vcmlnCTIwMDQtMDItMjcg
MTM6NDM6MTEuMDAwMDAwMDAwIC0wNjAwDQorKysgbmV0L2lwdjQvdGNwX21p
bmlzb2Nrcy5jCTIwMDQtMDItMjcgMTU6MjE6MTguMzE4ODkwNjcyIC0wNjAw
DQpAQCAtNDI3LDkgKzQyNyw3IEBAIHN0YXRpYyB1MzIgdHdraWxsX3RocmVh
ZF9zbG90czsNCiBzdGF0aWMgaW50IHRjcF9kb190d2tpbGxfd29yayhpbnQg
c2xvdCwgdW5zaWduZWQgaW50IHF1b3RhKQ0KIHsNCiAJc3RydWN0IHRjcF90
d19idWNrZXQgKnR3Ow0KLQlzdHJ1Y3QgaGxpc3Rfbm9kZSAqbm9kZSwgKnNh
ZmU7DQogCXVuc2lnbmVkIGludCBraWxsZWQ7DQotCWludCByZXQ7DQogDQog
CS8qIE5PVEU6IGNvbXBhcmUgdGhpcyB0byBwcmV2aW91cyB2ZXJzaW9uIHdo
ZXJlIGxvY2sNCiAJICogd2FzIHJlbGVhc2VkIGFmdGVyIGRldGFjaGluZyBj
aGFpbi4gSXQgd2FzIHJhY3ksDQpAQCAtNDM4LDI1ICs0MzYsMjEgQEAgc3Rh
dGljIGludCB0Y3BfZG9fdHdraWxsX3dvcmsoaW50IHNsb3QsIA0KIAkgKiBz
b2Z0IGlycXMgYXJlIG5vdCBzZXF1ZW5jZWQuDQogCSAqLw0KIAlraWxsZWQg
PSAwOw0KLQlyZXQgPSAwOw0KLQl0d19mb3JfZWFjaF9pbm1hdGUodHcsIG5v
ZGUsIHNhZmUsDQotCQkJICAgJnRjcF90d19kZWF0aF9yb3dbc2xvdF0pIHsN
CisJd2hpbGUgKGtpbGxlZCA8PSBxdW90YSAmJg0KKwkgICAgICAgIWhsaXN0
X2VtcHR5KCZ0Y3BfdHdfZGVhdGhfcm93W3Nsb3RdKSkgew0KKwkJdHcgPSBo
bGlzdF9lbnRyeSh0Y3BfdHdfZGVhdGhfcm93W3Nsb3RdLmZpcnN0LCBzdHJ1
Y3QgdGNwX3R3X2J1Y2tldCwgdHdfZGVhdGhfbm9kZSk7DQogCQlfX3R3X2Rl
bF9kZWFkX25vZGUodHcpOw0KIAkJc3Bpbl91bmxvY2soJnR3X2RlYXRoX2xv
Y2spOw0KIAkJdGNwX3RpbWV3YWl0X2tpbGwodHcpOw0KIAkJdGNwX3R3X3B1
dCh0dyk7DQogCQlraWxsZWQrKzsNCiAJCXNwaW5fbG9jaygmdHdfZGVhdGhf
bG9jayk7DQotCQlpZiAoa2lsbGVkID4gcXVvdGEpIHsNCi0JCQlyZXQgPSAx
Ow0KLQkJCWJyZWFrOw0KLQkJfQ0KIAl9DQogDQogCXRjcF90d19jb3VudCAt
PSBraWxsZWQ7DQogCU5FVF9BRERfU1RBVFNfQkgoVGltZVdhaXRlZCwga2ls
bGVkKTsNCiANCi0JcmV0dXJuIHJldDsNCisJcmV0dXJuIGtpbGxlZCA+IHF1
b3RhOw0KIH0NCiANCiBzdGF0aWMgdm9pZCB0Y3BfdHdraWxsKHVuc2lnbmVk
IGxvbmcgZHVtbXkpDQo=
--154490139-1198053911-1077914028=:32282--
