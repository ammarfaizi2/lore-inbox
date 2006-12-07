Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968808AbWLGFYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968808AbWLGFYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968811AbWLGFYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:24:05 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:31978 "EHLO
	exch01smtp11.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968808AbWLGFYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:24:02 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAHo0d0VThFhodGdsb2JhbACNNgE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.154):SA:0(-1.4/5.0):. Processed in 2.653059 secs Process 26823)
Subject: Re: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
References: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-C6DXGIHxb5qrcAt8zeNy"
Date: Thu, 07 Dec 2006 05:23:47 +0000
Message-Id: <1165469027.29517.11.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-OriginalArrivalTime: 07 Dec 2006 05:23:58.0913 (UTC) FILETIME=[E5DAFB10:01C719BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C6DXGIHxb5qrcAt8zeNy
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-11-26 at 15:23 -0800, Yinghai Lu wrote:
[PATCH 2/3] x86: remove duplicated parser for "pci=3Dnoacpi"=20

Remove "pci=3Dnoacpi" parse in acpi/boot.c, because it is duplicated=20
with that in pci/common.c.

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index d12fb97..6d62dd1 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -1285,15 +1293,6 @@ static int __init parse_acpi(char *arg)
 }
 early_param("acpi", parse_acpi);
=20
-/* FIXME: Using pci=3D for an ACPI parameter is a travesty. */
-static int __init parse_pci(char *arg)
-{
-       if (arg && strcmp(arg, "noacpi") =3D=3D 0)
-               acpi_disable_pci();
-       return 0;
-}
-early_param("pci", parse_pci);
-
 #ifdef CONFIG_X86_IO_APIC
 static int __init parse_acpi_skip_timer_override(char *arg)
 {
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index cdfcf97..6d5b70a 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -294,7 +294,7 @@ char * __devinit  pcibios_setup(char *str)
        }
 #endif
        else if (!strcmp(str, "noacpi")) {
-               acpi_noirq_set();
+               acpi_disable_pci();
                return NULL;
        }
        else if (!strcmp(str, "noearly")) {


/include/asm-x86_64/acpi.h (and asm-i386)
acpi_disable_pci :=20

#ifdef CONFIG_ACPI
static inline void acpi_noirq_set(void) { acpi_noirq =3D 1; }
static inline void acpi_disable_pci(void)
{
    acpi_pci_disabled =3D 1;
    acpi_noirq_set();
}
#else   /* !CONFIG_ACPI */
#define acpi_ioapic 0
static inline void acpi_noirq_set(void) { }
static inline void acpi_disable_pci(void) { }

so first hunk of the patch doesn't have nothing in common with second ,
and it is different disable acpi_irqs than disable all acpi,
callacpi_disable_pci () is acpi=3Doff.

My main goal when I read this mail was delete acpi=3Dnoirq or pci=3Dnoacpi
because is a redundant boot option which just make confusions. =20

I have to go (sleep)=20

Thanks,

--=20
S=E9rgio M.B.

--=-C6DXGIHxb5qrcAt8zeNy
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
SIb3DQEJBTEPFw0wNjEyMDcwNTIzNDNaMCMGCSqGSIb3DQEJBDEWBBRz+1r1aqgFcaq2XGF9Bp/q
FYaF/DANBgkqhkiG9w0BAQEFAASCAQA1bFRmYReaKdEJDFV+XLBlQOVWe3J13rwE0RqQ1WAMhc/5
y2Z6vnGnikiFrCgN8NcmQFBU/CWeSSlktyjlFBvc+gQR7CfefnzNy0EXsZ0Tvr4X88tZkphMWKse
WFJStjCunE6xpBRB/Okm3M+VLhFs+Zc7Vm8WwLSdxz8DKxaIcqzxkZnq7wDL7LMe6D8IbUUT9mTE
PSNcBP0g92SEI6jXHJn4zrQZ+arZBalXrWP5nQouaoCZ9fER9cde4oxfOG6fi/JhVsW0xZc7r4Rb
jkKR8pXhO6fzhqlC8e56ukcbqbngbBi0m7zJUnzsdXB6pCs6FA4huDdmtA7ZUXwltRZoAAAAAAAA



--=-C6DXGIHxb5qrcAt8zeNy--
