Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVATXsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVATXsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVATXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:47:47 -0500
Received: from palrel12.hp.com ([156.153.255.237]:25830 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262217AbVATXqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:46:53 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16880.17129.508590.974315@napali.hpl.hp.com>
Date: Thu, 20 Jan 2005 15:46:49 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: sparse warning, or why does jifies_to_msecs() return an int?
In-Reply-To: <Pine.LNX.4.58.0501150948120.2310@ppc970.osdl.org>
References: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
	<Pine.LNX.4.58.0501142020130.2310@ppc970.osdl.org>
	<16872.45268.823377.293250@napali.hpl.hp.com>
	<Pine.LNX.4.58.0501150948120.2310@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 15 Jan 2005 10:05:37 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:

  Linus> Hmm.. I don't think your patch is wrong per se, but I do
  Linus> think it's a bit too subtle. I'd almost rather make
  Linus> "jiffies_to_msecs()" just test for overflow instead, and that
  Linus> should also fix it.

You sure about that?

Actually, I think my patch was broken anyhow for HZ < 1000 because you
can potentially get integer-overflows in temporary results which could
make things come out wrong again.

I _think_ the attached patch works for all reasonable cases reasonably
uniformly, but if you thought the previous patch was subtle, I'm sure
you going to like this one even less.

Note that with the patch, platforms where HZ is not a power of two and
doesn't fit any of the other special cases (namely (HZ % 1000) != 0 &&
(1000 % HZ) != 0) would suffer a penalty.  AFAICS, this is true only
for Alpha/Rawhide (HZ=1200).  In such a case, rather than:

	(j * 1000)/HZ

the new code would compute:

	(j/HZ)*1000 + ((j%HZ)*1000)/HZ

It looks to me like we could get rid of all the ugly & complex
intermediate overflow-checks if we defined MAX_JIFFY_OFFSET
as:
	(~0UL / 1000)

However, on a 32-bit platform that runs at 1000 Hz, this would limit
us to 4294 seconds.  That may be cutting it a bit close.

	--david

===== include/linux/jiffies.h 1.11 vs edited =====
--- 1.11/include/linux/jiffies.h	2005-01-04 18:48:02 -08:00
+++ edited/include/linux/jiffies.h	2005-01-20 15:21:14 -08:00
@@ -254,13 +254,32 @@
  */
 static inline unsigned int jiffies_to_msecs(const unsigned long j)
 {
+	unsigned long res;
+
 #if HZ <= 1000 && !(1000 % HZ)
-	return (1000 / HZ) * j;
+	unsigned long max = ~0UL / (1000 / HZ);
+
+	if (j > max)
+		max = j;
+	res = (1000 / HZ) * j;
 #elif HZ > 1000 && !(HZ % 1000)
-	return (j + (HZ / 1000) - 1)/(HZ / 1000);
+	res = (j + (HZ / 1000) - 1) / (HZ / 1000);
 #else
-	return (j * 1000) / HZ;
+	/*
+	 * HZ better be a power of two; otherwise this gets real
+	 * expensive.  Better expensive than wrong, though.
+	 */
+# if HZ < 1000
+	unsigned long max = (~0UL / 1000) * HZ;
+
+	if (j > max)
+		j = max;
+# endif
+	res = (j / HZ) * 1000 + ((j % HZ) * 1000) / HZ;
 #endif
+	if (res > ~0U)
+		return ~0U;
+	return res;
 }
 
 static inline unsigned int jiffies_to_usecs(const unsigned long j)
