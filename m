Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbRE0VSK>; Sun, 27 May 2001 17:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262299AbRE0VSA>; Sun, 27 May 2001 17:18:00 -0400
Received: from ns.suse.de ([213.95.15.193]:2568 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262296AbRE0VRs>;
	Sun, 27 May 2001 17:17:48 -0400
To: "David S. Miller" <davem@redhat.com>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] softirq-2.4.5-B0
In-Reply-To: <15120.16986.610478.279574@pizda.ninka.net.suse.lists.linux.kernel> <Pine.LNX.4.33.0105271020310.1667-200000@localhost.localdomain.suse.lists.linux.kernel> <15121.21054.657593.830199@pizda.ninka.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 May 2001 23:17:30 +0200
In-Reply-To: "David S. Miller"'s message of "27 May 2001 21:20:33 +0200"
Message-ID: <oup4ru6bifp.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>  > the attached softirq-2.4.5-B0 patch fixes this problem by calling
>  > do_softirq()  from local_bh_enable() [if the bh count is 0, to avoid
>  > recursion].
> 
> Yikes!  I do not like this fix.
> 
> I'd rather local_bh_enable() not become a more heavy primitive.
> 
> I know, in one respect it makes sense because it parallels how
> hardware interrupts work, but not this thing is a function call
> instead of a counter bump :-(
> 
> Any other ideas how to zap this?

I think the right way to fix it is to do a final atomic check for softirqs 
when the kernel is exited. To be atomic this check neededs to be done with 
interrupts off until the kernel exited. I just implemented a very similar way 
into the x86-64 kernel (which needs to turn off interrupts for kernel anyways 
for other reasons, this just extends the cli area a bit). The same atomic
check is needed for race free check of need_schedule (which is still racy
on plain i386). 

-Andi
