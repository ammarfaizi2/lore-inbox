Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751505AbWFDPPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWFDPPu (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 11:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWFDPPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 11:15:50 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:172 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751505AbWFDPPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 11:15:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=cAHFjg8cROc/Y6LmMtC69a36R3FC6PQ+eHKooHqZjQckg5iKP/p+t5ZRvOViuYi63JDBIbcu8gwWpw+IQY5yGLJ/LMu1WWYanBFAaRujZSWV8DP/hly8GfIPAvbAKatbj7du3foGQxRngz6bvZrTwdcdZHY2gm0FY3uWheazywo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] non-scalar ktime addition and subtraction broken
Date: Sun, 4 Jun 2006 17:04:50 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Christopher S. Aker" <caker@theshore.net>
References: <20060602030825.GA8006@ccure.user-mode-linux.org> <200606022028.38510.blaisorblade@yahoo.it> <20060602213455.GA5889@ccure.user-mode-linux.org>
In-Reply-To: <20060602213455.GA5889@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041704.51072.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 23:34, Jeff Dike wrote:
> On Fri, Jun 02, 2006 at 08:28:37PM +0200, Blaisorblade wrote:
> > Ok, since I now I'll never finish it:
> > $ ll old-patch-scripts/patches/uml-fix-timers.patch
> > -rw-r--r-- 1 paolo paolo 6763 2005-07-24 06:41
> > old-patch-scripts/patches/uml-fix-timers.patch
> >
> > I'm attaching this incomplete patch. It won't apply (it was written
> > likely before 2.6.13 but surely after git was born), it likely introduces
> > bugs and I
> >
> > *) Rename timer() since it's a global and such a name is a "shooting
> > offense".  Also, it's difficult to find the def with ctags
> > currently, because people miss fantasy.
>
> This is now gone, replaced by get_time.  I can rename that if you feel
> it's objectionable.

I still see (around 2.6.17-rc3) timer() existing in the same place and with 
the same definition - even if it now seems unused:

void timer(void)
{
        gettimeofday(&xtime, NULL);
        timeradd(&xtime, &local_offset, &xtime);
}

> > *) do_timer must be called with xtime_lock held. I'm not sure
> > boot_timer_handler needs this, however I don't think it hurts: it simply
> > disables irq and takes a spinlock.
>
> Fixed.
>
> > *) wall_to_monotonic must be normalized and have a posititive ts_nsec
> > part, see wall_to_monotonic definition and i386 usage in
> > arch/i386/kernel/time.c. Otherwise you can get negative tv_nsec results
> > with
> > do_posix_clock_monotonic_gettime and its callers, including
> > sys_timer_gettime.
>
> Bah, you almost completely diagnosed the bug.  Fixed now.

Yep, however I didn't reproduce any misbehaviour at that time.

> > *) Remove um_time() and um_stime() syscalls since they are identical to
> > system-wide ones.

> Fixed.  sys_time64 seems to be gone on x86_64, so I deleted it from
> here as well.

Yes, I deleted sys_time64 time ago, forgot to update 
arch/um/sys-x86_64/syscall_table.c.

> > *) Move clock_was_set() from do_gettimeofday to do_settimeofday. Not
> > only from the name you guess this is needed, but I indeed verified
> > that for i386 it's in arch/i386/kernel/time.c:do_settimeofday().

> > *) XXX: Probably do_settimeofday should be copied from i386 to
> > replace the current version.
> >
> > *) XXX: do_[gs]ettimeofday() should use seqlocks like in i386,
> > instead of timer_lock() like they do. They also don't synchronize
> > with the rest, beyond the performance problems!
>
> You're probably right.  These two are related, and I'm not sure what
> to do with them offhand.

And that's why I didn't send the patches then in first place - I wanted to 
complete them (I have too many incomplete patches, and too little time to 
finish them :-( ).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
