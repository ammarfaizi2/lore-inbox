Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVDFLGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVDFLGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVDFLGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:06:05 -0400
Received: from host217-40-213-68.in-addr.btopenworld.com ([217.40.213.68]:26838
	"EHLO SERRANO.CAM.ARTIMI.COM") by vger.kernel.org with ESMTP
	id S262162AbVDFLF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:05:58 -0400
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "'Christophe Saout'" <christophe@saout.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jan Hubicka'" <hubicka@ucw.cz>,
       "'Gerold Jury'" <gerold.ml@inode.at>, <jakub@redhat.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <gcc@gcc.gnu.org>
Subject: RE: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 6 Apr 2005 12:05:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <200504061314.27740.vda@port.imtp.ilyichevsk.odessa.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcU6kZVVOibO+9eGStGoDfaE8UcpfQABLu0A
Message-ID: <SERRANOI8jsnNSe8xFY00000079@SERRANO.CAM.ARTIMI.COM>
X-OriginalArrivalTime: 06 Apr 2005 11:05:43.0084 (UTC) FILETIME=[934FAEC0:01C53A98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Original Message----
>From: Denis Vlasenko
>Sent: 06 April 2005 11:14

  Is this someone's idea of an April Fool's joke?  Because if it is, I've
suffered a serious sense-of-humour failure.

> Oh shit. I was trying to be too clever. I still run with this patch,
> so it must be happening very rarely.

  The kernel is way too important for cross-your-fingers-and-hope
engineering techniques to be applied.  This patch should never have been
permitted.  How on earth could anything like this hope to make it through a
strict review?

> Does this one compile ok?

> 	{
> 		/* load esi/edi */
> 		__asm__ __volatile__(
> 			""
> 			: "=&D" (edi), "=&S" (esi)
> 			: "0" ((long) to),"1" ((long) from)
> 			: "memory"
> 		);
> 	}
> 	if (n >= 5*4) {
> 		/* large block: use rep prefix */
> 		int ecx;
> 		__asm__ __volatile__(
> 			"rep ; movsl"
> 			: "=&c" (ecx), "=&D" (edi), "=&S" (esi)
> 			: "0" (n/4), "1" (edi),"2" (esi)
> 			: "memory"
> 		);


  It doesn't matter if it compiles or not, it's still *utterly* invalid.
You can NOT make assumptions about registers keeping their values between
one asm block and another.  Immediately after the closing quote of the first
asm, the compiler can do ANYTHING IT WANTS and to just _hope_ that it won't
use the registers you want is voodoo programming.  Even if it works when you
try it once, there are zero guarantees that another version or revision of
the compiler or even just a tiny change to the source that affects the
behaviour of the scheduler when compiling the function won't produce
something completely different, meaning that this code is appallingly
fragile.  This code should be completely discarded and rewritten properly.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

