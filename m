Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUEXWIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUEXWIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUEXWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:08:43 -0400
Received: from mail.homelink.ru ([81.9.33.123]:1740 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S264700AbUEXWIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:08:09 -0400
Date: Tue, 25 May 2004 02:08:03 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: class_device_find()
Message-Id: <20040525020803.759c5794.zap@homelink.ru>
In-Reply-To: <20040524164630.GB1543@kroah.com>
References: <20040523002309.2ec5965e.zap@homelink.ru>
	<20040524051303.GC27371@kroah.com>
	<20040524103921.7957533a.zap@homelink.ru>
	<20040524164630.GB1543@kroah.com>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__25_May_2004_02_08_03_+0400_Gd10Y+e2SC_7ZtGW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__25_May_2004_02_08_03_+0400_Gd10Y+e2SC_7ZtGW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 May 2004 09:46:31 -0700
Greg KH <greg@kroah.com> wrote:

> > The class_device_find() function returns a pointer to a class_device, but
> > the reference counter of that object is not incremented. This looks to me
> > somewhat racy, unless there are some details I'm missing.
> There were lots of problems with that function, and that's one reason
> it's not in the kernel tree :)
Oops, it looks like I was looking at the wrong patch :-( My comments were true
for original Jamey's patches, but your patch already has all these issues
fixed. Mea culpa.

> > Because in the first case if class_device_get succeeds, but class_id is
> > empty, the kobject will remain in a referenced state.
> Good catch.  But your fix is not quite correct, we should call
> class_device_put() on the class_dev variable before returning -EINVAL
> instead.
That was obvious, but it's more code and no extra functionality. The same
erroneous conditions will be caught, just a bit earlier, so there's no need to
call put() since we caught it before we called get(). Unless there's no other
condition when get() returns NULL, we are safe to call get() and do not check
for the return value.

> > And yet one more comment. What is the purpose of class_device_get at the
> > beginning and class_device_put at the end of the above function?
> We are just being safe.
IMHO it is useless to try to be safe for the reasons I pointed out. If
somebody calls class_rename() without holding a reference, there's anyway a
race condition. And if it calls class_rename holding a reference, there's no
need to call get/put. Doing get/put will just minimize the chance of a race,
not remove it.

Ok, apart from this discussion, what you don't like about the
class_device_find() function? I mean your fixed implementation. The locks are
in place, the returned object has got his reference counter increased. Or,
alternatively, any other ideas how we can solve the problem I've described in
my previous message?

Also one more question. Do you think if it is okay if a subclass (such
as the lcd device class) does strcpy() directly to class_device->class_id, or
it is worth to add a function class_dev_set_name(struct class_device *, const
char*)?

I've attached your version of class_device_find() yet again, with a tiny fix
(changed name arg to "const char *" in rename() and find(), and exported
rename() which looks like it has been forgotten to be). Also I still would
remove the get()/put() from rename() but this has not been done in this patch.

--
Greetings,
   Andrew

--Multipart=_Tue__25_May_2004_02_08_03_+0400_Gd10Y+e2SC_7ZtGW
Content-Type: application/octet-stream;
 name="class.diff"
Content-Disposition: attachment;
 filename="class.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi42L2RyaXZlcnMvYmFzZS9jbGFzcy5jCTIwMDQtMDUtMTAgMDY6MzM6MjEu
MDAwMDAwMDAwICswNDAwCisrKyBrZXJuZWwyNi9kcml2ZXJzL2Jhc2UvY2xhc3MuYwkyMDA0LTA1
LTI1IDAyOjAzOjQwLjAwMDAwMDAwMCArMDQwMApAQCAtMzU5LDcgKzM1OSw3IEBACiAJY2xhc3Nf
ZGV2aWNlX3B1dChjbGFzc19kZXYpOwogfQogCi1pbnQgY2xhc3NfZGV2aWNlX3JlbmFtZShzdHJ1
Y3QgY2xhc3NfZGV2aWNlICpjbGFzc19kZXYsIGNoYXIgKm5ld19uYW1lKQoraW50IGNsYXNzX2Rl
dmljZV9yZW5hbWUoc3RydWN0IGNsYXNzX2RldmljZSAqY2xhc3NfZGV2LCBjb25zdCBjaGFyICpu
ZXdfbmFtZSkKIHsKIAljbGFzc19kZXYgPSBjbGFzc19kZXZpY2VfZ2V0KGNsYXNzX2Rldik7CiAJ
aWYgKCFjbGFzc19kZXYpCkBAIC0zNzcsNiArMzc3LDMzIEBACiAJcmV0dXJuIDA7CiB9CiAKKy8q
KgorICogY2xhc3NfZGV2aWNlX2ZpbmQgLSBmaW5kIGEgc3RydWN0IGNsYXNzX2RldmljZSBpbiBh
IHNwZWNpZmljIGNsYXNzCisgKiBAY2xhc3M6IHRoZSBjbGFzcyB0byBzZWFyY2gKKyAqIEBjbGFz
c19pZDogdGhlIGNsYXNzX2lkIHRvIHNlYXJjaCBmb3IKKyAqCisgKiBJdGVyYXRlcyB0aHJvdWdo
IHRoZSBsaXN0IG9mIGFsbCBjbGFzcyBkZXZpY2VzIHJlZ2lzdGVyZWQgdG8gYSBjbGFzcy4gSWYK
KyAqIHRoZSBjbGFzc19pZCBpcyBmb3VuZCwgaXRzIHJlZmVyZW5jZSBjb3VudCBpcyBpbmNyZW1l
bnRlZCBhbmQgcmV0dXJuZWQgdG8KKyAqIHRoZSBjYWxsZXIuIElmIHRoZSBjbGFzc19pZCBkb2Vz
IG5vdCBtYXRjaCBhbnkgZXhpc3Rpbmcgc3RydWN0IGNsYXNzX2RldmljZQorICogcmVnaXN0ZXJl
ZCB0byB0aGlzIHN0cnVjdCBjbGFzcywgdGhlbiBOVUxMIGlzIHJldHVybmVkLgorICovCitzdHJ1
Y3QgY2xhc3NfZGV2aWNlICogY2xhc3NfZGV2aWNlX2ZpbmQoc3RydWN0IGNsYXNzICpjbGFzcywg
Y29uc3QgY2hhciAqY2xhc3NfaWQpCit7CisJc3RydWN0IGNsYXNzX2RldmljZSAqY2xhc3NfZGV2
OworCXN0cnVjdCBjbGFzc19kZXZpY2UgKmZvdW5kID0gTlVMTDsKKworCWRvd25fcmVhZCgmY2xh
c3MtPnN1YnN5cy5yd3NlbSk7CisJbGlzdF9mb3JfZWFjaF9lbnRyeShjbGFzc19kZXYsICZjbGFz
cy0+Y2hpbGRyZW4sIG5vZGUpIHsKKwkJaWYgKHN0cmNtcChjbGFzc19kZXYtPmNsYXNzX2lkLCBj
bGFzc19pZCkgPT0gMCkgeworCQkJZm91bmQgPSBjbGFzc19kZXZpY2VfZ2V0KGNsYXNzX2Rldik7
CisJCQlicmVhazsKKwkJfQorCX0KKwl1cF9yZWFkKCZjbGFzcy0+c3Vic3lzLnJ3c2VtKTsKKwor
CXJldHVybiBmb3VuZDsKK30KKwogc3RydWN0IGNsYXNzX2RldmljZSAqIGNsYXNzX2RldmljZV9n
ZXQoc3RydWN0IGNsYXNzX2RldmljZSAqY2xhc3NfZGV2KQogewogCWlmIChjbGFzc19kZXYpCkBA
IC00NjgsNiArNDk1LDggQEAKIEVYUE9SVF9TWU1CT0woY2xhc3NfZGV2aWNlX3B1dCk7CiBFWFBP
UlRfU1lNQk9MKGNsYXNzX2RldmljZV9jcmVhdGVfZmlsZSk7CiBFWFBPUlRfU1lNQk9MKGNsYXNz
X2RldmljZV9yZW1vdmVfZmlsZSk7CitFWFBPUlRfU1lNQk9MKGNsYXNzX2RldmljZV9yZW5hbWUp
OworRVhQT1JUX1NZTUJPTChjbGFzc19kZXZpY2VfZmluZCk7CiAKIEVYUE9SVF9TWU1CT0woY2xh
c3NfaW50ZXJmYWNlX3JlZ2lzdGVyKTsKIEVYUE9SVF9TWU1CT0woY2xhc3NfaW50ZXJmYWNlX3Vu
cmVnaXN0ZXIpOwotLS0gbGludXgtMi42LjYvaW5jbHVkZS9saW51eC9kZXZpY2UuaAkyMDA0LTA1
LTEwIDA2OjMzOjE5LjAwMDAwMDAwMCArMDQwMAorKysga2VybmVsMjYvaW5jbHVkZS9saW51eC9k
ZXZpY2UuaAkyMDA0LTA1LTI1IDAxOjU0OjMwLjAwMDAwMDAwMCArMDQwMApAQCAtMjEyLDggKzIx
Miw5IEBACiBleHRlcm4gaW50IGNsYXNzX2RldmljZV9hZGQoc3RydWN0IGNsYXNzX2RldmljZSAq
KTsKIGV4dGVybiB2b2lkIGNsYXNzX2RldmljZV9kZWwoc3RydWN0IGNsYXNzX2RldmljZSAqKTsK
IAotZXh0ZXJuIGludCBjbGFzc19kZXZpY2VfcmVuYW1lKHN0cnVjdCBjbGFzc19kZXZpY2UgKiwg
Y2hhciAqKTsKK2V4dGVybiBpbnQgY2xhc3NfZGV2aWNlX3JlbmFtZShzdHJ1Y3QgY2xhc3NfZGV2
aWNlICosIGNvbnN0IGNoYXIgKik7CiAKK2V4dGVybiBzdHJ1Y3QgY2xhc3NfZGV2aWNlICogY2xh
c3NfZGV2aWNlX2ZpbmQoc3RydWN0IGNsYXNzICpjbGFzcywgY29uc3QgY2hhciAqY2xhc3NfaWQp
OwogZXh0ZXJuIHN0cnVjdCBjbGFzc19kZXZpY2UgKiBjbGFzc19kZXZpY2VfZ2V0KHN0cnVjdCBj
bGFzc19kZXZpY2UgKik7CiBleHRlcm4gdm9pZCBjbGFzc19kZXZpY2VfcHV0KHN0cnVjdCBjbGFz
c19kZXZpY2UgKik7CiAK

--Multipart=_Tue__25_May_2004_02_08_03_+0400_Gd10Y+e2SC_7ZtGW--
