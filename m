Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWH3C5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWH3C5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 22:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWH3C5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 22:57:33 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:61342 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932411AbWH3C5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 22:57:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FALWa9ESBT4gpgTYB
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.212):SA:0(-1.2/5.0):. Processed in 6.387109 secs Process 16603)
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Daniel Drake <dsd@gentoo.org>, bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, jeff@garzik.org, harmon@ksu.edu
In-Reply-To: <44DE5A6F.50500@gentoo.org>
References: <1154091662.7200.9.camel@localhost.localdomain>
	 <44DE5A6F.50500@gentoo.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-rfEyrQJ3tjn6OO7zUHCE"
Date: Wed, 30 Aug 2006 03:57:18 +0100
Message-Id: <1156906638.3022.18.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 30 Aug 2006 02:57:30.0472 (UTC) FILETIME=[08A40E80:01C6CBE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rfEyrQJ3tjn6OO7zUHCE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, Sorry for so late answer , I have been in holidays and  busy.

I remember check my emails that I send to Len Brown about this subject.
And I found, what I want, is just revert one patch of Bjorn Helgaas :)
between kernel 2.6.12-rc5 and 6.13.

Check this out
http://sourceforge.net/mailarchive/message.php?msg_id=3D11858102

so I propose this patch like this :

 static void quirk_via_irq(struct pci_dev *dev)
  {
  	u8 irq, new_irq;
 =20
 +#ifdef CONFIG_X86_IO_APIC
 +	if (nr_ioapics && !skip_ioapic_setup)
 +		return;
 +#endif
 +#ifdef CONFIG_ACPI
 +	if (acpi_irq_model !=3D ACPI_IRQ_MODEL_PIC)
 +		return;
 +#endif
  	new_irq =3D dev->irq & 0xf;
  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
  	if (new_irq !=3D irq) {
=20
On Sat, 2006-08-12 at 23:47 +0100, Daniel Drake wrote:
> Sergio Monteiro Basto wrote:
> > Hi, this patch (now for 2.6.18-rc2) is more readable.
>=20
> Ok, it looks like I was wrong in my earlier mails, ACPI vs APIC=20
> confusion. In the bug reports I mentioned, APIC was not being used in=20
> any circumstances (however it is still a bit strange how these systems=20
> do not need quirks when acpi=3Doff).

I still convinced that we need patch even with acpi=3Doff , the problem
doesn't appear only on boot time.


>=20
> I'm reasonably certain that this patch will apply the quirks on the=20
> affected systems again, so I'm happy for it to be applied, people will=20
> be able to use their hardware again. However I'm not sure how good a=20
> solution it is, because in some circumstances it will apply the quirks=20
> to VIA PCI cards on non-VIA boards, which was the reason we messed with=20
> this code in the first place. We could possibly merge it with the=20
> southbridge detection hack, but it gets a bit silly at that point...
>=20
> Jeff/Chris: any thoughts?
>=20
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Cc: "Scott J. Harmon" <harmon@ksu.edu>
> > Cc: Andrew Morton <akpm@osdl.org>
> > Cc: Chris Wedgwood <cw@f00f.org>
> > Cc: Greg KH <greg@kroah.com>
> > Signed-off-by: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
> > ---
> >  quirks.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > --- linux-2.6.17.i686/drivers/pci/quirks.c.orig	2006-07-28 12:59:04.000=
000000 +0100
> > +++ linux-2.6.17.i686/drivers/pci/quirks.c	2006-07-28 13:26:49.00000000=
0 +0100
> > @@ -648,11 +648,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
> >   *
> >   * Some of the on-chip devices are actually '586 devices' so they are
> >   * listed here.
> > + *=20
> > + * if flags say that we have working apic(s), we don't need to quirk t=
hese
> > + * devices
> >   */
> >  static void quirk_via_irq(struct pci_dev *dev)
> >  {
> >  	u8 irq, new_irq;
> > =20
> > +	if ((smp_found_config && !skip_ioapic_setup && nr_ioapics) || cpu_has=
_apic)
> > +		return;
> > +
> >  	new_irq =3D dev->irq & 0xf;
> >  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> >  	if (new_irq !=3D irq) {
> > @@ -662,13 +668,7 @@ static void quirk_via_irq(struct pci_dev
> >  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> >  	}
> >  }
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0=
, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1=
, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2=
, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3=
, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, =
quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4=
, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5=
, quirk_via_irq);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq)=
;
> > =20
> >  /*
> >   * VIA VT82C598 has its device ID settable and many BIOSes
> >=20
> >=20
> >=20
> >=20
>=20

--=-rfEyrQJ3tjn6OO7zUHCE
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjA4MzAwMjU3MTRaMCMGCSqGSIb3DQEJBDEWBBTXrvF8z7qbulX7uBAsT1E9
6KCLkjANBgkqhkiG9w0BAQEFAASCAQCQtuSNMZ6wrCIYxoch2z7ZQXLnZ5cwpBTqHYG5WriAmGGM
9Y+bJCrlGDuOrTo5fLLXYtvq+whiJPJFw7Lc8Jro3p44mhfMoGHhzbJSwoIerAjSCcFnogoB3jkF
uBsyb59b82pPXjX0LQREu30ws1CnjivMpPToWJdWSTC5Hu0bJeB6HamtDE653sGnauD1RMiIfNwd
X1Sdku7o317GWTWLSlVmGZNcGOAcvMUeAro+YjWp1wnItTFWpiyej2fy5wtgmWVXHTP0cfcpWOOT
IGH+sfWRuAaE2tT50Fo1gq+yjqYXAAT/HKilOpr9yEdoaCqxI8rOxDFN1ljgzvvzQSHhAAAAAAAA



--=-rfEyrQJ3tjn6OO7zUHCE--
