Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263263AbVGAH21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbVGAH21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbVGAH20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:28:26 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44228 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263263AbVGAH2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:28:15 -0400
Date: Fri, 1 Jul 2005 13:07:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Benjamin LaHaise <bcrl@kvack.org>, wli@holomorphy.com, zab@zabbo.net,
       mason@suse.com
Subject: Re: [PATCH 0/6] Integrate AIO with wait-bit based filtered wakeups
Message-ID: <20050701073725.GA4625@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com> <1120146540.1604.65.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1120146540.1604.65.camel@frecb000686>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 05:49:00PM +0200, Sébastien Dugué wrote:
> On Mon, 2005-06-20 at 21:31 +0530, Suparna Bhattacharya wrote:
> > On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> > > Since AIO development is gaining momentum once again, ocfs2 and
> > > samba both appear to be using AIO, NFS needs async semaphores etc,
> > > there appears to be an increase in interest in straightening out some
> > > of the pending work in this area. So this seems like a good
> > > time to re-post some of those patches for discussion and decision.
> > > 
> > > Just to help sync up, here is an initial list based on the pieces
> > > that have been in progress with patches in existence (please feel free
> > > to add/update ones I missed or reflected inaccurately here):
> > > 
> > > (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> > > 	Status: Updated to 2.6.12-rc6, needs review
> > 
> > Here is a little bit of background on the motivation behind this set of
> > patches to update AIO for filtered wakeups:
> > 
> > (a) Since the introduction of filtered wakeups support and 
> >     the wait_bit_queue infrastructure in mainline, it is no longer
> >     sufficient to just embed a wait queue entry in the kiocb
> >     for AIO operations involving filtered wakeups.
> > (b) Given that filesystem reads/writes use filtered wakeups underlying
> >     wait_on_page_bit, fixing this becomes a pre-req for buffered
> >     filesystem AIO.
> > (c) The wait_bit_queue infrastructure actually enables a cleaner
> >     implementation of filesystem AIO because it already provides
> >     for an action routine intended to allow both blocking and
> >     non-blocking or asynchronous behaviour.
> > 
> > As I was rewriting the patches to address this, there is one other
> > change I made to resolve one remaining ugliness in my earlier
> > patchsets - special casing of the form 
> > 	if (wait == NULL) wait = &local_wait
> > to switch to a stack based wait queue entry if not passed a wait
> > queue entry associated with an iocb.
> > 
> > To avoid this, I have tried biting the bullet by including a default
> > wait bit queue entry in the task structure, to be used instead of
> > on-demand allocation of a wait bit queue entry on stack.
> > 
> > All in all, these changes have (hopefully) simplified the code,
> > as well as made it more up-to-date. Comments (including
> > better names etc as requested by Zach) are welcome !
> > 
> > Regards
> > Suparna
> > 
> 
>   Just found a bug in aio_run_iocb: after having called the retry
> method for the iocb, current->io_wait is RESET to NULL. While this
> does not affect applications doing only AIO, applications
> mixing sync and async IO (MySQL for example) end up crashing
> later on in the sync path when calling lock_page_slow as the io_wait
> queue is NULL.

Yes this is a problem. I had spotted it too but the implications hadn't
registered well enough for prompt fix - thanks for the patch.

Regards
Suparna

> 
>   Therefore after the retry method has been called the task io_wait
> queue should be set to the default queue.
> 
>   This patch applies over Suparna's wait-bit patchset and maybe should 
> be folded into aio-wait-bit.
> 
>   Sébastien.
> 
> -- 
> ------------------------------------------------------
> 
>   Sébastien Dugué                BULL/FREC:B1-247
>   phone: (+33) 476 29 77 70      Bullcom: 229-7770
> 
>   mailto:sebastien.dugue@bull.net
> 
>   Linux POSIX AIO: http://www.bullopensource.org/posix
>   
> ------------------------------------------------------



-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

