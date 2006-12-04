Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967664AbWLDWBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967664AbWLDWBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967571AbWLDWBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:01:37 -0500
Received: from ozlabs.org ([203.10.76.45]:58735 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967664AbWLDWBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:01:35 -0500
Date: Tue, 5 Dec 2006 08:58:25 +1100
From: Anton Blanchard <anton@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: supriya kannery <supriyak@in.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Incorrect order of last two arguments of ptrace for requests PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
Message-ID: <20061204215825.GB22514@krispykreme>
References: <453F421A.6070507@in.ibm.com> <1164220580.12365.8.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164220580.12365.8.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> > In ptrace, when request is PPC_PTRACE_GETREGS, SETREGS, GETFPREGS and 
> > SETFPREGS, order of the last two arguments is not correct.
> > 
> > General format of ptrace is ptrace (request, pid, addr, data).  For the 
> > above mentioned request ids in ppc64, if we use ptrace like
> > 
> >  long reg[32];
> >  ptrace (PPC_PTRACE_GETREGS, pid, 0, &reg[0]);
> > 
> > the return value is always -1.
> > 
> > If we exchange the last two arguments like,
> > 
> >  ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);
> > 
> > it works!
> > 
> > This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
> > such that general purpose
> > registers of the child process get copied to the address variable 
> > instead of data variable. Same is
> > the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
> > and SETFPREGS.
> > 
> > Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
> > This patch can be applied directly to 2.6.19-rc3 kernel.

I looked at this a while ago and my decision at the time was to keep the
old implementation around for a while and create two new ones that match
the x86 numbering:

#define PTRACE_GETREGS            12
#define PTRACE_SETREGS            13
#define PTRACE_GETFPREGS          14
#define PTRACE_SETFPREGS          15

I hate gratuitous differences, each ptrace app ends up with a sea of
ifdefs.

Also I think it would be worth changing getregs/setregs to grab the
entire pt_regs structure. Otherwise most ops (gdb, strace etc) will just
have to make multiple ptrace calls to get the nia etc.

Anton
