Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWBNCpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWBNCpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBNCpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:45:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbWBNCpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:45:49 -0500
Date: Mon, 13 Feb 2006 18:44:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: avuton@gmail.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060213184442.464f0fc6.akpm@osdl.org>
In-Reply-To: <20060213025603.2014f9bd.akpm@osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com>
	<20060213023925.2b950eea.akpm@osdl.org>
	<3aa654a40602130251t174a5e4bg28a52a147cc9b2cf@mail.gmail.com>
	<20060213025603.2014f9bd.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Avuton Olrich <avuton@gmail.com> wrote:
> >
> > I should have realized that would happen, hopefully here's a better
> >  one. Please let me know anything I can do to help.
> > 
> >  http://68.111.224.150:8080/~sbh/P1010031.JPG
> 
> Thanks.  Yes, it does look like the same bug.

argh.   The fix for this oops is still languishing in David's tree.


--- a/arch/i386/kernel/timers/timer_tsc.c
+++ b/arch/i386/kernel/timers/timer_tsc.c
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
 

