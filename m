Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbTAMJGl>; Mon, 13 Jan 2003 04:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbTAMJGl>; Mon, 13 Jan 2003 04:06:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1544 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267632AbTAMJGk>; Mon, 13 Jan 2003 04:06:40 -0500
Date: Mon, 13 Jan 2003 09:15:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fixing the tty layer was Re: any chance of 2.6.0-test*?
Message-ID: <20030113091526.A12379@flint.arm.linux.org.uk>
Mail-Followup-To: Dipankar Sarma <dipankar@in.ibm.com>,
	Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <20030112094007$1647@gated-at.bofh.it> <m3iswuk7xm.fsf_-_@averell.firstfloor.org> <20030113064131.GB14996@in.ibm.com> <20030113072539.GA2197@averell> <20030113081233.GA15525@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030113081233.GA15525@in.ibm.com>; from dipankar@in.ibm.com on Mon, Jan 13, 2003 at 01:42:33PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 01:42:33PM +0530, Dipankar Sarma wrote:
> > The idea of the BKL was to protect the protect context code against
> > itself (code lock) and also the few global data structures that 
> > are only accessed from process context (like the tty drivers list)
> 
> In that case would it not be better to replace all BKLs by a single tty
> lock ?

No.  The tty layer relies on being able to safely reschedule with the
BKL held.  If you replace it with a "tty lock" you need to find all
those schedule() points throughout _every_ tty line discipline and
tty driver and release that lock.

Basically, the tty later was written upon the assumption that there
would be only _one_ thread of execution running tty code at any one
time, and we only reschedule when we explicitly want to (which was
the general kernel coding rule before we got spinlocks etc.)  Every
point where a reschedule is possible, state checks are (should be)
made to prevent races.

When analysing the tty layer, you have to think not "what data does
this protect" but "what code are we protecting".  Note that you must
apply the same approach towards what were the global-cli points.

I don't think its the BKL points you have to worry about; they've
stayed the same over many kernel versions.  The places that need
deeper consideration are where the global-cli was replaced with the
local-cli.  Obviously the latter is not a direct subsitute for the
former.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

