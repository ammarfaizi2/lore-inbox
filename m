Return-Path: <linux-kernel-owner+w=401wt.eu-S1751896AbXARDXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbXARDXZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 22:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXARDXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 22:23:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:41003 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbXARDXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 22:23:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=VoK0IsUlm8j3sKkrK4aKolaGYG2/NK3fKPd22NBlPYdZiUR1zfy1DArL2jNbXJBfVXJFnMQ4IGp7QbdwM/O69uBsn8nhLuJ6v7f3AbdpsFVN+x2a1YNsQxy9/D4J+RhpqUz38tgtXZvIz8xnQCCwedZ67LhmbgUrOPE6dkJToK0=
Message-ID: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
Date: Thu, 18 Jan 2007 11:23:23 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_121492_11806356.1169090603720"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_121492_11806356.1169090603720
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the newest patch against 2.6.20-rc5.
======================================================
>From ad9ca9a32bdcaddce9988afbf0187bfd04685a0c Mon Sep 17 00:00:00 2001
From: Aubrey.Li <aubreylee@gmail.com>
Date: Thu, 18 Jan 2007 11:08:31 +0800
Subject: [PATCH] Add an interface to limit total vfs page cache.
The default percent is using 90% memory for page cache.

Signed-off-by: Aubrey.Li <aubreylee@gmail.com>
---
 include/linux/gfp.h     |    1 +
 include/linux/pagemap.h |    2 +-
 include/linux/sysctl.h  |    2 ++
 kernel/sysctl.c         |   11 +++++++++++
 mm/page_alloc.c         |   17 +++++++++++++++--
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 00c314a..531360e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use
emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce
hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
+#define __GFP_PAGECACHE	((__force gfp_t)0x80000u) /* Is page cache
allocation ? */

 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c3e255b..890bb23 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -62,7 +62,7 @@ static inline struct page *__page_cache_

 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return __page_cache_alloc(mapping_gfp_mask(x));
+	return __page_cache_alloc(mapping_gfp_mask(x)|__GFP_PAGECACHE);
 }

 static inline struct page *page_cache_alloc_cold(struct address_space *x)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 81480e6..d3c9174 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -202,6 +202,7 @@ enum
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
+	VM_PAGECACHE_RATIO=36,	/* percent of RAM to use as page cache */
 };


@@ -955,6 +956,7 @@ extern ctl_handler sysctl_string;
 extern ctl_handler sysctl_intvec;
 extern ctl_handler sysctl_jiffies;
 extern ctl_handler sysctl_ms_jiffies;
+extern int sysctl_pagecache_ratio;


 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 600b333..92db115 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1035,6 +1035,17 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 #endif
+	{
+		.ctl_name	= VM_PAGECACHE_RATIO,
+		.procname	= "pagecache_ratio",
+		.data		= &sysctl_pagecache_ratio,
+		.maxlen		= sizeof(sysctl_pagecache_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1         = &zero,
+                .extra2         = &one_hundred,
+	},
 	{ .ctl_name = 0 }
 };

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fc5b544..5802b39 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -82,6 +82,8 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 #endif
 };

+int sysctl_pagecache_ratio = 10;
+
 EXPORT_SYMBOL(totalram_pages);

 static char * const zone_names[MAX_NR_ZONES] = {
@@ -895,6 +897,7 @@ failed:
 #define ALLOC_HARDER		0x10 /* try to alloc harder */
 #define ALLOC_HIGH		0x20 /* __GFP_HIGH set */
 #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
+#define ALLOC_PAGECACHE		0x80 /* __GFP_PAGECACHE set */

 #ifdef CONFIG_FAIL_PAGE_ALLOC

@@ -998,6 +1001,9 @@ int zone_watermark_ok(struct zone *z, in
 	if (alloc_flags & ALLOC_HARDER)
 		min -= min / 4;

+	if (alloc_flags & ALLOC_PAGECACHE)
+		min = min + (sysctl_pagecache_ratio * z->present_pages) / 100;
+
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		return 0;
 	for (o = 0; o < order; o++) {
@@ -1236,8 +1242,12 @@ restart:
 		return NULL;
 	}

-	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, ALLOC_WMARK_LOW|ALLOC_CPUSET);
+	if (gfp_mask & __GFP_PAGECACHE)	
+		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
+			zonelist, ALLOC_WMARK_LOW|ALLOC_CPUSET|ALLOC_PAGECACHE);
+	else
+		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
+					zonelist, ALLOC_WMARK_LOW|ALLOC_CPUSET);
 	if (page)
 		goto got_pg;

@@ -1273,6 +1283,9 @@ restart:
 	if (wait)
 		alloc_flags |= ALLOC_CPUSET;

+	if (gfp_mask & __GFP_PAGECACHE)
+		alloc_flags |= ALLOC_PAGECACHE;
+
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks go deeper into reserves.
-- 
1.4.3.4
=====================================================

------=_Part_121492_11806356.1169090603720
Content-Type: text/plain; name="0001-Add-an-interface-to-limit-total-vfs-page-cache.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Add-an-interface-to-limit-total-vfs-page-cache.txt"
X-Attachment-Id: f_ex2mc22e

RnJvbSBhZDljYTlhMzJiZGNhZGRjZTk5ODhhZmJmMDE4N2JmZDA0Njg1YTBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdWJyZXkuTGkgPGF1YnJleWxlZUBnbWFpbC5jb20+CkRhdGU6
IFRodSwgMTggSmFuIDIwMDcgMTE6MDg6MzEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBZGQgYW4g
aW50ZXJmYWNlIHRvIGxpbWl0IHRvdGFsIHZmcyBwYWdlIGNhY2hlLgpUaGUgZGVmYXVsdCBwZXJj
ZW50IGlzIHVzaW5nIDkwJSBtZW1vcnkgZm9yIHBhZ2UgY2FjaGUuCgpTaWduZWQtb2ZmLWJ5OiBB
dWJyZXkuTGkgPGF1YnJleWxlZUBnbWFpbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9nZnAuaCAg
ICAgfCAgICAxICsKIGluY2x1ZGUvbGludXgvcGFnZW1hcC5oIHwgICAgMiArLQogaW5jbHVkZS9s
aW51eC9zeXNjdGwuaCAgfCAgICAyICsrCiBrZXJuZWwvc3lzY3RsLmMgICAgICAgICB8ICAgMTEg
KysrKysrKysrKysKIG1tL3BhZ2VfYWxsb2MuYyAgICAgICAgIHwgICAxNyArKysrKysrKysrKysr
KystLQogNSBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZ2ZwLmggYi9pbmNsdWRlL2xpbnV4L2dmcC5oCmlu
ZGV4IDAwYzMxNGEuLjUzMTM2MGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZ2ZwLmgKKysr
IGIvaW5jbHVkZS9saW51eC9nZnAuaApAQCAtNDYsNiArNDYsNyBAQCBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3Q7CiAjZGVmaW5lIF9fR0ZQX05PTUVNQUxMT0MgKChfX2ZvcmNlIGdmcF90KTB4MTAwMDB1
KSAvKiBEb24ndCB1c2UgZW1lcmdlbmN5IHJlc2VydmVzICovCiAjZGVmaW5lIF9fR0ZQX0hBUkRX
QUxMICAgKChfX2ZvcmNlIGdmcF90KTB4MjAwMDB1KSAvKiBFbmZvcmNlIGhhcmR3YWxsIGNwdXNl
dCBtZW1vcnkgYWxsb2NzICovCiAjZGVmaW5lIF9fR0ZQX1RISVNOT0RFCSgoX19mb3JjZSBnZnBf
dCkweDQwMDAwdSkvKiBObyBmYWxsYmFjaywgbm8gcG9saWNpZXMgKi8KKyNkZWZpbmUgX19HRlBf
UEFHRUNBQ0hFCSgoX19mb3JjZSBnZnBfdCkweDgwMDAwdSkgLyogSXMgcGFnZSBjYWNoZSBhbGxv
Y2F0aW9uID8gKi8KIAogI2RlZmluZSBfX0dGUF9CSVRTX1NISUZUIDIwCS8qIFJvb20gZm9yIDIw
IF9fR0ZQX0ZPTyBiaXRzICovCiAjZGVmaW5lIF9fR0ZQX0JJVFNfTUFTSyAoKF9fZm9yY2UgZ2Zw
X3QpKCgxIDw8IF9fR0ZQX0JJVFNfU0hJRlQpIC0gMSkpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3BhZ2VtYXAuaCBiL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oCmluZGV4IGMzZTI1NWIuLjg5
MGJiMjMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oCisrKyBiL2luY2x1ZGUv
bGludXgvcGFnZW1hcC5oCkBAIC02Miw3ICs2Miw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHBh
Z2UgKl9fcGFnZV9jYWNoZV8KIAogc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZSAqcGFnZV9jYWNo
ZV9hbGxvYyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqeCkKIHsKLQlyZXR1cm4gX19wYWdlX2NhY2hl
X2FsbG9jKG1hcHBpbmdfZ2ZwX21hc2soeCkpOworCXJldHVybiBfX3BhZ2VfY2FjaGVfYWxsb2Mo
bWFwcGluZ19nZnBfbWFzayh4KXxfX0dGUF9QQUdFQ0FDSEUpOwogfQogCiBzdGF0aWMgaW5saW5l
IHN0cnVjdCBwYWdlICpwYWdlX2NhY2hlX2FsbG9jX2NvbGQoc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
KngpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N5c2N0bC5oIGIvaW5jbHVkZS9saW51eC9z
eXNjdGwuaAppbmRleCA4MTQ4MGU2Li5kM2M5MTc0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L3N5c2N0bC5oCisrKyBiL2luY2x1ZGUvbGludXgvc3lzY3RsLmgKQEAgLTIwMiw2ICsyMDIsNyBA
QCBlbnVtCiAJVk1fUEFOSUNfT05fT09NPTMzLAkvKiBwYW5pYyBhdCBvdXQtb2YtbWVtb3J5ICov
CiAJVk1fVkRTT19FTkFCTEVEPTM0LAkvKiBtYXAgVkRTTyBpbnRvIG5ldyBwcm9jZXNzZXM/ICov
CiAJVk1fTUlOX1NMQUI9MzUsCQkgLyogUGVyY2VudCBwYWdlcyBpZ25vcmVkIGJ5IHpvbmUgcmVj
bGFpbSAqLworCVZNX1BBR0VDQUNIRV9SQVRJTz0zNiwJLyogcGVyY2VudCBvZiBSQU0gdG8gdXNl
IGFzIHBhZ2UgY2FjaGUgKi8KIH07CiAKIApAQCAtOTU1LDYgKzk1Niw3IEBAIGV4dGVybiBjdGxf
aGFuZGxlciBzeXNjdGxfc3RyaW5nOwogZXh0ZXJuIGN0bF9oYW5kbGVyIHN5c2N0bF9pbnR2ZWM7
CiBleHRlcm4gY3RsX2hhbmRsZXIgc3lzY3RsX2ppZmZpZXM7CiBleHRlcm4gY3RsX2hhbmRsZXIg
c3lzY3RsX21zX2ppZmZpZXM7CitleHRlcm4gaW50IHN5c2N0bF9wYWdlY2FjaGVfcmF0aW87CiAK
IAogLyoKZGlmZiAtLWdpdCBhL2tlcm5lbC9zeXNjdGwuYyBiL2tlcm5lbC9zeXNjdGwuYwppbmRl
eCA2MDBiMzMzLi45MmRiMTE1IDEwMDY0NAotLS0gYS9rZXJuZWwvc3lzY3RsLmMKKysrIGIva2Vy
bmVsL3N5c2N0bC5jCkBAIC0xMDM1LDYgKzEwMzUsMTcgQEAgc3RhdGljIGN0bF90YWJsZSB2bV90
YWJsZVtdID0gewogCQkuZXh0cmExCQk9ICZ6ZXJvLAogCX0sCiAjZW5kaWYKKwl7CisJCS5jdGxf
bmFtZQk9IFZNX1BBR0VDQUNIRV9SQVRJTywKKwkJLnByb2NuYW1lCT0gInBhZ2VjYWNoZV9yYXRp
byIsCisJCS5kYXRhCQk9ICZzeXNjdGxfcGFnZWNhY2hlX3JhdGlvLAorCQkubWF4bGVuCQk9IHNp
emVvZihzeXNjdGxfcGFnZWNhY2hlX3JhdGlvKSwKKwkJLm1vZGUJCT0gMDY0NCwKKwkJLnByb2Nf
aGFuZGxlcgk9ICZwcm9jX2RvaW50dmVjX21pbm1heCwKKwkJLnN0cmF0ZWd5CT0gJnN5c2N0bF9p
bnR2ZWMsCisJCS5leHRyYTEgICAgICAgICA9ICZ6ZXJvLAorICAgICAgICAgICAgICAgIC5leHRy
YTIgICAgICAgICA9ICZvbmVfaHVuZHJlZCwKKwl9LAogCXsgLmN0bF9uYW1lID0gMCB9CiB9Owog
CmRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9jLmMKaW5kZXggZmM1
YjU0NC4uNTgwMmIzOSAxMDA2NDQKLS0tIGEvbW0vcGFnZV9hbGxvYy5jCisrKyBiL21tL3BhZ2Vf
YWxsb2MuYwpAQCAtODIsNiArODIsOCBAQCBpbnQgc3lzY3RsX2xvd21lbV9yZXNlcnZlX3JhdGlv
W01BWF9OUl9aCiAjZW5kaWYKIH07CiAKK2ludCBzeXNjdGxfcGFnZWNhY2hlX3JhdGlvID0gMTA7
CisKIEVYUE9SVF9TWU1CT0wodG90YWxyYW1fcGFnZXMpOwogCiBzdGF0aWMgY2hhciAqIGNvbnN0
IHpvbmVfbmFtZXNbTUFYX05SX1pPTkVTXSA9IHsKQEAgLTg5NSw2ICs4OTcsNyBAQCBmYWlsZWQ6
CiAjZGVmaW5lIEFMTE9DX0hBUkRFUgkJMHgxMCAvKiB0cnkgdG8gYWxsb2MgaGFyZGVyICovCiAj
ZGVmaW5lIEFMTE9DX0hJR0gJCTB4MjAgLyogX19HRlBfSElHSCBzZXQgKi8KICNkZWZpbmUgQUxM
T0NfQ1BVU0VUCQkweDQwIC8qIGNoZWNrIGZvciBjb3JyZWN0IGNwdXNldCAqLworI2RlZmluZSBB
TExPQ19QQUdFQ0FDSEUJCTB4ODAgLyogX19HRlBfUEFHRUNBQ0hFIHNldCAqLwogCiAjaWZkZWYg
Q09ORklHX0ZBSUxfUEFHRV9BTExPQwogCkBAIC05OTgsNiArMTAwMSw5IEBAIGludCB6b25lX3dh
dGVybWFya19vayhzdHJ1Y3Qgem9uZSAqeiwgaW4KIAlpZiAoYWxsb2NfZmxhZ3MgJiBBTExPQ19I
QVJERVIpCiAJCW1pbiAtPSBtaW4gLyA0OwogCisJaWYgKGFsbG9jX2ZsYWdzICYgQUxMT0NfUEFH
RUNBQ0hFKQorCQltaW4gPSBtaW4gKyAoc3lzY3RsX3BhZ2VjYWNoZV9yYXRpbyAqIHotPnByZXNl
bnRfcGFnZXMpIC8gMTAwOworCiAJaWYgKGZyZWVfcGFnZXMgPD0gbWluICsgei0+bG93bWVtX3Jl
c2VydmVbY2xhc3N6b25lX2lkeF0pCiAJCXJldHVybiAwOwogCWZvciAobyA9IDA7IG8gPCBvcmRl
cjsgbysrKSB7CkBAIC0xMjM2LDggKzEyNDIsMTIgQEAgcmVzdGFydDoKIAkJcmV0dXJuIE5VTEw7
CiAJfQogCi0JcGFnZSA9IGdldF9wYWdlX2Zyb21fZnJlZWxpc3QoZ2ZwX21hc2t8X19HRlBfSEFS
RFdBTEwsIG9yZGVyLAotCQkJCXpvbmVsaXN0LCBBTExPQ19XTUFSS19MT1d8QUxMT0NfQ1BVU0VU
KTsKKwlpZiAoZ2ZwX21hc2sgJiBfX0dGUF9QQUdFQ0FDSEUpCQorCQlwYWdlID0gZ2V0X3BhZ2Vf
ZnJvbV9mcmVlbGlzdChnZnBfbWFza3xfX0dGUF9IQVJEV0FMTCwgb3JkZXIsCisJCQl6b25lbGlz
dCwgQUxMT0NfV01BUktfTE9XfEFMTE9DX0NQVVNFVHxBTExPQ19QQUdFQ0FDSEUpOworCWVsc2UK
KwkJcGFnZSA9IGdldF9wYWdlX2Zyb21fZnJlZWxpc3QoZ2ZwX21hc2t8X19HRlBfSEFSRFdBTEws
IG9yZGVyLAorCQkJCQl6b25lbGlzdCwgQUxMT0NfV01BUktfTE9XfEFMTE9DX0NQVVNFVCk7CiAJ
aWYgKHBhZ2UpCiAJCWdvdG8gZ290X3BnOwogCkBAIC0xMjczLDYgKzEyODMsOSBAQCByZXN0YXJ0
OgogCWlmICh3YWl0KQogCQlhbGxvY19mbGFncyB8PSBBTExPQ19DUFVTRVQ7CiAKKwlpZiAoZ2Zw
X21hc2sgJiBfX0dGUF9QQUdFQ0FDSEUpCisJCWFsbG9jX2ZsYWdzIHw9IEFMTE9DX1BBR0VDQUNI
RTsKKwogCS8qCiAJICogR28gdGhyb3VnaCB0aGUgem9uZWxpc3QgYWdhaW4uIExldCBfX0dGUF9I
SUdIIGFuZCBhbGxvY2F0aW9ucwogCSAqIGNvbWluZyBmcm9tIHJlYWx0aW1lIHRhc2tzIGdvIGRl
ZXBlciBpbnRvIHJlc2VydmVzLgotLSAKMS40LjMuNAoK
------=_Part_121492_11806356.1169090603720--
