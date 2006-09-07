Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWIGCIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWIGCIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWIGCIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:08:21 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:46387 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1422644AbWIGCIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:08:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAOsa/0SBT4hKgTAB
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.80):SA:0(-1.2/5.0):. Processed in 7.967821 secs Process 17762)
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Daniel Drake <dsd@gentoo.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Stian Jordet <liste@jordet.net>, akpm@osdl.org, jeff@garzik.org,
       greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru
In-Reply-To: <44FF5E90.9030808@gentoo.org>
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>
	 <44FE8EBA.4060104@jordet.net>  <44FCE36D.4000708@gentoo.org>
	 <1157557765.5091.1.camel@localhost.localdomain>
	 <44FF5E90.9030808@gentoo.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-95/XTmf1M7Cdv/hjrMG1"
Date: Thu, 07 Sep 2006 03:00:42 +0100
Message-Id: <1157594442.4700.9.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 07 Sep 2006 02:08:16.0984 (UTC) FILETIME=[7B878D80:01C6D222]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-95/XTmf1M7Cdv/hjrMG1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-06 at 19:49 -0400, Daniel Drake wrote:
> Sergio,
>=20
> Stian appears to be walking proof that quirks are sometimes required
> in=20
> IO-APIC mode.
>=20
> My next move would be to modify the patch to not revert Bjorn's
> changes=20
> (but leave Linus' modification in place, alongside the southbridge=20
> detection). Any thoughts?=20

Hi Daniel, since you ask for thoughts :)

yap, is the obvious conclusion, but no, my bet is one problem with USB
and USB guys could put the USB things working.=20
I just had remember, my Asrock with VIA8237 and VIA SATA (where I am
write now) is working without quirks and USB guys made a patch, by
coincidence. Since then have been working great.
http://bugzilla.kernel.org/show_bug.cgi?id=3D6419#c19

About Linus patch I have to correct me about what I had write,
http://lkml.org/lkml/2005/9/27/113
=AB(it used to say "if we have an IO-APIC, don't do this" (my patch), now
it says "if this irq is bound to an IO-APIC, don't do this")=BB
Or my patch or the Linus patch, not both.


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=20
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -546,7 +546,10 @@ static void quirk_via_irq(struct pci_dev
 {
 	u8 irq, new_irq;
=20
-	new_irq =3D dev->irq & 0xf;
+	new_irq =3D dev->irq;
+	if (!new_irq || new_irq >=3D 15)
+		return;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq !=3D irq) {

but I look to this Linus patch and I see 2 bugs
one should be > not >=3D and new_irq after tests new_irq should be dev->irq=
 & 0xf;
like this:
-	new_irq =3D dev->irq & 0xf;
+	new_irq =3D dev->irq;
+	if (!new_irq || new_irq > 15)
+		return;
+	new_irq =3D dev->irq & 0xf;
	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq !=3D irq) {

or simply :

+	if (!dev->irq || dev->irq > 15)
+		return;
	new_irq =3D dev->irq & 0xf;

About Stian computer, looking for /proc/interrupts=20

11:      30696      27559   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uh=
ci_hcd:usb3

have USB on irq 11, with IO-APIC-level, which less acpi is not normal on
low numbers ( <=3D15  )  be IO-APIC-level,  normally is IO-APIC-edge.=20
Could be a ACPI problem .

Thanks,
--=20
S=E9rgio M. B.

--=-95/XTmf1M7Cdv/hjrMG1
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
SIb3DQEJBTEPFw0wNjA5MDcwMjAwMzhaMCMGCSqGSIb3DQEJBDEWBBTTPgkIEeJdlt8cZPYDJLXq
64SY6DANBgkqhkiG9w0BAQEFAASCAQAsaBoiJfPqNpsZaWKl/LuSKW7nw69Cuvs7gIrTVFYqnWuU
t/U3wDJkiN+efX8B7P6E1tXxgR4JnW0PGq6C+m4N0YTaWNVdAF0FH3InHCSrpMFvxibQIb+799Q0
LZCSUYl9HwSGX+5YXyIDMnZglD2PRzHF7t+do3V8vVsbT4RG+qldET3nO6Y0pxxw5rjrkl5F+XFQ
y6UT0jJub0U5hCPjhHj+zKnVyon838eFdbv3w9jqBIvvpMiF5KBurJWmLT0j8mfqw7V7whoS7c02
b7vJmTy5f5TSKNC/Hd1W5DerNwecH51mArqHoiEEVNhsuFv3p9KzgKXCG3Lg+YQgkXBVAAAAAAAA



--=-95/XTmf1M7Cdv/hjrMG1--
