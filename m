Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWBAKgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWBAKgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWBAKgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:36:10 -0500
Received: from ns2.suse.de ([195.135.220.15]:29095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1160997AbWBAKgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:36:09 -0500
From: Thomas Renninger <trenn@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: [PATCH 1/2] Re: 2.6.16-rc1-mm4
Date: Wed, 1 Feb 2006 11:36:04 +0100
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
Message-Id: <200602011136.05381.trenn@suse.de>
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

The driver seem not to initialize policy->cur in it's init function?
The 0 div probably comes from cpufreq_scale() called in time_cpufreq_notifier()
in kernel/arch/i386/timers/timer_tsc.c

This patch checks in update_policy() whether 0 is set as current freq:
(Be careful, Dave adjusted my original patch to mm, this one is on top of my
original one, so it might not patch cleanly on what Dave finally put in, but it should...)
Maybe it's easier if I submit the old one again with these lines added?
compile tested ...
_________________________________________________

Check whether driver init did not initialize current freq

signed-off-by: Thomas Renninger <trenn@suse.de>


Index: linux-2.6.16-rc1-mm3/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.16-rc1-mm3/drivers/cpufreq/cpufreq.c
@@ -1435,8 +1435,14 @@ int cpufreq_update_policy(unsigned int c
 	*/
 	if (cpufreq_driver->get){
 		policy.cur = cpufreq_driver->get(cpu);
-		if (data->cur != policy.cur)
-			cpufreq_out_of_sync(cpu, data->cur, policy.cur);
+		if (!data->cur){
+			dprintk("Driver did not initialize current freq");
+			data->cur = policy.cur;
+		}
+		else{
+			if (data->cur != policy.cur)
+				cpufreq_out_of_sync(cpu, data->cur, policy.cur);
+		}
 	}
 
 	ret = __cpufreq_set_policy(data, &policy);
