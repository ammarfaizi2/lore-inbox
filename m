Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265016AbRFZQaG>; Tue, 26 Jun 2001 12:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbRFZQ34>; Tue, 26 Jun 2001 12:29:56 -0400
Received: from authsrv.nacamar.de ([194.162.162.197]:18440 "HELO
	dialup.nacamar.de") by vger.kernel.org with SMTP id <S265016AbRFZQ3m>;
	Tue, 26 Jun 2001 12:29:42 -0400
From: "Hugo Mildenberger" <milden@dialup.nacamar.de>
To: "Brian Gerst" <bgerst@didntduck.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: Questionable SIGSEGV signal handling bug concerning siginfo.si_addr on i386-linux 2.4.2
Date: Tue, 26 Jun 2001 18:19:44 +0200
Message-ID: <DIEOJPFHFLBDHJJOIGOHAEMDCAAA.milden@dialup.nacamar.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <3B38A0F9.DD3256BD@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Brian,

it is hard to admit, but you are right even if a structure was not directly
involved. The corresponding high level statements were

double guarded_log( double *arg ) {
       try {
            return log( *arg ); // e.g. arg==0 or arg==0x1234.
       } catch ( s2e::SCN(SIGSGEV)*e ) {
         // [...]
       } catch ( s2e::SCN(SIGFPE)*e ) {
         // [...]
       }
}

... but your supposed structure access is really there - because a double
value allocates 8 bytes and the gcc-3.0 developers obviously changed code
generation. They access at least FPU parameters now differently and highest
long-word first; that explains the difference in program behavior. Your
suggestion of testing against the whole occupied address range is the
general solution which I already used intuitively if I was dealing with
structs and arrays - but I did not realize that also a double value is a
certain kind of struct if seen from the processor?s point of view, which is
(at the time of writing usually) only 32 bits wide.

Thank you for your exact analysis and your quick response.

Hugo Mildenberger

>Von: Brian Gerst [mailto:bgerst@didntduck.org]
>What you are seeing is the correct behavior.  The address in si_addr is
>the exact address that caused the page fault (from register %cr2).  It
>appears that you were trying to access an element of a structure, where
>the structure pointer was in %eax and the offset of the element within
>the structure is 4 bytes.  I suggest that if you are trying to find out
>if a fault happened inside a structure you check the whole range of
>addresses in that structure, because any of them could have faulted.
>
>--
>
>				Brian Gerst

