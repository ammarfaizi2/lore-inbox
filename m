Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVF0PsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVF0PsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVF0PrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:47:03 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:26005 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262067AbVF0Pk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:40:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=CQKqe0FLTkCTVSlP3DT4uckBUJMReye9jhPHpdWFBhrgjdFYMpDNgHVQ041mcI06A8hBxCT3GmYfJ8JYdxys6IXAxfFLNpi/ywhXZ+ex3u58pvEz8YHfzmrLLdxMrYENPiqAu3QlD5tcT9Y251Ht9HdfRPBjtAjYbSENuaQ3B7g=
Message-ID: <2c1942a705062708402d07657e@mail.gmail.com>
Date: Mon, 27 Jun 2005 18:40:27 +0300
From: Levent Serinol <lserinol@gmail.com>
Reply-To: Levent Serinol <lserinol@gmail.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] enable/disable profiling via proc/sysctl
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       riel@redhat.com
In-Reply-To: <20050627125649.GJ3334@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5256_15833211.1119886827658"
References: <2c1942a705062623411b7e88c3@mail.gmail.com>
	 <20050627000125.1a6f8a91.akpm@osdl.org>
	 <2c1942a7050627051357e9b532@mail.gmail.com>
	 <20050627125649.GJ3334@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5256_15833211.1119886827658
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi William,

 You're right. As you suggest I reverted memory barrier part. Also,
added memory barriers while allocating and freeing memory.

Can you confirm that if it's okay now or missed anything else ?

PS. I couldn't figure out how to reverse function of hotcpu_notifier.
That's why I used  register_cpu_notifier and #ifdefs.



On 6/27/05, William Lee Irwin III <wli@holomorphy.com> wrote:
> On Mon, Jun 27, 2005 at 03:13:13PM +0300, Levent Serinol wrote:
> > +#ifdef CONFIG_SMP
> > +int remove_hash_tables(void)
> > +{
> > +     int cpu;
> > +
> > +
> > +     for_each_online_cpu(cpu) {
> > +             struct page *page;
> > +
> > +             if (per_cpu(cpu_profile_hits, cpu)[0]) {
> > +                     page =3D virt_to_page(per_cpu(cpu_profile_hits, c=
pu)[0]);
> > +                     per_cpu(cpu_profile_hits, cpu)[0] =3D NULL;
> > +                     __free_page(page);
> > +             }
> > +             if (per_cpu(cpu_profile_hits, cpu)[1]) {
> > +                     page =3D virt_to_page(per_cpu(cpu_profile_hits, c=
pu)[1]);
> > +                     per_cpu(cpu_profile_hits, cpu)[1] =3D NULL;
> > +                     __free_page(page);
> > +             }
> > +     }
> > +     return -1;
>=20
> Big problem. Timer interrupts can be firing while this is in progress.
> The reason for profile_nop() is so that the code I have running during
> timer interrupts (protected by local_irq_save()) runs to completion,
> where it will afterward discover the flags or variables set to updated
> states. You'll probably have to add more (e.g. memory barriers) since
> you can tolerate less once you're dynamically allocating and freeing etc.
>=20
>=20
> On Mon, Jun 27, 2005 at 03:13:13PM +0300, Levent Serinol wrote:
> > @@ -560,7 +668,11 @@ static int __init create_proc_profile(vo
> >               return 0;
> >       entry->proc_fops =3D &proc_profile_operations;
> >       entry->size =3D (1+prof_len) * sizeof(atomic_t);
> > -     hotcpu_notifier(profile_cpu_callback, 0);
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +     register_cpu_notifier(&profile_cpu_notifier);
> > +#endif
> > +     profile_params[0] =3D prof_on;
> > +     profile_params[1] =3D prof_shift;
> >       return 0;
> >  }
> >  module_init(create_proc_profile);
>=20
> hotcpu_notifier() is there to avoid the #ifdef; you shouldn't need to
> rearrange that.
>=20
> Anyway, just keep fixing it up. There should be a few more after this.
>=20
>=20
> -- wli
>=20


--=20

Stay out of the road, if you want to grow old.=20
~ Pink Floyd ~.

------=_Part_5256_15833211.1119886827658
Content-Type: text/x-patch; name="profile.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="profile.patch"

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuMTItcmM2Lm9yaWcvaW5jbHVkZS9saW51
eC9wcm9maWxlLmggbGludXgtMi42LjEyLXJjNi9pbmNsdWRlL2xpbnV4L3Byb2ZpbGUuaAotLS0g
bGludXgtMi42LjEyLXJjNi5vcmlnL2luY2x1ZGUvbGludXgvcHJvZmlsZS5oCTIwMDUtMDMtMDIg
MDk6Mzg6MDguMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTItcmM2L2luY2x1ZGUvbGlu
dXgvcHJvZmlsZS5oCTIwMDUtMDYtMjcgMTA6MTk6NDMuMDAwMDAwMDAwICswMzAwCkBAIC02LDE0
ICs2LDIxIEBACiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgvY29u
ZmlnLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L3N5c2N0bC5o
PgogI2luY2x1ZGUgPGxpbnV4L2NwdW1hc2suaD4KICNpbmNsdWRlIDxhc20vZXJybm8uaD4KIAog
I2RlZmluZSBDUFVfUFJPRklMSU5HCTEKICNkZWZpbmUgU0NIRURfUFJPRklMSU5HCTIKIAorc3Ry
dWN0IGN0bF90YWJsZTsKK3N0cnVjdCBmaWxlOwogc3RydWN0IHByb2NfZGlyX2VudHJ5Owogc3Ry
dWN0IHB0X3JlZ3M7CitleHRlcm4gaW50IHByb2ZpbGVfcGFyYW1zW107CitpbnQgcHJvZmlsZV9z
eXNjdGxfaGFuZGxlcihjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsCisgICAgICAgICAgICAg
ICBzdHJ1Y3QgZmlsZSAqZmlsZSwgdm9pZCBfX3VzZXIgKmJ1ZmZlciwgc2l6ZV90CisqbGVuZ3Ro
LCBsb2ZmX3QgKnBwb3MpOwogCiAvKiBpbml0IGJhc2ljIGtlcm5lbCBwcm9maWxlciAqLwogdm9p
ZCBfX2luaXQgcHJvZmlsZV9pbml0KHZvaWQpOwpkaWZmIC11cHJOIC1YIGRvbnRkaWZmIGxpbnV4
LTIuNi4xMi1yYzYub3JpZy9pbmNsdWRlL2xpbnV4L3N5c2N0bC5oIGxpbnV4LTIuNi4xMi1yYzYv
aW5jbHVkZS9saW51eC9zeXNjdGwuaAotLS0gbGludXgtMi42LjEyLXJjNi5vcmlnL2luY2x1ZGUv
bGludXgvc3lzY3RsLmgJMjAwNS0wNi0yNyAxODoyNToxMy4wMDAwMDAwMDAgKzAzMDAKKysrIGxp
bnV4LTIuNi4xMi1yYzYvaW5jbHVkZS9saW51eC9zeXNjdGwuaAkyMDA1LTA2LTI3IDEwOjE1OjU0
LjAwMDAwMDAwMCArMDMwMApAQCAtMTM2LDYgKzEzNiw3IEBAIGVudW0KIAlLRVJOX1VOS05PV05f
Tk1JX1BBTklDPTY2LCAvKiBpbnQ6IHVua25vd24gbm1pIHBhbmljIGZsYWcgKi8KIAlLRVJOX0JP
T1RMT0FERVJfVFlQRT02NywgLyogaW50OiBib290IGxvYWRlciB0eXBlICovCiAJS0VSTl9SQU5E
T01JWkU9NjgsIC8qIGludDogcmFuZG9taXplIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSAqLworCUtF
Uk5fUFJPRklMRT02OSwgLyogaW50OiBwcm9maWxlIG9uL29mZiAqLwogfTsKIAogCmRpZmYgLXVw
ck4gLVggZG9udGRpZmYgbGludXgtMi42LjEyLXJjNi5vcmlnL2tlcm5lbC9wcm9maWxlLmMgbGlu
dXgtMi42LjEyLXJjNi9rZXJuZWwvcHJvZmlsZS5jCi0tLSBsaW51eC0yLjYuMTItcmM2Lm9yaWcv
a2VybmVsL3Byb2ZpbGUuYwkyMDA1LTA2LTI3IDE4OjI1OjEzLjAwMDAwMDAwMCArMDMwMAorKysg
bGludXgtMi42LjEyLXJjNi9rZXJuZWwvcHJvZmlsZS5jCTIwMDUtMDYtMjcgMTg6MjM6NDcuMDAw
MDAwMDAwICswMzAwCkBAIC0yMSw3ICsyMSw2IEBACiAjaW5jbHVkZSA8bGludXgvbW0uaD4KICNp
bmNsdWRlIDxsaW51eC9jcHVtYXNrLmg+CiAjaW5jbHVkZSA8bGludXgvY3B1Lmg+Ci0jaW5jbHVk
ZSA8bGludXgvcHJvZmlsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4KICNpbmNsdWRl
IDxhc20vc2VjdGlvbnMuaD4KICNpbmNsdWRlIDxhc20vc2VtYXBob3JlLmg+CkBAIC0zNyw5ICsz
NiwxMiBAQCBzdHJ1Y3QgcHJvZmlsZV9oaXQgewogLyogT3Byb2ZpbGUgdGltZXIgdGljayBob29r
ICovCiBpbnQgKCp0aW1lcl9ob29rKShzdHJ1Y3QgcHRfcmVncyAqKTsKIAorc3RydWN0IHNlbWFw
aG9yZSBwcm9mX3NlbTsKK2ludCBwcm9maWxlX3BhcmFtc1syXSA9IHswLCAwfTsKIHN0YXRpYyBh
dG9taWNfdCAqcHJvZl9idWZmZXI7CiBzdGF0aWMgdW5zaWduZWQgbG9uZyBwcm9mX2xlbiwgcHJv
Zl9zaGlmdDsKIHN0YXRpYyBpbnQgcHJvZl9vbjsKK3N0YXRpYyBpbnQgcHJvZl9ib290b247CiBz
dGF0aWMgY3B1bWFza190IHByb2ZfY3B1X21hc2sgPSBDUFVfTUFTS19BTEw7CiAjaWZkZWYgQ09O
RklHX1NNUAogc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBwcm9maWxlX2hpdCAqWzJdLCBj
cHVfcHJvZmlsZV9oaXRzKTsKQEAgLTc0LDEyICs3NiwxNCBAQCBfX3NldHVwKCJwcm9maWxlPSIs
IHByb2ZpbGVfc2V0dXApOwogCiB2b2lkIF9faW5pdCBwcm9maWxlX2luaXQodm9pZCkKIHsKKwlp
bml0X01VVEVYKCZwcm9mX3NlbSk7CiAJaWYgKCFwcm9mX29uKSAKIAkJcmV0dXJuOwogIAogCS8q
IG9ubHkgdGV4dCBpcyBwcm9maWxlZCAqLwogCXByb2ZfbGVuID0gKF9ldGV4dCAtIF9zdGV4dCkg
Pj4gcHJvZl9zaGlmdDsKIAlwcm9mX2J1ZmZlciA9IGFsbG9jX2Jvb3RtZW0ocHJvZl9sZW4qc2l6
ZW9mKGF0b21pY190KSk7CisJcHJvZl9ib290b24gPSAxOwogfQogCiAvKiBQcm9maWxlIGV2ZW50
IG5vdGlmaWNhdGlvbnMgKi8KQEAgLTM2Nyw2ICszNzEsMTIgQEAgc3RhdGljIGludCBfX2Rldmlu
aXQgcHJvZmlsZV9jcHVfY2FsbGJhYwogCX0KIAlyZXR1cm4gTk9USUZZX09LOwogfQorc3RhdGlj
IHN0cnVjdCBub3RpZmllcl9ibG9jayBwcm9maWxlX2NwdV9ub3RpZmllciA9Cit7CisgICAgICAg
ICAubm90aWZpZXJfY2FsbCA9IHByb2ZpbGVfY3B1X2NhbGxiYWNrLAorICAgICAgICAgLnByaW9y
aXR5ID0gMCwKK307CisKICNlbmRpZiAvKiBDT05GSUdfSE9UUExVR19DUFUgKi8KICNlbHNlIC8q
ICFDT05GSUdfU01QICovCiAjZGVmaW5lIHByb2ZpbGVfZmxpcF9idWZmZXJzKCkJCWRvIHsgfSB3
aGlsZSAoMCkKQEAgLTUwMCwxMSArNTEwLDExIEBAIHN0YXRpYyBzdHJ1Y3QgZmlsZV9vcGVyYXRp
b25zIHByb2NfcHJvZmkKIH07CiAKICNpZmRlZiBDT05GSUdfU01QCi1zdGF0aWMgdm9pZCBfX2lu
aXQgcHJvZmlsZV9ub3Aodm9pZCAqdW51c2VkKQorc3RhdGljIHZvaWQgcHJvZmlsZV9ub3Aodm9p
ZCAqdW51c2VkKQogewogfQogCi1zdGF0aWMgaW50IF9faW5pdCBjcmVhdGVfaGFzaF90YWJsZXMo
dm9pZCkKK2ludCBjcmVhdGVfaGFzaF90YWJsZXModm9pZCkKIHsKIAlpbnQgY3B1OwogCkBAIC01
NDgsNiArNTU4LDExMyBAQCBvdXRfY2xlYW51cDoKICNkZWZpbmUgY3JlYXRlX2hhc2hfdGFibGVz
KCkJCQkoeyAwOyB9KQogI2VuZGlmCiAKKyNpZmRlZiBDT05GSUdfU01QCitpbnQgcmVtb3ZlX2hh
c2hfdGFibGVzKHZvaWQpCit7CisJaW50IGNwdTsKKworCisJcHJvZl9vbiA9IDA7CisJc21wX21i
KCk7CisJb25fZWFjaF9jcHUocHJvZmlsZV9ub3AsIE5VTEwsIDAsIDEpOworCisJZm9yX2VhY2hf
b25saW5lX2NwdShjcHUpIHsKKwkJc3RydWN0IHBhZ2UgKnBhZ2U7CisKKwkJaWYgKHBlcl9jcHUo
Y3B1X3Byb2ZpbGVfaGl0cywgY3B1KVswXSkgeworCQkJcGFnZSA9IHZpcnRfdG9fcGFnZShwZXJf
Y3B1KGNwdV9wcm9maWxlX2hpdHMsIGNwdSlbMF0pOworCQkJcGVyX2NwdShjcHVfcHJvZmlsZV9o
aXRzLCBjcHUpWzBdID0gTlVMTDsKKwkJCV9fZnJlZV9wYWdlKHBhZ2UpOworCQl9CisJCWlmIChw
ZXJfY3B1KGNwdV9wcm9maWxlX2hpdHMsIGNwdSlbMV0pIHsKKwkJCXBhZ2UgPSB2aXJ0X3RvX3Bh
Z2UocGVyX2NwdShjcHVfcHJvZmlsZV9oaXRzLCBjcHUpWzFdKTsKKwkJCXBlcl9jcHUoY3B1X3By
b2ZpbGVfaGl0cywgY3B1KVsxXSA9IE5VTEw7CisJCQlfX2ZyZWVfcGFnZShwYWdlKTsKKwkJfQor
CX0KKwlyZXR1cm4gLTE7Cit9CisjZWxzZQorI2RlZmluZSByZW1vdmVfaGFzaF90YWJsZXMoKQkJ
CSh7IDA7IH0pCisjZW5kaWYKKworaW50IHByb2ZpbGVfc3lzY3RsX2hhbmRsZXIoY3RsX3RhYmxl
ICp0YWJsZSwgaW50IHdyaXRlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgCisJCXZvaWQgX191c2VyICpi
dWZmZXIsIHNpemVfdCAqbGVuZ3RoLCBsb2ZmX3QgKnBwb3MpCit7CisJaW50IGVycjsKKwlzdHJ1
Y3QgcHJvY19kaXJfZW50cnkgKmVudHJ5OworCisKKwlkb3duKCZwcm9mX3NlbSk7CisKKwlpZiAo
cHJvZl9ib290b24gJiYgd3JpdGUpIAorCQlnb3RvIG91dDsKKworCWVycj1wcm9jX2RvaW50dmVj
KHRhYmxlLCB3cml0ZSwgZmlsZSwgYnVmZmVyLCBsZW5ndGgsIHBwb3MpOworCWlmIChlcnIgPCAw
IHx8ICF3cml0ZSkKKwkJZ290byBvdXQ7CisKKwlwcm9mX3NoaWZ0ID0gcHJvZmlsZV9wYXJhbXNb
MV07CisKKwlpZiAoIXByb2ZpbGVfcGFyYW1zWzBdKSB7CisJCWlmIChwcm9mX29uKSB7CisJCQlw
cm9mX29uID0gMDsKKwkJCXJlbW92ZV9wcm9jX2VudHJ5KCJwcm9maWxlIixOVUxMKTsKKyNpZmRl
ZiBDT05GSUdfSE9UUExVR19DUFUKKwkJCXVucmVnaXN0ZXJfY3B1X25vdGlmaWVyKCZwcm9maWxl
X2NwdV9ub3RpZmllcik7CisjZW5kaWYKKwkJCXJlbW92ZV9oYXNoX3RhYmxlcygpOworCQkJc21w
X21iKCk7CisJCQlvbl9lYWNoX2NwdShwcm9maWxlX25vcCwgTlVMTCwgMCwgMSk7CisJCQl2ZnJl
ZShwcm9mX2J1ZmZlcik7CisJCQlwcmludGsoS0VSTl9JTkZPICJrZXJuZWwgcHJvZmlsaW5nIGRp
c2FibGVkXG4iKTsKKwkJfQorCX0KKworCWlmICgocHJvZmlsZV9wYXJhbXNbMF09PVNDSEVEX1BS
T0ZJTElORykgfHwgKHByb2ZpbGVfcGFyYW1zWzBdPT1DUFVfUFJPRklMSU5HKSkgeworCQlpZiAo
cHJvZl9vbikKKwkJCWdvdG8gb3V0OworICAgICAgICAJcHJvZl9sZW4gPSAoX2V0ZXh0IC0gX3N0
ZXh0KSA+PiBwcm9mX3NoaWZ0OworCQlzbXBfbWIoKTsKKyAgICAgICAgCXByb2ZfYnVmZmVyID0g
dm1hbGxvYyhwcm9mX2xlbipzaXplb2YoYXRvbWljX3QpKTsKKwkJaWYgKCFwcm9mX2J1ZmZlcikK
KwkJCWdvdG8gb3V0OworCQlpZiAoY3JlYXRlX2hhc2hfdGFibGVzKCkpIHsKKwkJCXZmcmVlKHBy
b2ZfYnVmZmVyKTsKKwkJCWdvdG8gb3V0OworCQl9CisJCXByb2Zfb24gPSBwcm9maWxlX3BhcmFt
c1swXTsKKwkJaWYgKCEoZW50cnkgPSBjcmVhdGVfcHJvY19lbnRyeSgicHJvZmlsZSIsIFNfSVdV
U1IgfCBTX0lSVUdPLCBOVUxMKSkpIHsKKwkJCXJlbW92ZV9oYXNoX3RhYmxlcygpOworCQkJc21w
X21iKCk7CisJCQlvbl9lYWNoX2NwdShwcm9maWxlX25vcCwgTlVMTCwgMCwgMSk7CisJCQl2ZnJl
ZShwcm9mX2J1ZmZlcik7CisJCQlnb3RvIG91dDsKKwkJfQorCQllbnRyeS0+cHJvY19mb3BzID0g
JnByb2NfcHJvZmlsZV9vcGVyYXRpb25zOworCQllbnRyeS0+c2l6ZSA9ICgxK3Byb2ZfbGVuKSAq
IHNpemVvZihhdG9taWNfdCk7CisjaWZkZWYgQ09ORklHX0hPVFBMVUdfQ1BVCisJCXJlZ2lzdGVy
X2NwdV9ub3RpZmllcigmcHJvZmlsZV9jcHVfbm90aWZpZXIpOworI2VuZGlmCisJCXByb2ZpbGVf
ZGlzY2FyZF9mbGlwX2J1ZmZlcnMoKTsKKyAgICAgICAgCW1lbXNldChwcm9mX2J1ZmZlciwgMCwg
cHJvZl9sZW4gKiBzaXplb2YoYXRvbWljX3QpKTsKKwkJCXN3aXRjaChwcm9mX29uKSB7CisJCQlj
YXNlIFNDSEVEX1BST0ZJTElORzoKKwkJCQlwcmludGsoS0VSTl9JTkZPICJrZXJuZWwgc2NoZWR1
bGUgcHJvZmlsaW5nIGVuYWJsZWQgKHNoaWZ0OiAlbGQpXG4iLAorCQkJCQkJcHJvZl9zaGlmdCk7
CisJCQkJYnJlYWs7CisJCQljYXNlIENQVV9QUk9GSUxJTkc6CisJCQkJcHJpbnRrKEtFUk5fSU5G
TyAia2VybmVsIHByb2ZpbGluZyBlbmFibGVkIChzaGlmdDogJWxkKVxuIiwKKwkJCQkJCXByb2Zf
c2hpZnQpOworCQkJCWJyZWFrOworCQkJfSAKKwl9CisKK291dDoKKwl1cCgmcHJvZl9zZW0pOwor
CXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IF9faW5pdCBjcmVhdGVfcHJvY19wcm9maWxlKHZv
aWQpCiB7CiAJc3RydWN0IHByb2NfZGlyX2VudHJ5ICplbnRyeTsKQEAgLTU2MCw3ICs2NzcsMTEg
QEAgc3RhdGljIGludCBfX2luaXQgY3JlYXRlX3Byb2NfcHJvZmlsZSh2bwogCQlyZXR1cm4gMDsK
IAllbnRyeS0+cHJvY19mb3BzID0gJnByb2NfcHJvZmlsZV9vcGVyYXRpb25zOwogCWVudHJ5LT5z
aXplID0gKDErcHJvZl9sZW4pICogc2l6ZW9mKGF0b21pY190KTsKLQlob3RjcHVfbm90aWZpZXIo
cHJvZmlsZV9jcHVfY2FsbGJhY2ssIDApOworI2lmZGVmIENPTkZJR19IT1RQTFVHX0NQVQorCXJl
Z2lzdGVyX2NwdV9ub3RpZmllcigmcHJvZmlsZV9jcHVfbm90aWZpZXIpOworI2VuZGlmCisJcHJv
ZmlsZV9wYXJhbXNbMF0gPSBwcm9mX29uOworCXByb2ZpbGVfcGFyYW1zWzFdID0gcHJvZl9zaGlm
dDsKIAlyZXR1cm4gMDsKIH0KIG1vZHVsZV9pbml0KGNyZWF0ZV9wcm9jX3Byb2ZpbGUpOwpkaWZm
IC11cHJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNi4xMi1yYzYub3JpZy9rZXJuZWwvc3lzY3RsLmMg
bGludXgtMi42LjEyLXJjNi9rZXJuZWwvc3lzY3RsLmMKLS0tIGxpbnV4LTIuNi4xMi1yYzYub3Jp
Zy9rZXJuZWwvc3lzY3RsLmMJMjAwNS0wNi0yNyAxODoyNToxMy4wMDAwMDAwMDAgKzAzMDAKKysr
IGxpbnV4LTIuNi4xMi1yYzYva2VybmVsL3N5c2N0bC5jCTIwMDUtMDYtMjcgMTA6MTk6MDcuMDAw
MDAwMDAwICswMzAwCkBAIC0yMSw2ICsyMSw3IEBACiAjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+
CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgvbW0uaD4KKyNpbmNs
dWRlIDxsaW51eC9wcm9maWxlLmg+CiAjaW5jbHVkZSA8bGludXgvc3dhcC5oPgogI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9zeXNjdGwuaD4KQEAgLTY0Miw3ICs2NDMs
MTUgQEAgc3RhdGljIGN0bF90YWJsZSBrZXJuX3RhYmxlW10gPSB7CiAJCS5tb2RlCQk9IDA2NDQs
CiAJCS5wcm9jX2hhbmRsZXIJPSAmcHJvY19kb2ludHZlYywKIAl9LAotCisJeworCQkuY3RsX25h
bWUgICAgICAgPSBLRVJOX1BST0ZJTEUsCisJCS5wcm9jbmFtZSAgICAgICA9ICJwcm9maWxlIiwK
KwkJLmRhdGEgICAgICAgICAgID0gJnByb2ZpbGVfcGFyYW1zLAorCQkubWF4bGVuICAgICAgICAg
PSAyKnNpemVvZihpbnQpLAorCQkubW9kZSAgICAgICAgICAgPSAwNjQ0LAorCQkucHJvY19oYW5k
bGVyICAgPSAmcHJvZmlsZV9zeXNjdGxfaGFuZGxlciwKKwkJLnN0cmF0ZWd5ICAgICAgID0gJnN5
c2N0bF9pbnR2ZWMsCisJfSwKIAl7IC5jdGxfbmFtZSA9IDAgfQogfTsKIAo=
------=_Part_5256_15833211.1119886827658--
