Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWIVTRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWIVTRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWIVTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:17:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932171AbWIVTRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:17:06 -0400
Date: Fri, 22 Sep 2006 12:16:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>, Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] Migration of Standard Timers
Message-Id: <20060922121635.99e906d0.akpm@osdl.org>
In-Reply-To: <20060919152942.GA26863@sgi.com>
References: <20060919152942.GA26863@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 10:29:42 -0500
Dimitri Sivanich <sivanich@sgi.com> wrote:

> This patch allows the user to migrate currently queued
> standard timers from one cpu to another.  Migrating
> timers off of select cpus allows those cpus to run
> time critical threads with minimal timer induced latency
> (which can reach 100's of usec for a single timer as shown
> on an X86_64 test machine), thereby improving overall
> determinance on those selected cpus.
> 
> This patch considers timers placed with add_timer_on()
> to have 'cpu affinity' and does not move them, unless the
> timers are being migrated off of a hotplug cpu that is
> going down.
> 
> The changes in drivers/base/cpu.c provide a clean and
> convenient interface for triggering the migration through
> sysfs, via writing the destination cpu number to an owner
> writeable file (0200 permissions) associated with the source
> cpu.  In additon, this functionality is available for kernel
> module use.
> 
> Note that migrating timers will not, by itself, keep new
> timers off of the chosen cpu.  But with careful control of
> thread affinity, one can control the affinity of new timers
> and keep timer induced latencies off of the chosen cpu.
> 
> This particular patch does not affect the hrtimers.  That
> could be addressed later.

I can't say I like this, sorry.

- It adds another word to the timer_list structure for a very obscure
  application.  And a lot of kernel data structures aggregate timer_lists.

- There are places in the kernel which assume that once a timer is added
  on a CPU, it will stay there.  The timer handler re-arms the timer,
  confident in the knowledge that everything stays on this CPU.

  I recall working on such code a couple of years ago, but I now forget where
  it was.

  It is reasonable to do add_timer() within the CPU_ONLINE handler (for
  example), in the expectation that that timer will fire on this CPU.

  The proposed change permits the administrator to break that assumption.
  We would need to hunt down any code which makes that assumption and
  convert it to add_timer_on().  And we'd need to be very vigilant in the
  future, since people could easily add new code which had the old
  assumption which worked just fine for them in testing.

