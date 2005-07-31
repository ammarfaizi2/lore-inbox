Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVGaS5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVGaS5T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVGaS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:57:19 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:3977 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261900AbVGaS5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:57:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=lXvoPUDroJGZmDdqPSZriy2MdRjSExx9BqmF90SNIWAvWgIiUqUyrlTHUpG6bO+dOPIDQCiYXCMFF4fj8dhVeVN+fbOYJd+LcNo1SQG2xWABmkt2biQ5gXkudrnLDDZSiLcI8GbIr884Bl5dAdq5nivuTJCXXjenMdhIhZvOdwY=
Message-ID: <355e5e5e05073111577d9d3ea6@mail.gmail.com>
Date: Sun, 31 Jul 2005 11:57:13 -0700
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3 RESEND] Add disk hotswap support to libata
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42E671EE.7000309@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2123_28009498.1122836233312"
References: <355e5e5e050722111141c0bf14@mail.gmail.com>
	 <42E671EE.7000309@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2123_28009498.1122836233312
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 7/26/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> > +static void pdc2_phy_reset(struct ata_port *ap)
> > +{
> > +     /* As observed on the Promise SATAII150 Tx2 Plus/Tx4, giving the
> > +      * controller a hard reset triggers another hotplug interrupt.  S=
o
> > +      * disable them for the hard reset, and re-enable afterwards.
> > +      *
> > +      * No PATA support here yet
> > +      */
> > +     if (ap->flags & ATA_FLAG_SATA_RESET && ap->flags & ATA_FLAG_SATA)=
 {
> > +             pdc2_disable_channel_hotplug_interrupts(ap);
> > +             pdc_phy_reset(ap);
> > +             pdc2_enable_channel_hotplug_interrupts(ap);
> > +     } else
> > +             pdc_phy_reset(ap);
> > +}
>=20
> Don't special case this.  disable/enable hotplug interrupts for all
> controllers.
>=20

OK, I've done this in my new patches.

<snip>

> > +     if (mask =3D=3D 0xffffffff)
> > +             goto try_hotplug;
>=20
> you are confusing controller hotplug (mask =3D=3D 0xffffffff) and device
> hotplug.
>=20
> controller hotplug should already be handled correct, by testing
> 0xffffffff and supporting the PCI ->remove hook.
>=20

Yes.  Done this as well.

<snip>

> > +     if (plugdata) {
> > +             writeb(plugdata, mmio_base + hotplug_regs);
> > +             for (i =3D 0; i < host_set->n_ports; ++i) {
> > +                     ap =3D host_set->ports[i];
> > +                     if (!(ap->flags & ATA_FLAG_SATA))
> > +                             continue;  //No PATA support here... yet
> > +                     // Check unplug flag
> > +                     if (plugdata & 0x01) {
> > +                             ata_hotplug_unplug(ap);
> > +                             handled =3D 1;
> > +                     } else if ((plugdata >> 4) & 0x01) {  //Check plu=
g flag
> > +                             ata_hotplug_plug(ap);
> > +                             handled =3D 1;
> > +                     }
> > +                     plugdata >>=3D 1;
>=20
> you probably need a debounce timer; see the SiI email I am about to send.

Keep in mind that I sent three patches:
- 01 - sata_promise properly supporting SATAII150 controllers
- 02 - libata hotswap infrastructure
- 03 - sata_promise supporting the infrastructure

I believe the debounce timer should really go into patch 02.  This is
actually something that's probably needed by every controller... if
you're just plugging drives in/out of a controller, what you're doing
is connecting metal pins, they can be imprecise and trigger a whole
host of interrupts.  Hence, I propose changing patch 02 (attached for
all of your convenience) to be as follows:
- on calling ata_hotplug_unplug:  if a debounce timer is running, stop
it.  Conditionally call ap->ops->unplug_janitor or something like
that, for cases (like the Sil driver, it would seem) that need to do
something special like hard-reset the channel.  Start a new
debounce_timer  (say, with an interval of 500ms, as suggested by the
Sil guys?
- on calling ata_hotplug_plug:  if a debounce_timer is running, stop
it.  Conditionally call ap->ops->plug_janitor, if any driver needs
anything special done on a plug action.  Start a new one.
- when the debounce_timer goes off, the first thing it does is call
ap->ops->hotplug_action, which returns whether it should be plugging
or unplugging.  On a plug, do an ata_bus_probe, an an ata_scsi_plug on
success, ata_scsi_unplug on failure.  On an unplug event,
ata_port_disable and then call ata_scsi_unplug (kill any outstanding
taskfiles).

This means that patch 02 will no longer have a workqueue, but a timer.

Any suggestions/comments on this approach?

Luke Kosewski

------=_Part_2123_28009498.1122836233312
Content-Type: text/x-patch; name="02-libata_hotswap_infrastructure-2.6.13-rc3-mm1.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="02-libata_hotswap_infrastructure-2.6.13-rc3-mm1.diff"

MjEuMDcuMDUgIEx1a2UgS29zZXdza2kgIDxsa29zZXdza0BuaXQuY2E+CgoJKiBBIHBhdGNoIHRv
IGFkZCBhIGdlbmVyYWwtcHVycG9zZSBob3Rzd2FwIGZyYW1ld29yayB0byBsaWJhdGEuICBGcm9t
CgkgIHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoZSBkcml2ZXIgd3JpdGVyLCB3ZSBvbmx5IGhhdmUg
dHdvIG5ldyBBUEkKCSAgZnVuY3Rpb25zOyAnYXRhX2hvdHBsdWdfcGx1ZycgYW5kICdhdGFfaG90
cGx1Z191bnBsdWcnLCB3aGljaCBoYXZlCgkgIHJhdGhlciBzZWxmLWV4cGxhbmF0b3J5IGZ1bmN0
aW9ucy4KCSogQSBmZXcgbWlzYyBjaGFuZ2VzIGFyZSBuZWNlc3NhcnkgdG8gcHJvcGVybHkgcmVz
ZXQgZmxhZ3Mgd2hpY2ggYXJlCgkgIHNldCBieSBkZXZpY2VzIHdoZW4gdGhleSBhcmUgcHJlc2Vu
dCB0byBtYWtlIHN1cmUgdGhhdCBuZXcgZGV2aWNlcwoJICAoZm9yIGluc3RhbmNlLCBkaXNrcyB3
aXRoIGRpZmZlcmVudCBtYXggVURNQSB0cmFuc2ZlciByYXRlcywgbm90IHVzaW5nCgkgIExCQTQ4
LCBldGMuKSBiZWluZyBzd2FwcGVkIGluIGRvIG5vdCBhc3N1bWUgdmFsdWVzIGZvciB0aGUgb2xk
CgkgIGRldmljZXMuCgkqIEdyYXR1aXRvdXMgY29tbWVudHMgaGVyZSB0aGF0IGNhbiBwcm9iYWJs
eSBiZSByZW1vdmVkLCBzbyB0aGF0IGFueW9uZQoJICBsb29raW5nIGF0IHRoaXMgY2FuIHVuZGVy
c3RhbmQgdGhpcyBhbmQgcG9rZSBob2xlcyBpbiBteSBsb2dpYy4KClNpZ25lZC1vZmYtYnk6ICBM
dWtlIEtvc2V3c2tpIDxsa29zZXdza0BuaXQuY2E+CgotLS0gbGludXgtMi42LjEzLXJjMy9kcml2
ZXJzL3Njc2kvbGliYXRhLWNvcmUuYy5vbGQJMjAwNS0wNy0yMSAxMzozNTozMS42MDk4MzIzMjQg
LTA0MDAKKysrIGxpbnV4LTIuNi4xMy1yYzMvZHJpdmVycy9zY3NpL2xpYmF0YS1jb3JlLmMJMjAw
NS0wNy0yMSAxMzo0Mjo1My45NDUzODYwNjAgLTA0MDAKQEAgLTQ0LDcgKzQ0LDYgQEAKICNpbmNs
dWRlIDxzY3NpL3Njc2lfaG9zdC5oPgogI2luY2x1ZGUgPGxpbnV4L2xpYmF0YS5oPgogI2luY2x1
ZGUgPGFzbS9pby5oPgotI2luY2x1ZGUgPGFzbS9zZW1hcGhvcmUuaD4KICNpbmNsdWRlIDxhc20v
Ynl0ZW9yZGVyLmg+CiAKICNpbmNsdWRlICJsaWJhdGEuaCIKQEAgLTY1LDYgKzY0LDcgQEAgc3Rh
dGljIHZvaWQgX19hdGFfcWNfY29tcGxldGUoc3RydWN0IGF0YQogCiBzdGF0aWMgdW5zaWduZWQg
aW50IGF0YV91bmlxdWVfaWQgPSAxOwogc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICph
dGFfd3E7CitzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmF0YV9pcnFfd3E7CiAKIE1P
RFVMRV9BVVRIT1IoIkplZmYgR2FyemlrIik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkxpYnJhcnkg
bW9kdWxlIGZvciBBVEEgZGV2aWNlcyIpOwpAQCAtMTEzNCw2ICsxMTM0LDExIEBAIHN0YXRpYyB2
b2lkIGF0YV9kZXZfaWRlbnRpZnkoc3RydWN0IGF0YV8KIAkJcmV0dXJuOwogCX0KIAorCS8qIE5l
Y2Vzc2FyeSBpZiB3ZSBoYWQgYW4gTEJBNDggZHJpdmUgaW4sIHdlIHB1bGxlZCBpdCBvdXQsIGFu
ZCBwdXQgaW4KKwkgKiBhIG5vbi1MQkE0OCBkcml2ZSB0byByZXBsYWNlIGl0LgorCSAqLworCWRl
di0+ZmxhZ3MgJj0gfkFUQV9ERkxBR19MQkE0ODsKKwogCWlmIChhcC0+ZmxhZ3MgJiAoQVRBX0ZM
QUdfU1JTVCB8IEFUQV9GTEFHX1NBVEFfUkVTRVQpKQogCQl1c2luZ19lZGQgPSAwOwogCWVsc2UK
QEAgLTM2MzUsNiArMzY0MCw3MyBAQCBpZGxlX2lycToKIAlyZXR1cm4gMDsJLyogaXJxIG5vdCBo
YW5kbGVkICovCiB9CiAKK3ZvaWQgYXRhX2NoZWNrX2tpbGxfcWMoc3RydWN0IGF0YV9wb3J0ICph
cCkKK3sKKwlzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKnFjID0gYXRhX3FjX2Zyb21fdGFnKGFwLCBh
cC0+YWN0aXZlX3RhZyk7CisKKwlpZiAodW5saWtlbHkocWMpKSB7CisJCS8qIFRoaXMgaXMgU08g
YmFkLiAgQnV0IHdlIGNhbid0IGp1c3QgcnVuCisJCSAqIGF0YV9xY19jb21wbGV0ZSB3aXRob3V0
IGRvaW5nIHRoaXMsIGJlY2F1c2UKKwkJICogYXRhX3Njc2lfcWNfY29tcGxldGUgd2FudHMgdG8g
dGFsayB0byB0aGUgZGV2aWNlLAorCQkgKiBhbmQgd2UgY2FuJ3QgbGV0IGl0IGRvIHRoYXQgc2lu
Y2UgaXQgZG9lc24ndCBleGlzdAorCQkgKiBhbnltb3JlLgorCQkgKi8KKwkJYXRhX3Njc2lfcHJl
cGFyZV9xY19hYm9ydChxYyk7CisJCWF0YV9xY19jb21wbGV0ZShxYywgQVRBX0VSUik7CisJfQor
fQorCitzdGF0aWMgdm9pZCBhdGFfaG90cGx1Z191bnBsdWdfZnVuYyh2b2lkICpfZGF0YSkKK3sK
KwlzdHJ1Y3QgYXRhX3BvcnQgKmFwID0gKHN0cnVjdCBhdGFfcG9ydCAqKV9kYXRhOworCURQUklO
VEsoIkdvdCBhbiB1bnBsdWcgcmVxdWVzdCBvbiBwb3J0ICVkXG4iLCBhcC0+aWQpOworCisJZG93
bigmYXAtPmhvdHBsdWdfbXV0ZXgpOworCisJYXRhX3Njc2lfaGFuZGxlX3VucGx1ZyhhcCk7CisK
Kwl1cCgmYXAtPmhvdHBsdWdfbXV0ZXgpOworfQorCitzdGF0aWMgdm9pZCBhdGFfaG90cGx1Z19w
bHVnX2Z1bmModm9pZCAqX2RhdGEpCit7CisJc3RydWN0IGF0YV9wb3J0ICphcCA9IChzdHJ1Y3Qg
YXRhX3BvcnQgKilfZGF0YTsKKwlEUFJJTlRLKCJHb3QgYSBwbHVnIHJlcXVlc3Qgb24gcG9ydCAl
ZFxuIiwgYXAtPmlkKTsKKworCWRvd24oJmFwLT5ob3RwbHVnX211dGV4KTsKKwkvKiBQdXJlIGV2
aWwuICBTdXBwb3NlIHRoYXQgeW91IGhhdmUgYW4gJ3VucGx1Zycgd2FpdGluZyBvbiB5b3VyCisJ
ICogcXVldWUsIGFuZCB0aGlzIGZ1bmN0aW9uIGV4ZWN1dGVzIHdoaWxlIGl0J3MgdGhlcmUgKGJl
Y2F1c2UgCisJICogeW91IHVucGx1Z2dlZC9wbHVnZ2VkIGluIGEgZGlzayBvbiBhbiBTTVAgc3lz
dGVtIFZFUlkgRkFTVCkuCisJICogUkVBTExZIGJhZCBuZXdzLCBiZWNhdXNlIHdoZW4geW91IHVu
cGx1Z2dlZCB5b3VyIGRpc2ssIHlvdQorCSAqIG1pZ2h0IGhhdmUgaGFkIGEgcGVuZGluZyBxYyB3
aGljaCB3aWxsIG5vdyBzaXQgdGhlcmUgYW5kIHRpbWUKKwkgKiBvdXQgbGlrZSB0aGUgbW9mbyBp
dCBpcy4gIENoZWNrIHRvIHNlZSBpZiB3ZSBoYXZlIG9uZSBzaXR0aW5nCisJICogYXJvdW5kIGFu
ZCBLSUxMIElUIGlmIHRoaXMgaXMgc28uCisJICovCisJYXRhX2NoZWNrX2tpbGxfcWMoYXApOwor
CS8vIE9ic2VydmVkIG5lY2Vzc2FyeSBvbiBzb21lIFNlYWdhdGUgZHJpdmVzLgorCWFwLT5mbGFn
cyB8PSBBVEFfRkxBR19TQVRBX1JFU0VUOworCWFwLT51ZG1hX21hc2sgPSBhcC0+b3JpZ191ZG1h
X21hc2s7CisKKwlpZiAoYXRhX2J1c19wcm9iZShhcCkgLyogRG9lcyBpdHMgb3duIGxvY2tpbmcg
Ki8pCisJCWF0YV9zY3NpX2hhbmRsZV91bnBsdWcoYXApOyAgLy9taWdodCBiZSBuZWNlc3Nhcnkg
b24gU01QCisJZWxzZQorCQlhdGFfc2NzaV9oYW5kbGVfcGx1ZyhhcCk7CisJdXAoJmFwLT5ob3Rw
bHVnX211dGV4KTsKK30KKworLyogU2hvdWxkIGJlIHByb3RlY3RlZCBieSBob3N0X3NldC0+bG9j
ayAqLwordm9pZCBhdGFfaG90cGx1Z191bnBsdWcoc3RydWN0IGF0YV9wb3J0ICphcCkKK3sKKwlh
dGFfcG9ydF9kaXNhYmxlKGFwKTsgLy9kaXNhYmxlIHRoaXMgTk9XLCBkZXZpY2UgaXMgZ29uZQor
CXF1ZXVlX3dvcmsoYXRhX2lycV93cSwgJmFwLT5ob3RwbHVnX3VucGx1Z190YXNrKTsKK30KKwor
LyogU2hvdWxkIGJlIHByb3RlY3RlZCBieSBob3N0X3NldC0+bG9jayAqLwordm9pZCBhdGFfaG90
cGx1Z19wbHVnKHN0cnVjdCBhdGFfcG9ydCAqYXApCit7CisJcXVldWVfd29yayhhdGFfaXJxX3dx
LCAmYXAtPmhvdHBsdWdfcGx1Z190YXNrKTsKK30KKwogLyoqCiAgKglhdGFfaW50ZXJydXB0IC0g
RGVmYXVsdCBBVEEgaG9zdCBpbnRlcnJ1cHQgaGFuZGxlcgogICoJQGlycTogaXJxIGxpbmUgKHVu
dXNlZCkKQEAgLTM4NjAsNyArMzkzMiwxMSBAQCBzdGF0aWMgdm9pZCBhdGFfaG9zdF9pbml0KHN0
cnVjdCBhdGFfcG9yCiAJYXAtPmNibCA9IEFUQV9DQkxfTk9ORTsKIAlhcC0+YWN0aXZlX3RhZyA9
IEFUQV9UQUdfUE9JU09OOwogCWFwLT5sYXN0X2N0bCA9IDB4RkY7CisJYXAtPm9yaWdfdWRtYV9t
YXNrID0gZW50LT51ZG1hX21hc2s7CiAKKwlpbml0X01VVEVYKCZhcC0+aG90cGx1Z19tdXRleCk7
CisJSU5JVF9XT1JLKCZhcC0+aG90cGx1Z19wbHVnX3Rhc2ssIGF0YV9ob3RwbHVnX3BsdWdfZnVu
YywgYXApOworCUlOSVRfV09SSygmYXAtPmhvdHBsdWdfdW5wbHVnX3Rhc2ssIGF0YV9ob3RwbHVn
X3VucGx1Z19mdW5jLCBhcCk7CiAJSU5JVF9XT1JLKCZhcC0+cGFja2V0X3Rhc2ssIGF0YXBpX3Bh
Y2tldF90YXNrLCBhcCk7CiAJSU5JVF9XT1JLKCZhcC0+cGlvX3Rhc2ssIGF0YV9waW9fdGFzaywg
YXApOwogCkBAIC00NDY4LDYgKzQ1NDQsMTEgQEAgc3RhdGljIGludCBfX2luaXQgYXRhX2luaXQo
dm9pZCkKIAlhdGFfd3EgPSBjcmVhdGVfd29ya3F1ZXVlKCJhdGEiKTsKIAlpZiAoIWF0YV93cSkK
IAkJcmV0dXJuIC1FTk9NRU07CisJYXRhX2lycV93cSA9IGNyZWF0ZV93b3JrcXVldWUoImF0YV9p
cnEiKTsKKwlpZiAoIWF0YV9pcnFfd3EpIHsKKwkJZGVzdHJveV93b3JrcXVldWUoYXRhX3dxKTsK
KwkJcmV0dXJuIC1FTk9NRU07CisJfQogCiAJcHJpbnRrKEtFUk5fREVCVUcgImxpYmF0YSB2ZXJz
aW9uICIgRFJWX1ZFUlNJT04gIiBsb2FkZWQuXG4iKTsKIAlyZXR1cm4gMDsKQEAgLTQ0NzYsNiAr
NDU1Nyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGF0YV9pbml0KHZvaWQpCiBzdGF0aWMgdm9pZCBf
X2V4aXQgYXRhX2V4aXQodm9pZCkKIHsKIAlkZXN0cm95X3dvcmtxdWV1ZShhdGFfd3EpOworCWRl
c3Ryb3lfd29ya3F1ZXVlKGF0YV9pcnFfd3EpOwogfQogCiBtb2R1bGVfaW5pdChhdGFfaW5pdCk7
CkBAIC00NTMxLDYgKzQ2MTMsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTChhdGFfZGV2X2NsYXNzaWZ5
KTsKIEVYUE9SVF9TWU1CT0xfR1BMKGF0YV9kZXZfaWRfc3RyaW5nKTsKIEVYUE9SVF9TWU1CT0xf
R1BMKGF0YV9kZXZfY29uZmlnKTsKIEVYUE9SVF9TWU1CT0xfR1BMKGF0YV9zY3NpX3NpbXVsYXRl
KTsKK0VYUE9SVF9TWU1CT0xfR1BMKGF0YV9ob3RwbHVnX3VucGx1Zyk7CitFWFBPUlRfU1lNQk9M
X0dQTChhdGFfaG90cGx1Z19wbHVnKTsKIAogI2lmZGVmIENPTkZJR19QQ0kKIEVYUE9SVF9TWU1C
T0xfR1BMKHBjaV90ZXN0X2NvbmZpZ19iaXRzKTsKLS0tIGxpbnV4LTIuNi4xMy1yYzMvZHJpdmVy
cy9zY3NpL2xpYmF0YS1zY3NpLmMub2xkCTIwMDUtMDctMjEgMTM6MzU6MzUuNjIyNjg0ODUwIC0w
NDAwCisrKyBsaW51eC0yLjYuMTMtcmMzL2RyaXZlcnMvc2NzaS9saWJhdGEtc2NzaS5jCTIwMDUt
MDctMjEgMTM6NDI6NTMuOTUwMzg0NjI3IC0wNDAwCkBAIC0xMDExLDYgKzEwMTEsNTMgQEAgc3Rh
dGljIGludCBhdGFfc2NzaV9xY19jb21wbGV0ZShzdHJ1Y3QgYQogCXJldHVybiAwOwogfQogCitz
dGF0aWMgaW50IGF0YV9zY3NpX3FjX2Fib3J0KHN0cnVjdCBhdGFfcXVldWVkX2NtZCAqcWMsIHU4
IGRydl9zdGF0KQoreworCXN0cnVjdCBzY3NpX2NtbmQgKmNtZCA9IHFjLT5zY3NpY21kOworCisJ
Y21kLT5yZXN1bHQgPSBTQU1fU1RBVF9UQVNLX0FCT1JURUQ7IC8vRklYTUU6ICBJcyB0aGlzIHdo
YXQgd2Ugd2FudD8KKworCXFjLT5zY3NpZG9uZShjbWQpOworCisJcmV0dXJuIDA7Cit9CisKK3Zv
aWQgYXRhX3Njc2lfcHJlcGFyZV9xY19hYm9ydChzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKnFjKQor
eworCS8vIEZvciBzb21lIHJlYXNvbiBvciBhbm90aGVyLCB3ZSBjYW4ndCBhbGxvdyBhIG5vcm1h
bCBzY3NpX3FjX2NvbXBsZXRlCisJaWYgKHFjLT5jb21wbGV0ZV9mbiA9PSBhdGFfc2NzaV9xY19j
b21wbGV0ZSk7CisJCXFjLT5jb21wbGV0ZV9mbiA9IGF0YV9zY3NpX3FjX2Fib3J0OworfQorCit2
b2lkIGF0YV9zY3NpX2hhbmRsZV9wbHVnKHN0cnVjdCBhdGFfcG9ydCAqYXApCit7CisJLy9DdXJy
ZW50bHkgU0FUQSBvbmx5CisJc2NzaV9hZGRfZGV2aWNlKGFwLT5ob3N0LCAwLCAwLCAwKTsKK30K
Kwordm9pZCBhdGFfc2NzaV9oYW5kbGVfdW5wbHVnKHN0cnVjdCBhdGFfcG9ydCAqYXApCit7CisJ
Ly9TQVRBIG9ubHksIG5vIFBBVEEKKwlzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNjZCA9IHNjc2lfZGV2
aWNlX2xvb2t1cChhcC0+aG9zdCwgMCwgMCwgMCk7CisJLyogc2NkIG1pZ2h0IG5vdCBleGlzdDsg
c29tZW9uZSBkaWQgJ2VjaG8gInNjc2kgcmVtb3ZlLXNpbmdsZS1kZXZpY2UKKwkgKiAuLi4gIiA+
IC9wcm9jL3Njc2kvc2NzaScgb3Igc29tZWJvZHkgIHdhcyB0dXJuaW5nIHRoZSBrZXkgaW4gdGhl
CisJICogaG90c3dhcCBiYXkgYmV0d2VlbiBvbiBhbmQgb2ZmIHJlYWxseSByZWFsbHkgZmFzdC4K
KwkgKi8KKwlpZiAoc2NkKSB7CisJCXNjc2lfZGV2aWNlX3NldF9zdGF0ZShzY2QsIFNERVZfQ0FO
Q0VMKTsKKwkJLyogV2UgbWlnaHQgaGF2ZSBhIHBlbmRpbmcgcWMgb24gSS9PIHRvIGEgcmVtb3Zl
ZCBkZXZpY2UsCisJCSAqIGhvd2V2ZXIsIEkgYXJndWUgaXQncyBpbXBvc3NpYmxlIHVubGVzcyB3
ZSBoYXZlIGFuICdzY2QnCisJCSAqIGJlY2F1c2UgaXQgbWVhbnMgd2UgbmV2ZXIgY29tcGxldGVk
IGEgJ3BsdWcnIGludG8gdGhlIHN5c3RlbQorCQkgKiAob3Igbm8gZGV2aWNlIHdhcyBwcmVzZW50
IG9uIGJvb3R1cCksIHNvIGVpdGhlciB3ZSBoYXZlIG5vCisJCSAqIHBvc3NpYmxlIEkvTywgb3Ig
YSBxYyB3aGljaCAnYXRhX2hvdHBsdWdfcGx1Z19mdW5jJyB0b29rCisJCSAqIGNhcmUgb2YKKwkJ
ICovCisJCWF0YV9jaGVja19raWxsX3FjKGFwKTsKKwkJc2NzaV9yZW1vdmVfZGV2aWNlKHNjZCk7
CisJCXNjc2lfZGV2aWNlX3B1dChzY2QpOworCX0KK30KKwogLyoqCiAgKglhdGFfc2NzaV90cmFu
c2xhdGUgLSBUcmFuc2xhdGUgdGhlbiBpc3N1ZSBTQ1NJIGNvbW1hbmQgdG8gQVRBIGRldmljZQog
ICoJQGFwOiBBVEEgcG9ydCB0byB3aGljaCB0aGUgY29tbWFuZCBpcyBhZGRyZXNzZWQKLS0tIGxp
bnV4LTIuNi4xMy1yYzMvZHJpdmVycy9zY3NpL2xpYmF0YS5oLm9sZAkyMDA1LTA3LTIxIDEzOjM1
OjI0LjIxNzk0NTk1NSAtMDQwMAorKysgbGludXgtMi42LjEzLXJjMy9kcml2ZXJzL3Njc2kvbGli
YXRhLmgJMjAwNS0wNy0yMSAxMzo0Mjo1My45NTUzODMxOTMgLTA0MDAKQEAgLTQwLDYgKzQwLDcg
QEAgZXh0ZXJuIHN0cnVjdCBhdGFfcXVldWVkX2NtZCAqYXRhX3FjX25ldwogZXh0ZXJuIHZvaWQg
YXRhX3FjX2ZyZWUoc3RydWN0IGF0YV9xdWV1ZWRfY21kICpxYyk7CiBleHRlcm4gaW50IGF0YV9x
Y19pc3N1ZShzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKnFjKTsKIGV4dGVybiBpbnQgYXRhX2NoZWNr
X2F0YXBpX2RtYShzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKnFjKTsKK2V4dGVybiB2b2lkIGF0YV9j
aGVja19raWxsX3FjKHN0cnVjdCBhdGFfcG9ydCAqYXApOwogZXh0ZXJuIHZvaWQgYXRhX2Rldl9z
ZWxlY3Qoc3RydWN0IGF0YV9wb3J0ICphcCwgdW5zaWduZWQgaW50IGRldmljZSwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB3YWl0LCB1bnNpZ25lZCBpbnQgY2FuX3Ns
ZWVwKTsKIGV4dGVybiB2b2lkIGF0YV90Zl90b19ob3N0X25vbG9jayhzdHJ1Y3QgYXRhX3BvcnQg
KmFwLCBzdHJ1Y3QgYXRhX3Rhc2tmaWxlICp0Zik7CkBAIC03Niw2ICs3Nyw5IEBAIGV4dGVybiB2
b2lkIGF0YV9zY3NpX2JhZGNtZChzdHJ1Y3Qgc2NzaV8KIGV4dGVybiB2b2lkIGF0YV9zY3NpX3Ji
dWZfZmlsbChzdHJ1Y3QgYXRhX3Njc2lfYXJncyAqYXJncywgCiAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgKCphY3RvcikgKHN0cnVjdCBhdGFfc2NzaV9hcmdzICphcmdzLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4ICpyYnVmLCB1bnNp
Z25lZCBpbnQgYnVmbGVuKSk7CitleHRlcm4gdm9pZCBhdGFfc2NzaV9wcmVwYXJlX3FjX2Fib3J0
KHN0cnVjdCBhdGFfcXVldWVkX2NtZCAqcWMpOworZXh0ZXJuIHZvaWQgYXRhX3Njc2lfaGFuZGxl
X3BsdWcoc3RydWN0IGF0YV9wb3J0ICphcCk7CitleHRlcm4gdm9pZCBhdGFfc2NzaV9oYW5kbGVf
dW5wbHVnKHN0cnVjdCBhdGFfcG9ydCAqYXApOwogCiBzdGF0aWMgaW5saW5lIHZvaWQgYXRhX2Jh
ZF9zY3Npb3Aoc3RydWN0IHNjc2lfY21uZCAqY21kLCB2b2lkICgqZG9uZSkoc3RydWN0IHNjc2lf
Y21uZCAqKSkKIHsKLS0tIGxpbnV4LTIuNi4xMy1yYzMvaW5jbHVkZS9saW51eC9saWJhdGEuaC5v
bGQJMjAwNS0wNy0yMSAxMzozNTo1MC41NDg0MTY1NzYgLTA0MDAKKysrIGxpbnV4LTIuNi4xMy1y
YzMvaW5jbHVkZS9saW51eC9saWJhdGEuaAkyMDA1LTA3LTIxIDEzOjQyOjUzLjk2MDM4MTc2MCAt
MDQwMApAQCAtMjksNiArMjksNyBAQAogI2luY2x1ZGUgPGFzbS9pby5oPgogI2luY2x1ZGUgPGxp
bnV4L2F0YS5oPgogI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgorI2luY2x1ZGUgPGFzbS9z
ZW1hcGhvcmUuaD4KIAogLyoKICAqIGNvbXBpbGUtdGltZSBvcHRpb25zCkBAIC0zMTksNiArMzIw
LDkgQEAgc3RydWN0IGF0YV9wb3J0IHsKIAlzdHJ1Y3QgYXRhX2hvc3Rfc3RhdHMJc3RhdHM7CiAJ
c3RydWN0IGF0YV9ob3N0X3NldAkqaG9zdF9zZXQ7CiAKKwlzdHJ1Y3Qgc2VtYXBob3JlCWhvdHBs
dWdfbXV0ZXg7CisJc3RydWN0IHdvcmtfc3RydWN0CWhvdHBsdWdfcGx1Z190YXNrOworCXN0cnVj
dCB3b3JrX3N0cnVjdAlob3RwbHVnX3VucGx1Z190YXNrOwogCXN0cnVjdCB3b3JrX3N0cnVjdAlw
YWNrZXRfdGFzazsKIAogCXN0cnVjdCB3b3JrX3N0cnVjdAlwaW9fdGFzazsKQEAgLTMyNiw2ICsz
MzAsOCBAQCBzdHJ1Y3QgYXRhX3BvcnQgewogCXVuc2lnbmVkIGxvbmcJCXBpb190YXNrX3RpbWVv
dXQ7CiAKIAl2b2lkCQkJKnByaXZhdGVfZGF0YTsKKworCXVuc2lnbmVkIGludAkJb3JpZ191ZG1h
X21hc2s7CiB9OwogCiBzdHJ1Y3QgYXRhX3BvcnRfb3BlcmF0aW9ucyB7CkBAIC00MDIsNiArNDA4
LDggQEAgZXh0ZXJuIGludCBhdGFfc2NzaV9xdWV1ZWNtZChzdHJ1Y3Qgc2NzaQogZXh0ZXJuIGlu
dCBhdGFfc2NzaV9lcnJvcihzdHJ1Y3QgU2NzaV9Ib3N0ICpob3N0KTsKIGV4dGVybiBpbnQgYXRh
X3Njc2lfcmVsZWFzZShzdHJ1Y3QgU2NzaV9Ib3N0ICpob3N0KTsKIGV4dGVybiB1bnNpZ25lZCBp
bnQgYXRhX2hvc3RfaW50cihzdHJ1Y3QgYXRhX3BvcnQgKmFwLCBzdHJ1Y3QgYXRhX3F1ZXVlZF9j
bWQgKnFjKTsKK2V4dGVybiB2b2lkIGF0YV9ob3RwbHVnX3VucGx1ZyhzdHJ1Y3QgYXRhX3BvcnQg
KmFwKTsKK2V4dGVybiB2b2lkIGF0YV9ob3RwbHVnX3BsdWcoc3RydWN0IGF0YV9wb3J0ICphcCk7
CiAvKgogICogRGVmYXVsdCBkcml2ZXIgb3BzIGltcGxlbWVudGF0aW9ucwogICovCg==
------=_Part_2123_28009498.1122836233312--
