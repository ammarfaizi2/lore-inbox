Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLDWOc>; Mon, 4 Dec 2000 17:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLDWOX>; Mon, 4 Dec 2000 17:14:23 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:46096 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129410AbQLDWOE>;
	Mon, 4 Dec 2000 17:14:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre4 boot failure (better than pre3 and lower) 
In-Reply-To: Your message of "Mon, 04 Dec 2000 16:26:42 CDT."
             <20001204162642.A5553@animx.eu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Dec 2000 08:43:31 +1100
Message-ID: <3906.975966211@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000 16:26:42 -0500, 
Wakko Warner <wakko@animx.eu.org> wrote:
>PCI patches that were added between pre3 and pre4 allow me to boot the
>kernel on my noritake alpha.  Once it boots, however, it oops's in the
>swapper.  I've tried a few times in the past to use ksymoops on oops's on
>the alpha arch, but it doesn't appear to work.  (I'm using the ksymoops
>that's part of the debian potato dist)

Most architectures dump their code as a string of bytes and print the
code after the registers and trace back.  Alpha dumps the code before
the trace and also decodes the instructions which really confuses
ksymoops.  Somebody changed 'Trace: ' to 'Trace:' between 2.2 and 2.4
kernels so ksymoops no longer picks the trace data.

Is there any chance of changing arch/alpha/kernel/traps.c to print
registers, trace and _raw_ code, in that order so it is more like other
architectures?  You can print the decoded instructions as well (prefix
Decode:, not Code:) as long as the raw code bytes are also available.

In the meantime, this patch to ksymoops 2.3.5 will pick up the change
to the trace lines.  It will still complain about a bad code line,
ksymoops is built for raw data.

Index: 6.2/oops.c
--- 6.2/oops.c Mon, 06 Nov 2000 16:34:56 +1100 kaos (ksymoops-2.3/11_oops.c 1.22 644)
+++ 6.2(w)/oops.c Tue, 05 Dec 2000 08:37:38 +1100 kaos (ksymoops-2.3/11_oops.c 1.22 644)
@@ -1081,7 +1081,7 @@ static const char *Oops_trace(const char
     RE_COMPILE(&re_Oops_trace,
 	    "^("						     /* 1 */
 		    "(Call Trace: )"				     /* 2 */
-    /* alpha */     "|(Trace: )"				     /* 3 */
+    /* alpha */     "|(Trace:)"					     /* 3 */
     /* various */   "|(" BRACKETED_ADDRESS ")"			     /* 4,5 */
     /* ppc */	    "|(Call backtrace:)"			     /* 6 */
     /* ppc, s390 */ "|" UNBRACKETED_ADDRESS			     /* 7 */
@@ -1464,7 +1464,7 @@ static int Oops_print(const char *line, 
      * anybody wants to print a VERSION_nnnn line in their Oops, this code
      * is ready.
      *
-     * string 9 is defined if the text is 'Trace: ' (alpha).
+     * string 9 is defined if the text is 'Trace:' (alpha).
      * string 10 is defined if the text is 'Call backtrace:' (ppc, i370).
      * string 11 is defined if the text is 'bh:' (i386).  Stack addresses are
      * on the next line.  In our typical inconsistent manner, the bh: stack
@@ -1503,7 +1503,7 @@ static int Oops_print(const char *line, 
     /* various */   "|(Call Trace: )"			/*  5  T */
     /* various */   "|(" BRACKETED_ADDRESS ")"		/* 6,7 T */
     /* various */   "|(Version_[0-9]+)"			/*  8 */
-    /* alpha */	    "|(Trace: )"			/*  9  T */
+    /* alpha */	    "|(Trace:)"				/*  9  T */
     /* ppc, i370 */ "|(Call backtrace:)"		/* 10  T */
     /* i386 */	    "|(bh:)"				/* 11  T */
     /* i386 */	    "|" REVBRACKETED_ADDRESS		/* 12  T */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
