Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbRFLRVC>; Tue, 12 Jun 2001 13:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRFLRUw>; Tue, 12 Jun 2001 13:20:52 -0400
Received: from [202.153.120.85] ([202.153.120.85]:36880 "EHLO sinocdn.com")
	by vger.kernel.org with ESMTP id <S261502AbRFLRUe>;
	Tue, 12 Jun 2001 13:20:34 -0400
Date: Wed, 13 Jun 2001 01:30:38 +0800 (HKT)
From: <eg_nth@sinocdn.com>
To: linux-kernel@vger.kernel.org
cc: dicky@sinocdn.com
Subject: CLOSE_WAIT bug?
Message-ID: <Pine.LNX.4.21.0106130037330.10007-200000@sinocdn.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1714793096-547517730-992367038=:10007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1714793096-547517730-992367038=:10007
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi all,

I suppect that there is bug in both kernel 2.2.19 and 2.4.5.
The situation is as follow.

One server socket created and listening, blocking on select(),
once a client connect to that port, there is another thread in server
side issues a close() to the new connection. 
After the client close the connection. The connection in server side will
stuck on CLOSE_WAIT forever until the program being killed.

I have attached a program to trigger the bug.
The program is written base on a bugtraq post on this link:

  http://archives.indenial.com/hypermail/bugtraq/1999/January1999/0015.html

This is the output of "netstat -anop":

tcp   1   0 127.0.0.1:52882   127.0.0.1:1031  CLOSE_WAIT   -  off (0.00/0/0)
tcp   1   0 127.0.0.1:52882   127.0.0.1:1030  CLOSE_WAIT   -  off (0.00/0/0)

You can see that there is no owner and the timer is off.

I encounter this in my server program and the CLOSE_WAIT thread eat up
all the resource as it cannot be released.

I have tried this on kernel 2.2.16, 2.2.19, 2.4.5 and using
gcc version 2.96 20000731 (Red Hat Linux 7.0), all this have such problem.

I am new to kernel hacking. I don't know whether this is a bug or not. 
Please correct me if I am doing something wrong and forgive my poor
description.  :)


Thanks
Dicky

PS. Please CC: dicky@sinocdn.com when reply.


---1714793096-547517730-992367038=:10007
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="CLOSE_WAIT_test.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0106130130380.10007@sinocdn.com>
Content-Description: 
Content-Disposition: attachment; filename="CLOSE_WAIT_test.c"

Ly8gVGhpcyBwcm9ncmFtIHdpbGwga2lsbCBhIHJhbmRvbSBwb3J0IG9uIGEg
bGludXggbWFjaGluZS4gVGhlIGtlcm5lbCB3aWxsDQovLyBmb3JldmVyIGxp
c3RlbiB0byB0aGF0IHBvcnQgYW5kIHNlbmQgdGhlIGNvbm5lY3Rpb25zIG5v
d2hlcmUuIFRlc3RlZCB3aXRoDQovLyBMaW51eCBrZXJuZWwgMi4wLjM1IGFu
ZCBsaWJjLTIuMC43LiBSZXF1aXJlcyBMaW51eFRocmVhZHMgdG8gY29tcGls
ZSwNCi8vIGJ1dCByZW1vdmluZyBMaW51eFRocmVhZHMgZnJvbSB5b3VyIHN5
c3RlbSB3aWxsIG5vdCBzb2x2ZSB0aGUgcHJvYmxlbS4NCg0KLy8gVGhlIGJ1
ZyBpcyB0cmlnZ2VyZWQgd2hlbiBhIG11bHRpdGhyZWFkZWQgcHJvZ3JhbSBj
bG9zZXMgYSBzb2NrZXQgZnJvbQ0KLy8gb25lIHRocmVhZCB3aGlsZSBhbm90
aGVyIHRocmVhZCBpcyBzZWxlY3Rpbmcgb24gaXQuIEEgc3Vic2VxdWVudCBh
Ym9ydA0KLy8gbGVhdmVzIHRoZSBzb2NrZXQgaW4gbmV2ZXItbmV2ZXIgbGFu
ZC4NCg0KLy8gRG8gbm90IHVuZGVyZXN0aW1hdGUgdGhlIHJpc2sgb2YgdGhp
cyBleHBsb2l0LiBXaGlsZSB0aGlzIHByb2dyYW0NCi8vIGlzIG1pbGQsIG1v
cmUgdmljaW91cyBwcm9ncmFtcyBjb3VsZCBsb2NrIGxhcmdlIG51bWJlcnMg
b2YgcG9ydHMgb3INCi8vIHJlcGxpY2F0ZSB0aGlzIHNhbWUgYXR0YWNrIG9u
IGFuIGFjdGl2ZSBjb25uZWN0aW9uIHdpdGggbGFyZ2UNCi8vIHNlbmQvcmVj
ZWl2ZSBidWZmZXJzIGZ1bGwgb2YgZGF0YS4gVGhpcyBjb3VsZCBjYXVzZSBs
YXJnZSBpbmNyZWFzZXMNCi8vIGluIGtlcm5lbCBtZW1vcnkgY29uc3VtcHRp
b24uDQoNCi8vIERpc2NvdmVyZWQgYnkgRGF2aWQgSi4gU2Nod2FydHogPGRh
dmlkc0B3ZWJtYXN0ZXIuY29tPg0KLy8gQ29weXJpZ2h0IChDKSAxOTk4LCBE
YXZpZCBKLiBTY2h3YXJ0eg0KDQovLyBOb3RlOiBUaGlzIGJ1ZyB3YXMgbm90
IGZpeGVkIGluIDIuMC4zNiwgYXMgSSB3YXMgdG9sZCBpdCB3b3VsZCBiZQ0K
DQovLyBDb21waWxlIHdpdGg6DQovLyBnY2MgQ0xPU0VfV0FJVF90ZXN0LmMg
LWxwdGhyZWFkIC1vIENMT1NFX1dBSVRfdGVzdA0KDQojaW5jbHVkZSA8cHRo
cmVhZC5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3R5
cGVzLmg+DQojaW5jbHVkZSA8c3lzL3NvY2tldC5oPg0KI2luY2x1ZGUgPG5l
dGluZXQvaW4uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNsdWRlIDxh
cnBhL2luZXQuaD4NCiNpbmNsdWRlIDxlcnJuby5oPg0KDQp2b2xhdGlsZSBp
bnQgczsNCnZvbGF0aWxlIGludCBzb2NrOw0Kdm9sYXRpbGUgaW50IGNvbm5l
Y3RlZD0wOw0KDQp2b2lkICpUaHJlYWQxKHZvaWQgKmEpDQp7DQogaW50IGks
cDsNCiBzdHJ1Y3Qgc29ja2FkZHJfaW4gdG87DQogZmRfc2V0IGZkOw0KIHM9
c29ja2V0KEFGX0lORVQsIFNPQ0tfU1RSRUFNLCAwKTsNCiBpZihzPD0wKSBy
ZXR1cm47DQogbWVtc2V0KCZ0bywgMCwgc2l6ZW9mKHRvKSk7DQogc3JhbmQo
Z2V0cGlkKCkpOw0KDQogLyogd2UgcGljayBhIHJhbmRvbSBwb3J0IGJldHdl
ZW4gNTAwMDAgYW5kIDU5OTk5ICovDQogcD0ocmFuZCgpJTEwMDAwKSs1MDAw
MDsNCg0KIHByaW50ZigicG9ydCA9ICVkXG4iLCBwKTsNCiBmZmx1c2goc3Rk
b3V0KTsNCiB0by5zaW5fcG9ydD1odG9ucyhwKTsNCiB0by5zaW5fYWRkci5z
X2FkZHI9MDsNCiB0by5zaW5fZmFtaWx5PUFGX0lORVQ7DQogaWYoYmluZChz
LCAoc3RydWN0IHNvY2thZGRyICopJnRvLCBzaXplb2YodG8pKTwwKQ0KICBm
cHJpbnRmKHN0ZGVyciwibm8gYmluZFxuIik7DQogaWYobGlzdGVuKHMsMTAp
IT0wKQ0KICBmcHJpbnRmKHN0ZGVyciwiTm8gTGlzdGVuXG4iKTsNCiAvKiBu
b3cgd2UgYXJlIGxpc3RlbmluZyBvbiB0aGF0IHBvcnQgKi8NCiBpPXNpemVv
Zih0byk7DQogRkRfWkVSTygmZmQpOw0KIEZEX1NFVChzLCZmZCk7DQogIGZw
cmludGYoc3Rkb3V0LCJMaXN0ZW5pbmcsIGJlZm9yZSBzZWxlY3RcbiIpOyAN
CiAgZnByaW50ZihzdGRvdXQsIlBsZWFzZSBjb25uZWN0IHRvIHBvcnQgJWQg
bm93XG4iLCBwKTsgDQogIHNlbGVjdChzKzEsJmZkLE5VTEwsTlVMTCxOVUxM
KTsNCiAgLyogYXQgdGhpcyBwb2ludCB3ZSBoYXZlIHNlbGVjdGVkIG9uIGl0
IGFzIHdlbGwgKi8NCiAgZnByaW50ZihzdGRlcnIsInNlbGVjdCByZXR1cm5l
ZCFcbiIpOw0KDQogIGlmIChGRF9JU1NFVChzLCAmZmQpKQ0KICB7DQogICAg
ZnByaW50ZihzdGRvdXQsICJzb2NrZXQgaXMgc2V0XG4iKTsNCiAgICBzb2Nr
ID0gYWNjZXB0KHMsIE5VTEwsIE5VTEwpOw0KICAgIGZwcmludGYoc3Rkb3V0
LCAiYWNjZXB0ZWRcbiIpOw0KICAgIEZEX1NFVChzb2NrLCAmZmQpOw0KICAg
IGZwcmludGYoc3Rkb3V0LCAiRkRfU0VUIG9rXG4iKTsNCiAgICBjb25uZWN0
ZWQgPSAxOw0KDQogICAgZnByaW50ZihzdGRvdXQsIlxuTGlzdGVuaW5nLCBi
ZWZvcmUgc2VsZWN0XG4iKTsgDQogICAgc2VsZWN0KHNvY2srMSwgJmZkLCBO
VUxMLCBOVUxMLCBOVUxMKTsNCiAgICBmcHJpbnRmKHN0ZG91dCwgInNlbGVj
dCByZXR1cm5lZFxuIik7DQoNCiAgICANCiAgfQ0KICBlbHNlDQogIHsNCiAg
ICBmcHJpbnRmKHN0ZGVyciwgIkVycm9yIDogZmQgbm90IHNldFxuIik7DQog
ICAgZXhpdCgxKTsNCiAgfQ0KfQ0KDQp2b2lkICpUaHJlYWQyKHZvaWQgKmEp
DQp7DQogIGZwcmludGYoc3Rkb3V0LCJUaHJlYWQyIDogYmVmb3JlIGNsb3Nl
IHRoZSBjbGllbnQgc29ja2V0XG4iKTsNCiAgY2xvc2Uoc29jayk7DQogIGZw
cmludGYoc3Rkb3V0LCJUaHJlYWQyIDogYWZ0ZXIgY2xvc2UgdGhlIGNsaWVu
dCBzb2NrZXRcblxuXG4iKTsNCiAgZnByaW50ZihzdGRvdXQsIlBsZWFzZSBj
bG9zZSB0aGUgcmVtb3RlIHNlc3Npb24gYW5kIGNoZWNrIHRoZSByZXN1bHRc
biIpOw0KIGZmbHVzaChzdGRlcnIpOw0KLy8gYWJvcnQoKTsNCn0NCg0Kdm9p
ZCBtYWluKHZvaWQpDQp7DQogcHRocmVhZF90IGo7DQogcHRocmVhZF9jcmVh
dGUoJmosTlVMTCxUaHJlYWQxLE5VTEwpOw0KDQogd2hpbGUgKGNvbm5lY3Rl
ZCA9PSAwKQ0KICAgdXNsZWVwKDEwMDApOyAvKiBnaXZlIHRoZSBvdGhlciB0
aHJlYWQgdGltZSB0byBmaW5pc2ggKi8NCiBwdGhyZWFkX2NyZWF0ZSgmaixO
VUxMLFRocmVhZDIsTlVMTCk7DQoNCiB3aGlsZSgxKSBzbGVlcCgxKTsNCn0N
Cg0KDQoNCg==
---1714793096-547517730-992367038=:10007--
