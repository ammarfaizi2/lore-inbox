Return-Path: <linux-kernel-owner+w=401wt.eu-S1752020AbXAQE3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXAQE3b (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXAQE3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:29:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:34727 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbXAQE3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:29:30 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Tx8/8IzxZcr6BypTJsJXixL+bFSjgBm30Voh/x25wO2Wj/gqTi0KftZgugyTxCL7dR8m7wGgkdr98SRZKYwQRQ42tZwqkW6bugKzg4+TMWoMGqFwcV7Ll1k7mOicqZsFSE26wLwjWBsCct9DAAjHI6gpsRyeGNL4PvKe7Ybyb34=
Message-ID: <6d6a94c50701162029x1c345040r85c3efc0569add20@mail.gmail.com>
Date: Wed, 17 Jan 2007 12:29:29 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: O_DIRECT question
Cc: "Roy Huang" <royhuang9@gmail.com>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrew Morton" <akpm@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>
In-Reply-To: <Pine.LNX.4.64.0701110842480.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_102204_4983065.1169008169167"
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	 <20070110220603.f3685385.akpm@osdl.org>
	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
	 <20070110225720.7a46e702.akpm@osdl.org>
	 <45A5E1B2.2050908@yahoo.com.au>
	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
	 <afe668f90701110005ya2e8187pc6604c5aad24cc84@mail.gmail.com>
	 <Pine.LNX.4.64.0701110842480.3594@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_102204_4983065.1169008169167
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/12/07, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 11 Jan 2007, Roy Huang wrote:
> >
> > On a embedded systerm, limiting page cache can relieve memory
> > fragmentation. There is a patch against 2.6.19, which limit every
> > opened file page cache and total pagecache. When the limit reach, it
> > will release the page cache overrun the limit.
>
> I do think that something like this is probably a good idea, even on
> non-embedded setups. We historically couldn't do this, because mapped
> pages were too damn hard to remove, but that's obviously not much of a
> problem any more.
>
> However, the page-cache limit should NOT be some compile-time constant. It
> should work the same way the "dirty page" limit works, and probably just
> default to "feel free to use 90% of memory for page cache".
>
>                 Linus
>

The attached patch limit the page cache by a simple way:

1) If request memory from page cache, Set a flag to mark this kind of
allocation:

static inline struct page *page_cache_alloc(struct address_space *x)
 {
-       return __page_cache_alloc(mapping_gfp_mask(x));
+       return __page_cache_alloc(mapping_gfp_mask(x)|__GFP_PAGECACHE);
 }

2) Have zone_watermark_ok done this limit:

+       if (alloc_flags & ALLOC_PAGECACHE){
+               min = min + VFS_CACHE_LIMIT;
+       }
+
        if (free_pages <= min + z->lowmem_reserve[classzone_idx])
                return 0;

3) So, when __alloc_pages is called by page cache, pass the
ALLOC_PAGECACHE into get_page_from_freelist to trigger the pagecache
limit branch in zone_watermark_ok.

This approach works on my side, I'll make a new patch to make the
limit tunable in the proc fs soon.

The following is the patch:
=====================================================
Index: mm/page_alloc.c
===================================================================
--- mm/page_alloc.c	(revision 2645)
+++ mm/page_alloc.c	(working copy)
@@ -892,6 +892,9 @@ failed:
 #define ALLOC_HARDER		0x10 /* try to alloc harder */
 #define ALLOC_HIGH		0x20 /* __GFP_HIGH set */
 #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
+#define ALLOC_PAGECACHE		0x80 /* __GFP_PAGECACHE set */
+
+#define VFS_CACHE_LIMIT		0x400 /* limit VFS cache page */

 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
@@ -910,6 +913,10 @@ int zone_watermark_ok(struct zone *z, in
 	if (alloc_flags & ALLOC_HARDER)
 		min -= min / 4;

+	if (alloc_flags & ALLOC_PAGECACHE){
+		min = min + VFS_CACHE_LIMIT;
+	}
+
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		return 0;
 	for (o = 0; o < order; o++) {
@@ -1000,8 +1007,12 @@ restart:
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

@@ -1027,6 +1038,9 @@ restart:
 	if (wait)
 		alloc_flags |= ALLOC_CPUSET;

+	if (gfp_mask & __GFP_PAGECACHE)
+		alloc_flags |= ALLOC_PAGECACHE;
+
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks go deeper into reserves.
Index: include/linux/gfp.h
===================================================================
--- include/linux/gfp.h	(revision 2645)
+++ include/linux/gfp.h	(working copy)
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
Index: include/linux/pagemap.h
===================================================================
--- include/linux/pagemap.h	(revision 2645)
+++ include/linux/pagemap.h	(working copy)
@@ -62,7 +62,7 @@ static inline struct page *__page_cache_

 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return __page_cache_alloc(mapping_gfp_mask(x));
+	return __page_cache_alloc(mapping_gfp_mask(x)|__GFP_PAGECACHE);
 }

 static inline struct page *page_cache_alloc_cold(struct address_space *x)
=====================================================

Welcome any comments and suggestions,

Thanks,
-Aubrey

------=_Part_102204_4983065.1169008169167
Content-Type: text/x-patch; name=vfscache.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ex1998kv
Content-Disposition: attachment; filename="vfscache.diff"

SW5kZXg6IG1tL3BhZ2VfYWxsb2MuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBtbS9wYWdlX2FsbG9jLmMJKHJl
dmlzaW9uIDI2NDUpCisrKyBtbS9wYWdlX2FsbG9jLmMJKHdvcmtpbmcgY29weSkKQEAgLTg5Miw2
ICs4OTIsOSBAQCBmYWlsZWQ6CiAjZGVmaW5lIEFMTE9DX0hBUkRFUgkJMHgxMCAvKiB0cnkgdG8g
YWxsb2MgaGFyZGVyICovCiAjZGVmaW5lIEFMTE9DX0hJR0gJCTB4MjAgLyogX19HRlBfSElHSCBz
ZXQgKi8KICNkZWZpbmUgQUxMT0NfQ1BVU0VUCQkweDQwIC8qIGNoZWNrIGZvciBjb3JyZWN0IGNw
dXNldCAqLworI2RlZmluZSBBTExPQ19QQUdFQ0FDSEUJCTB4ODAgLyogX19HRlBfUEFHRUNBQ0hF
IHNldCAqLworCisjZGVmaW5lIFZGU19DQUNIRV9MSU1JVAkJMHg0MDAgLyogbGltaXQgVkZTIGNh
Y2hlIHBhZ2UgKi8KIAogLyoKICAqIFJldHVybiAxIGlmIGZyZWUgcGFnZXMgYXJlIGFib3ZlICdt
YXJrJy4gVGhpcyB0YWtlcyBpbnRvIGFjY291bnQgdGhlIG9yZGVyCkBAIC05MTAsNiArOTEzLDEw
IEBAIGludCB6b25lX3dhdGVybWFya19vayhzdHJ1Y3Qgem9uZSAqeiwgaW4KIAlpZiAoYWxsb2Nf
ZmxhZ3MgJiBBTExPQ19IQVJERVIpCiAJCW1pbiAtPSBtaW4gLyA0OwogCisJaWYgKGFsbG9jX2Zs
YWdzICYgQUxMT0NfUEFHRUNBQ0hFKXsKKwkJbWluID0gbWluICsgVkZTX0NBQ0hFX0xJTUlUOwor
CX0KKwogCWlmIChmcmVlX3BhZ2VzIDw9IG1pbiArIHotPmxvd21lbV9yZXNlcnZlW2NsYXNzem9u
ZV9pZHhdKQogCQlyZXR1cm4gMDsKIAlmb3IgKG8gPSAwOyBvIDwgb3JkZXI7IG8rKykgewpAQCAt
MTAwMCw4ICsxMDA3LDEyIEBAIHJlc3RhcnQ6CiAJCXJldHVybiBOVUxMOwogCX0KIAotCXBhZ2Ug
PSBnZXRfcGFnZV9mcm9tX2ZyZWVsaXN0KGdmcF9tYXNrfF9fR0ZQX0hBUkRXQUxMLCBvcmRlciwK
LQkJCQl6b25lbGlzdCwgQUxMT0NfV01BUktfTE9XfEFMTE9DX0NQVVNFVCk7CisJaWYgKGdmcF9t
YXNrICYgX19HRlBfUEFHRUNBQ0hFKQkKKwkJcGFnZSA9IGdldF9wYWdlX2Zyb21fZnJlZWxpc3Qo
Z2ZwX21hc2t8X19HRlBfSEFSRFdBTEwsIG9yZGVyLAorCQkJem9uZWxpc3QsIEFMTE9DX1dNQVJL
X0xPV3xBTExPQ19DUFVTRVR8QUxMT0NfUEFHRUNBQ0hFKTsKKwllbHNlCisJCXBhZ2UgPSBnZXRf
cGFnZV9mcm9tX2ZyZWVsaXN0KGdmcF9tYXNrfF9fR0ZQX0hBUkRXQUxMLCBvcmRlciwKKwkJCQkJ
em9uZWxpc3QsIEFMTE9DX1dNQVJLX0xPV3xBTExPQ19DUFVTRVQpOwogCWlmIChwYWdlKQogCQln
b3RvIGdvdF9wZzsKIApAQCAtMTAyNyw2ICsxMDM4LDkgQEAgcmVzdGFydDoKIAlpZiAod2FpdCkK
IAkJYWxsb2NfZmxhZ3MgfD0gQUxMT0NfQ1BVU0VUOwogCisJaWYgKGdmcF9tYXNrICYgX19HRlBf
UEFHRUNBQ0hFKQorCQlhbGxvY19mbGFncyB8PSBBTExPQ19QQUdFQ0FDSEU7CisKIAkvKgogCSAq
IEdvIHRocm91Z2ggdGhlIHpvbmVsaXN0IGFnYWluLiBMZXQgX19HRlBfSElHSCBhbmQgYWxsb2Nh
dGlvbnMKIAkgKiBjb21pbmcgZnJvbSByZWFsdGltZSB0YXNrcyBnbyBkZWVwZXIgaW50byByZXNl
cnZlcy4KSW5kZXg6IGluY2x1ZGUvbGludXgvZ2ZwLmgKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gaW5jbHVkZS9s
aW51eC9nZnAuaAkocmV2aXNpb24gMjY0NSkKKysrIGluY2x1ZGUvbGludXgvZ2ZwLmgJKHdvcmtp
bmcgY29weSkKQEAgLTQ2LDYgKzQ2LDcgQEAgc3RydWN0IHZtX2FyZWFfc3RydWN0OwogI2RlZmlu
ZSBfX0dGUF9OT01FTUFMTE9DICgoX19mb3JjZSBnZnBfdCkweDEwMDAwdSkgLyogRG9uJ3QgdXNl
IGVtZXJnZW5jeSByZXNlcnZlcyAqLwogI2RlZmluZSBfX0dGUF9IQVJEV0FMTCAgICgoX19mb3Jj
ZSBnZnBfdCkweDIwMDAwdSkgLyogRW5mb3JjZSBoYXJkd2FsbCBjcHVzZXQgbWVtb3J5IGFsbG9j
cyAqLwogI2RlZmluZSBfX0dGUF9USElTTk9ERQkoKF9fZm9yY2UgZ2ZwX3QpMHg0MDAwMHUpLyog
Tm8gZmFsbGJhY2ssIG5vIHBvbGljaWVzICovCisjZGVmaW5lIF9fR0ZQX1BBR0VDQUNIRQkoKF9f
Zm9yY2UgZ2ZwX3QpMHg4MDAwMHUpIC8qIElzIHBhZ2UgY2FjaGUgYWxsb2NhdGlvbiA/ICovCiAK
ICNkZWZpbmUgX19HRlBfQklUU19TSElGVCAyMAkvKiBSb29tIGZvciAyMCBfX0dGUF9GT08gYml0
cyAqLwogI2RlZmluZSBfX0dGUF9CSVRTX01BU0sgKChfX2ZvcmNlIGdmcF90KSgoMSA8PCBfX0dG
UF9CSVRTX1NISUZUKSAtIDEpKQpJbmRleDogaW5jbHVkZS9saW51eC9wYWdlbWFwLmgKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0gaW5jbHVkZS9saW51eC9wYWdlbWFwLmgJKHJldmlzaW9uIDI2NDUpCisrKyBpbmNs
dWRlL2xpbnV4L3BhZ2VtYXAuaAkod29ya2luZyBjb3B5KQpAQCAtNjIsNyArNjIsNyBAQCBzdGF0
aWMgaW5saW5lIHN0cnVjdCBwYWdlICpfX3BhZ2VfY2FjaGVfCiAKIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IHBhZ2UgKnBhZ2VfY2FjaGVfYWxsb2Moc3RydWN0IGFkZHJlc3Nfc3BhY2UgKngpCiB7Ci0J
cmV0dXJuIF9fcGFnZV9jYWNoZV9hbGxvYyhtYXBwaW5nX2dmcF9tYXNrKHgpKTsKKwlyZXR1cm4g
X19wYWdlX2NhY2hlX2FsbG9jKG1hcHBpbmdfZ2ZwX21hc2soeCl8X19HRlBfUEFHRUNBQ0hFKTsK
IH0KIAogc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZSAqcGFnZV9jYWNoZV9hbGxvY19jb2xkKHN0
cnVjdCBhZGRyZXNzX3NwYWNlICp4KQo=
------=_Part_102204_4983065.1169008169167--
