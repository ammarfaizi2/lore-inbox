Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271897AbRIIHin>; Sun, 9 Sep 2001 03:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271920AbRIIHid>; Sun, 9 Sep 2001 03:38:33 -0400
Received: from colorfullife.com ([216.156.138.34]:22283 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271897AbRIIHiP>;
	Sun, 9 Sep 2001 03:38:15 -0400
Message-ID: <001a01c13902$762c7f30$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Robert Love" <rml@tech9.net>
Cc: "Roger Larsson" <roger.larsson@norran.net>, <linux-kernel@vger.kernel.org>,
        <nigel@nrg.org>
In-Reply-To: <000901c138bb$8e151270$010411ac@local> <1000007070.836.14.camel@phantasy>
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
Date: Sun, 9 Sep 2001 09:38:16 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C13913.2720D6F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C13913.2720D6F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


> #define kmap_atomic(page,idx) ctx_sw_off(); kmap(page);
> #define kunmap_atomic(page,idx) ctx_sw_on(); kunmap(page);
>
No. kmap_atomic is called from interrupt context, and kmap calls
schedule().

I thought about the attached patch (completely untested).

--
    Manfred

------=_NextPart_000_0013_01C13913.2720D6F0
Content-Type: application/octet-stream;
	name="patch-untested"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-untested"

--- highmem.h.prev	Sun Sep  9 08:59:04 2001=0A=
+++ highmem.h	Sun Sep  9 09:00:07 2001=0A=
@@ -88,6 +88,7 @@=0A=
 	if (page < highmem_start_page)=0A=
 		return page_address(page);=0A=
 =0A=
+	ctx_sw_off();=0A=
 	idx =3D type + KM_TYPE_NR*smp_processor_id();=0A=
 	vaddr =3D __fix_to_virt(FIX_KMAP_BEGIN + idx);=0A=
 #if HIGHMEM_DEBUG=0A=
@@ -119,6 +120,7 @@=0A=
 	pte_clear(kmap_pte-idx);=0A=
 	__flush_tlb_one(vaddr);=0A=
 #endif=0A=
+	ctx_sw_on();=0A=
 }=0A=
 =0A=
 #endif /* __KERNEL__ */=0A=

------=_NextPart_000_0013_01C13913.2720D6F0--

