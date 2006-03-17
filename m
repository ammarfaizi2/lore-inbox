Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWCQSvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWCQSvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWCQSvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:51:44 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:4725 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751049AbWCQSvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:51:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=JnQRmYz7CzeslaTD0jPw+2svHSgof3hVe4k/vIEZlgGAfOhacl19ZUh5DI3hrdXDYQm009czdGKpfHx8dXerMs8vI/aq+OciHlgH7QN8ZpTRMtWXhwV4DF60DiAhZcNiSI68bJ72GGOoWfVcHhtJtvD7pkxXibIPGH/BR83aupw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
Date: Fri, 17 Mar 2006 19:46:54 +0100
User-Agent: KMail/1.8.3
Cc: Daniel Jacobowitz <dan@debian.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>
References: <200603150415_MC3-1-BAB1-D3CE@compuserve.com> <20060316200201.GA20315@nevyn.them.org> <1142543798.3284.6.camel@localhost.localdomain>
In-Reply-To: <1142543798.3284.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eQwGEZYmI8p1+4g"
Message-Id: <200603171946.54784.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_eQwGEZYmI8p1+4g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Side note - I'm attaching another (incomplete) patch for ptrace.2 with some 
addition - there is already something worth adding, though I only listed the 
2.6-only ptrace options since I don't know what they do.

On Thursday 16 March 2006 22:16, Charles P. Wright wrote:
> On Thu, 2006-03-16 at 15:02 -0500, Daniel Jacobowitz wrote:
> > >        PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP
> > >               For  PTRACE_SYSEMU,  continue  and  stop  on  entry  to
> > > the next syscall, which will not  be  executed.   For 
> > > PTRACE_SYSEMU_SIN- GLESTEP, so the same but also singlestep if not a
> > > syscall.
> >
> > I think this is right; I had nothing to do with these :-)
>
> I didn't have anything to do with it, but this description is correct
> (if a bit confusing).  I think that you should explicitly say (assuming
> that Paolo does not have any objections):

> PTRACE_SYSEMU only makes sense at a call's exit, not at entry.

I must indeed check the detail but I'm almost totally sure that this point is 
totally wrong; conceptually, I understand what you mean, 
but mixing PTRACE_SYSEMU and PTRACE_SYSCALL has non-obvious results.

Indeed, whether a syscall is performed or skipped is decided by the call which 
stops at syscall entry, not by the call which resumes the syscall.

Actually, choosing what to do at resume time would make more sense, but for 
historical reasons this was overlooked (also see at the end of this email).

I've described the exact semantics below, however I feel that mixing the calls 
does not make any sense - we implemented this support mainly for testing - on 
2.4 hosts we could test UML performance this way, on 2.6 we couldn't and then 
"fixed" the API to be again this strange one.

The exact semantics are these:

remember that PTRACE_SYSEMU is called once per syscall; you attach the 
process, do a PTRACE_SYSEMU on it, and it'll stop at syscall #1 entry, and 
this syscall will not be executed; you look at calls param, perform what you 
want to do, and then resume it.

If you resume it with PTRACE_SYSEMU, it'll stop at next syscall entry, as 
expected, and next syscall will not be executed.

If you resume it with PTRACE_SYSCALL (which made sense only for debugging), 
the only thing which changes is that _next_ syscall will be executed 
normally; then after stopping at syscall #2 exit you can choose to resume 
with PTRACE_SYSEMU. You can do that even at syscall #2 entry, but you get the 
same result.

> PTRACE_SYSEMU is only practical if you want to emulate all of a
> process's system calls (as is done in UML), because you can not examine
> the process's registers before making the decision to emulate a call.

This is true.

However, I remember I answered to your request to fix this problem with some 
patches to test (I remember I was sure enough of their correctness, for what 
can be seen by code inspection), but got no answer and didn't finish 
anything. Lost the email or the interest?

I was also busy so I didn't test them myself (even because reading this code 
and following the exact states causes me a headache).

Bye

> Charles

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_eQwGEZYmI8p1+4g
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Man-Patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Man-Patch"

--- /dev/fd/63	2006-03-17 19:45:28.381175723 +0100
+++ /home/paolo/man/man2/ptrace-mine.2	2005-10-29 00:53:32.000000000 +0200
@@ -179,6 +179,29 @@
 PTRACE_TRACEME.  Although perhaps not intended, under Linux a traced child
 can be detached in this way regardless of which method was used to initiate
 tracing.  (\fIaddr\fP is ignored.)
+.TP
+PTRACE_SETOPTIONS
+Allows setting some options that influence the ptrace behavior. You can
+set any amount of them by OR'ing and passing them as the \fIdata\fP parameter.
+See the section \fBPtrace Options\fP below.
+.SH PTRACE OPTIONS
+.TP
+PTRACE_O_TRACESYSGOOD
+Makes possible the distinction between a SIGTRAP delivery and a syscall stop.
+When this option is active, the process will appear to be stopped by receipt
+of SIGTRAP|0x80, instead of SIGTRAP.
+.TP
+PTRACE_O_TRACEFORK
+.TP
+PTRACE_O_TRACEVFORK
+.TP
+PTRACE_O_TRACECLONE
+.TP
+PTRACE_O_TRACEEXEC
+.TP
+PTRACE_O_TRACEVFORKDONE
+.TP
+PTRACE_O_TRACEEXIT
 .SH NOTES
 Although arguments to
 .B ptrace
@@ -227,11 +250,21 @@
 request may be \-1, the caller must check
 .I errno
 after such requests to determine whether or not an error occurred.
+.SH BUGS
+On hosts with 2.6 kernel headers, PTRACE_SETOPTIONS is declared with a different
+value than the one for 2.4. This leads to applications compiled with such
+headers to fail when run on 2.4 host kernels.
+.LP
+This can be workarounded by redefining PTRACE_SETOPTIONS to
+PTRACE_OLDSETOPTIONS, if that is defined.
 .SH ERRORS
 .TP
 .B EBUSY
 (i386 only) There was an error with allocating or freeing a debug register.
 .TP
+.B EINVAL
+An attempt was done to set a nonexisting option.
+.TP
 .B EFAULT
 There was an attempt to read from or write to an invalid area in the parent's
 or child's memory, probably because the area wasn't mapped or accessible.

--Boundary-00=_eQwGEZYmI8p1+4g--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
