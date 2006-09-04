Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWIDAtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWIDAtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 20:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWIDAtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 20:49:40 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:27796 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751217AbWIDAti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 20:49:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAMMT+0SBT4ljgRg
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.223):SA:0(0.7/5.0):. Processed in 3.659266 secs Process 2956)
Subject: VIA IRQ quirk fixup only in XT-PIC mode Take 3
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu, Daniel Drake <dsd@gentoo.org>
Cc: Len Brown <len.brown@intel.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-UqU04QgP9o4nfz/RGWbd"
Date: Mon, 04 Sep 2006 01:42:47 +0100
Message-Id: <1157330567.3046.24.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 04 Sep 2006 00:49:35.0927 (UTC) FILETIME=[FE522C70:01C6CFBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UqU04QgP9o4nfz/RGWbd
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi, this patch (now for 2.6.18-rc5).


I found, on my new VIA with IO-APIC working well, that quirks aren't
good/needed.
After, I found this interesting email http://lkml.org/lkml/2005/8/13/30
by Karsten Wiese, after, Alan Cox writes this
http://lkml.org/lkml/2005/8/16/160 (on same thread) and Karsten Wiese
end ups with the solution on http://lkml.org/lkml/2005/8/18/92, which I
want try to implement. =20
I have 2 VIAs with almost same IDs (others reporters have
with exactly the same IDs) and in ones I need the quirks and in others
don't, because one don't have APIC enabled, the other have it !?!

we have other reported of the same problem
http://lkml.org/lkml/2006/7/30/59
and=20
http://lkml.org/lkml/2006/9/1/106

Checking my emails that I send to Len Brown on May of 2005 about this
subject. I found, what I want, is just revert one patch of Bjorn
Helgaas, between kernel 2.6.12-rc5 and 6.14.
Check this out
http://sourceforge.net/mailarchive/message.php?msg_id=3D11858102

To finish I want put clear, the great work of Bjorn Helgaas which have
made all of this, but at the end, I suspect with one false positive
report introduce this regression, that I hopefully found.

Thanks,
I aspect all of you, your positive vote.

--
S=E9rgio M. B.=20

Cc: len.brown@intel.com=20
Cc: bjorn.helgaas@hp.com=20
Cc: Daniel Drake <dsd@gentoo.org>=20
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Scott J. Harmon" <harmon@ksu.edu>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org
diff linux-2.6.17.x86_64/drivers/pci/quirks.c.orig linux-2.6.17.x86_64/driv=
ers/pci/quirks.c -up
--- linux-2.6.17.x86_64/drivers/pci/quirks.c.orig       2006-09-04 01:37:09=
.000000000 +0100
+++ linux-2.6.17.x86_64/drivers/pci/quirks.c    2006-09-04 01:40:16.0000000=
00 +0100
@@ -654,22 +654,24 @@ static void quirk_via_irq(struct pci_dev
 {
        u8 irq, new_irq;

+#ifdef CONFIG_X86_IO_APIC
+       if (nr_ioapics && !skip_ioapic_setup)
+               return;
+#endif
+#ifdef CONFIG_ACPI
+       if (acpi_irq_model !=3D ACPI_IRQ_MODEL_PIC)
+               return;
+#endif
        new_irq =3D dev->irq & 0xf;
        pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
        if (new_irq !=3D irq) {
-               printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\=
n",
+               printk(KERN_INFO "PCI: VIA PIC IRQ fixup for %s, from %d to=
 %d\n",
                        pci_name(dev), irq, new_irq);
                udelay(15);     /* unknown if delay really needed */
                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
        }
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quir=
k_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, qu=
irk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);

 /*
  * VIA VT82C598 has its device ID settable and many BIOSes


--=-UqU04QgP9o4nfz/RGWbd
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
SIb3DQEJBTEPFw0wNjA5MDQwMDQyNDNaMCMGCSqGSIb3DQEJBDEWBBQWmVrbxPowYNvA49sdt5X3
yTuRzjANBgkqhkiG9w0BAQEFAASCAQBkdJmFnJEW1JizFvU4V0Btz+IAws9BjuLGEqU1ObLlV6U0
ROKzYids+jVjH0hDA+1JbkfkLWnNto3/FOJgK8bC152kGOhlxB2+uAvjRMoi+slmqht76HQGagbh
ZGyyBV4j53JRht4USpCgervNmyS+5Wr9XIyyIiYzFDvIKcR7FLb65rgDWptyMc2jfszQmLoR+YHh
Cf486AykmljuTgwfgcTq0/ojFOyiOth4FJvs/CsLaaX1KhJYmUWJ4w6FqpBku9dKu05RM5qxUcUy
mqVed2Ad+KzbSwhYM2C15HEzJC9p6/Y8gJjnKwxjFpf47lEtZct7e+sbAb3rHKsBrQt6AAAAAAAA



--=-UqU04QgP9o4nfz/RGWbd--

-- 
VGER BF report: U 0.5
