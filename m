Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWG2M1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWG2M1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWG2M1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:27:52 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:53484 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751365AbWG2M1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:27:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Date: Sat, 29 Jul 2006 14:27:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, Nathan Lynch <ntl@pobox.com>
References: <200607281015.30048.rjw@sisk.pl> <20060728221508.9ec9be23.akpm@osdl.org>
In-Reply-To: <20060728221508.9ec9be23.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291427.01749.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 07:15, Andrew Morton wrote:
> On Fri, 28 Jul 2006 10:15:29 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > int disable_nonboot_cpus(void)
> > +{
> > +	int cpu, error = 0;
> > +
> > +	/* We take all of the non-boot CPUs down in one shot to avoid races
> > +	 * with the userspace trying to use the CPU hotplug at the same time
> > +	 */
> > +	mutex_lock(&cpu_add_remove_lock);
> > +	cpus_clear(frozen_cpus);
> > +	printk("Disabling non-boot CPUs ...\n");
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu == 0)
> > +			continue;
> 
> This is presumably only called on cpu 0, yes?
> 
> How can we guarantee that, given that preemption is enabled?

If cpu 0 is online, it will end up running on it when all of the other cpus
are down.

> What happens if cpu 0 isn't online?

Fortunately, on x86_64 and i386 it cannot be offline (I'm not sure about ppc,
though), but of course in general we shouldn't assume that it's online or even
present here.

I'm discussing the issue with Nathan right now.
