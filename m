Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVAOF5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVAOF5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVAOF5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:57:47 -0500
Received: from palrel11.hp.com ([156.153.255.246]:46222 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262217AbVAOF5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:57:45 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16872.45268.823377.293250@napali.hpl.hp.com>
Date: Fri, 14 Jan 2005 21:57:40 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: sparse warning, or why does jifies_to_msecs() return an int?
In-Reply-To: <Pine.LNX.4.58.0501142020130.2310@ppc970.osdl.org>
References: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
	<Pine.LNX.4.58.0501142020130.2310@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 14 Jan 2005 20:29:07 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:

  >> Is there are a good reason to constrain the return value to 4
  >> billion msecs?  If so, what's the proper way to shut up sparse?

  Linus> There's no good way to shut up sparse, I think. The fact is,
  Linus> we _are_ losing bits, but it doesn't matter much in this
  Linus> case.

Yes, you're right.

  Linus> I think "jiffies_to_msecs(MAX_JIFFY_OFFSET)" is fundamentally
  Linus> a suspect operation (since the ranges are different for the
  Linus> two types), and I think that the sparse warnign is correct,
  Linus> but it's one of those "doing the wrong thing is not always
  Linus> wrogn enough to matter".

How about something along the lines of the attached?  The test in
msecs_to_jiffies is non-sensical for HZ>=1000 because

 (a) jiffies_to_msecs(x) <= x, if HZ >= 1000, and
 (b) MAX_UINT <= MAX_ULONG

	--david

===== include/linux/jiffies.h 1.11 vs edited =====
--- 1.11/include/linux/jiffies.h	2005-01-04 18:48:02 -08:00
+++ edited/include/linux/jiffies.h	2005-01-14 21:52:46 -08:00
@@ -276,8 +276,10 @@
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
+#if HZ < 1000
 	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
+#endif
 #if HZ <= 1000 && !(1000 % HZ)
 	return (m + (1000 / HZ) - 1) / (1000 / HZ);
 #elif HZ > 1000 && !(HZ % 1000)
