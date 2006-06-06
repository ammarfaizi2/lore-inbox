Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWFFXeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWFFXeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWFFXeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:34:37 -0400
Received: from mail.suse.de ([195.135.220.2]:59319 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751354AbWFFXeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:34:36 -0400
From: Andi Kleen <ak@suse.de>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 01:34:28 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com, miles.lane@gmail.com,
       jeremy@goop.org, linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <20060606151507.613edaad.akpm@osdl.org> <20060606230504.GC11696@redhat.com>
In-Reply-To: <20060606230504.GC11696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606070134.29292.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 01:05, Don Zickus wrote:

> Inside those functions I saved the previous state of the watchdog timer.
> However, I learned today that my understanding was incorrect.  Instead
> first the _hotplug_ code is called for every cpu _except_ cpu0.  The
> _suspend/resume_ functions are only called in the context of _cpu0_.
>
> This breaks the design I have because upon resuming the watchdog timers
> automatically start on all cpus (except cpu0 because I saved the previous
> state through the handlers), regardless of what the previous state was.

This means the design was incorrect for CPU hotplug (which needs
to work anyways). suspend is just the most popular user of CPU
hotplug.

> So my question is/was what is the proper way to handle processor level
> subsystems during the suspend/resume path on an SMP system.  I really
> don't understand the hotplug path nor the suspend/resume path very well.

Make it work properly for CPU hotplug for individual CPU and then in suspend
you take care of "global" state and the last CPU.

> I didn't want to register a hotplug handler because a hotplug event is
> really different than a suspend event (I want to _save_ info during a
> suspend event).  The documentation I was reading seemed to suggest that
> hotplug/suspend/smp was a work-in-progress.

You need to disable the nmi watchdog on CPU hotunplug too,
it's no good to keep the NMI running.


-Andi
