Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWIMHVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWIMHVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 03:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWIMHVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 03:21:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:58765 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751658AbWIMHVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 03:21:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=YK5+QRqaeSAEYOWK7asVWM7m25yyF+9JDlz5ZsD1TLETs3XyeNrKNJqBajJvXbtzDckXRaoYaso0A9frscYDy/2Nnk7kiP5qkmh1jTdtGuJZft4oxd/NQMCyIEzNvQjBxoApIHEMJmWfDVzSIz0bmGW9oL12dwqbgxHztFHAVN8=
Message-ID: <6d6a94c50609130021q5e9071a1n5c9b6036f6037b28@mail.gmail.com>
Date: Wed, 13 Sep 2006 15:21:47 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Cc: "David Howells" <dhowells@redhat.com>, "Matt Mackall" <mpm@selenic.com>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
In-Reply-To: <450769E2.4080904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_185772_28088143.1158132107974"
References: <20060912174339.GA19707@waste.org>
	 <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>
	 <17162.1157365295@warthog.cambridge.redhat.com>
	 <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>
	 <3551.1157448903@warthog.cambridge.redhat.com>
	 <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com>
	 <44FE4222.3080106@yahoo.com.au>
	 <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com>
	 <15193.1158088232@warthog.cambridge.redhat.com>
	 <450769E2.4080904@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_185772_28088143.1158132107974
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I changed my patch with some of your suggestions. Anyway, my system
works properly with the patch while the current kernel does not.

From: Aubrey.Li <aubrey@linux-suse.ADI>
Date: Wed, 13 Sep 2006 15:01:23 +0800
Subject: [PATCH] Make the SLOB allocator mark its pages with PG_slab.
Signed-off-by: Aubrey.Li <aubrey.adi@gmail.com>
---
 mm/slob.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 7b52b20..05f0d16 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -109,6 +109,7 @@ static void *slob_alloc(size_t size, gfp

 			slob_free(cur, PAGE_SIZE);
 			spin_lock_irqsave(&slob_lock, flags);
+			SetPageSlab(virt_to_page(cur));
 			cur = slobfree;
 		}
 	}
@@ -173,12 +174,17 @@ void *kmalloc(size_t size, gfp_t gfp)
 		return 0;

 	bb->order = find_order(size);
-	bb->pages = (void *)__get_free_pages(gfp, bb->order);
+	page = alloc_pages(gfp, bb->order);
+	bb->pages = page_address(page);

 	if (bb->pages) {
 		spin_lock_irqsave(&block_lock, flags);
 		bb->next = bigblocks;
 		bigblocks = bb;
+		for (i = 0; i < (1 << bb->order); i++) {
+			SetPageSlab(page);
+			page++;
+		}
 		spin_unlock_irqrestore(&block_lock, flags);
 		return bb->pages;
 	}
@@ -202,8 +208,15 @@ void kfree(const void *block)
 		spin_lock_irqsave(&block_lock, flags);
 		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
 			if (bb->pages == block) {
+				struct page *page = virt_to_page(bb->pages);
+				int i;
+
 				*last = bb->next;
 				spin_unlock_irqrestore(&block_lock, flags);
+				for (i = 0; i < (1 << bb->order); i++) {
+					ClearPageSlab(page);
+					page++;
+				}
 				free_pages((unsigned long)block, bb->order);
 				slob_free(bb, sizeof(bigblock_t));
 				return;
@@ -332,11 +345,6 @@ static struct timer_list slob_timer = TI

 void kmem_cache_init(void)
 {
-	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
-
-	if (p)
-		free_page((unsigned long)p);
-
 	mod_timer(&slob_timer, jiffies + HZ);
 }

-- 
1.4.0

------=_Part_185772_28088143.1158132107974
Content-Type: text/plain; 
	name=0001-Make-the-SLOB-allocator-mark-its-pages-with-PG_slab.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_es1e6714
Content-Disposition: attachment; filename="0001-Make-the-SLOB-allocator-mark-its-pages-with-PG_slab.txt"

RnJvbSA2ZTJlNjE1YTJmNTlmNWI4ZDFiODMxMmM1ZjhjYzU5NmI5MjdiZTlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdWJyZXkuTGkgPGF1YnJleUBsaW51eC1zdXNlLkFEST4KRGF0
ZTogV2VkLCAxMyBTZXAgMjAwNiAxNTowMToyMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIE1ha2Ug
dGhlIFNMT0IgYWxsb2NhdG9yIG1hcmsgaXRzIHBhZ2VzIHdpdGggUEdfc2xhYi4KU2lnbmVkLW9m
Zi1ieTogQXVicmV5LkxpIDxhdWJyZXkuYWRpQGdtYWlsLmNvbT4KLS0tCiBtbS9zbG9iLmMgfCAg
IDIwICsrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vc2xvYi5jIGIvbW0vc2xvYi5jCmlu
ZGV4IDdiNTJiMjAuLjA1ZjBkMTYgMTAwNjQ0Ci0tLSBhL21tL3Nsb2IuYworKysgYi9tbS9zbG9i
LmMKQEAgLTEwOSw2ICsxMDksNyBAQCBzdGF0aWMgdm9pZCAqc2xvYl9hbGxvYyhzaXplX3Qgc2l6
ZSwgZ2ZwCiAKIAkJCXNsb2JfZnJlZShjdXIsIFBBR0VfU0laRSk7CiAJCQlzcGluX2xvY2tfaXJx
c2F2ZSgmc2xvYl9sb2NrLCBmbGFncyk7CisJCQlTZXRQYWdlU2xhYih2aXJ0X3RvX3BhZ2UoY3Vy
KSk7CiAJCQljdXIgPSBzbG9iZnJlZTsKIAkJfQogCX0KQEAgLTE3MywxMiArMTc0LDE3IEBAIHZv
aWQgKmttYWxsb2Moc2l6ZV90IHNpemUsIGdmcF90IGdmcCkKIAkJcmV0dXJuIDA7CiAKIAliYi0+
b3JkZXIgPSBmaW5kX29yZGVyKHNpemUpOwotCWJiLT5wYWdlcyA9ICh2b2lkICopX19nZXRfZnJl
ZV9wYWdlcyhnZnAsIGJiLT5vcmRlcik7CisJcGFnZSA9IGFsbG9jX3BhZ2VzKGdmcCwgYmItPm9y
ZGVyKTsKKwliYi0+cGFnZXMgPSBwYWdlX2FkZHJlc3MocGFnZSk7CiAKIAlpZiAoYmItPnBhZ2Vz
KSB7CiAJCXNwaW5fbG9ja19pcnFzYXZlKCZibG9ja19sb2NrLCBmbGFncyk7CiAJCWJiLT5uZXh0
ID0gYmlnYmxvY2tzOwogCQliaWdibG9ja3MgPSBiYjsKKwkJZm9yIChpID0gMDsgaSA8ICgxIDw8
IGJiLT5vcmRlcik7IGkrKykgeworCQkJU2V0UGFnZVNsYWIocGFnZSk7CisJCQlwYWdlKys7CisJ
CX0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYmxvY2tfbG9jaywgZmxhZ3MpOwogCQlyZXR1
cm4gYmItPnBhZ2VzOwogCX0KQEAgLTIwMiw4ICsyMDgsMTUgQEAgdm9pZCBrZnJlZShjb25zdCB2
b2lkICpibG9jaykKIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmJsb2NrX2xvY2ssIGZsYWdzKTsKIAkJ
Zm9yIChiYiA9IGJpZ2Jsb2NrczsgYmI7IGxhc3QgPSAmYmItPm5leHQsIGJiID0gYmItPm5leHQp
IHsKIAkJCWlmIChiYi0+cGFnZXMgPT0gYmxvY2spIHsKKwkJCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9
IHZpcnRfdG9fcGFnZShiYi0+cGFnZXMpOworCQkJCWludCBpOworCiAJCQkJKmxhc3QgPSBiYi0+
bmV4dDsKIAkJCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZibG9ja19sb2NrLCBmbGFncyk7CisJ
CQkJZm9yIChpID0gMDsgaSA8ICgxIDw8IGJiLT5vcmRlcik7IGkrKykgeworCQkJCQlDbGVhclBh
Z2VTbGFiKHBhZ2UpOworCQkJCQlwYWdlKys7CisJCQkJfQogCQkJCWZyZWVfcGFnZXMoKHVuc2ln
bmVkIGxvbmcpYmxvY2ssIGJiLT5vcmRlcik7CiAJCQkJc2xvYl9mcmVlKGJiLCBzaXplb2YoYmln
YmxvY2tfdCkpOwogCQkJCXJldHVybjsKQEAgLTMzMiwxMSArMzQ1LDYgQEAgc3RhdGljIHN0cnVj
dCB0aW1lcl9saXN0IHNsb2JfdGltZXIgPSBUSQogCiB2b2lkIGttZW1fY2FjaGVfaW5pdCh2b2lk
KQogewotCXZvaWQgKnAgPSBzbG9iX2FsbG9jKFBBR0VfU0laRSwgMCwgUEFHRV9TSVpFLTEpOwot
Ci0JaWYgKHApCi0JCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwKTsKLQogCW1vZF90aW1lcigm
c2xvYl90aW1lciwgamlmZmllcyArIEhaKTsKIH0KIAotLSAKMS40LjAKCg==
------=_Part_185772_28088143.1158132107974--
