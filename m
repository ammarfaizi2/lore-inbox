Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSKEUUX>; Tue, 5 Nov 2002 15:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbSKEUUW>; Tue, 5 Nov 2002 15:20:22 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:15249 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265196AbSKEUUV>;
	Tue, 5 Nov 2002 15:20:21 -0500
Message-ID: <3DC8450F.6000901@colorfullife.com>
Date: Tue, 05 Nov 2002 23:24:15 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix slab allocator for non zero boot cpu
References: <20021105054948.GA10335@krispykreme>
Content-Type: multipart/mixed;
 boundary="------------020309080904050100050904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020309080904050100050904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Anton Blanchard wrote:

>Hi,
>
>The slab allocator doesnt initialise ->array for all cpus. This means
>we fail to boot on a machine with boot cpu != 0. I was testing current
>2.5 BK.
>
>Luckily Rusty was at hand to explain the ins and outs of initialisers
>to me. Manfred, does this look OK to you?
>
I don't like the patch - it removes the safety net.

initarray_cache is __initdata, and is replaced with actual data after 
the kmalloc caches work, but only for the cpu that performed the 
bootstrap (end of kmem_cache_sizes_init())

With your patch, the pointer to the head arrays of the other cpus still 
point to an __initdata variable. It's even oopsable, if a 
CPU_ONLINE_PREPARE is failed by another subsystem.

What about the attached patch?

--
    Manfred

--------------020309080904050100050904
Content-Type: application/x-java-applet;version=1.1.1;
 name="patch-other"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch-other"

LS0tIGxrLm9yaWcvbW0vc2xhYi5jCVR1ZSBOb3YgIDUgMjE6MTc6NDYgMjAwMgorKysgbGsv
bW0vc2xhYi5jCVR1ZSBOb3YgIDUgMjE6MTg6MzggMjAwMgpAQCAtNDM3LDcgKzQzNyw2IEBA
CiAvKiBpbnRlcm5hbCBjYWNoZSBvZiBjYWNoZSBkZXNjcmlwdGlvbiBvYmpzICovCiBzdGF0
aWMga21lbV9jYWNoZV90IGNhY2hlX2NhY2hlID0gewogCS5saXN0cwkJPSBMSVNUM19JTklU
KGNhY2hlX2NhY2hlLmxpc3RzKSwKLQkuYXJyYXkJCT0geyBbMF0gPSAmaW5pdGFycmF5X2Nh
Y2hlLmNhY2hlIH0sCiAJLmJhdGNoY291bnQJPSAxLAogCS5saW1pdAkJPSBCT09UX0NQVUNB
Q0hFX0VOVFJJRVMsCiAJLm9ianNpemUJPSBzaXplb2Yoa21lbV9jYWNoZV90KSwKQEAgLTU5
Nyw2ICs1OTYsNyBAQAogCWluaXRfTVVURVgoJmNhY2hlX2NoYWluX3NlbSk7CiAJSU5JVF9M
SVNUX0hFQUQoJmNhY2hlX2NoYWluKTsKIAlsaXN0X2FkZCgmY2FjaGVfY2FjaGUubmV4dCwg
JmNhY2hlX2NoYWluKTsKKwljYWNoZV9jYWNoZS5hcnJheVtzbXBfcHJvY2Vzc29yX2lkKCld
ID0gJmluaXRhcnJheV9jYWNoZS5jYWNoZTsKIAogCWNhY2hlX2VzdGltYXRlKDAsIGNhY2hl
X2NhY2hlLm9ianNpemUsIDAsCiAJCQkmbGVmdF9vdmVyLCAmY2FjaGVfY2FjaGUubnVtKTsK

--------------020309080904050100050904--

