Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVA0TXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVA0TXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVA0TXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:23:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262679AbVA0TXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:23:13 -0500
Date: Thu, 27 Jan 2005 14:22:50 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050127151211.GB10843@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
 <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com>
 <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com>
 <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279726928-714884949-1106853770=:13927"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279726928-714884949-1106853770=:13927
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Thu, 27 Jan 2005, William Lee Irwin III wrote:

> The only claim above is the effect of clobbering virtual page 0 and
> referring to this phenomenon by the macro. I was rather careful not to
> claim a specific lower boundary to the address space.

OK, here is a patch that does compile against the current
2.6 kernel.  It it obvious we need a cutoff somewhere, so
I've chosen one that's sure to spark up a conversation
and I'll let others decide what that cutoff value is ;)))

===== mm/mmap.c 1.161 vs edited =====
--- 1.161/mm/mmap.c	Wed Jan 12 11:26:28 2005
+++ edited/mm/mmap.c	Thu Jan 27 14:19:21 2005
@@ -1259,6 +1259,13 @@
  			return addr;

  		/*
+		 * Make sure we don't allocate all the way down to
+		 * zero, which would break NULL pointer detection.
+		 */
+		if (addr < mm->brk)
+			goto fail;
+
+		/*
  		 * new region fits between prev_vma->vm_end and
  		 * vma->vm_start, use it:
  		 */
--279726928-714884949-1106853770=:13927
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="mmt2.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0501271422500.13927@chimarrao.boston.redhat.com>
Content-Description: zero mmap test case
Content-Disposition: attachment; filename="mmt2.c"

LyoNCiAqIFRlc3QgY2FzZSB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUga2Vy
bmVsIGNhbiBlbmQgdXAgbWFwcGluZyBhDQogKiBub24temVybyBub24tTUFQ
X0ZJWEVEIG1tYXAgYXJlYSBhdCBhZGRyZXNzIHplcm8sIHdoaWNoIHdvdWxk
DQogKiBiZSBiYWQuDQogKi8NCg0KI2luY2x1ZGUgPHN0ZGlvLmg+IA0KI2lu
Y2x1ZGUgPHN5cy90aW1lLmg+IA0KI2luY2x1ZGUgPHN5cy9tbWFuLmg+IA0K
I2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPiANCiNpbmNsdWRlIDx1bmlzdGQu
aD4gDQojaW5jbHVkZSA8ZmNudGwuaD4gDQogIA0KICANCmludCBtYWluKGlu
dCBhcmdjLCBjaGFyICoqYXJndikgDQp7IA0KICAgIGludCBpOyANCiAgICB2
b2lkICpwOyANCiAgICBmb3IoaSA9IDA7IDtpKyspIHsgDQoJDQogICAgICAg
IHAgPSBtbWFwKDAsIDQwOTYsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIA0K
ICAgICAgICAgICAgICAgICAgIE1BUF9QUklWQVRFIHwgTUFQX0FOT04sIC0x
LCAwKTsNCiAgICAgICAgaWYgKHAgPT0gTUFQX0ZBSUxFRCkgeyANCiAgICAg
ICAgICAgIGJyZWFrOyANCiAgICAgICAgfSANCiAgICAgICAgaWYgKHAgPT0g
MCkgeyANCiAgICAgICAgICAgIHByaW50ZigiQUNLISBHb3QgTklMIGFmdGVy
ICVkIG1hcHBpbmdzXG4iLCBpKTsgDQogLy8JICAgIHBlcnJvcigicHJvYmFi
bHkgdW5oZWxwZnVsOiAiKTsNCiAgICAgICAgICAgIGV4aXQoMSk7IA0KICAg
ICAgICB9IA0KCWlmICgoaSAlIDEwMDApID09IDApIHByaW50ZigiJWQgbWFw
c1xuIiwgaSk7IA0KICAgIH0gDQogICAgcmV0dXJuIDA7IA0KfSANCg==

--279726928-714884949-1106853770=:13927--
