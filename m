Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWEHRsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWEHRsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEHRsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:48:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59830 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932459AbWEHRsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:48:45 -0400
Subject: Re: 2.6.17-rc3-mm1
From: john stultz <johnstul@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1146911438.7467.13.camel@localhost.localdomain>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	 <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
	 <20060503064816.ef7ec2b7.akpm@osdl.org>
	 <1146665732.27820.75.camel@localhost.localdomain>
	 <20060503144318.GA5505@ens-lyon.fr>  <20060505150509.GA16562@ens-lyon.fr>
	 <1146911438.7467.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 08 May 2006 10:48:39 -0700
Message-Id: <1147110520.13441.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-06 at 10:30 +0000, Thomas Gleixner wrote:
> Benoit,
> 
> On Fri, 2006-05-05 at 17:05 +0200, Benoit Boissinot wrote:
> > @@ -437,6 +438,12 @@ hrtimer_start(struct hrtimer *timer, kti
> >  
> >  	if (mode == HRTIMER_REL) {
> - 		tim = ktime_add(tim, new_base->get_time());
> +		ktime_t curr = new_base->get_time();
> +		
> +		tim = ktime_add(tim, curr);
> +
> 
> Can you change the debug that way? So we have the values which are
> added. Please print out new_base->id too.
> 
> > and when urxvtd hanged I had the following in dmesg:
> > [  356.696000] urxvtd: empty nanosleep 356726124322 17948911854451
> > 
> > So I suppose something is wrong in ktime_add()
> 
> Well, ktime_add is adding two 64 bit values.
> 
> The delta between the two values is 0xFFFFFFB3451. That looks like the
> timekeeping on your box is screwed by 0x100000000000. 
> 
> John, any idea ?

I suspect the system is falling back to the PIT instead of the ACPI PM
due to mis-merged patch in 2.6.17-rc3-mm1. The PIT has had a few reports
of problems, and I've got a test patch which I'm waiting for some
results on from a tester before sending (I can't reproduce the issue
locally).

Applying the patch here should get the ACPI PM working again.
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f0ec5e39765cd254d436a6d86e211d81795952a4;hp=30d55280b867aa0cae99f836ad0181bb0bf8f9cb


thanks
-john

