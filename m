Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWA0UYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWA0UYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWA0UYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:24:50 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:47841 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S1161006AbWA0UYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:24:49 -0500
Date: Fri, 27 Jan 2006 13:10:58 -0700
From: jmerkey@ns1.utah-nac.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled check
Message-ID: <20060127201058.GA18805@ns1.utah-nac.org>
References: <43DA62CC.8090309@wolfmountaingroup.com> <Pine.LNX.4.61.0601271513360.15124@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601271513360.15124@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OK.  Got it.  I guess I need to restructure.  And BTW, This was a code fragment
only, the spinlock gets released when -EFAULT is called -- was just an example.

Jeff

On Fri, Jan 27, 2006 at 03:18:06PM -0500, linux-os (Dick Johnson) wrote:
> 
> On Fri, 27 Jan 2006, Jeff V. Merkey wrote:
> 
> >
> > Is there a good reason someone set a disabled_irq() check on 2.6.14 and
> > above for copy_to_user to barf out
> > tons of bogus stack dump messages if the function is called from within
> > a spinlock:
> >
> 
> This is a joke, right????
> 
> > i.e.
> >
> > spin_lock_irqsave(&regen_lock, regen_flags);
> >    v = regen_head;
> >    while (v)
> >    {
> >       if (i >= count)
> >          return -EFAULT;
> 
> ** BUG **  return with spin-lock held!
> 
> >
> >
> >       err = copy_to_user(&s[i++], v, sizeof(VIRTUAL_SETUP));
> 
> ** BUG ** copy to user with spinlock held!
> 
> >       if (err)
> >          return err;
> >
> 
> ** BUG ** Return with spin-lock held!
> >
> >       v = v->next;
> >    }
> >    spin_unlock_irqrestore(&regen_lock, regen_flags);
> >
> > is now busted and worked in kernels up to this point.  The error message
> > is annoying but non-fatal.
> >
> > Jeff
> 
> It was NEVER supposed to work! The only reason it worked is because
> your page(s) copied to, were not swapped out. If they were swapped
> out, you are stuck, the page-fault won't occur.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
