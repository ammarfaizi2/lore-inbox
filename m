Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUCJMzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUCJMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:55:55 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:23595 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S262592AbUCJMzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:55:50 -0500
Message-ID: <404F104C.2030206@cs.up.ac.za>
Date: Wed, 10 Mar 2004 14:55:40 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040309
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stack allocation and gcc
References: <404F09C6.7030200@softhome.net>
In-Reply-To: <404F09C6.7030200@softhome.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030604010901070709010802"
X-Scan-Signature: 73c8e545bfdb47013f4f15c9692eacb1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030604010901070709010802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ihar,

In your code you have 3 buffers, one in the mani branch of 32 bytes and 
one of 32 bytes in each of the sub branches.  This adds up to a total of 
64 bytes since as you say, the two buffers named buf2[32] can be 
shared.  Thus it is 32 bytes for buf and 32 bytes for the shared 
buffer.  Now if you look at the function startup code:

   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 ec 68                sub    $0x68,%esp

THe push saves the frame pointer (ebp).  The mov sets up the new stack 
frame and the sub allocates space of 68 bytes on the stack, 4 bytes more 
than the expected 64, this is probably for temporary storage required 
somewhere in the function.  As such, gcc does not allocate 32 bytes too 
many (at least not on i386, but probably not on other architectures either).

Jaco

Ihar 'Philips' Filipau wrote:

> Hello All!
>
>    [ please cc: me ]
>
>    I have observed funny behaviour of both gcc 2.95/322 on ppc32 and 
> i686 platforms.
>
>    Have written this routine and compiled it with 'gcc -O2':
>
> int a(int v)
> {
>         char buf[32];
>
>         if (v > 5) {
>                 char buf2[32];
>                 printf( buf, buf2 );
>         } else {
>                 char buf2[32];
>                 printf( buf, buf2 );
>         }
>         return 1;
> }
>
>    I expected that stack on every branch of 'if(v>5)' will be 
> allocated later - but seems that gcc allocate stack space once and in 
> this case it will 'overallocate' 32 bytes - 'char buf2' will be 
> allocated twice for every branch. On i686 gcc allocates 108 bytes, on 
> ppc32 it allocates 116 bytes. (additional space seems to be induced by 
> printf() call)
>    Adding to this routine something like 'do { char a[32]; } 
> while(0);' several times shows that stack buffers are not reused - and 
> allocated for every this kind of context separately.
>
>    As to my understanding - since this buffers do live in different 
> mutually exclusive contextes - they can be reused. But this seems to 
> be not case. Waste of precious kernel stack space - and waste of d-cache.
>
>    I have read 'info gcc' - but found nothing relevant to this.
>    I've checked ppc abi - but found no limitations to reuse of stack 
> space.
>
>    Is it expected behaviour of compiler? gcc feature?
>
>    [ I have created macro which opens into inline function call which 
> utilizes va_list - on ppc32 va_list adds at least 32 bytes to stack 
> use. Seems to be bad idea for kernel-space, since every use if macro 
> adds to stack use (10 macro calls == 320 bytes). Easy to rewrite to 
> not to use va_list - but have I *NO* stack allocation check script in 
> place - this stuff could easily get into production release. Not nice. ]
>
>    disassembling outputs:
>
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms030604010901070709010802
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAwuV3TANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwMTI4MTMxNTM0WhcNMDUwMTI3MTMxNTM0
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJq
a3Jvb25AY3MudXAuYWMuemEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGM68H
Bm8eLZzRqFlPks3sjEOAQrolKEESLKGNAL6Pu+KUMRQ9wC5feaXfg5wmVBe6VLhTY9pkiVJi
mTX1VrHdJgnvqkKfjQrPn66oAqUlytHCSB6s5SmIquw1Nu4rMK5D+/LMqV73iTEyP/2p9GbK
w9h3xmqn3HytZfqgK/Zh8SKhjRzAE+PT2aVSBL43RetHgn4CRKVacERTLYK2Gfv5jhljPuSE
6ppfVOq/Jm/tduG/xn92wWlIOL8oPq4dQcy5wYjg9nrImwM7tFlD22iY0IESSqKTe2EkhcUY
rpc+M3XZEU7bz+sSTG7MbXNfkfn+4G92KN7Z9hhex1QAxBfnAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmprcm9vbkBjcy51cC5hYy56YTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AKItHT03yxemitMQFThOBwjiQrPwKqF5lqskzUY467RLA+6EBki+6MtGnv6yhwrOaV7H4BE3
p7gpVXtQZBlmHfZnK2l5C56OSdahZ77ti7+qsft7t1z+DyUUWCuRxA5hy4xXKgqd9cwy6mEp
uU7muCasFm9FR6H5vQbkCHH1DmjqMIIC0TCCAjqgAwIBAgIDC5XdMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNDAx
MjgxMzE1MzRaFw0wNTAxMjcxMzE1MzRaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmprcm9vbkBjcy51cC5hYy56YTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMYzrwcGbx4tnNGoWU+SzeyMQ4BCuiUoQRIsoY0Avo+74pQx
FD3ALl95pd+DnCZUF7pUuFNj2mSJUmKZNfVWsd0mCe+qQp+NCs+frqgCpSXK0cJIHqzlKYiq
7DU27iswrkP78sypXveJMTI//an0ZsrD2HfGaqfcfK1l+qAr9mHxIqGNHMAT49PZpVIEvjdF
60eCfgJEpVpwRFMtgrYZ+/mOGWM+5ITqml9U6r8mb+124b/Gf3bBaUg4vyg+rh1BzLnBiOD2
esibAzu0WUPbaJjQgRJKopN7YSSFxRiulz4zddkRTtvP6xJMbsxtc1+R+f7gb3Yo3tn2GF7H
VADEF+cCAwEAAaMvMC0wHQYDVR0RBBYwFIESamtyb29uQGNzLnVwLmFjLnphMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAoi0dPTfLF6aK0xAVOE4HCOJCs/AqoXmWqyTNRjjr
tEsD7oQGSL7oy0ae/rKHCs5pXsfgETenuClVe1BkGWYd9mcraXkLno5J1qFnvu2Lv6qx+3u3
XP4PJRRYK5HEDmHLjFcqCp31zDLqYSm5Tua4JqwWb0VHofm9BuQIcfUOaOowggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDAzMTAxMjU1NDBaMCMGCSqGSIb3DQEJ
BDEWBBRzuVetcVo+YIdFXFEO70cV6NyVFzBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQAz3GMH
Bm+Vam0lqPUVDq8V4vO4u1P6d8btBq8QiYNfHNksvjjP5d+uJpIYVnTG8KX0zhoe9SyT3z8C
yEM4rHGztSIhTnCLD2EyIHVlvi5XZzuIGzWGYDAoqzkQw3ae5eZEMA8LEtRQLcR5Ts2THPfC
HP0g04CtcK3Gp6YDhjBIFLFq1Cm6bJpTL+Au/7dTWQrMJTOfuwyXbugwV3IKXGdvyHtIbxal
BT+7z0Ra9Btvgj7jEJ4su1EU2kDMfRIGTvt6geZloj7p1yoYtwohtD4TrL6nULOdHafY0S4A
8f81swgzGuValfTfjgw9yJQNtHaPQQJrvi6W4yPg5mdRghz7AAAAAAAA
--------------ms030604010901070709010802--
