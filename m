Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWDZU0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWDZU0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWDZU0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:26:51 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:60382 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964859AbWDZU0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:26:50 -0400
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <444797F8.6020509@fujitsu-siemens.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	 <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
	 <444797F8.6020509@fujitsu-siemens.com>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 16:26:42 -0400
Message-Id: <1146083202.10211.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 16:17 +0200, Bodo Stroesser wrote:
> Heiko Carstens wrote:
> >>Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> >>traced.  It takes a bitmask and a length.  A system call is traced
> >>if its bit is one.  Otherwise, it executes normally, and is
> >>invisible to the ptracing parent.
> >>[...]
> >>+int set_syscall_mask(struct task_struct *child, char __user *mask,
> >>+		     unsigned long len)
> >>+{
> >>+	int i, n = (NR_syscalls + 7) / 8;
> >>+	char c;
> >>+
> >>+	if(len > n){
> >>+		for(i = NR_syscalls; i < len * 8; i++){
> >>+			get_user(c, &mask[i / 8]);
> >>+			if(!(c & (1 << (i % 8)))){
> >>+				printk("Out of range syscall at %d\n", i);
> >>+				return -EINVAL;
> >>+			}
> >>+		}
> >>+
> >>+		len = n;
> >>+	}
> > 
> > 
> > Since it's quite likely that len > n will be true (e.g. after installing the
> > latest version of your debug tool) it would be better to silently ignore all
> > bits not within the range of NR_syscalls.
> > There is no point in flooding the console. The tracing process won't see any
> > of the non existant syscalls it requested to see anyway.
> 
> Shouldn't 'len' better be the number of bits in the mask than the number of chars?
> Assume a syscall newly added to UML would be a candidate for processing on the host,
> but the incremented NR_syscalls still would result in the same number of bytes. Also
> assume, host doesn't yet have that new syscall. Current implementation doesn't catch
> the fact, that host can't execute that syscall.
> 
> OTOH, I think UML shouldn't send the entire mask, but relevant part only. The missing
> end is filled with 0xff by host anyway. So it would be enough to send the mask up to the
> highest bit representing a syscall, that needs to be executed by host. (currently, that
> is __NR_gettimeofday). If UML would do so, no more problem results from UML having
> a higher NR_syscall than the host (as long as the new syscalls are to be intercepted
> and executed by UML)
> 
> A greater problem might be a process in UML, that calls an invalid syscall number. AFAICS
> syscall number (orig_eax) isn't checked before it is used in do_syscall_trace to address
> syscall_mask. This might result in a crash.
I have a similar local patch that I've been using.  I think it would be
worthwhile to have an extra bit in the bitmap that says what to do with
calls that fall outside the range [0, __NR_syscall].  That way the
ptrace monitor can decide whether it is useful to get informed of these
"bogus" calls.

Charles

