Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUEMQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUEMQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUEMQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:26:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:2994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264034AbUEMQ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:26:42 -0400
Date: Thu, 13 May 2004 09:17:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: scott douglass <scott.douglass@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: local_irq_save, memory clobbering and volatile
Message-Id: <20040513091750.09da28df.rddunlap@osdl.org>
In-Reply-To: <1084465048.12767.106.camel@pc982.cambridge.arm.com>
References: <1084465048.12767.106.camel@pc982.cambridge.arm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 17:17:28 +0100 scott douglass wrote:

| Hello,
|  
| I've searched through the mailing list archives and I've found these
| comments about volatile (albeit from a few years back):
| 
| > "volatile" is _never_ a good idea, [...]
| 
| and
| 
| > [...] volatile is an evil keyword that is badly specified and only 
| > makes the compiler generate worse code without ever fixing any real
| > bugs.
| 
| But there's a lot of archive to search though and I may have missed
| something relevant.  I also looked though the Documentation directory
| without success.
| 
| If I understand correctly, the arguments against volatile are/were that
| using volatile can slow down some critical regions like list traversal
| and can hide the absence of proper locking.  It seems to me that the
| "slow down some critical regions" can be handled by manually caching the
| value (in the critical region) rather than hoping the compiler would
| notice.
| 
| Do I understand the arguments against volatile correctly?
| 
| Is this still the official position?  If so, why is volatile used so
| much in the current kernel sources?

Here's a general rant^W discourse on volatile from Linus:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107341248115735&w=2

| I think the clobbering of memory by local_irq_save, et al. is not
| necessary in cases were volatile is used correctly.  The clobbering
| inhibits the compiler's ability to optimize more than volatile does. 
| When memory gets clobbered the compiler can't optimize other memory
| accesses in the function even though they are not involved in the
| critical region.  As compilers do more inlining the amount of
| optimization damage done by clobbering memory grows.
|  
| Existing code relies on the current clobbering instead of using volatile
| accesses, so I'm suggesting that there should be new, non-clobbering
| forms, e.g. local_irq_save_no_clobber, etc.  To use them correctly the
| accesses in the critical region must be to volatile objects, for
| example:
|  
| __inline__ void atomic_clear_mask (unsigned long mask, volatile unsigned
| long *addr) {
| 	unsigned long flags;
|  
| 	local_irq_save_no_clobber(flags);
| 	*addr &= ~mask;
| 	local_irq_restore_no_clobber(flags);
| }
|  
| This lets the compiler know exactly which accesses are to volatile
| objects and means that functions that call atomic_clear_mask can still
| be optimized.  Some of the C definitions of atomic_clear_mask in the
| sources already have this volatile qualification.
|  
| Is there any reason not to add local_irq_save_no_clobber, etc. (perhaps
| with better names)?
| 
| [I'm not on the mailing list but I will check the mailing list for
| replies.]


--
~Randy
