Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTAMJZf>; Mon, 13 Jan 2003 04:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTAMJZf>; Mon, 13 Jan 2003 04:25:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45199 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267717AbTAMJZe>;
	Mon, 13 Jan 2003 04:25:34 -0500
Date: Mon, 13 Jan 2003 15:06:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fixing the tty layer was Re: any chance of 2.6.0-test*?
Message-ID: <20030113093632.GC15525@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <20030112094007$1647@gated-at.bofh.it> <m3iswuk7xm.fsf_-_@averell.firstfloor.org> <20030113064131.GB14996@in.ibm.com> <20030113072539.GA2197@averell> <20030113081233.GA15525@in.ibm.com> <20030113091526.A12379@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113091526.A12379@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 09:15:26AM +0000, Russell King wrote:
> > In that case would it not be better to replace all BKLs by a single tty
> > lock ?
> 
> No.  The tty layer relies on being able to safely reschedule with the
> BKL held.  If you replace it with a "tty lock" you need to find all
> those schedule() points throughout _every_ tty line discipline and
> tty driver and release that lock.

Yes, I get it now from this and Andi's mail. I hadn't thought about
that "special feature" of BKL :)

> 
> Basically, the tty later was written upon the assumption that there
> would be only _one_ thread of execution running tty code at any one
> time, and we only reschedule when we explicitly want to (which was
> the general kernel coding rule before we got spinlocks etc.)  Every
> point where a reschedule is possible, state checks are (should be)
> made to prevent races.

Hmm.. This understanding would make it easier for me to go take another look
at the tty layer.

> 
> When analysing the tty layer, you have to think not "what data does
> this protect" but "what code are we protecting".  Note that you must
> apply the same approach towards what were the global-cli points.
> 
> I don't think its the BKL points you have to worry about; they've
> stayed the same over many kernel versions.  The places that need
> deeper consideration are where the global-cli was replaced with the
> local-cli.  Obviously the latter is not a direct subsitute for the
> former.

BKL confused me here because I wasn't sure whether BKL was implicitly
protecting the tty driver code against anything else apart from itself.

Thanks
Dipankar
