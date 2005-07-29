Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVG2Raw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVG2Raw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVG2Rau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:30:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262571AbVG2RaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:30:01 -0400
Date: Fri, 29 Jul 2005 10:29:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Cal Peake <cp@absolutedigital.net>
cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
In-Reply-To: <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
Message-ID: <Pine.LNX.4.58.0507291022500.3307@g5.osdl.org>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
 <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
 <20050728213543.6264ca60.akpm@osdl.org> <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2005, Cal Peake wrote:
> 
> Thanks Andrew! Indeed your suspicions are correct. Adding in all the 
> debugging moved the problem around, it now shows itself when probing 
> parport. Upon further investigation reverting the commit below seems to 
> have nixed the problem.

Thanks. Just out of interest, does this patch fix it instead?

		Linus

----
diff --git a/include/asm-i386/bitops.h b/include/asm-i386/bitops.h
--- a/include/asm-i386/bitops.h
+++ b/include/asm-i386/bitops.h
@@ -335,14 +335,13 @@ static inline unsigned long __ffs(unsign
 static inline int find_first_bit(const unsigned long *addr, unsigned size)
 {
 	int x = 0;
-	do {
-		if (*addr)
-			return __ffs(*addr) + x;
-		addr++;
-		if (x >= size)
-			break;
+
+	while (x < size) {
+		unsigned long val = *addr++;
+		if (val)
+			return __ffs(val) + x;
 		x += (sizeof(*addr)<<3);
-	} while (1);
+	}
 	return x;
 }
 
