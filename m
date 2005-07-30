Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263099AbVG3Sti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbVG3Sti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVG3Sti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:49:38 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:18799 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263099AbVG3Sth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:49:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:User-Agent:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QQbE6e7URpKddmKdOtZcNfJ/209X54D1wiQejaqipBElVVo7QqCAmUIuo9RFQ/ONbXpxqXvOJQ/1WvHKp6NFcdxJEQJYCOU1ZXX+LCoj6DWdQKA1VgNLAz+N0VYzySg55fe5QVa9uoJfGhcYEVmZWBQWr5UnFZibxoXWsoUFp6Q=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Fwd: Re: [patch 1/4] UML Support - Ptrace: adds the host SYSEMU support, for UML and general usage
Date: Sat, 30 Jul 2005 21:34:20 +0200
User-Agent: KMail/1.7.2
To: user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302134.20394.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: Re: [patch 1/4] UML Support - Ptrace: adds the host SYSEMU support, 
for UML and general usage
Date: Wednesday 27 July 2005 20:40
From: Blaisorblade <blaisorblade@yahoo.it>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike 
<jdike@addtoit.com>

On Wednesday 27 July 2005 19:19, Charles P. Wright wrote:
> Paolo,
>
> I'm also using ptrace to emulate system calls for a file system project
> that I'm working on, so needless to say this patch is quite interesting
> for me.
>
> However, I'm not quite sure how the user-level interface is
> supposed to work from the comments.
>
> Normally the flow looks something like the following:
>
> pid = wait();  	/* To trap the syscall entry. */
> if (emulation) {
> 	/* Set the eax value to something invalid. */
> }
> ptrace(PTRACE_SYSCALL, pid); /* Let the call execute. */
> pid = wait();  	/* To trap the syscall exit. */
> if (emualation) {
> 	/* Force a return value. */
> }
> ptrace(PTRACE_SYSCALL);	/* To go back to user code. */
>
> Ideally,
>
> I would like to do the following as I only emulate some of the
> system calls,

Hmm, yes, this is a problem in the current SYSEMU interface, if to be used in
this way.

> and from the code, it seems like I should be able to:
>
> pid = wait();  	/* To trap the syscall entry. */
> if (emulation) {
> 	/* Force a return value. */
> 	ptrace(PTRACE_SYSEMU, pid); /* Go back to user code */
> } else {
> 	ptrace(PTRACE_SYSCALL); /* Let the call execute. */
> 	pid = wait();  	/* To trap the syscall exit. */
> 	ptrace(PTRACE_SYSCALL); /* To go back to user code. */
> }
>
> The comment here seems to indicate the interface is different:
> +       case PTRACE_SYSEMU: /* continue and stop at next syscall, which
> will not be executed */
>
> That would indicate to me that we run SYSEMU to get stopped at the next
> entry, and that call won't be executed (before we even know what it is).

Ok, yes, this is true.

Currently, SYSEMU allows us to switch from SYSEMU to SYSCALL, but the
execution mode for a syscall is determined from which mode was used on
syscall entry; if you use PTRACE_SYSCALL after syscall entry, this syscall is
completed as usual, and next syscall will run as under PTRACE_SYSCALL.

Actually, as a general purpose patch this might be a bit broken, I have to
admit, but it was written for UML's usage at the beginning. On 2.4 it
provided this behaviour automatically, on 2.6 it was fixed to conform to the
same interface.

But I think this is fixable; for the patch itself it should be trivial, the
problem is supporting it in UML: whether the syscall is executed or not, is
determined from the return value of do_syscall_trace(); as easily seen in the
code, the return value is read on syscall entry, and reused even after
running the debugger.

Also, I'm not that happy to change again UML to support yet another
 interface, but if needed it may be done I hope.

I think that this may be basically fixed in UML by using the same syscall
interception even for completing the syscall... at no performance cost.

The only cost would be adding yet another startup test for this new feature -
however, it is greatly outweighted by mainline inclusion.

> Charles

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
