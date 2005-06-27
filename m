Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVF0MNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVF0MNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVF0MNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:13:47 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:42648 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261157AbVF0MNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:13:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=b3fMgUND4hs4EGXNLRDClse1R7WWWr7Bbr8d6t9s6Y9Yqnx8vjMX4qRKwz7fwptUpQuzroH8TVwecpcC/ilPmu4DxrDwovVCYloxf4Sg7IUPQUc5c+4BAgqONtBXGUBPnofzDLEhDa81u0PfZ64aaNs5cFy64dn4JGJS/hAuN4I=
Message-ID: <2c1942a7050627051357e9b532@mail.gmail.com>
Date: Mon, 27 Jun 2005 15:13:13 +0300
From: Levent Serinol <lserinol@gmail.com>
Reply-To: Levent Serinol <lserinol@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] enable/disable profiling via proc/sysctl
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, wli@holomorphy.com
In-Reply-To: <20050627000125.1a6f8a91.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4292_3185413.1119874393526"
References: <2c1942a705062623411b7e88c3@mail.gmail.com>
	 <20050627000125.1a6f8a91.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4292_3185413.1119874393526
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,

 The fixed patch is attached. I hope, it's ok this time.=20

Thanks,


On 6/27/05, Andrew Morton <akpm@osdl.org> wrote:
> Levent Serinol <lserinol@gmail.com> wrote:
> >
> > This patch enables controlling kernel profiling through proc/sysctl inf=
erface.
> >
> >  With this patch profiling will be available without rebooting the
> >  machine (especially for
> >  production servers) with some drawbacks of vmalloc(tlb). So, bootime
> >  algorithm part is left unchanged for anyone who wishes to use
> >  profiling as usual without tlb drawback by rebooting the machine.
>=20
>=20
> > --- include/linux/sysctl.h.org        2005-06-13 16:05:17.000000000 +03=
00
> > +++ include/linux/sysctl.h    2005-06-25 15:05:06.000000000 +0300
>=20
> Patches should be in `patch -p1' form, please.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>=20
> > +static int prof_on =3D 0;
> > +static int prof_booton =3D 0;
>=20
> There's no need to explicitly initialise these.
>=20
> > +#ifdef CONFIG_SMP
> > +static int remove_hash_tables(void)
> > +{
> > +     int cpu;
> > +
> > +     smp_mb();
> > +     on_each_cpu(profile_nop, NULL, 0, 1);
>=20
> Why?
>=20
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
>=20
> Can this race against itself?  If two cpus run the sysctl at the same tim=
e?
> We seem to have lock_kernel() coverage.  It's be nice to do something
> firmer.
>=20
> > +int profile_sysctl_handler(ctl_table *table, int write,
> > +     struct file *file, void __user *buffer, size_t *length, loff_t *p=
pos)
> > +{
> > +     int err;
> > +     struct proc_dir_entry *entry;
> > +
> > +     if (prof_booton && write) return 0;
> > +     err=3Dproc_dointvec(table, write, file, buffer, length, ppos);
> > +     if ((err >=3D 0) && write) {
> > +     prof_shift =3D profile_params[1];
> > +     switch(profile_params[0])
> > +     {
> > +     case 0:
> > +             if (prof_on) {
>=20
> Coding style is all over the place here, as well as in most of the rest o=
f
> the patch.
>=20
>=20
>         if (prof_booton && write)
>                 return 0;
>         err =3D proc_dointvec(table, write, file, buffer, length, ppos);
>         if (err >=3D 0 && write) {
>                 prof_shift =3D profile_params[1];
>                 switch (profile_params[0])
>                 {
>                 case 0:
>                         if (prof_on) {
>=20
> Every line was changed there...
>=20
> Also, doing multiple returns per function is unpopular, although the
> very-early
>=20
>         if (foo)
>                 return <something>;
>=20
> right at the top of the function is OK.  You can use
>=20
>         if (err < 0 || !write)
>                 goto out;
>=20
> to save a tab stop.
>=20
> > +                  }
> > +             break;
>=20
>                 }
>                 break;
>=20
> > +     case SCHED_PROFILING || CPU_PROFILING:
>=20
> eh?  I'm surprised the compiler swallowed that.  I guess it's the same as
> `case 1:'.  Looks like a bug though.
>=20
> > +             if (prof_on) return -1;
> > +             prof_len =3D (_etext - _stext) >> prof_shift;
> > +             prof_buffer =3D vmalloc(prof_len*sizeof(atomic_t));
> > +             if (!prof_buffer) return(-ENOMEM);
> > +             if (create_hash_tables()) {
> > +                     vfree(prof_buffer);
> > +                     return -1;
> > +                     }
> > +             prof_on =3D profile_params[0];
> > +             if (!(entry =3D create_proc_entry("profile", S_IWUSR | S_=
IRUGO, NULL))) {
> > +                     remove_hash_tables();
> > +                     vfree(prof_buffer);
> > +                     return 0;
> > +                     }
> > +             entry->proc_fops =3D &proc_profile_operations;
> > +             entry->size =3D (1+prof_len) * sizeof(atomic_t);
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +             register_cpu_notifier(&profile_cpu_notifier);
> > +#endif
> > +             profile_discard_flip_buffers();
> > +             memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
> > +                     switch(prof_on)
> > +                     {
> > +                     case SCHED_PROFILING:printk(KERN_INFO
> > +                             "kernel schedule profiling enabled (shift=
: %ld)\n",
> > +                             prof_shift);
> > +                             break;
> > +                     case CPU_PROFILING:printk(KERN_INFO
> > +                             "kernel profiling enabled (shift: %ld)\n"=
,
> > +                             prof_shift);
> > +                             break;
> > +                             }
> > +                     break;
> > +                     }
> > +             }
> > +     return 0;
> > +}
>=20
> Documentation/CodingStyle is your friend ;)
>=20
> > --- kernel/sysctl.c.org       2005-06-13 16:05:23.000000000 +0300
> > +++ kernel/sysctl.c   2005-06-26 02:06:23.000000000 +0300
> > ...
> > +extern int profile_params[];
>=20
> Try to place this declaration in a header.
>=20
> What locking protects prof_boot_on()?  lock_kernel() won't be sufficient
> because we're doing sleeping allocations in here.
>=20
> I suspect it would be best to whap a semaphore around the whole thing.
>=20


--=20

Stay out of the road, if you want to grow old.=20
~ Pink Floyd ~.

------=_Part_4292_3185413.1119874393526
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
bGludXgvc3lzY3RsLmgJMjAwNS0wNi0yNyAxNTowNjoyMy4wMDAwMDAwMDAgKzAzMDAKKysrIGxp
bnV4LTIuNi4xMi1yYzYvaW5jbHVkZS9saW51eC9zeXNjdGwuaAkyMDA1LTA2LTI3IDEwOjE1OjU0
LjAwMDAwMDAwMCArMDMwMApAQCAtMTM2LDYgKzEzNiw3IEBAIGVudW0KIAlLRVJOX1VOS05PV05f
Tk1JX1BBTklDPTY2LCAvKiBpbnQ6IHVua25vd24gbm1pIHBhbmljIGZsYWcgKi8KIAlLRVJOX0JP
T1RMT0FERVJfVFlQRT02NywgLyogaW50OiBib290IGxvYWRlciB0eXBlICovCiAJS0VSTl9SQU5E
T01JWkU9NjgsIC8qIGludDogcmFuZG9taXplIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSAqLworCUtF
Uk5fUFJPRklMRT02OSwgLyogaW50OiBwcm9maWxlIG9uL29mZiAqLwogfTsKIAogCmRpZmYgLXVw
ck4gLVggZG9udGRpZmYgbGludXgtMi42LjEyLXJjNi5vcmlnL2tlcm5lbC9wcm9maWxlLmMgbGlu
dXgtMi42LjEyLXJjNi9rZXJuZWwvcHJvZmlsZS5jCi0tLSBsaW51eC0yLjYuMTItcmM2Lm9yaWcv
a2VybmVsL3Byb2ZpbGUuYwkyMDA1LTA2LTI3IDE1OjA2OjIzLjAwMDAwMDAwMCArMDMwMAorKysg
bGludXgtMi42LjEyLXJjNi9rZXJuZWwvcHJvZmlsZS5jCTIwMDUtMDYtMjcgMTU6MDU6MDcuMDAw
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
NDgsNiArNTU4LDEwNCBAQCBvdXRfY2xlYW51cDoKICNkZWZpbmUgY3JlYXRlX2hhc2hfdGFibGVz
KCkJCQkoeyAwOyB9KQogI2VuZGlmCiAKKyNpZmRlZiBDT05GSUdfU01QCitpbnQgcmVtb3ZlX2hh
c2hfdGFibGVzKHZvaWQpCit7CisJaW50IGNwdTsKKworCisJZm9yX2VhY2hfb25saW5lX2NwdShj
cHUpIHsKKwkJc3RydWN0IHBhZ2UgKnBhZ2U7CisKKwkJaWYgKHBlcl9jcHUoY3B1X3Byb2ZpbGVf
aGl0cywgY3B1KVswXSkgeworCQkJcGFnZSA9IHZpcnRfdG9fcGFnZShwZXJfY3B1KGNwdV9wcm9m
aWxlX2hpdHMsIGNwdSlbMF0pOworCQkJcGVyX2NwdShjcHVfcHJvZmlsZV9oaXRzLCBjcHUpWzBd
ID0gTlVMTDsKKwkJCV9fZnJlZV9wYWdlKHBhZ2UpOworCQl9CisJCWlmIChwZXJfY3B1KGNwdV9w
cm9maWxlX2hpdHMsIGNwdSlbMV0pIHsKKwkJCXBhZ2UgPSB2aXJ0X3RvX3BhZ2UocGVyX2NwdShj
cHVfcHJvZmlsZV9oaXRzLCBjcHUpWzFdKTsKKwkJCXBlcl9jcHUoY3B1X3Byb2ZpbGVfaGl0cywg
Y3B1KVsxXSA9IE5VTEw7CisJCQlfX2ZyZWVfcGFnZShwYWdlKTsKKwkJfQorCX0KKwlyZXR1cm4g
LTE7Cit9CisjZWxzZQorI2RlZmluZSByZW1vdmVfaGFzaF90YWJsZXMoKQkJCSh7IDA7IH0pCisj
ZW5kaWYKKworaW50IHByb2ZpbGVfc3lzY3RsX2hhbmRsZXIoY3RsX3RhYmxlICp0YWJsZSwgaW50
IHdyaXRlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgCisJCXZvaWQgX191c2VyICpidWZmZXIsIHNpemVf
dCAqbGVuZ3RoLCBsb2ZmX3QgKnBwb3MpCit7CisJaW50IGVycjsKKwlzdHJ1Y3QgcHJvY19kaXJf
ZW50cnkgKmVudHJ5OworCisKKwlkb3duKCZwcm9mX3NlbSk7CisKKwlpZiAocHJvZl9ib290b24g
JiYgd3JpdGUpIAorCQlnb3RvIG91dDsKKworCWVycj1wcm9jX2RvaW50dmVjKHRhYmxlLCB3cml0
ZSwgZmlsZSwgYnVmZmVyLCBsZW5ndGgsIHBwb3MpOworCWlmIChlcnIgPCAwIHx8ICF3cml0ZSkK
KwkJZ290byBvdXQ7CisKKwlwcm9mX3NoaWZ0ID0gcHJvZmlsZV9wYXJhbXNbMV07CisKKwlpZiAo
IXByb2ZpbGVfcGFyYW1zWzBdKSB7CisJCWlmIChwcm9mX29uKSB7CisJCQlwcm9mX29uID0gMDsK
KwkJCXJlbW92ZV9wcm9jX2VudHJ5KCJwcm9maWxlIixOVUxMKTsKKyNpZmRlZiBDT05GSUdfSE9U
UExVR19DUFUKKwkJCXVucmVnaXN0ZXJfY3B1X25vdGlmaWVyKCZwcm9maWxlX2NwdV9ub3RpZmll
cik7CisjZW5kaWYKKwkJCXJlbW92ZV9oYXNoX3RhYmxlcygpOworCQkJdmZyZWUocHJvZl9idWZm
ZXIpOworCQkJcHJpbnRrKEtFUk5fSU5GTyAia2VybmVsIHByb2ZpbGluZyBkaXNhYmxlZFxuIik7
CisJCX0KKwl9CisKKwlpZiAoKHByb2ZpbGVfcGFyYW1zWzBdPT1TQ0hFRF9QUk9GSUxJTkcpIHx8
IChwcm9maWxlX3BhcmFtc1swXT09Q1BVX1BST0ZJTElORykpIHsKKwkJaWYgKHByb2Zfb24pCisJ
CQlnb3RvIG91dDsKKyAgICAgICAgCXByb2ZfbGVuID0gKF9ldGV4dCAtIF9zdGV4dCkgPj4gcHJv
Zl9zaGlmdDsKKyAgICAgICAgCXByb2ZfYnVmZmVyID0gdm1hbGxvYyhwcm9mX2xlbipzaXplb2Yo
YXRvbWljX3QpKTsKKwkJaWYgKCFwcm9mX2J1ZmZlcikKKwkJCWdvdG8gb3V0OworCQlpZiAoY3Jl
YXRlX2hhc2hfdGFibGVzKCkpIHsKKwkJCXZmcmVlKHByb2ZfYnVmZmVyKTsKKwkJCWdvdG8gb3V0
OworCQl9CisJCXByb2Zfb24gPSBwcm9maWxlX3BhcmFtc1swXTsKKwkJaWYgKCEoZW50cnkgPSBj
cmVhdGVfcHJvY19lbnRyeSgicHJvZmlsZSIsIFNfSVdVU1IgfCBTX0lSVUdPLCBOVUxMKSkpIHsK
KwkJCXJlbW92ZV9oYXNoX3RhYmxlcygpOworCQkJdmZyZWUocHJvZl9idWZmZXIpOworCQkJZ290
byBvdXQ7CisJCX0KKwkJZW50cnktPnByb2NfZm9wcyA9ICZwcm9jX3Byb2ZpbGVfb3BlcmF0aW9u
czsKKwkJZW50cnktPnNpemUgPSAoMStwcm9mX2xlbikgKiBzaXplb2YoYXRvbWljX3QpOworI2lm
ZGVmIENPTkZJR19IT1RQTFVHX0NQVQorCQlyZWdpc3Rlcl9jcHVfbm90aWZpZXIoJnByb2ZpbGVf
Y3B1X25vdGlmaWVyKTsKKyNlbmRpZgorCQlwcm9maWxlX2Rpc2NhcmRfZmxpcF9idWZmZXJzKCk7
CisgICAgICAgIAltZW1zZXQocHJvZl9idWZmZXIsIDAsIHByb2ZfbGVuICogc2l6ZW9mKGF0b21p
Y190KSk7CisJCQlzd2l0Y2gocHJvZl9vbikgeworCQkJY2FzZSBTQ0hFRF9QUk9GSUxJTkc6CisJ
CQkJcHJpbnRrKEtFUk5fSU5GTyAia2VybmVsIHNjaGVkdWxlIHByb2ZpbGluZyBlbmFibGVkIChz
aGlmdDogJWxkKVxuIiwKKwkJCQkJCXByb2Zfc2hpZnQpOworCQkJCWJyZWFrOworCQkJY2FzZSBD
UFVfUFJPRklMSU5HOgorCQkJCXByaW50ayhLRVJOX0lORk8gImtlcm5lbCBwcm9maWxpbmcgZW5h
YmxlZCAoc2hpZnQ6ICVsZClcbiIsCisJCQkJCQlwcm9mX3NoaWZ0KTsKKwkJCQlicmVhazsKKwkJ
CX0gCisJfQorCitvdXQ6CisJdXAoJnByb2Zfc2VtKTsKKwlyZXR1cm4gMDsKK30KKwogc3RhdGlj
IGludCBfX2luaXQgY3JlYXRlX3Byb2NfcHJvZmlsZSh2b2lkKQogewogCXN0cnVjdCBwcm9jX2Rp
cl9lbnRyeSAqZW50cnk7CkBAIC01NjAsNyArNjY4LDExIEBAIHN0YXRpYyBpbnQgX19pbml0IGNy
ZWF0ZV9wcm9jX3Byb2ZpbGUodm8KIAkJcmV0dXJuIDA7CiAJZW50cnktPnByb2NfZm9wcyA9ICZw
cm9jX3Byb2ZpbGVfb3BlcmF0aW9uczsKIAllbnRyeS0+c2l6ZSA9ICgxK3Byb2ZfbGVuKSAqIHNp
emVvZihhdG9taWNfdCk7Ci0JaG90Y3B1X25vdGlmaWVyKHByb2ZpbGVfY3B1X2NhbGxiYWNrLCAw
KTsKKyNpZmRlZiBDT05GSUdfSE9UUExVR19DUFUKKwlyZWdpc3Rlcl9jcHVfbm90aWZpZXIoJnBy
b2ZpbGVfY3B1X25vdGlmaWVyKTsKKyNlbmRpZgorCXByb2ZpbGVfcGFyYW1zWzBdID0gcHJvZl9v
bjsKKwlwcm9maWxlX3BhcmFtc1sxXSA9IHByb2Zfc2hpZnQ7CiAJcmV0dXJuIDA7CiB9CiBtb2R1
bGVfaW5pdChjcmVhdGVfcHJvY19wcm9maWxlKTsKZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51
eC0yLjYuMTItcmM2Lm9yaWcva2VybmVsL3N5c2N0bC5jIGxpbnV4LTIuNi4xMi1yYzYva2VybmVs
L3N5c2N0bC5jCi0tLSBsaW51eC0yLjYuMTItcmM2Lm9yaWcva2VybmVsL3N5c2N0bC5jCTIwMDUt
MDYtMjcgMTU6MDY6MjMuMDAwMDAwMDAwICswMzAwCisrKyBsaW51eC0yLjYuMTItcmM2L2tlcm5l
bC9zeXNjdGwuYwkyMDA1LTA2LTI3IDEwOjE5OjA3LjAwMDAwMDAwMCArMDMwMApAQCAtMjEsNiAr
MjEsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CisjaW5jbHVkZSA8bGludXgvcHJvZmlsZS5oPgog
I2luY2x1ZGUgPGxpbnV4L3N3YXAuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVk
ZSA8bGludXgvc3lzY3RsLmg+CkBAIC02NDIsNyArNjQzLDE1IEBAIHN0YXRpYyBjdGxfdGFibGUg
a2Vybl90YWJsZVtdID0gewogCQkubW9kZQkJPSAwNjQ0LAogCQkucHJvY19oYW5kbGVyCT0gJnBy
b2NfZG9pbnR2ZWMsCiAJfSwKLQorCXsKKwkJLmN0bF9uYW1lICAgICAgID0gS0VSTl9QUk9GSUxF
LAorCQkucHJvY25hbWUgICAgICAgPSAicHJvZmlsZSIsCisJCS5kYXRhICAgICAgICAgICA9ICZw
cm9maWxlX3BhcmFtcywKKwkJLm1heGxlbiAgICAgICAgID0gMipzaXplb2YoaW50KSwKKwkJLm1v
ZGUgICAgICAgICAgID0gMDY0NCwKKwkJLnByb2NfaGFuZGxlciAgID0gJnByb2ZpbGVfc3lzY3Rs
X2hhbmRsZXIsCisJCS5zdHJhdGVneSAgICAgICA9ICZzeXNjdGxfaW50dmVjLAorCX0sCiAJeyAu
Y3RsX25hbWUgPSAwIH0KIH07CiAK
------=_Part_4292_3185413.1119874393526--
