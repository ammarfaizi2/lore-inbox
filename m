Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTKRVBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTKRVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 16:01:22 -0500
Received: from mmp-1.gci.net ([208.138.130.80]:55002 "EHLO mmp-1.gci.net")
	by vger.kernel.org with ESMTP id S263786AbTKRVBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 16:01:17 -0500
Date: Tue, 18 Nov 2003 12:01:14 -0900
From: leif <leif@gci.net>
Subject: error in Sparc64 rwlock.S
In-reply-to: <200212112043.gBBKhLE28272@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <00de01c3ae17$1ac8bd70$31828ad0@internet.gci.net>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Content-type: multipart/signed;
 boundary="----=_NextPart_000_0035_01C3ADCB.AA13DA60"; micalg=SHA1;
 protocol="application/x-pkcs7-signature"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0035_01C3ADCB.AA13DA60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I'm going through the 2.6.0-test9 and some -mm3 patches, and have run
into
an issue with arch/sparc64/lib/rwlock.S

When compiling, the assembler complains of multiple definitions of
__write_trylock.

from the 2.6.0-test9-mm3.bz2  patchfile:

--- linux-2.6.0-test9/arch/sparc64/lib/rwlock.S 2003-11-09
16:45:05.000000000 -
+++ 25/arch/sparc64/lib/rwlock.S        2003-11-12 21:37:55.000000000
-0800
@@ -63,5 +63,55 @@ __write_lock: /* %o0 = lock_ptr */
        be,pt           %icc, 99b
         membar         #StoreLoad | #StoreStore
        ba,a,pt         %xcc, 1b
+
+       .globl          __write_trylock
+__write_trylock: /* %o0 = lock_ptr */ 
+       sethi           %hi(0x80000000), %g2
+1:     lduw            [%o0], %g5
+       brnz,pn         %g5, __write_trylock_fail
+4:      or             %g5, %g2, %g7
+
+       cas             [%o0], %g5, %g7
+       cmp             %g5, %g7
+       be,pt           %icc, __write_trylock_succeed
+        membar         #StoreLoad | #StoreStore
+
+       ba,pt           %xcc, 1b
+        nop
+__write_trylock_succeed:
+       retl
+        mov            1, %o0
+
+__write_trylock_fail:
+       retl
+        mov            0, %o0
+
+       .globl  __read_trylock
+__read_trylock: /* %o0 = lock_ptr */
+       ldsw            [%o0], %g5   
+       brlz,pn         %g5, 100f    
+        add            %g5, 1, %g7  
+       cas             [%o0], %g5, %g7
+       cmp             %g5, %g7
+       bne,pn          %icc, __read_trylock
+        membar         #StoreLoad | #StoreStore
+       retl
+        mov            1, %o0
+
+       .globl          __write_trylock
+__write_trylock: /* %o0 = lock_ptr */ 
+       sethi           %hi(0x80000000), %g2
+1:     lduw            [%o0], %g5
+4:     brnz,pn         %g5, 100f 
+        or             %g5, %g2, %g7
+       cas             [%o0], %g5, %g7
+       cmp             %g5, %g7
+       bne,pn          %icc, 1b
+        membar         #StoreLoad | #StoreStore
+       retl
+        mov            1, %o0
+100:   retl
+        mov            0, %o0


You can see where __write_trylock is defined as a global entry point
twice.

Unfortunately, I'm not knowledgeable enough about sparc assembler to
be able to fix this correctly.

Please cc me directly, as I'm no longer on LKML.

Thanks,

 Leif

------=_NextPart_000_0035_01C3ADCB.AA13DA60
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFuDCCAngw
ggHhoAMCAQICAwkdJTANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAzMDEyMTIzMjkwOVoXDTA0MDEyMTIzMjkwOVowQTEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEeMBwGCSqGSIb3DQEJARYPbHNhd3llckBnY2kuY29tMIGfMA0GCSqG
SIb3DQEBAQUAA4GNADCBiQKBgQCu1qlKy81sgP+hQsDnPs7sZfShYyGKmkdL5spm0JpheqGIboGB
IeoGP2sUX++b5TcOhbg5ZCQDd2yT75O9BN0gJLlDzNxabms5mJRBbj5LzCwucQqZG25Seo9sHk8R
mW5hCOQbnULWPEMUTG/kDNtXFZjCr0Om5OWnnTuNHqK4KQIDAQABoywwKjAaBgNVHREEEzARgQ9s
c2F3eWVyQGdjaS5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCChYp5yWCZ5Mh3
h6kbzZgoeCiKM09rHvckT157nuXOj1bqm/HEsCaXDZu/MecPsaEfDixMOFP6Qwg3U67ceGL01yVP
clnNJE/api0+DU7jRBaNI09+RgwegexT6VvIqanB8riRgOtbklZX/NOymHI87yrNshq9UBONeSzc
Pj8FqTCCAzgwggKhoAMCAQICEGZFcrfMdPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgG
A1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMg
RGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3
DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wNDA4
MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQH
EwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2Vydmlj
ZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1Km1wPPrcrvfudG8w
vDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxD
QlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRow
GAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIB
BjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6
/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXrokefbKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXd
iuT82w0fnQLzWtvKPPZE6iZph39Ins6ln+eE2MliYq0FxjGCAqowggKmAgEBMIGaMIGSMQswCQYD
VQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNV
BAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNv
bmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwkdJTAJBgUrDgMCGgUAoIIBZTAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMzExMTgyMTAxMTNaMCMGCSqGSIb3DQEJ
BDEWBBS1khPXBBUxDrHd9O2rqRSvN+SGaTBYBgkqhkiG9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0C
BTCBqwYJKwYBBAGCNxAEMYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlm
aWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
AwkdJTANBgkqhkiG9w0BAQEFAASBgEoFO9yvlKHGXExqdy1ZFQfXorkWFsvdPotkx5NPKtzmVmRU
zpP7D06gFJEr23+lf3NrPYOrzRHcwPpJk98SA8SGxaSGhBYn7A+gN+6i/XkXpawGcTsvYsG0xQ5u
TyhIzFfD7Eipoc2vbwCpaPOCs99YTKWGdFbXJAtJPwjN/sAEAAAAAAAA

------=_NextPart_000_0035_01C3ADCB.AA13DA60--

