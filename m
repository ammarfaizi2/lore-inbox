Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVIFJri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVIFJri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVIFJri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:47:38 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40789
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964786AbVIFJri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:47:38 -0400
Message-Id: <431D82120200007800023FC1@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 06 Sep 2005 11:48:34 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <discuss@x86-64.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: watchdog frequency calculation adjustments
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB193E2E2.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartB193E2E2.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Like previously done for i386, get the x86_64 watchdog tick
calculation
into a state where it can also be used on CPUs with frequencies beyond
4GHz.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
/home/jbeulich/tmp/linux-2.6.13/arch/x86_64/kernel/nmi.c	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13/arch/x86_64/kernel/nmi.c	2005-09-06 11:03:36.000000000
+0200
@@ -367,7 +367,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -408,8 +408,8 @@ static int setup_p4_watchdog(void)
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n",
-(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz *
1000UL / nmi_hz));
+	wrmsrl(MSR_P4_IQ_COUNTER0, -((u64)cpu_khz * 1000 / nmi_hz));
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 	return 1;
@@ -505,7 +505,7 @@ void nmi_watchdog_tick (struct pt_regs *
  			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
  			apic_write(APIC_LVTPC, APIC_DM_NMI);
  		}
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 /
nmi_hz));
 	}
 }
 


--=__PartB193E2E2.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-watchdog.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-watchdog.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkxpa2UgcHJldmlvdXNseSBkb25lIGZvciBp
Mzg2LCBnZXQgdGhlIHg4Nl82NCB3YXRjaGRvZyB0aWNrIGNhbGN1bGF0aW9uCmludG8gYSBzdGF0
ZSB3aGVyZSBpdCBjYW4gYWxzbyBiZSB1c2VkIG9uIENQVXMgd2l0aCBmcmVxdWVuY2llcyBiZXlv
bmQKNEdIei4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29t
PgoKLS0tIC9ob21lL2piZXVsaWNoL3RtcC9saW51eC0yLjYuMTMvYXJjaC94ODZfNjQva2VybmVs
L25taS5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMvYXJj
aC94ODZfNjQva2VybmVsL25taS5jCTIwMDUtMDktMDYgMTE6MDM6MzYuMDAwMDAwMDAwICswMjAw
CkBAIC0zNjcsNyArMzY3LDcgQEAgc3RhdGljIHZvaWQgc2V0dXBfazdfd2F0Y2hkb2codm9pZCkK
IAkJfCBLN19OTUlfRVZFTlQ7CiAKIAl3cm1zcihNU1JfSzdfRVZOVFNFTDAsIGV2bnRzZWwsIDAp
OwotCXdybXNyKE1TUl9LN19QRVJGQ1RSMCwgLShjcHVfa2h6L25taV9oeioxMDAwKSwgLTEpOwor
CXdybXNybChNU1JfSzdfUEVSRkNUUjAsIC0oKHU2NCljcHVfa2h6ICogMTAwMCAvIG5taV9oeikp
OwogCWFwaWNfd3JpdGUoQVBJQ19MVlRQQywgQVBJQ19ETV9OTUkpOwogCWV2bnRzZWwgfD0gSzdf
RVZOVFNFTF9FTkFCTEU7CiAJd3Jtc3IoTVNSX0s3X0VWTlRTRUwwLCBldm50c2VsLCAwKTsKQEAg
LTQwOCw4ICs0MDgsOCBAQCBzdGF0aWMgaW50IHNldHVwX3A0X3dhdGNoZG9nKHZvaWQpCiAKIAl3
cm1zcihNU1JfUDRfQ1JVX0VTQ1IwLCBQNF9OTUlfQ1JVX0VTQ1IwLCAwKTsKIAl3cm1zcihNU1Jf
UDRfSVFfQ0NDUjAsIFA0X05NSV9JUV9DQ0NSMCAmIH5QNF9DQ0NSX0VOQUJMRSwgMCk7Ci0JRHBy
aW50aygic2V0dGluZyBQNF9JUV9DT1VOVEVSMCB0byAweCUwOGx4XG4iLCAtKGNwdV9raHovbm1p
X2h6KjEwMDApKTsKLQl3cm1zcihNU1JfUDRfSVFfQ09VTlRFUjAsIC0oY3B1X2toei9ubWlfaHoq
MTAwMCksIC0xKTsKKwlEcHJpbnRrKCJzZXR0aW5nIFA0X0lRX0NPVU5URVIwIHRvIDB4JTA4bHhc
biIsIC0oY3B1X2toeiAqIDEwMDBVTCAvIG5taV9oeikpOworCXdybXNybChNU1JfUDRfSVFfQ09V
TlRFUjAsIC0oKHU2NCljcHVfa2h6ICogMTAwMCAvIG5taV9oeikpOwogCWFwaWNfd3JpdGUoQVBJ
Q19MVlRQQywgQVBJQ19ETV9OTUkpOwogCXdybXNyKE1TUl9QNF9JUV9DQ0NSMCwgbm1pX3A0X2Nj
Y3JfdmFsLCAwKTsKIAlyZXR1cm4gMTsKQEAgLTUwNSw3ICs1MDUsNyBAQCB2b2lkIG5taV93YXRj
aGRvZ190aWNrIChzdHJ1Y3QgcHRfcmVncyAqCiAgCQkJd3Jtc3IoTVNSX1A0X0lRX0NDQ1IwLCBu
bWlfcDRfY2Njcl92YWwsIDApOwogIAkJCWFwaWNfd3JpdGUoQVBJQ19MVlRQQywgQVBJQ19ETV9O
TUkpOwogIAkJfQotCQl3cm1zcihubWlfcGVyZmN0cl9tc3IsIC0oY3B1X2toei9ubWlfaHoqMTAw
MCksIC0xKTsKKwkJd3Jtc3JsKG5taV9wZXJmY3RyX21zciwgLSgodTY0KWNwdV9raHogKiAxMDAw
IC8gbm1pX2h6KSk7CiAJfQogfQogCg==

--=__PartB193E2E2.0__=--
