Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVBOWin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVBOWin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVBOWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:38:42 -0500
Received: from tiere.net.avaya.com ([198.152.12.100]:2738 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S261918AbVBOWiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:38:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C513AE.E682AD40"
Subject: [2.4 TTY] Lost wake-up of tty->write_wait due to race?
Date: Tue, 15 Feb 2005 15:37:16 -0700
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0702351A@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [2.4 TTY] Lost wake-up of tty->write_wait due to race?
Thread-Index: AcUTrqqGHVWuX5hMRwSFNoUMOL6iBg==
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C513AE.E682AD40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry for the repost! I forgot to attach my analysis so far ...

In the 2.4 kernels, is there a race window when a wake_up() of the
tty->write_wait queue from the underlying tty_driver can be lost in
la-la-land, while a task is sleeping on it from tty_wait_until_sent() ?

I am seeing something similar. I have the "pppd" daemon in the
TASK_INTERRUPTIBLE state stuck in tty_wait_until_sent() [determined from
wchan] as a result of its ioctl(fd, TIOCSETD, [N_TTY]) call while about
to exit.

The debug module is showing that the tty->write_wait queue is empty. As
a result, *nothing* will wake up pppd from its TASK_INTERRUPTIBLE state.

How could that be? Just to show that I've done my homework, attached is
my analysis of the issue.

I've seen references to race conditions in the changing of
line-disciplines in postings by Alan Cox, but none of those references
seems to explain what I am seeing.

Any insight will be greatly appreciated!

Thanks

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com

------_=_NextPart_001_01C513AE.E682AD40
Content-Type: text/plain;
	name="ppp-race.txt"
Content-Transfer-Encoding: base64
Content-Description: ppp-race.txt
Content-Disposition: attachment;
	filename="ppp-race.txt"

cHBwZDoKICAgQ2FsbHMgaW9jdGwobW9kZW1mZCBbL2Rldi91c2IvdHR5QUNNMF0sIFRJT0NTRVRE
LCAoTl9UVFkpKQogICBJbiB0aGUga2VybmVsOgoJdHR5X2lvY3RsKCkgY2FsbHMgdHR5X3dhaXRf
dW50aWxfc2VudCh0dHksIDApIAoJCVsgZHJpdmVycy9jaGFyL3R0eV9pby5jOjE3MzUgXQoJdHR5
X3dhaXRfdW50aWxfc2VudCh0dHksIDApCgkJY2hlY2tzIHR0eS0+ZHJpdmVyLmNoYXJzX2luX2J1
ZmZlciBmdW5jIHB0ci4gSWYgdHJ1ZSwKCQlBZGRzIHBwcGQgdG8gdGhlIHR0eS0+d3JpdGVfd2Fp
dCB3YWl0IHF1ZXVlCgkJQ2FsbHMgdHR5LT5kcml2ZXIuY2hhcnNfaW5fYnVmZmVyKHR0eSkuIElm
IHRydWUsCgkJCVRyYW5zbGF0ZXMgdG8gYWNtX3R0eV9jaGFyc19pbl9idWZmZXIoKQoJCQlSZXR1
cm5zIDAgaWYgYWNtLT53cml0ZXVyYi5zdGF0dXMgIT0gRUlOUFJPR1JFU1MKCQkJUmV0dXJucyAt
RUlOVkFMIGlmICFBQ01fUkVBRFkoKQoJCQlSZXR1cm5zIGFjbS0+d3JpdGV1cmIudHJhbnNmZXJf
YnVmZmVyX2xlbmd0aCBpZgoJCQkJYWNtLT53cml0ZXVyYi5zdGF0dXM9PUVJTlBST0dSRVNTCgkJ
Q2FsbHMgc2NoZWR1bGVfdGltZW91dChNQVhfU0NIRURVTEVfVElNRU9VVCkKCiAgIFRvIHdha2Ug
dXAgcHBwZCBmcm9tIHNjaGVkdWxlX3RpbWVvdXQoTUFYX1NDSEVEVUxFX1RJTUVPVVQpLCBzb21l
b25lIGhhcwogICAJdG8gd2FrZV91cCB0aGUgdHR5LT53cml0ZV93YWl0IHdhaXQgcXVldWUKICAg
T25lIGNhbmRpZGF0ZSB0byBkbyBzbyBpcyBhY21fc29mdGludCgpCiAgIGFjbV9zb2Z0aW50KCkg
aXMgY2FsbGVkIGluIGJvdHRvbS1oYWxmIG9mIGFjbV93cml0ZV9idWxrKCkKICAgYWNtX3dyaXRl
X2J1bGsoKSBpcyBjYWxsZWQgYXMgYSBjb21wbGV0aW9uIHJvdXRpbmUgZm9yIHRoZSB3cml0ZSBV
UkIKICAgICAgTW9zdCBsaWtlbHkgaGFwcGVucyBpbiBpbnRlcnJ1cHQgY29udGV4dCwgYXMgdGhl
IG91dHN0YW5kaW5nCiAgICAgIFVIQ0kgVEQgaXMgY29tcGxldGVkLiBUaGF0J3Mgd2h5IGl0IHF1
ZXVlcyBhIElNTUVESUFURV9CSCB0YXNrCiAgICAgIHRvIGRvIGFjbV9zb2Z0aW50KCkKClBPVEVO
VElBTFMgRk9SIFJBQ0UgQ09ORElUSU9OOgpBbm90aGVyIHRhc2sgZG9lcyBhIHdyaXRlKCkgb24g
L2Rldi91c2IvdHR5QUNNMAogIFRyYW5zbGF0ZXMgdG8gYWNtX3R0eV93cml0ZSgpCiAgICAgYWNt
LT53cml0ZXVyYi50cmFuZmVyX2J1ZmZlcl9sZW5ndGggPSBjb3VudCBwYXNzZWQgaW4KICAgICB1
c2Jfc3VibWl0X3VyYigmYWNtLT53cml0ZXVyYikKCVVIQ0kgZHJpdmVyIHdyaXRlcyBURCB0byBV
U0IgY29udHJvbGxlcgpJZiBwcHBkIGRvZXMgaXRzIGlvY3RsKFRJT0NTRVREKSAqYWZ0ZXIqIHVz
Yl9zdWJtaXRfdXJiKCkgZnJvbSBvdGhlciB0YXNrLAp0aGVuIGl0cyB0dHlfd2FpdF91bnRpbF9z
ZW50KHR0eSwgMCkgcm91dGluZSB3aWxsIGdldCBhIG5vbi16ZXJvIAphY21fdHR5X2NoYXJzX2lu
X2J1ZmZlcigpLiBCeSB0aGF0IHRpbWUsIHBwcGQgaGFzIGFkZGVkIGl0c2VsZiB0byB0aGUKdHR5
LT53cml0ZV93YWl0IHF1ZXVlLiBTbyBvbiBjb21wbGV0aW9uIG9mIHRoZSBURC9VUkIsIGFjbV9z
b2Z0aW50KCkKKnNob3VsZCogd2FrZSB1cCBwcHBkIGNvcnJlY3RseQoKV2hhdCBoYXBwZW5zIGlm
IHRoZSBURCBjb21wbGV0aW9uIGludGVycnVwdCAoYW5kIGhlbmNlIHRoZSBjYWxsIHRvCmFjbV93
cml0ZV9idWxrKCkpIGNvbWVzIGluIHJpZ2h0IGJlZm9yZSBwcHBkIGNhbGxzCnNjaGVkdWxlX3Rp
bWVvdXQoTUFYX1NDSEVVTEVfVElNRU9VVCkgPwpJdCBxdWV1ZXMgYW4gSU1NRURJQVRFX0JIIHRh
c2sgdG8gZG8gYWNtX3NvZnRpbnQoKSwgd2hpY2ggd29uJ3QgYmUgZXhlY3V0ZWQKdW50aWwgKmFm
dGVyKiB0aGUgc2NoZWR1bGVfdGltZW91dCgpIGNhbGwgZnJvbSBwcHBkICgqSSBUSElOSyosIGR1
ZSB0byB0aGUKbm9uLXByZWVtcHRpYmxlIG5hdHVyZSBvZiB0aGUgMi40LjIwIGtlcm5lbCkuIGFj
bV9zb2Z0aW50KCkgKnNob3VsZCogYmUKZXhlY3V0ZWQgYnkgdGhlIGtzb2Z0aXJxZCBrZXJuZWwg
dGhyZWFkLCB3aGljaCBydW5zICphZnRlciogcHBwZCBoYXMgY2FsbGVkCnNjaGVkdWxlX3RpbWVv
dXQoKS4gU28gdGhlIHdha2UtdXAgb2YgdHR5LT53cml0ZV93YWl0ICpzaG91bGQqIHdha2UgdXAg
cHBwZApjb3JyZWN0bHkKCgpXaGF0IGNhbiBJIGRvIHRvIHNlZSBpZiBwcHBkIGlzIHN0aWxsIG9u
IHRoZSB3cml0ZV93YWl0IHF1ZXVlIGZvciB0aGUgdHR5PwoKV3JpdGUgYSBkcml2ZXIgd2hvc2Ug
aW5pdCByb3V0aW5lIHdpbGwgY3JlYXRlIGEgdHR5LCBhbmQgZXhhbWluZSBpdHMKd3JpdGVfd2Fp
dCBxdWV1ZS4K

------_=_NextPart_001_01C513AE.E682AD40--
