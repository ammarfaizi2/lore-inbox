Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292368AbSCON3O>; Fri, 15 Mar 2002 08:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292339AbSCON3C>; Fri, 15 Mar 2002 08:29:02 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:64268 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291279AbSCON2o>; Fri, 15 Mar 2002 08:28:44 -0500
Date: Fri, 15 Mar 2002 13:28:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, davej@suse.de
Subject: [PATCH] 2.4 and 2.5: fix /proc/kcore
Message-ID: <20020315132837.D24984@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned on May 11 on LKML, here is a patch to fix /proc/kcore for
architectures which do not have RAM located at physical address 0.

I did say I'd send this on Monday, however I only got feedback from the
ia64 people, and /proc/kcore is already broken on their machines anyway.
(They need to fix it up; they place modules below PAGE_OFFSET, which
breaks our generated ELF core header).

So I've decided to send it a few days early.

Please apply.

--- orig/fs/proc/kcore.c	Fri Mar 15 10:14:44 2002
+++ linux/fs/proc/kcore.c	Fri Mar 15 11:18:21 2002
@@ -381,8 +381,13 @@
 			return tsz;
 	}
 #endif
-	/* fill the remainder of the buffer from kernel VM space */
-	start = (unsigned long)__va(*fpos - elf_buflen);
+	
+	/*
+	 * Fill the remainder of the buffer from kernel VM space.
+	 * We said in the ELF header that the data which starts
+	 * at 'elf_buflen' is virtual address PAGE_OFFSET. --rmk
+	 */
+	start = PAGE_OFFSET + (*fpos - elf_buflen);
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 		


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

