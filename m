Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRJKUhn>; Thu, 11 Oct 2001 16:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276901AbRJKUhd>; Thu, 11 Oct 2001 16:37:33 -0400
Received: from pc2-redb4-0-cust130.bre.cable.ntl.com ([213.107.133.130]:22256
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S276891AbRJKUh0>; Thu, 11 Oct 2001 16:37:26 -0400
Date: Thu, 11 Oct 2001 21:36:55 +0100
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Question and patch about spinlocks (x86)
Message-ID: <20011011213655.D7138@itsolve.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just looking through at the spinlock assembly I noticed a few things which I
think are bugs:
 
 	"js 2f\n" \
 	".section .text.lock,\"ax\"\n" \
 	"2:\t" \
	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
	"jle 2b\n\t" \
 	"jmp 1b\n" \
 	".previous"

We do the cmp loop as a 'soft' check, as the lock operand locks the whole system
bus, stopping the system for a while (as much as 70 cycles, I believe). However,
I don't understand why it was put before the 'rep; nop' which just sets the
processor to wait for a bit. Surely it would be better to test *after* we have
waited, as then we have a better chance of it being correct.

Any comments? Attached is a patch to fix it.

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- include/asm-i386/spinlock.h.old	Thu Oct 11 21:28:37 2001
+++ include/asm-i386/spinlock.h	Thu Oct 11 21:35:14 2001
@@ -58,8 +58,8 @@
 	"js 2f\n" \
 	".section .text.lock,\"ax\"\n" \
 	"2:\t" \
-	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
+	"cmpb $0,%0\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
 	".previous"

--G4iJoqBmSsgzjUCe--
