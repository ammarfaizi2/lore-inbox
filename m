Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWG2TDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWG2TDi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWG2TDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:03:38 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:527 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751412AbWG2TDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:03:37 -0400
Date: Sat, 29 Jul 2006 14:59:57 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [KJ] audit return code handling for kernel_thread [2/11]
Message-ID: <20060729185957.GA7976@localhost.localdomain>
References: <200607282007.k6SK7DhX009584@ra.tuxdriver.com> <20060729093704.GD26956@flint.arm.linux.org.uk> <20060729131419.GA6892@localhost.localdomain> <20060729145004.GA5733@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729145004.GA5733@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:50:04PM +0100, Russell King wrote:
> On Sat, Jul 29, 2006 at 09:14:19AM -0400, Neil Horman wrote:
> > On Sat, Jul 29, 2006 at 10:37:04AM +0100, Russell King wrote:
> > > On Fri, Jul 28, 2006 at 04:07:13PM -0400, nhorman@tuxdriver.com wrote:
> > > > Audit/Cleanup of kernel_thread calls, specifically checking of return codes.
> > > >     Problems seemed to fall into 3 main categories:
> > > >     
> > > >     1) callers of kernel_thread were inconsistent about meaning of a zero return
> > > >     code.  Some callers considered a zero return code to mean success, others took
> > > >     it to mean failure.  a zero return code, while not actually possible in the
> > > >     current implementation, should be considered a success (pid 0 is/should be
> > > >     valid). fixed all callers to treat zero return as success
> > > >     
> > > >     2) caller of kernel_thread saved return code of kernel_thread for later use
> > > >     without ever checking its value.  Callers who did this tended to assume a
> > > >     non-zero return was success, and would often wait for a completion queue to be
> > > >     woken up, implying that an error (negative return code) from kernel_thread could
> > > >     lead to deadlock.  Repaired by checking return code at call time, and setting
> > > >     saved return code to zero in the event of an error.
> > > 
> > > This is inconsistent with your assertion that pid 0 "is/should be valid"
> > > above.  If you want '0' to mean "not valid" then it's not a valid return
> > > value from kernel_thread() (and arguably that's true, since pid 0 is
> > > permanently allocated to the idle thread.)
> > > 
> > No its, not, but I can see how my comments might be ambiguous. I want zero to be
> > a valid return code, since we never actually return zero, but we certainly could
> > if we wanted to.  Note that kernel_thread returns an int (not an unsigned int),
> > and as such assuming that a non-zero return code implies success ignores the
> > fact that kernel_thread can return a negative value, which indicates failure.
> > This is what I found, and what my patch fixes.
> > 
> > > I don't particularly care whether you decide to that returning pid 0 from
> > > kernel_thread is valid or not, just that your two points above are at least
> > > consistent with each other.
> > > 
> > My comments in (2) should be made more clear by changing "assume a non-zero
> > return was success" to "assume a negative return was success".  This is what my
> > patch fixes.
> 
> In the first point, you say that you want return of zero to mean success.
> In the second point, you use zero to mark an error event.  That's the
> inconsistency I'm referring to.
> 
> So, if we _did_ return zero from kernel_thread, and we had your fix as in
> (2), you'd store zero into the saved return code, which would then be
> interpreted in later code as an error.
> 
Ahh, I see what your saying now.  The later check of the stored return code
should specifically check for negative, rather than non-zero return codes,
instead of just assigning zero to the stored result to avoid the later check
going down the wrong return path, good point.  I'll fix that up early next week,
with the other items on my todo list.

Thanks & Regards
Neil

> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
