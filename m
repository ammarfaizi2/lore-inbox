Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVJKAWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVJKAWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVJKAWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:22:22 -0400
Received: from mail.servus.at ([193.170.194.20]:273 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S1751177AbVJKAWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:22:22 -0400
Message-ID: <434B0609.6080109@oberhumer.com>
Date: Tue, 11 Oct 2005 02:23:37 +0200
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
References: <43273CB3.7090200@oberhumer.com> <20050914154425.GM11338@wotan.suse.de> <43494B3F.5070303@oberhumer.com> <200510091857.11566.ak@suse.de>
In-Reply-To: <200510091857.11566.ak@suse.de>
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
Content-Type: multipart/mixed;
 boundary="------------040106040204080704030402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040106040204080704030402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've just seen that Linus has merged my second patch, so here is one more 
missing piece to fix ia64 in ia32 emulation as well.

~Markus

p.s. this patch has not been tested due to lack of hardware


Andi Kleen wrote:
> On Sunday 09 October 2005 18:54, Markus F.X.J. Oberhumer wrote:
> 
> 
>>Here is a somewhat simplified version of my previous patch with
>>updated comments.
>>
>>Attached is also a new small user-space test program which does not
>>depend on any special gcc features and should trigger the problem on all
>>machines.
> 
> 
> I already have a version of the patch in my queue, but it's not a strict 
> bugfix so it's only for after 2.6.14.
> 
> -Andi
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/sigframe-alignment
> 
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/

--------------040106040204080704030402
Content-Type: text/x-patch;
 name="i386-align_sigframe-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-align_sigframe-ia64.patch"

[PATCH] i386: fix stack alignment for signal handlers (ia64)

This fixes the setup of the alignment of the signal frame, so that all
signal handlers are run with a properly aligned stack frame.

The current code "over-aligns" the stack pointer so that the stack frame
is effectively always mis-aligned by 4 bytes.  But what we really want
is that on function entry ((sp + 4) & 15) == 0, which matches what would
happen if the stack were aligned before a "call" instruction.

[ This patch fixes ia64. i386 and x86_64 are already fixed by
  git commit d347f372273c2b3d86a66e2e1c94c790c208e166 ]

Signed-off-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>



Index: linux-2.6.git/arch/ia64/ia32/ia32_signal.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/ia32/ia32_signal.c
+++ linux-2.6.git/arch/ia64/ia32/ia32_signal.c
@@ -810,7 +810,11 @@
 	}
 	/* Legacy stack switching not supported */
 
-	return (void __user *)((esp - frame_size) & -8ul);
+	esp -= frame_size;
+	/* Align the stack pointer according to the i386 ABI,
+	 * i.e. so that on function entry ((sp + 4) & 15) == 0. */
+	esp = ((esp + 4) & -16ul) - 4;
+	return (void __user *) esp;
 }
 
 static int

--------------040106040204080704030402--
