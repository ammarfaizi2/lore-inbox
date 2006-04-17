Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDQNMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDQNMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDQNMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:12:53 -0400
Received: from mail0.lsil.com ([147.145.40.20]:16113 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750815AbWDQNMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:12:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C66220.996327B3"
Subject: RE: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Date: Mon, 17 Apr 2006 07:12:37 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BCD2@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Thread-Index: AcZgXBeEzfbDP2zISl2INptZrQeDFgBwy7fg
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Andre Hedrick" <andre@linux-ide.org>, "Andrew Morton" <akpm@osdl.org>
Cc: <James.Bottomley@SteelEye.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 17 Apr 2006 13:12:37.0790 (UTC) FILETIME=[99599BE0:01C66220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66220.996327B3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you all for comment on the issue.
>From the comment, it looks having 'ndelay/udelay' would be right way to =
address the issue.
I've attached a patch for just review purpose.
Once it confirmed, I'll post the patch officially.

Thank you,

> -----Original Message-----
> From: Andre Hedrick [mailto:andre@linux-ide.org]=20
> Sent: Saturday, April 15, 2006 3:10 AM
> To: Andrew Morton
> Cc: Ju, Seokmann; Ju, Seokmann; James.Bottomley@SteelEye.com;=20
> linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> Subject: Re: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in=20
> reset handler
>=20
>=20
> Andrew,
>=20
> This is real, and is a known bug which is 100% reproducable (sp).
> There are other harry issues too, but this is as much as I can say.
>=20
> cpu_relax() will not work, already tried some time ago.
>=20
>=20
> Andre Hedrick
> LAD Storage Consulting Group
>=20
> On Wed, 12 Apr 2006, Andrew Morton wrote:
>=20
> > "Ju, Seokmann" <Seokmann.Ju@lsil.com> wrote:
> > >
> > > This patch has fix for a bug in the 'megaraid_reset_handler()'.
> > >=20
> > >  When abort failed, the driver gets reset handleer=20
> called. In the reset
> > >  handler, driver calls 'scsi_done()' callback for same=20
> SCSI command
> > >  packet (struct scsi_cmnd) multiple times if there are=20
> multiple SCSI
> > >  command packet in the pend_list. More over, if there are=20
> entry in the
> > >  pend_lsit with IOCTL packet associated, the driver=20
> returns it to wrong
> > >  free_list so that, in turn, the driver could end up with=20
> 'NULL pointer
> > >  dereference..' during I/O command building with=20
> incorrect resource.
> > >=20
> > >  Also, the patch contains several minor/cosmetic changes=20
> besides this.
> > >
> > > ..
> > >
> > > @@ -2655,32 +2655,48 @@
> > >  	// Also, reset all the commands currently owned by the driver
> > >  	spin_lock_irqsave(PENDING_LIST_LOCK(adapter), flags);
> > >  	list_for_each_entry_safe(scb, tmp, &adapter->pend_list, list) {
> > > -
> > >  		list_del_init(&scb->list);	// from pending list
> > > =20
> > > -		con_log(CL_ANN, (KERN_WARNING
> > > -			"megaraid: %ld:%d[%d:%d], reset from=20
> pending list\n",
> > > -				scp->serial_number, scb->sno,
> > > -				scb->dev_channel, scb->dev_target));
> > > +		if (scb->sno >=3D MBOX_MAX_SCSI_CMDS) {
> > > +			con_log(CL_ANN, (KERN_WARNING=20
> > > +			"megaraid: IOCTL packet with %d[%d:%d]=20
> being reset\n",
> > > +			scb->sno, scb->dev_channel, scb->dev_target));
> > > =20
> > > -		scp->result =3D (DID_RESET << 16);
> > > -		scp->scsi_done(scp);
> > > +			scb->status =3D -EFAULT;
> >=20
> > What is the significance of -EFAULT here?  Seems inappropriate?
> >=20
> > > @@ -2918,12 +2933,12 @@
> > >  	wmb();
> > >  	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
> > > =20
> > > -	for (i =3D 0; i < 0xFFFFF; i++) {
> > > +	for (i =3D 0; i < 0xFFFFFF; i++) {
> > >  		if (mbox->numstatus !=3D 0xFF) break;
> > >  		rmb();
> > >  	}
> >=20
> > Oh my.  That's an awfully long interrupts-off spin.  1.7e7=20
> operations with
> > an NMI watchdog timeout of five seconds - I'm surprised it=20
> doesn't trigger.
> >=20
> > Is that reading from a PCI register there?   Or main memory?
> >=20
> > I'm somewhat surprised that the compiler never "optimises"=20
> this into a
> > lockup, actually.  That's what `volatile' is for.
> >=20
> > Is it not possible to do this with an interrupt?
> >=20
> > A `cpu_relax()' in that loop would help cool things down a bit.
> >=20
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-scsi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
>=20

------_=_NextPart_001_01C66220.996327B3
Content-Type: application/octet-stream;
	name="kernel.patch"
Content-Transfer-Encoding: base64
Content-Description: kernel.patch
Content-Disposition: attachment;
	filename="kernel.patch"

ZGlmZiAtTmF1ciBvbGQvRG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZCBuZXcv
RG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZA0KLS0tIG9sZC9Eb2N1bWVudGF0
aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkCTIwMDYtMDQtMTAgMTg6MDQ6MDQuMDAwMDAwMDAw
IC0wNDAwDQorKysgbmV3L0RvY3VtZW50YXRpb24vc2NzaS9DaGFuZ2VMb2cubWVnYXJhaWQJMjAw
Ni0wNC0xMiAwOTozNToyMC4wMDAwMDAwMDAgLTA0MDANCkBAIC0xLDMgKzEsMjggQEANCitSZWxl
YXNlIERhdGUJOiBNb24gQXByIDExIDEyOjI3OjIyIEVTVCAyMDA2IC0gU2Vva21hbm4gSnUgPHNq
dUBsc2lsLmNvbT4NCitDdXJyZW50IFZlcnNpb24gOiAyLjIwLjQuOCAoc2NzaSBtb2R1bGUpLCAy
LjIwLjIuNiAoY21tIG1vZHVsZSkNCitPbGRlciBWZXJzaW9uCTogMi4yMC40LjcgKHNjc2kgbW9k
dWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1bGUpDQorDQorMS4JRml4ZWQgYSBidWcgaW4gbWVnYXJh
aWRfcmVzZXRfaGFuZGxlcigpLg0KKwlDdXN0b21lciByZXBvcnRlZCAiVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQorCWF0IHZpcnR1YWwgYWRkcmVzcyAw
MDAwMDAwMCIgd2hlbiBzeXN0ZW0gZ29lcyB0byByZXNldCBjb25kaXRpb24NCisJZm9yIHNvbWUg
cmVhc29uLiBJdCBoYXBwZW5lZCByYW5kb21seS4NCisJUm9vdCBDYXVzZTogaW4gdGhlIG1lZ2Fy
YWlkX3Jlc2V0X2hhbmRsZXIoKSwgdGhlcmUgaXMgcG9zc2liaWxpdHkgbm90IA0KKwlyZXR1cm5p
bmcgcGVuZGluZyBwYWNrZXRzIGluIHRoZSBwZW5kX2xpc3QgaWYgdGhlcmUgYXJlIG11bHRpcGxl
DQorCXBlbmRpbmcgcGFja2V0cy4gDQorCUZpeDogTWFkZSB0aGUgY2hhbmdlIGluIHRoZSBkcml2
ZXIgc28gdGhhdCBpdCB3aWxsIHJldHVybiBhbGwgcGFja2V0cyANCisJaW4gdGhlIHBlbmRfbGlz
dC4NCisNCisyLglBZGRlZCBjaGFuZ2UgcmVxdWVzdC4NCisJQXMgZm91bmQgaW4gdGhlIGZvbGxv
d2luZyBVUkwsIHJtYigpIG9ubHkgZGlkbid0IGhlbHAgdGhlDQorCXByb2JsZW0uIEkgaGFkIHRv
IGluY3JlYXNlIHRoZSBsb29wIGNvdW50ZXIgdG8gMHhGRkZGRkYuICg2IEYncykNCisJaHR0cDov
L21hcmMudGhlYWltc2dyb3VwLmNvbS8/bD1saW51eC1zY3NpJm09MTEwOTcxMDYwNTAyNDk3Jnc9
Mg0KKyANCisJSSBhdHRhY2hlZCBhIHBhdGNoIGZvciB5b3VyIHJlZmVyZW5jZSwgdG9vLg0KKwlD
b3VsZCB5b3UgY2hlY2sgYW5kIGdldCB0aGlzIGZpeCBpbiB5b3VyIGRyaXZlcj8NCisgDQorCUJl
c3QgUmVnYXJkcywNCisJSnVuJ2ljaGkgTm9tdXJhDQorDQogUmVsZWFzZSBEYXRlCTogRnJpIE5v
diAxMSAxMjoyNzoyMiBFU1QgMjAwNSAtIFNlb2ttYW5uIEp1IDxzanVAbHNpbC5jb20+DQogQ3Vy
cmVudCBWZXJzaW9uIDogMi4yMC40LjcgKHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1
bGUpDQogT2xkZXIgVmVyc2lvbgk6IDIuMjAuNC42IChzY3NpIG1vZHVsZSksIDIuMjAuMi42IChj
bW0gbW9kdWxlKQ0KZGlmZiAtTmF1ciBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlk
X21ib3guYyBuZXcvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYw0KLS0tIG9s
ZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5jCTIwMDYtMDQtMTAgMTc6MTQ6
MjIuMDAwMDAwMDAwIC0wNDAwDQorKysgbmV3L2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFp
ZF9tYm94LmMJMjAwNi0wNC0xMyAxNjo0Njo1My42Nzc2ODczNjggLTA0MDANCkBAIC0xMCw3ICsx
MCw3IEBADQogICoJICAgMiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkg
bGF0ZXIgdmVyc2lvbi4NCiAgKg0KICAqIEZJTEUJCTogbWVnYXJhaWRfbWJveC5jDQotICogVmVy
c2lvbgk6IHYyLjIwLjQuNyAoTm92IDE0IDIwMDUpDQorICogVmVyc2lvbgk6IHYyLjIwLjQuOCAo
QXByIDExIDIwMDYpDQogICoNCiAgKiBBdXRob3JzOg0KICAqIAlBdHVsIE11a2tlcgkJPEF0dWwu
TXVra2VyQGxzaWwuY29tPg0KQEAgLTIyNzgsNiArMjI3OCw3IEBADQogCXVuc2lnbmVkIGxvbmcJ
CWZsYWdzOw0KIAl1aW50OF90CQkJYzsNCiAJaW50CQkJc3RhdHVzOw0KKwl1aW9jX3QJCQkqa2lv
YzsNCiANCiANCiAJaWYgKCFhZGFwdGVyKSByZXR1cm47DQpAQCAtMjMyMCw2ICsyMzIxLDkgQEAN
CiAJCQkvLyByZW1vdmUgZnJvbSBsb2NhbCBjbGlzdA0KIAkJCWxpc3RfZGVsX2luaXQoJnNjYi0+
bGlzdCk7DQogDQorCQkJa2lvYwkJCT0gKHVpb2NfdCAqKXNjYi0+Z3A7DQorCQkJa2lvYy0+c3Rh
dHVzCQk9IDA7DQorDQogCQkJbWVnYXJhaWRfbWJveF9tbV9kb25lKGFkYXB0ZXIsIHNjYik7DQog
DQogCQkJY29udGludWU7DQpAQCAtMjYzNiw2ICsyNjQwLDcgQEANCiAJaW50CQlyZWNvdmVyeV93
aW5kb3c7DQogCWludAkJcmVjb3ZlcmluZzsNCiAJaW50CQlpOw0KKwl1aW9jX3QJCSpraW9jOw0K
IA0KIAlhZGFwdGVyCQk9IFNDUDJBREFQVEVSKHNjcCk7DQogCXJhaWRfZGV2CT0gQURBUDJSQUlE
REVWKGFkYXB0ZXIpOw0KQEAgLTI2NTUsMzIgKzI2NjAsNTEgQEANCiAJLy8gQWxzbywgcmVzZXQg
YWxsIHRoZSBjb21tYW5kcyBjdXJyZW50bHkgb3duZWQgYnkgdGhlIGRyaXZlcg0KIAlzcGluX2xv
Y2tfaXJxc2F2ZShQRU5ESU5HX0xJU1RfTE9DSyhhZGFwdGVyKSwgZmxhZ3MpOw0KIAlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUoc2NiLCB0bXAsICZhZGFwdGVyLT5wZW5kX2xpc3QsIGxpc3QpIHsN
Ci0NCiAJCWxpc3RfZGVsX2luaXQoJnNjYi0+bGlzdCk7CS8vIGZyb20gcGVuZGluZyBsaXN0DQog
DQotCQljb25fbG9nKENMX0FOTiwgKEtFUk5fV0FSTklORw0KLQkJCSJtZWdhcmFpZDogJWxkOiVk
WyVkOiVkXSwgcmVzZXQgZnJvbSBwZW5kaW5nIGxpc3RcbiIsDQotCQkJCXNjcC0+c2VyaWFsX251
bWJlciwgc2NiLT5zbm8sDQotCQkJCXNjYi0+ZGV2X2NoYW5uZWwsIHNjYi0+ZGV2X3RhcmdldCkp
Ow0KKwkJaWYgKHNjYi0+c25vID49IE1CT1hfTUFYX1NDU0lfQ01EUykgew0KKwkJCWNvbl9sb2co
Q0xfQU5OLCAoS0VSTl9XQVJOSU5HIA0KKwkJCSJtZWdhcmFpZDogSU9DVEwgcGFja2V0IHdpdGgg
JWRbJWQ6JWRdIGJlaW5nIHJlc2V0XG4iLA0KKwkJCXNjYi0+c25vLCBzY2ItPmRldl9jaGFubmVs
LCBzY2ItPmRldl90YXJnZXQpKTsNCiANCi0JCXNjcC0+cmVzdWx0ID0gKERJRF9SRVNFVCA8PCAx
Nik7DQotCQlzY3AtPnNjc2lfZG9uZShzY3ApOw0KKwkJCXNjYi0+c3RhdHVzID0gLTE7DQogDQot
CQltZWdhcmFpZF9kZWFsbG9jX3NjYihhZGFwdGVyLCBzY2IpOw0KKwkJCWtpb2MJCQk9ICh1aW9j
X3QgKilzY2ItPmdwOw0KKwkJCWtpb2MtPnN0YXR1cwkJPSAtRUZBVUxUOw0KKw0KKwkJCW1lZ2Fy
YWlkX21ib3hfbW1fZG9uZShhZGFwdGVyLCBzY2IpOw0KKwkJfSBlbHNlIHsNCisJCQlpZiAoc2Ni
LT5zY3AgPT0gc2NwKSB7CS8vIEZvdW5kIGNvbW1hbmQNCisJCQkJY29uX2xvZyhDTF9BTk4sIChL
RVJOX1dBUk5JTkcNCisJCQkJCSJtZWdhcmFpZDogJWxkOiVkWyVkOiVkXSwgcmVzZXQgZnJvbSBw
ZW5kaW5nIGxpc3RcbiIsDQorCQkJCQlzY3AtPnNlcmlhbF9udW1iZXIsIHNjYi0+c25vLA0KKwkJ
CQkJc2NiLT5kZXZfY2hhbm5lbCwgc2NiLT5kZXZfdGFyZ2V0KSk7DQorCQkJfSBlbHNlIHsNCisJ
CQkJY29uX2xvZyhDTF9BTk4sIChLRVJOX1dBUk5JTkcgDQorCQkJCSJtZWdhcmFpZDogSU8gcGFj
a2V0IHdpdGggJWRbJWQ6JWRdIGJlaW5nIHJlc2V0XG4iLA0KKwkJCQlzY2ItPnNubywgc2NiLT5k
ZXZfY2hhbm5lbCwgc2NiLT5kZXZfdGFyZ2V0KSk7DQorCQkJfQ0KKw0KKwkJCXNjYi0+c2NwLT5y
ZXN1bHQgPSAoRElEX1JFU0VUIDw8IDE2KTsNCisJCQlzY2ItPnNjcC0+c2NzaV9kb25lKHNjYi0+
c2NwKTsNCisNCisJCQltZWdhcmFpZF9kZWFsbG9jX3NjYihhZGFwdGVyLCBzY2IpOw0KKwkJfQ0K
IAl9DQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoUEVORElOR19MSVNUX0xPQ0soYWRhcHRlciks
IGZsYWdzKTsNCiANCiAJaWYgKGFkYXB0ZXItPm91dHN0YW5kaW5nX2NtZHMpIHsNCiAJCWNvbl9s
b2coQ0xfQU5OLCAoS0VSTl9OT1RJQ0UNCiAJCQkibWVnYXJhaWQ6ICVkIG91dHN0YW5kaW5nIGNv
bW1hbmRzLiBNYXggd2FpdCAlZCBzZWNcbiIsDQotCQkJYWRhcHRlci0+b3V0c3RhbmRpbmdfY21k
cywgTUJPWF9SRVNFVF9XQUlUKSk7DQorCQkJYWRhcHRlci0+b3V0c3RhbmRpbmdfY21kcywgDQor
CQkJKE1CT1hfUkVTRVRfV0FJVCArIE1CT1hfUkVTRVRfRVhUX1dBSVQpKSk7DQogCX0NCiANCiAJ
cmVjb3Zlcnlfd2luZG93ID0gTUJPWF9SRVNFVF9XQUlUICsgTUJPWF9SRVNFVF9FWFRfV0FJVDsN
CiANCiAJcmVjb3ZlcmluZyA9IGFkYXB0ZXItPm91dHN0YW5kaW5nX2NtZHM7DQogDQotCWZvciAo
aSA9IDA7IGkgPCByZWNvdmVyeV93aW5kb3cgJiYgYWRhcHRlci0+b3V0c3RhbmRpbmdfY21kczsg
aSsrKSB7DQorCWZvciAoaSA9IDA7IGkgPCByZWNvdmVyeV93aW5kb3c7IGkrKykgew0KIA0KIAkJ
bWVnYXJhaWRfYWNrX3NlcXVlbmNlKGFkYXB0ZXIpOw0KIA0KQEAgLTI2ODksMTIgKzI3MTMsMTEg
QEANCiAJCQljb25fbG9nKENMX0FOTiwgKA0KIAkJCSJtZWdhcmFpZCBtYm94OiBXYWl0IGZvciAl
ZCBjb21tYW5kcyB0byBjb21wbGV0ZTolZFxuIiwNCiAJCQkJYWRhcHRlci0+b3V0c3RhbmRpbmdf
Y21kcywNCi0JCQkJTUJPWF9SRVNFVF9XQUlUIC0gaSkpOw0KKwkJCQkoTUJPWF9SRVNFVF9XQUlU
ICsgTUJPWF9SRVNFVF9FWFRfV0FJVCkgLSBpKSk7DQogCQl9DQogDQogCQkvLyBiYWlsb3V0IGlm
IG5vIHJlY292ZXJ5IGhhcHBlbmRlZCBpbiByZXNldCB0aW1lDQotCQlpZiAoKGkgPT0gTUJPWF9S
RVNFVF9XQUlUKSAmJg0KLQkJCShyZWNvdmVyaW5nID09IGFkYXB0ZXItPm91dHN0YW5kaW5nX2Nt
ZHMpKSB7DQorCQlpZiAoYWRhcHRlci0+b3V0c3RhbmRpbmdfY21kcyA9PSAwKSB7DQogCQkJYnJl
YWs7DQogCQl9DQogDQpAQCAtMjkxOCwxMiArMjk0MSwxMyBAQA0KIAl3bWIoKTsNCiAJV1JJTkRP
T1IocmFpZF9kZXYsIHJhaWRfZGV2LT5tYm94X2RtYSB8IDB4MSk7DQogDQotCWZvciAoaSA9IDA7
IGkgPCAweEZGRkZGOyBpKyspIHsNCisJZm9yIChpID0gMDsgaSA8IE1CT1hfU1lOQ19XQUlUX0NO
VDsgaSsrKSB7DQogCQlpZiAobWJveC0+bnVtc3RhdHVzICE9IDB4RkYpIGJyZWFrOw0KIAkJcm1i
KCk7DQorCQl1ZGVsYXkoTUJPWF9TWU5DX0RFTEFZXzIwMCk7DQogCX0NCiANCi0JaWYgKGkgPT0g
MHhGRkZGRikgew0KKwlpZiAoaSA9PSBNQk9YX1NZTkNfV0FJVF9DTlQpIHsNCiAJCS8vIFdlIG1h
eSBuZWVkIHRvIHJlLWNhbGlicmF0ZSB0aGUgY291bnRlcg0KIAkJY29uX2xvZyhDTF9BTk4sIChL
RVJOX0NSSVQNCiAJCQkibWVnYXJhaWQ6IGZhc3Qgc3luYyBjb21tYW5kIHRpbWVkIG91dFxuIikp
Ow0KQEAgLTM0NzUsNyArMzQ5OSw3IEBADQogCWFkcC5kcnZyX2RhdGEJCT0gKHVuc2lnbmVkIGxv
bmcpYWRhcHRlcjsNCiAJYWRwLnBkZXYJCT0gYWRhcHRlci0+cGRldjsNCiAJYWRwLmlzc3VlX3Vp
b2MJCT0gbWVnYXJhaWRfbWJveF9tbV9oYW5kbGVyOw0KLQlhZHAudGltZW91dAkJPSAzMDA7DQor
CWFkcC50aW1lb3V0CQk9IE1CT1hfUkVTRVRfV0FJVCArIE1CT1hfUkVTRVRfRVhUX1dBSVQ7DQog
CWFkcC5tYXhfa2lvYwkJPSBNQk9YX01BWF9VU0VSX0NNRFM7DQogDQogCWlmICgocnZhbCA9IG1y
YWlkX21tX3JlZ2lzdGVyX2FkcCgmYWRwKSkgIT0gMCkgew0KQEAgLTM3MDIsNyArMzcyNiw2IEBA
DQogCXVuc2lnbmVkIGxvbmcJCWZsYWdzOw0KIA0KIAlraW9jCQkJPSAodWlvY190ICopc2NiLT5n
cDsNCi0Ja2lvYy0+c3RhdHVzCQk9IDA7DQogCW1ib3g2NAkJCT0gKG1ib3g2NF90ICopKHVuc2ln
bmVkIGxvbmcpa2lvYy0+Y21kYnVmOw0KIAltYm94NjQtPm1ib3gzMi5zdGF0dXMJPSBzY2ItPnN0
YXR1czsNCiAJcmF3X21ib3gJCT0gKHVpbnQ4X3QgKikmbWJveDY0LT5tYm94MzI7DQpkaWZmIC1O
YXVyIG9sZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5oIG5ldy9kcml2ZXJz
L3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5oDQotLS0gb2xkL2RyaXZlcnMvc2NzaS9tZWdh
cmFpZC9tZWdhcmFpZF9tYm94LmgJMjAwNi0wNC0xMCAxNzoxNDoyMi4wMDAwMDAwMDAgLTA0MDAN
CisrKyBuZXcvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guaAkyMDA2LTA0LTEz
IDE2OjA1OjMwLjMxMzIxNjE1MiAtMDQwMA0KQEAgLTIxLDggKzIxLDggQEANCiAjaW5jbHVkZSAi
bWVnYXJhaWRfaW9jdGwuaCINCiANCiANCi0jZGVmaW5lIE1FR0FSQUlEX1ZFUlNJT04JIjIuMjAu
NC43Ig0KLSNkZWZpbmUgTUVHQVJBSURfRVhUX1ZFUlNJT04JIihSZWxlYXNlIERhdGU6IE1vbiBO
b3YgMTQgMTI6Mjc6MjIgRVNUIDIwMDUpIg0KKyNkZWZpbmUgTUVHQVJBSURfVkVSU0lPTgkiMi4y
MC40LjgiDQorI2RlZmluZSBNRUdBUkFJRF9FWFRfVkVSU0lPTgkiKFJlbGVhc2UgRGF0ZTogTW9u
IEFwciAxMSAxMjoyNzoyMiBFU1QgMjAwNikiDQogDQogDQogLyoNCkBAIC0xMDAsNiArMTAwLDkg
QEANCiAjZGVmaW5lIE1CT1hfQlVTWV9XQUlUCQkxMAkvLyBtYXggdXNlYyB0byB3YWl0IGZvciBi
dXN5IG1haWxib3gNCiAjZGVmaW5lIE1CT1hfUkVTRVRfV0FJVAkJMTgwCS8vIHdhaXQgdGhlc2Ug
bWFueSBzZWNvbmRzIGluIHJlc2V0DQogI2RlZmluZSBNQk9YX1JFU0VUX0VYVF9XQUlUCTEyMAkv
LyBleHRlbmRlZCB3YWl0IHJlc2V0DQorI2RlZmluZSBNQk9YX1NZTkNfV0FJVF9DTlQJMHhGRkZG
CS8vIHdhaXQgbG9vcCBpbmRleCBmb3Igc3luY2hyb25vdXMgbW9kZQ0KKw0KKyNkZWZpbmUgTUJP
WF9TWU5DX0RFTEFZXzIwMAkyMDAJLy8gMjAwIG1pY3JvLXNlY29uZHMNCiANCiAvKg0KICAqIG1h
eGltdW0gdHJhbnNmZXIgdGhhdCBjYW4gaGFwcGVuIHRocm91Z2ggdGhlIGZpcm13YXJlIGNvbW1h
bmRzIGlzc3VlZA0K

------_=_NextPart_001_01C66220.996327B3--
