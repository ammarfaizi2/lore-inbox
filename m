Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWBAKik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWBAKik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWBAKik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:38:40 -0500
Received: from ns.suse.de ([195.135.220.2]:40865 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1160998AbWBAKij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:38:39 -0500
From: Thomas Renninger <trenn@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: [PATCH 2/2] Re: 2.6.16-rc1-mm4
Date: Wed, 1 Feb 2006 11:38:37 +0100
User-Agent: KMail/1.8.2
Cc: Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060129144533.128af741.akpm@osdl.org> <20060201001940.GM16557@redhat.com> <20060201005930.GR16557@redhat.com>
In-Reply-To: <20060201005930.GR16557@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011138.38065.trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 01:59, Dave Jones wrote:
> On Tue, Jan 31, 2006 at 07:19:40PM -0500, Dave Jones wrote:
>  > On Tue, Jan 31, 2006 at 02:45:58PM -0800, Avuton Olrich wrote:
>  >  > On 1/29/06, Andrew Morton <akpm@osdl.org> wrote:
>  >  > >
>  >  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
>  >  > 
>  >  > I'm getting a kernel panic on my Libretto L5 on boot, I don't have a
>  >  > serial port on this laptop, I don't have time at the moment to setup
>  >  > netconsole, and it doesn't get the full information. Hopefully this
>  >  > picture helps a bit:
>  >  > 
>  >  > http://68.111.224.150:8080/P1010306.JPG
>  >  > 
>  >  > If it doesn't help I will attempt to get a netconsole on this computer
>  >  > on the near future.
>  > 
>  > Thomas recently changed cpufreq_update_policy to call cpufreq_out_of_sync()
>  > to resync when the BIOS changed the frequency behind our back.
>  > The div by 0 trace fingers that code, but I'm puzzled what we're actually
>  > dividing there.
> 
> it'd be interesting to see the output of cpufreq.debug=7 to see
> what adjust_jiffies is getting before we div by 0, though I fear
> it'll scroll off the screen before we get a chance to capture it.
> 

Test for old_freq equals 0 to insure not to divide by 0:
______________________________________________

Check for not initialized freq on cpufreq changes

signed-off-by: Thomas Renninger <trenn@suse.de>


Index: linux-2.6.16-rc1-mm3/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/arch/i386/kernel/timers/timer_tsc.c
+++ linux-2.6.16-rc1-mm3/arch/i386/kernel/timers/timer_tsc.c
@@ -272,6 +272,10 @@ time_cpufreq_notifier(struct notifier_bl
 	if (val != CPUFREQ_RESUMECHANGE)
 		write_seqlock_irq(&xtime_lock);
 	if (!ref_freq) {
+		if (!freq->old){
+			ref_freq = freq->new;
+			goto end;
+		}
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
 #ifndef CONFIG_SMP
@@ -297,6 +301,7 @@ time_cpufreq_notifier(struct notifier_bl
 #endif
 	}
 
+end:
 	if (val != CPUFREQ_RESUMECHANGE)
 		write_sequnlock_irq(&xtime_lock);
 
