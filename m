Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbVJHA5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbVJHA5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbVJHA5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:57:04 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:47821 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1161026AbVJHA5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:57:01 -0400
Date: Fri, 7 Oct 2005 17:56:57 -0700 (PDT)
From: Nickolai Zeldovich <nickolai@cs.stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: Reproducible kernel panic on NFS unmount
Message-ID: <Pine.LNX.4.44.0510071742240.27324-300000@cardinal3.Stanford.EDU>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1085012751-1936467436-1128733017=:27324"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1085012751-1936467436-1128733017=:27324
Content-Type: TEXT/PLAIN; charset=US-ASCII

There seems to be some bug in the 2.6.12-1.1447_FC4 kernel NFS client: if
you unmount at the right time, when the TCP connection to the NFS server
is closed, and there's an outstanding request, the reconnect timer doesn't
seem to be deleted(?), and RPC_REESTABLISH_TIMEOUT/HZ seconds later, the
kernel panics with something like:

    kernel BUG at kernel/timer.c:418!
    invalid operand: 0000 [#1]
    ...
    Kernel panic - not syncing: Fatal exception in interrupt

and the call trace is different every time.

The attached shell script (and funmount.c program) reproduce the problem.
Run the shell script with one argument (nfs-server:/exported/path) and it
will do the following:

 * mount the NFS server
 * set up iptables to RST the TCP connection
 * create an outstanding request to the NFS server (statvfs)
 * call umount2(/mountpoint, MNT_FORCE | MNT_DETACH)
 * 15 seconds later, the kernel panics

-- kolya

--1085012751-1936467436-1128733017=:27324
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="funmount.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0510071756570.27324@cardinal3.Stanford.EDU>
Content-Description: 
Content-Disposition: attachment; filename="funmount.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5j
bHVkZSA8c3lzL21vdW50Lmg+DQoNCmludCBtYWluKGludCBhYywgY2hhciAq
KmF2KSB7DQogICAgaWYgKGFjICE9IDIpIHsNCglmcHJpbnRmKHN0ZGVyciwg
IlVzYWdlOiAlcyBtb3VudHBvaW50XG4iLCBhdlswXSk7DQoJcmV0dXJuIDE7
DQogICAgfQ0KDQogICAgY2hhciAqcG4gPSBhdlsxXTsNCiAgICBpZiAodW1v
dW50MihwbiwgTU5UX0ZPUkNFIHwgLyogTU5UX0RFVEFDSCAqLyAyKSA8IDAp
IHsNCglwZXJyb3IoInVtb3VudDIiKTsNCglyZXR1cm4gMTsNCiAgICB9DQoN
CiAgICByZXR1cm4gMDsNCn0NCg==
--1085012751-1936467436-1128733017=:27324
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nfs-crash.sh"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0510071756571.27324@cardinal3.Stanford.EDU>
Content-Description: 
Content-Disposition: attachment; filename="nfs-crash.sh"

IyEvYmluL3NoIC14DQoNCmlmIFsgIiQxIiA9ICIiIF07IHRoZW4NCiAgICBl
Y2hvICJVc2FnZTogJDAgbmZzLXNlcnZlcjovc29tZS9wYXRoIg0KICAgIGV4
aXQgMQ0KZmkNCg0KaXB0YWJsZXMgLUYgT1VUUFVUDQppcHRhYmxlcyAtUCBP
VVRQVVQgQUNDRVBUDQppcHRhYmxlcyAtTiBuZnMtb3V0LWJsb2NrDQppcHRh
YmxlcyAtQSBuZnMtb3V0LWJsb2NrIC1wIHRjcCAtLWRwb3J0IDIwNDkgLWog
UkVKRUNUIC0tcmVqZWN0LXdpdGggdGNwLXJlc2V0DQoNCm1rZGlyIC1wIC9t
bnQvbmZzLWNyYXNoLXRlc3QNCm1vdW50IC1uICIkMSIgL21udC9uZnMtY3Jh
c2gtdGVzdA0KDQppcHRhYmxlcyAtQSBPVVRQVVQgLWogbmZzLW91dC1ibG9j
aw0KZGYgLWsgL21udC9uZnMtY3Jhc2gtdGVzdCAmDQoNCiggVD0wOyB3aGls
ZSBbICIkVCIgIT0gMjAgXTsgZG8gVD1gZXhwciAkVCArIDFgOyBzbGVlcCAx
OyBkb25lICkgJg0KDQpzbGVlcCAxDQouL2Z1bm1vdW50IC9tbnQvbmZzLWNy
YXNoLXRlc3QNCg0K
--1085012751-1936467436-1128733017=:27324--
