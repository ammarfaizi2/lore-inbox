Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUL3XBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUL3XBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUL3XBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:01:24 -0500
Received: from nevyn.them.org ([66.93.172.17]:47805 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261741AbUL3XBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:01:20 -0500
Date: Thu, 30 Dec 2004 18:00:46 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041230230046.GA14843@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jesse Allen <the3dfxdude@gmail.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org> <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 architecture details are really not my thing, so I'm going to
trust you on most of this, but this bit:

On Thu, Dec 30, 2004 at 02:46:17PM -0800, Linus Torvalds wrote:
>  	/* the 0x80 provides a way for the tracing parent to distinguish
>  	   between a syscall stop and SIGTRAP delivery */
> -	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
> -				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
> +	info.si_code = SIGTRAP;
> +	if ((current->ptrace & PT_TRACESYSGOOD) && !test_thread_flag(TIF_SINGLESTEP))
> +		info.si_code = SIGTRAP | 0x80;
> +	info.si_pid = current->tgid;
> +	info.si_uid = current->uid;
>  
> -	/*
> -	 * this isn't the same as continuing with a signal, but it will do
> -	 * for normal use.  strace only continues with a signal if the
> -	 * stopping signal is not SIGTRAP.  -brl
> -	 */
> -	if (current->exit_code) {
> -		send_sig(current->exit_code, current, 1);
> -		current->exit_code = 0;
> -	}
> +	/* Send us the fakey SIGTRAP */
> +	send_sig_info(SIGTRAP, &info, current);
>  }

does not look right to me.  Before, we'd get an 0x80|SIGTRAP result
from wait.  Now, you've moved the 0x80 to live only inside the siginfo.
This is accessible to the debugger via ptrace, but only very recently
(late 2.5.x).  So this will probably break users of PT_TRACESYSGOOD.

-- 
Daniel Jacobowitz
