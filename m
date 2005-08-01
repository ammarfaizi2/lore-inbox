Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVHAJ4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVHAJ4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVHAJ4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:56:12 -0400
Received: from village.ehouse.ru ([193.111.92.18]:51207 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262079AbVHAJ4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:56:11 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12 hangs on boot
Date: Mon, 1 Aug 2005 13:54:36 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
References: <200506221813.50385.gluk@php4.ru> <20050728220921.231623b5.akpm@osdl.org>
In-Reply-To: <20050728220921.231623b5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508011354.36377.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 July 2005 09:09, Andrew Morton wrote:
> "Alexander Y. Fomichev" <gluk@php4.ru> wrote:
> > G' day
> >
> > I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8
> > GHz [ MoBo: Intel E7520, intel 82801 ]
> > but kernel hangs on boot right after records:
> >
> > Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
> > Initializing CPU#2
> >
> > ( below is a link to full boot trace, actually -git3 but no differences)
> > http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-hang
> >
> > An attempt to enable debug:
> > +CONFIG_ACPI_DEBUG=y
> > +CONFIG_DEBUG_SLAB=y
> > +CONFIG_DEBUG_PREEMPT=y
> > +CONFIG_DEBUG_SPINLOCK=y
> > +CONFIG_DEBUG_SPINLOCK_SLEEP=y
> > +CONFIG_DEBUG_KOBJECT=y
> > +CONFIG_DEBUG_INFO=y
> > +CONFIG_INIT_DEBUG=y
> > gives rather strange result, kernel boots successfully ( with a lot of
> > debuging messages of course but i couldn't find something suspicious )
> > http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3-debug
> >
> > config for 2.6.12 have been taken from previous one, only
> > 'make oldconfig' has been made.
> > http://sysadminday.org.ru/2.6.12-hang-on-boot/2.6.12-git3.config
> >
> > Hang 100% reproducible on at least two of my EM64T hosts.
> > ( actualy the same configuration as of MoBo/CPU )
>
> Is this still happening in 2.6.13-rc4?
>
> If so, could you please test 2.6.13-rc4 plus the below fix?
>
> Thanks.
>
>
> From: ebiederm@xmission.com (Eric W. Biederman)
>
> sync_tsc was using smp_call_function to ask the boot processor to report
> it's tsc value.  smp_call_function performs an IPI_send_allbutself which is
> a broadcast ipi.  There is a window during processor startup during which
> the target cpu has started and before it has initialized it's interrupt
> vectors so it can properly process an interrupt.  Receveing an interrupt
> during that window will triple fault the cpu and do other nasty things.
>
> Why cli does not protect us from that is beyond me.
>
> The simple fix is to match ia64 and provide a smp_call_function_single.
> Which avoids the broadcast and is more efficient.
>
> This certainly fixes the problem of getting stuck on boot which was very
> easy to trigger on my SMP Hyperthreaded Xeon, and I think it fixes it for
> the right reasons.
>
> I believe this patch suffers from apicid versus logical cpu number
> confusion.  I copied the basic logic from smp_send_reschedule and I can't
> find where that translates from the logical cpuid to apicid.  So it isn't
> quite correct yet.  It should be close enough that it shouldn't be too hard
> to finish it up.
>
> More bug fixes after I have slept but I figured I needed to get this
> one out for review.
>
> Signed-off-by: Eric ic W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
[skip]

I've not tried 2.6.13-rc4 itself because i notice changes has been commited
into Linus git tree under id: 3d483f47579461a4715db33c68ef8752e5a97a2d
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3d483f47579461a4715db33c68ef8752e5a97a2d
and this tree works well for me though previous one
[94d2ac66c12397e2ca7988dbf59f24a966d275cb] -- hangs. So i guess it is exactly
problem this patch solve.
Thank you and for your help.


-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
