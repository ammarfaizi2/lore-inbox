Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWAIACZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWAIACZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWAIACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:02:25 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60340 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161254AbWAIACY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:02:24 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 8 Jan 2006 16:02:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFC] POLLHUP tinkering ...
Message-ID: <Pine.LNX.4.63.0601081528170.6925@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-386799369-1136764930=:6925"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-386799369-1136764930=:6925
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


Some time ago there was a discussion about adding a simple flag to the 
Linux poll subsystem, to signal half-closed links during read operations and 
epoll:

http://lkml.org/lkml/2003/7/12/116

The problem for users of EPOLLET is that they rely on a shorter-than-buffersize
read to detect the end of the currant payload, and go back to wait for events 
again. What they do is basically (in a very simplified way), once EPOLLIN is 
received:

 	do {
 		n = read(fd, buf, bufsiz);
 		...
 	} while (n == bufsiz);

But if and hangup happened with some data (data + FIN), they won't receive any 
more events for the Linux poll subsystem (and epoll, when using the event 
triggered interface), so they are forced to issue an extra read() after the 
loop to detect the EOF condition. Besides from the extra read() overhead, 
the code does not come exactly pretty. During the last few months I 
received quite a few messages from dudes asking me why, after a 
substantial agreement, that kind of patch has never been implemented. 
After looking at the code yesterday, I realized that there is not need of 
extra flags, and a correct POLLHUP reporting from f_op->poll() can do it.
Linux almost everywhere reports the POLLHUP in a way that is useful for 
EPOLLET users, with only few exceptions. In those few places the full 
SHUTDOWN_MASK is expected in order to report POLLHUP, whereas the simple 
RCV_SHUTDOWN would be sufficent to detect a shutdown peer. When 
RCV_SHUTDOWN is set, the outbound data channel is definitely shutdown, so 
POLLHUP is deserved in such condition. Returning POLLHUP upon RCV_SHUTDOWN 
would automatically solve the above problem, and won't conflict with the 
SUS definition of POLLHUP:

[POLLHUP]
The device has been disconnected. This event and POLLOUT are mutually 
exclusive; a stream can never be writable if a hangup has occurred. 
However, this event and POLLIN, POLLRDNORM, POLLRDBAND or POLLPRI are not 
mutually exclusive. This flag is only valid in the revents bitmask; it is 
ignored in the events member.

With that in place, EPOLLET users can simply check for the EPOLLHUP flag 
returned, and yank the session w/out extra cumbersome code.
The attached patch is against 2.6.15-git4. Comments?



- Davide



net/bluetooth/af_bluetooth.c |    5 ++---
net/core/datagram.c          |    5 ++---
net/dccp/proto.c             |    4 ++--
net/ipv4/tcp.c               |    4 ++--
net/sctp/socket.c            |    5 ++---
net/unix/af_unix.c           |    5 ++---
6 files changed, 12 insertions(+), 16 deletions(-)


--8323328-386799369-1136764930=:6925
Content-Type: TEXT/plain; charset=US-ASCII; name=pollhup-2.6.15.git4-0.1.diff
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=pollhup-2.6.15.git4-0.1.diff

ZGlmZiAtTnJ1IGxpbnV4LTIuNi4xNS9uZXQvYmx1ZXRvb3RoL2FmX2JsdWV0
b290aC5jIGxpbnV4LTIuNi4xNS5tb2QvbmV0L2JsdWV0b290aC9hZl9ibHVl
dG9vdGguYw0KLS0tIGxpbnV4LTIuNi4xNS9uZXQvYmx1ZXRvb3RoL2FmX2Js
dWV0b290aC5jCTIwMDYtMDEtMDIgMTk6MjE6MTAuMDAwMDAwMDAwIC0wODAw
DQorKysgbGludXgtMi42LjE1Lm1vZC9uZXQvYmx1ZXRvb3RoL2FmX2JsdWV0
b290aC5jCTIwMDYtMDEtMDggMTE6NTY6MzAuMDAwMDAwMDAwIC0wODAwDQpA
QCAtMjM4LDExICsyMzgsMTAgQEANCiAJaWYgKHNrLT5za19lcnIgfHwgIXNr
Yl9xdWV1ZV9lbXB0eSgmc2stPnNrX2Vycm9yX3F1ZXVlKSkNCiAJCW1hc2sg
fD0gUE9MTEVSUjsNCiANCi0JaWYgKHNrLT5za19zaHV0ZG93biA9PSBTSFVU
RE9XTl9NQVNLKQ0KKwlpZiAoc2stPnNrX3NodXRkb3duICYgUkNWX1NIVVRE
T1dOKQ0KIAkJbWFzayB8PSBQT0xMSFVQOw0KIA0KLQlpZiAoIXNrYl9xdWV1
ZV9lbXB0eSgmc2stPnNrX3JlY2VpdmVfcXVldWUpIHx8IA0KLQkJCShzay0+
c2tfc2h1dGRvd24gJiBSQ1ZfU0hVVERPV04pKQ0KKwlpZiAoIXNrYl9xdWV1
ZV9lbXB0eSgmc2stPnNrX3JlY2VpdmVfcXVldWUpKQ0KIAkJbWFzayB8PSBQ
T0xMSU4gfCBQT0xMUkROT1JNOw0KIA0KIAlpZiAoc2stPnNrX3N0YXRlID09
IEJUX0NMT1NFRCkNCmRpZmYgLU5ydSBsaW51eC0yLjYuMTUvbmV0L2NvcmUv
ZGF0YWdyYW0uYyBsaW51eC0yLjYuMTUubW9kL25ldC9jb3JlL2RhdGFncmFt
LmMNCi0tLSBsaW51eC0yLjYuMTUvbmV0L2NvcmUvZGF0YWdyYW0uYwkyMDA2
LTAxLTAyIDE5OjIxOjEwLjAwMDAwMDAwMCAtMDgwMA0KKysrIGxpbnV4LTIu
Ni4xNS5tb2QvbmV0L2NvcmUvZGF0YWdyYW0uYwkyMDA2LTAxLTA4IDExOjU2
OjAyLjAwMDAwMDAwMCAtMDgwMA0KQEAgLTQzOSwxMiArNDM5LDExIEBADQog
CS8qIGV4Y2VwdGlvbmFsIGV2ZW50cz8gKi8NCiAJaWYgKHNrLT5za19lcnIg
fHwgIXNrYl9xdWV1ZV9lbXB0eSgmc2stPnNrX2Vycm9yX3F1ZXVlKSkNCiAJ
CW1hc2sgfD0gUE9MTEVSUjsNCi0JaWYgKHNrLT5za19zaHV0ZG93biA9PSBT
SFVURE9XTl9NQVNLKQ0KKwlpZiAoc2stPnNrX3NodXRkb3duICYgUkNWX1NI
VVRET1dOKQ0KIAkJbWFzayB8PSBQT0xMSFVQOw0KIA0KIAkvKiByZWFkYWJs
ZT8gKi8NCi0JaWYgKCFza2JfcXVldWVfZW1wdHkoJnNrLT5za19yZWNlaXZl
X3F1ZXVlKSB8fA0KLQkgICAgKHNrLT5za19zaHV0ZG93biAmIFJDVl9TSFVU
RE9XTikpDQorCWlmICghc2tiX3F1ZXVlX2VtcHR5KCZzay0+c2tfcmVjZWl2
ZV9xdWV1ZSkpDQogCQltYXNrIHw9IFBPTExJTiB8IFBPTExSRE5PUk07DQog
DQogCS8qIENvbm5lY3Rpb24tYmFzZWQgbmVlZCB0byBjaGVjayBmb3IgdGVy
bWluYXRpb24gYW5kIHN0YXJ0dXAgKi8NCmRpZmYgLU5ydSBsaW51eC0yLjYu
MTUvbmV0L2RjY3AvcHJvdG8uYyBsaW51eC0yLjYuMTUubW9kL25ldC9kY2Nw
L3Byb3RvLmMNCi0tLSBsaW51eC0yLjYuMTUvbmV0L2RjY3AvcHJvdG8uYwky
MDA2LTAxLTAyIDE5OjIxOjEwLjAwMDAwMDAwMCAtMDgwMA0KKysrIGxpbnV4
LTIuNi4xNS5tb2QvbmV0L2RjY3AvcHJvdG8uYwkyMDA2LTAxLTA4IDExOjU1
OjIyLjAwMDAwMDAwMCAtMDgwMA0KQEAgLTE3NSwxMCArMTc1LDEwIEBADQog
CWlmIChzay0+c2tfZXJyKQ0KIAkJbWFzayA9IFBPTExFUlI7DQogDQotCWlm
IChzay0+c2tfc2h1dGRvd24gPT0gU0hVVERPV05fTUFTSyB8fCBzay0+c2tf
c3RhdGUgPT0gRENDUF9DTE9TRUQpDQorCWlmIChzay0+c2tfc3RhdGUgPT0g
RENDUF9DTE9TRUQpDQogCQltYXNrIHw9IFBPTExIVVA7DQogCWlmIChzay0+
c2tfc2h1dGRvd24gJiBSQ1ZfU0hVVERPV04pDQotCQltYXNrIHw9IFBPTExJ
TiB8IFBPTExSRE5PUk07DQorCQltYXNrIHw9IFBPTExJTiB8IFBPTExSRE5P
Uk0gfCBQT0xMSFVQOw0KIA0KIAkvKiBDb25uZWN0ZWQ/ICovDQogCWlmICgo
MSA8PCBzay0+c2tfc3RhdGUpICYgfihEQ0NQRl9SRVFVRVNUSU5HIHwgREND
UEZfUkVTUE9ORCkpIHsNCmRpZmYgLU5ydSBsaW51eC0yLjYuMTUvbmV0L2lw
djQvdGNwLmMgbGludXgtMi42LjE1Lm1vZC9uZXQvaXB2NC90Y3AuYw0KLS0t
IGxpbnV4LTIuNi4xNS9uZXQvaXB2NC90Y3AuYwkyMDA2LTAxLTAyIDE5OjIx
OjEwLjAwMDAwMDAwMCAtMDgwMA0KKysrIGxpbnV4LTIuNi4xNS5tb2QvbmV0
L2lwdjQvdGNwLmMJMjAwNi0wMS0wOCAxMTo1NDo0OS4wMDAwMDAwMDAgLTA4
MDANCkBAIC0zNjIsMTAgKzM2MiwxMCBAQA0KIAkgKiBOT1RFLiBDaGVjayBm
b3IgVENQX0NMT1NFIGlzIGFkZGVkLiBUaGUgZ29hbCBpcyB0byBwcmV2ZW50
DQogCSAqIGJsb2NraW5nIG9uIGZyZXNoIG5vdC1jb25uZWN0ZWQgb3IgZGlz
Y29ubmVjdGVkIHNvY2tldC4gLS1BTksNCiAJICovDQotCWlmIChzay0+c2tf
c2h1dGRvd24gPT0gU0hVVERPV05fTUFTSyB8fCBzay0+c2tfc3RhdGUgPT0g
VENQX0NMT1NFKQ0KKwlpZiAoc2stPnNrX3N0YXRlID09IFRDUF9DTE9TRSkN
CiAJCW1hc2sgfD0gUE9MTEhVUDsNCiAJaWYgKHNrLT5za19zaHV0ZG93biAm
IFJDVl9TSFVURE9XTikNCi0JCW1hc2sgfD0gUE9MTElOIHwgUE9MTFJETk9S
TTsNCisJCW1hc2sgfD0gUE9MTElOIHwgUE9MTFJETk9STSB8IFBPTExIVVA7
DQogDQogCS8qIENvbm5lY3RlZD8gKi8NCiAJaWYgKCgxIDw8IHNrLT5za19z
dGF0ZSkgJiB+KFRDUEZfU1lOX1NFTlQgfCBUQ1BGX1NZTl9SRUNWKSkgew0K
ZGlmZiAtTnJ1IGxpbnV4LTIuNi4xNS9uZXQvc2N0cC9zb2NrZXQuYyBsaW51
eC0yLjYuMTUubW9kL25ldC9zY3RwL3NvY2tldC5jDQotLS0gbGludXgtMi42
LjE1L25ldC9zY3RwL3NvY2tldC5jCTIwMDYtMDEtMDIgMTk6MjE6MTAuMDAw
MDAwMDAwIC0wODAwDQorKysgbGludXgtMi42LjE1Lm1vZC9uZXQvc2N0cC9z
b2NrZXQuYwkyMDA2LTAxLTA4IDExOjUzOjU3LjAwMDAwMDAwMCAtMDgwMA0K
QEAgLTQ0NTAsMTIgKzQ0NTAsMTEgQEANCiAJLyogSXMgdGhlcmUgYW55IGV4
Y2VwdGlvbmFsIGV2ZW50cz8gICovDQogCWlmIChzay0+c2tfZXJyIHx8ICFz
a2JfcXVldWVfZW1wdHkoJnNrLT5za19lcnJvcl9xdWV1ZSkpDQogCQltYXNr
IHw9IFBPTExFUlI7DQotCWlmIChzay0+c2tfc2h1dGRvd24gPT0gU0hVVERP
V05fTUFTSykNCisJaWYgKHNrLT5za19zaHV0ZG93biAmIFJDVl9TSFVURE9X
TikNCiAJCW1hc2sgfD0gUE9MTEhVUDsNCiANCiAJLyogSXMgaXQgcmVhZGFi
bGU/ICBSZWNvbnNpZGVyIHRoaXMgY29kZSB3aXRoIFRDUC1zdHlsZSBzdXBw
b3J0LiAgKi8NCi0JaWYgKCFza2JfcXVldWVfZW1wdHkoJnNrLT5za19yZWNl
aXZlX3F1ZXVlKSB8fA0KLQkgICAgKHNrLT5za19zaHV0ZG93biAmIFJDVl9T
SFVURE9XTikpDQorCWlmICghc2tiX3F1ZXVlX2VtcHR5KCZzay0+c2tfcmVj
ZWl2ZV9xdWV1ZSkpDQogCQltYXNrIHw9IFBPTExJTiB8IFBPTExSRE5PUk07
DQogDQogCS8qIFRoZSBhc3NvY2lhdGlvbiBpcyBlaXRoZXIgZ29uZSBvciBu
b3QgcmVhZHkuICAqLw0KZGlmZiAtTnJ1IGxpbnV4LTIuNi4xNS9uZXQvdW5p
eC9hZl91bml4LmMgbGludXgtMi42LjE1Lm1vZC9uZXQvdW5peC9hZl91bml4
LmMNCi0tLSBsaW51eC0yLjYuMTUvbmV0L3VuaXgvYWZfdW5peC5jCTIwMDYt
MDEtMDIgMTk6MjE6MTAuMDAwMDAwMDAwIC0wODAwDQorKysgbGludXgtMi42
LjE1Lm1vZC9uZXQvdW5peC9hZl91bml4LmMJMjAwNi0wMS0wOCAxMTo1Mzoy
OC4wMDAwMDAwMDAgLTA4MDANCkBAIC0xODc3LDEyICsxODc3LDExIEBADQog
CS8qIGV4Y2VwdGlvbmFsIGV2ZW50cz8gKi8NCiAJaWYgKHNrLT5za19lcnIp
DQogCQltYXNrIHw9IFBPTExFUlI7DQotCWlmIChzay0+c2tfc2h1dGRvd24g
PT0gU0hVVERPV05fTUFTSykNCisJaWYgKHNrLT5za19zaHV0ZG93biAmIFJD
Vl9TSFVURE9XTikNCiAJCW1hc2sgfD0gUE9MTEhVUDsNCiANCiAJLyogcmVh
ZGFibGU/ICovDQotCWlmICghc2tiX3F1ZXVlX2VtcHR5KCZzay0+c2tfcmVj
ZWl2ZV9xdWV1ZSkgfHwNCi0JICAgIChzay0+c2tfc2h1dGRvd24gJiBSQ1Zf
U0hVVERPV04pKQ0KKwlpZiAoIXNrYl9xdWV1ZV9lbXB0eSgmc2stPnNrX3Jl
Y2VpdmVfcXVldWUpKQ0KIAkJbWFzayB8PSBQT0xMSU4gfCBQT0xMUkROT1JN
Ow0KIA0KIAkvKiBDb25uZWN0aW9uLWJhc2VkIG5lZWQgdG8gY2hlY2sgZm9y
IHRlcm1pbmF0aW9uIGFuZCBzdGFydHVwICovDQo=

--8323328-386799369-1136764930=:6925--
