Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbRFLOUe>; Tue, 12 Jun 2001 10:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbRFLOUY>; Tue, 12 Jun 2001 10:20:24 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:4227 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262575AbRFLOUR>; Tue, 12 Jun 2001 10:20:17 -0400
From: DJBARROW@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A69.004E9AF2.00@d12mta09.de.ibm.com>
Date: Tue, 12 Jun 2001 16:17:48 +0200
Subject: Re: bug in /net/core/dev.c
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=FiHzD00gsc4wc7SCeTJXS18vd4RuIoG5jpxlwkSdIYn3T2EuunVOWB8J"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=FiHzD00gsc4wc7SCeTJXS18vd4RuIoG5jpxlwkSdIYn3T2EuunVOWB8J
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Hi Alan/Dave
Here is a better version of the patch I think it cuts about 15 lines out of
dev.c  & I think logically it is more bulletproof than my previous attempt.

(See attached file: dev.c.2.4.5.v2.patch)

Hi Dave,

On 390 it is very easy to hotplug devices under VM.

We do it all the time using the channel device layer on s/390, so users
can reconfigure devices if they misconfigure them.

If it can be registered it should be able to be unregistered.

Cornelia Huck in our group in boeblingen noticed the bug too.



Please respond to "David S. Miller" <davem@redhat.com>

To:   Denis Joseph Barrow/Germany/Contr/IBM@IBMDE
cc:   linux-kernel@vger.kernel.org
Subject:  Re: bug in /net/core/dev.c





DJBARROW@de.ibm.com writes:
 > The dev->refcnt will go up to 2 ( it should be 1) unregister_netdevice
will
 > usually  loop forever
 > waiting for the refcnt to drop to 1 when an attempt to unregister is
done.

When will devices built statically into the kernel ever be
unregister'd?

Later,
David S. Miller
davem@redhat.com

Hi,
I found this bug in dev.c

It happens if register_netdevice is called before net_dev_init which can
happen from init functions,
when device drivers are compiled into the kernel.

The dev->refcnt will go up to 2 ( it should be 1) unregister_netdevice will
usually  loop forever
waiting for the refcnt to drop to 1 when an attempt to unregister is done.

The printk in the bootmessages early initialization of device <blah> is
deferred is evidence of this behaviour occuring.

The small patch is below ,hope it is okay for you.

--0__=FiHzD00gsc4wc7SCeTJXS18vd4RuIoG5jpxlwkSdIYn3T2EuunVOWB8J
Content-type: application/octet-stream; 
	name="dev.c.2.4.5.v2.patch"
Content-Disposition: attachment; filename="dev.c.2.4.5.v2.patch"
Content-transfer-encoding: base64

LS0tIG5ldC9jb3JlL2Rldi5vbGQuYwlXZWQgTWF5IDMwIDE0OjI0OjQ3IDIwMDEKKysrIG5ldC9j
b3JlL2Rldi5jCVR1ZSBKdW4gMTIgMTU6Mzc6NTggMjAwMQpAQCAtMjAsNiArMjAsMTAgQEAKICAq
ICAgICAgICAgICAgICBQZWtrYSBSaWlrb25lbiA8cHJpaWtvbmVAcG9lc2lkb24ucHNwdC5maT4K
ICAqCiAgKglDaGFuZ2VzOgorICogICAgICAgICAgICAgIEQuSi4gQmFycm93ICAgICA6ICAgICAg
IEZpeGVkIGJ1ZyB3aGVyZSBkZXYtPnJlZmNudCBnZXRzIHNldCB0byAyIAorICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIHJlZ2lzdGVyX25ldGRldiBnZXRzIGNhbGxl
ZCBiZWZvcmUKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXRfZGV2
X2luaXQgJiBhbHNvIHJlbW92ZWQgYSBmZXcgbGluZXMKKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBvZiBjb2RlIGluIHRoZSBwcm9jZXNzLgogICoJCUFsYW4gQ294CToJ
ZGV2aWNlIHByaXZhdGUgaW9jdGwgY29waWVzIGZpZWxkcyBiYWNrLgogICoJCUFsYW4gQ294CToJ
VHJhbnNtaXQgcXVldWUgY29kZSBkb2VzIHJlbGV2YW50IHN0dW50cyB0bwogICoJCQkJCWtlZXAg
dGhlIHF1ZXVlIHNhZmUuCkBAIC0yMzgyLDYgKzIzODYsNyBAQAogICoJd2lsbCBub3QgZ2V0IHRo
ZSBzYW1lIG5hbWUuCiAgKi8KIAoraW50IG5ldF9kZXZfaW5pdCh2b2lkKTsKIGludCByZWdpc3Rl
cl9uZXRkZXZpY2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZCwgKipkcDsKQEAgLTIzOTYsNDggKzI0MDEsOCBAQAogCWRldi0+ZmFzdHBhdGhfbG9jaz1S
V19MT0NLX1VOTE9DS0VEOwogI2VuZGlmCiAKLQlpZiAoZGV2X2Jvb3RfcGhhc2UpIHsKLSNpZmRl
ZiBDT05GSUdfTkVUX0RJVkVSVAotCQlyZXQgPSBhbGxvY19kaXZlcnRfYmxrKGRldik7Ci0JCWlm
IChyZXQpCi0JCQlyZXR1cm4gcmV0OwotI2VuZGlmIC8qIENPTkZJR19ORVRfRElWRVJUICovCi0J
CQotCQkvKiBUaGlzIGlzIE5PVCBidWcsIGJ1dCBJIGFtIG5vdCBzdXJlLCB0aGF0IGFsbCB0aGUK
LQkJICAgZGV2aWNlcywgaW5pdGlhbGl6ZWQgYmVmb3JlIG5ldGRldiBtb2R1bGUgaXMgc3RhcnRl
ZAotCQkgICBhcmUgc2FuZS4gCi0KLQkJICAgTm93IHRoZXkgYXJlIGNoYWluZWQgdG8gZGV2aWNl
IGJvb3QgbGlzdAotCQkgICBhbmQgcHJvYmVkIGxhdGVyLiBJZiBhIG1vZHVsZSBpcyBpbml0aWFs
aXplZAotCQkgICBiZWZvcmUgbmV0ZGV2LCBidXQgYXNzdW1lcyB0aGF0IGRldi0+aW5pdAotCQkg
ICBpcyByZWFsbHkgY2FsbGVkIGJ5IHJlZ2lzdGVyX25ldGRldigpLCBpdCB3aWxsIGZhaWwuCi0K
LQkJICAgU28gdGhhdCB0aGlzIG1lc3NhZ2Ugc2hvdWxkIGJlIHByaW50ZWQgZm9yIGEgd2hpbGUu
Ci0JCSAqLwotCQlwcmludGsoS0VSTl9JTkZPICJlYXJseSBpbml0aWFsaXphdGlvbiBvZiBkZXZp
Y2UgJXMgaXMgZGVmZXJyZWRcbiIsIGRldi0+bmFtZSk7Ci0KLQkJLyogQ2hlY2sgZm9yIGV4aXN0
ZW5jZSwgYW5kIGFwcGVuZCB0byB0YWlsIG9mIGNoYWluICovCi0JCWZvciAoZHA9JmRldl9iYXNl
OyAoZD0qZHApICE9IE5VTEw7IGRwPSZkLT5uZXh0KSB7Ci0JCQlpZiAoZCA9PSBkZXYgfHwgc3Ry
Y21wKGQtPm5hbWUsIGRldi0+bmFtZSkgPT0gMCkgewotCQkJCXJldHVybiAtRUVYSVNUOwotCQkJ
fQotCQl9Ci0JCWRldi0+bmV4dCA9IE5VTEw7Ci0JCXdyaXRlX2xvY2tfYmgoJmRldl9iYXNlX2xv
Y2spOwotCQkqZHAgPSBkZXY7Ci0JCWRldl9ob2xkKGRldik7Ci0JCXdyaXRlX3VubG9ja19iaCgm
ZGV2X2Jhc2VfbG9jayk7Ci0KLQkJLyoKLQkJICoJRGVmYXVsdCBpbml0aWFsIHN0YXRlIGF0IHJl
Z2lzdHJ5IGlzIHRoYXQgdGhlCi0JCSAqCWRldmljZSBpcyBwcmVzZW50LgotCQkgKi8KLQotCQlz
ZXRfYml0KF9fTElOS19TVEFURV9QUkVTRU5ULCAmZGV2LT5zdGF0ZSk7Ci0KLQkJcmV0dXJuIDA7
Ci0JfQotCisJaWYgKGRldl9ib290X3BoYXNlKQorCQluZXRfZGV2X2luaXQoKTsKICNpZmRlZiBD
T05GSUdfTkVUX0RJVkVSVAogCXJldCA9IGFsbG9jX2RpdmVydF9ibGsoZGV2KTsKIAlpZiAocmV0
KQpAQCAtMjY3OSw3ICsyNjQ0LDkgQEAKIHsKIAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCAqKmRw
OwogCWludCBpOwotCisJCisJaWYoIWRldl9ib290X3BoYXNlKQorCQlyZXR1cm4gMDsKICNpZmRl
ZiBDT05GSUdfTkVUX1NDSEVECiAJcGt0c2NoZWRfaW5pdCgpOwogI2VuZGlmCg==

--0__=FiHzD00gsc4wc7SCeTJXS18vd4RuIoG5jpxlwkSdIYn3T2EuunVOWB8J--

