Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130424AbQJNCBF>; Fri, 13 Oct 2000 22:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130045AbQJNCA4>; Fri, 13 Oct 2000 22:00:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:273 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S129122AbQJNCAn>; Fri, 13 Oct 2000 22:00:43 -0400
Date: Fri, 13 Oct 2000 18:47:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up x86 write-protect test
In-Reply-To: <39E7AA78.B6E5D6D@didntduck.org>
Message-ID: <Pine.LNX.4.10.10010131845060.962-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Oct 2000, Brian Gerst wrote:
> 
> Also, Could somebody who has a machine with a known buggy processor give
> this patch a try?

I like the patch. Would you mind re-writing the exception handling the
other way around, though:

Instead of doing it like this:

+       __asm__ __volatile__(
+               "       movb %0,%1      \n"
+               "1:     movb %1,%0      \n"
+               "       jmp 3f          \n"
+               "2:     incl %2         \n"
+               "3:                     \n"
+               ".section __ex_table,\"a\"\n"
+               "       .align 4        \n"
+               "       .long 1b,2b     \n"
+               ".previous              \n"
+:"=m" (*(char *) vaddr),
+                "=q" (tmp_reg),
+                "=r" (flag)
+:"2" (flag)
+:"memory");

it would be nicer to simply to the other way around (if exception happens,
"flag" is untouched and jumped over, if not, flag is cleared):

+       __asm__ __volatile__(
+               "       movb %0,%1      \n"
+               "1:     movb %1,%0      \n"
+               "       xor %2,%2       \n"
+               "2:                     \n"
+               ".section __ex_table,\"a\"\n"
+               "       .align 4        \n"
+               "       .long 1b,2b     \n"
+               ".previous              \n"
+:"=m" (*(char *) vaddr),
+                "=q" (tmp_reg),
+                "=r" (flag)
+:"2" (1)
+:"memory");

which basically means that if flag stays as "1", then the exception
happened, but if the exception didn't happen the code will fall through
the "xor" and clear "flag".

After that, and testing that it works on a broken machine, I'd love to
apply it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
