Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWD1U24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWD1U24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWD1U24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:28:56 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:48045 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751787AbWD1U2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:28:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=V3nVyB8x9FSVC21OTUOvGhqs4HrhOW5KWSkxMBbpi8ayNiad7VTlKhNrnewnCHr302ukZs8j58ky7NOn9kkZbwWe1FozMn8GUyd42zrM09irC2qZWR1h9eu4eqM5/Oclkl8/adGAZoRisNYioHqPK91PQ4M7rXiIMoovnI+Ygrg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Date: Fri, 28 Apr 2006 22:28:46 +0200
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org>
In-Reply-To: <20060426154607.GA8628@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604282228.46681.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 17:46, Jeff Dike wrote:
> On Wed, Apr 26, 2006 at 05:47:54PM +0200, Blaisorblade wrote:

> Why not just zero out the bits that the kernel knows about?  Then, if
> we return -EINVAL, the process just looks at the remaining bits that
> are set to see what system calls the kernel didn't know about.

Good idea. When you're leaving the whole mask to 1 _except_ some bits set to 0 
what do you suggest? Setting everything to 1 so the process sees the invalid 
0 bits?

However, I've had a new idea for the API form - sigprocmask() is used to 
either enable or disable some bits in the _signal_ mask. But you pass in both 
cases the bits to toggle. Making the API more similar to this would be good.

Even if the semantics of both settings and clearing bits are unclear. 
Probably, simply making both calls _set_ the mask but one of them (i.e. 
MASK_DEFAULT_TRACE) reverse the mask before setting and after zero-extending 
it to the right.

Ok, this gives us a definite proposal, which I finally like:

* to exclude sys_tee:

bitmask = 0;
set_bit(__NR_tee, bitmask);
ptrace(PTRACE_SET_NOTRACE, bitmask);

* to trace only sys_tee:

bitmask = 0;
set_bit(__NR_tee, bitmask);
ptrace(PTRACE_SET_TRACEONLY, bitmask);

Semantics:

in both cases, the mask is first zero-extended to the right (for syscalls not 
known to userspace), bits for syscall not known to the kernel are checked and 
the call fails if any of them is 1, and in the failure case E2BIG or 
EOVERFLOW is returned (I want to avoid EINVAL and ENOSYS to avoid confusion) 
and the part of the mask known to the kernel is 0-ed.

In case of success, for NOTRACE (which was DEFAULT_TRACE) the mask is reversed 
before copying in the kernel syscall mask, for TRACEONLY it's copied there 
directly.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
