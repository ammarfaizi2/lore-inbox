Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUKBWcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUKBWcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbUKBWcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:32:17 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:52405 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262223AbUKBW2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:28:46 -0500
Date: Tue, 2 Nov 2004 23:28:19 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
Message-ID: <20041102222819.GA16414@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au
References: <20041101084337.GA7824@dominikbrodowski.de> <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 07:00:07AM -0700, Zwane Mwaikambo wrote:
> On Mon, 1 Nov 2004, Dominik Brodowski wrote:
> 
> > [CPU-HOTPLUG] Use a rw-semaphore for serializing and locking
> > 
> > Currently, lock_cpu_hotplug serializes multiple calls to cpufreq->target()
> > on multiple CPUs even though that's unneccessary. Even further, it
> > serializes these calls with totally unrelated other parts of the kernel...
> > some ppc64 event reporting, some cache management, and so on. In my opinion
> > locking should be done subsystem (and normally data-)specific, and disabling
> > CPU hotplug should just do that.
> > 
> > This patch converts the semaphore cpucontrol to be a rwsem which allows us 
> > to use it for _both_ variants: locking (write) and (multiple) other parts 
> > disabling CPU hotplug (read).
> > 
> > Only problem I see with this approach is that lock_cpu_hotplug_interruptible()
> > needs to disappear as there is no down_write_interruptible() for rw-semaphores.
> > 
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>
> 
> Agreed it makes a lot more sense, i think there could be some places where 
> we use preempt_disable to protect against cpu offline which could 
> converted, but that can come later.

Except that we don't want to (and can't[*]) disable preemption in the
cpufreq case. Therefore, we __need__ to disable CPU hotplug specifically,
and not meddle with other issues like preemption, scheduling, CPUs which are
in the allowed_map, and so on. So back to the original patch: Rusty, do you
agree with it?

Thanks,
	Dominik

[*] calls to cpufreq->target() may sleep.
