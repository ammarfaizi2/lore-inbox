Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWHAAaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWHAAaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 20:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWHAAaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 20:30:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31568 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030355AbWHAAaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 20:30:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EbbAEUQJfMLEPHgCWfgrAZa3Y5uMMbgY4qmccqvuVD5gBzGFotymt4eaQypxbl8ap953tErHL9DrLezxZvHrCABENd7wSYOKwYIjV23InxWNA4btNKGkvhw3POAsKqdInndGrrHNdr3Nbi39Dkx20IF6B6VJdZe9nAbB92rKVbo=
Message-ID: <787b0d920607311730s5a951a5cv38eea7db03c759c8@mail.gmail.com>
Date: Mon, 31 Jul 2006 20:30:07 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: ptrace bugs and related problems
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andi Kleen" <ak@suse.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Roland Dreier" <roland@redhat.com>
In-Reply-To: <200607310224_MC3-1-C689-D6DC@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607310224_MC3-1-C689-D6DC@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> On Thu, 27 Jul 2006 02:55:17 -0400, Albert Cahalan wrote:

> > There is also no check
> > for failure, as when the popf or iret takes an alignment exception
> > or hits an unmapped page.
>
> Can that happen?  Singlestep traps happen after the instruction has
> already executed.  Or are you talking about starting to singlestep
> after hitting a code breakpoint fault?

You're at a popf that can not complete.
You single-step.
The kernel sets TF.
The kernel notes the popf.
The kernel assumes that TF will be determined by the popf.
The kernel tries to run the popf.
The popf faults, leaving TF unmodified.
The kernel fails to clear TF.

> > There is the pushf problem. Single-stepping this simple code
> > does not work:   pushf ; popf
>
> The debugger needs to mask TF in the pushed flags.  Read the comment
> in is_at_popf().

I saw the comment. I don't consider that documentation.
Why even have single-step support if the debugger has to
mess with eflags manually anyway? I might as well just
exclusively use PTRACE_SYSCALL.

I think the term is "known bug".

> > The is_at_popf function on x86-64 fails to account for instruction
> > set differences. Many prefixes are only valid in 32-bit mode, and
> > many others are only valid in 64-bit mode.
>
> I only see one bug here: the REX prefixes are 'inc' instructions
> in compatibility mode.  Otherwise, prefixes that are only valid in
> 32-bit mode are ignored in 64-bit mode.

Oh, OK, I thought they faulted. (AMD botched this)

There is a problem with instruction length though.
The buffer is 16 bytes long, but should be only 15.

The 0xf0 (lock) prefix is not valid for popf or iret.
