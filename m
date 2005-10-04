Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVJDQoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVJDQoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVJDQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:44:13 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:14255 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964851AbVJDQoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:44:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G5M5LSyxvoNHKKRrQDTle0sV07EgkwB5JeDv9D5Jc6UJPDOl869gdcRP3b+e6M+iHhH3bzR3s6iaxQc440FqL57dY+42h6WUrxbz53eVW63TTvjPyIsE9S13wpBR0ij5+af2vhjnv0/5HQ5fygCa6NvdeGt0IbsJjXfU4y7HiUs=
Message-ID: <29495f1d0510040944i6d8eb36aud85b63ff12608e8a@mail.gmail.com>
Date: Tue, 4 Oct 2005 09:44:10 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1128404215.31063.32.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128404215.31063.32.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> This is the actual thermal control support for PowerMac8,1, PowerMac8,2
> and PowerMac9,1 machines (SMU based), that is iMac G5 and single CPU desktop.
> It requires CPUFREQ to be enabled to properly deal with overtemp conditions.
> The new thermal control code implements a new framework (nicknamed "windfarm")
> to which I expect to port the old G5 thermal control, and possibly some of the
> powerbook thermal control drivers as well in the future.

<snip>

> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/drivers/macintosh/windfarm_core.c        2005-10-04 15:17:33.000000000 +1000

<snip>

> +static int wf_thread_func(void *data)
> +{
> +       unsigned long next, delay;
> +
> +       next = jiffies;
> +
> +       DBG("wf: thread started\n");
> +
> +       while(!kthread_should_stop()) {
> +               try_to_freeze();
> +
> +               if (time_after_eq(jiffies, next)) {
> +                       wf_notify(WF_EVENT_TICK, NULL);
> +                       if (wf_overtemp) {
> +                               wf_overtemp_counter++;
> +                               /* 10 seconds overtemp, notify userland */
> +                               if (wf_overtemp_counter > 10)
> +                                       wf_critical_overtemp();
> +                               /* 30 seconds, shutdown */
> +                               if (wf_overtemp_counter > 30) {
> +                                       printk(KERN_ERR "windfarm: Overtemp "
> +                                              "for more than 30"
> +                                              " seconds, shutting down\n");
> +                                       machine_power_off();
> +                               }
> +                       }
> +                       next += HZ;
> +               }
> +
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               delay = next - jiffies;
> +               if (delay <= HZ)
> +                       schedule_timeout(delay);
> +               set_current_state(TASK_RUNNING);

This can be schedule_timeout_interruptible(delay); and then you can
get rid of the set_current_state(TASK_RUNNING);

Thanks,
NIsh
