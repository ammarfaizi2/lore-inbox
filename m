Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUGAAkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUGAAkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUGAAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 20:40:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53482 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263429AbUGAAkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 20:40:10 -0400
Date: Wed, 30 Jun 2004 15:31:20 -0500
From: linas@austin.ibm.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6 PPC64: lockfix for rtas error log (third-times-a-charm?)
Message-ID: <20040630153120.W21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com> <1088559864.1906.9.camel@gaston> <20040630123637.S21634@forte.austin.ibm.com> <1088621248.1920.43.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1088621248.1920.43.camel@gaston>; from benh@kernel.crashing.org on Wed, Jun 30, 2004 at 01:47:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 01:47:29PM -0500, Benjamin Herrenschmidt wrote:
> 
> > Well, the problem was that there is no lock that is protecting the
> > use of the single, global buffer.  Adding yet another lock is bad;
> > it makes hunting for deadlocks that much more tedious and difficult;
> > already, finding deadlocks is error-prone, and subject to bit-rot as
> > future hackers update the code.  So instead, the problem can be easily
> > avoided by not using a global buffer.  The code below mallocs/frees.
> > Its not perf-critcal, so I don't mind malloc overhead.  Would this
> > work for you?  Patch attached below.
> 
> I prefer that, but couldn't we move the kmalloc outside of the spinlock
> and so use GFP_KERNEL instead ?

OK,

Upon closer analysis of the code, I see that log_rtas_error() 
was incorrectly named, and was being used incorrectly.  The 
solution is to get rid of it entirely; see patch below. So:

-- In one case kmalloc must be GFP_ATOMIC because rtas_call()
   can happen in any context, incl. irqs.
-- In the other case, I turned it into GFP_KENREL, at the cost
   of doing a needless malloc/free in the vast majority of 
   cases where there is no error.  Small price, as I beleive
   that this routine is very rarely called.

Patch below, 
Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

