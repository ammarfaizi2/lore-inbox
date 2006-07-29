Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWG2NLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWG2NLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 09:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWG2NLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 09:11:39 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:22282 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751370AbWG2NLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 09:11:38 -0400
Date: Sat, 29 Jul 2006 09:00:58 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [KJ] audit return code handling for kernel_thread [2/11]
Message-ID: <20060729130058.GB6669@localhost.localdomain>
References: <200607282007.k6SK7DhX009584@ra.tuxdriver.com> <20060729093704.GD26956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729093704.GD26956@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 10:37:04AM +0100, Russell King wrote:
> On Fri, Jul 28, 2006 at 04:07:13PM -0400, nhorman@tuxdriver.com wrote:
> > Audit/Cleanup of kernel_thread calls, specifically checking of return codes.
> >     Problems seemed to fall into 3 main categories:
> >     
> >     1) callers of kernel_thread were inconsistent about meaning of a zero return
> >     code.  Some callers considered a zero return code to mean success, others took
> >     it to mean failure.  a zero return code, while not actually possible in the
> >     current implementation, should be considered a success (pid 0 is/should be
> >     valid). fixed all callers to treat zero return as success
> >     
> >     2) caller of kernel_thread saved return code of kernel_thread for later use
> >     without ever checking its value.  Callers who did this tended to assume a
> >     non-zero return was success, and would often wait for a completion queue to be
> >     woken up, implying that an error (negative return code) from kernel_thread could
> >     lead to deadlock.  Repaired by checking return code at call time, and setting
> >     saved return code to zero in the event of an error.
> 
> This is inconsistent with your assertion that pid 0 "is/should be valid"
> above.  If you want '0' to mean "not valid" then it's not a valid return
> value from kernel_thread() (and arguably that's true, since pid 0 is
> permanently allocated to the idle thread.)
> 
I think you misread.  I want a return code of zero to be valid (and imply
success).  However, kernel_thread returns an int (not an unsigned int), and
there are/were callers who assumed that _any_ non-zero return values were
success, including negative return values, which indicate a failure in
kernel_thread.

> I don't particularly care whether you decide to that returning pid 0 from
> kernel_thread is valid or not, just that your two points above are at least
> consistent with each other.
> 
I should have been more clear above, point two is meant to indicate that there
were callers of kernel_thread which assume a negative return code from
kernel_thread meant success.  That is what I fixed.

Regards
Neil

> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
