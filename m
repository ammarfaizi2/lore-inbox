Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWGIKpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWGIKpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWGIKpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:45:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932194AbWGIKpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:45:30 -0400
Date: Sun, 9 Jul 2006 03:45:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Fabio Comolli" <fabio.comolli@gmail.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709034509.c4652caa.akpm@osdl.org>
In-Reply-To: <b637ec0b0607090326w5a1702d1l9b7619fba7e4bc41@mail.gmail.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<b637ec0b0607090326w5a1702d1l9b7619fba7e4bc41@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 12:26:45 +0200
"Fabio Comolli" <fabio.comolli@gmail.com> wrote:

> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> cpuspeed/1520 is trying to acquire lock:
>  (&policy->lock){--..}, at: [<c02c130f>] mutex_lock+0x21/0x24
> 
> but task is already holding lock:
>  (cpucontrol){--..}, at: [<c02c130f>] mutex_lock+0x21/0x24
> 
> which lock already depends on the new lock.

Yeah, that's lock_cpu_hotplug().  We've made a complete and utter mess of
that thing.

And I don't know how to fix it, really.  Is it a highly-localised innermost
lock?  Or a broad-coverage outermost lock?  Nobody knows, neither suits.

I'm suspecting is was a bad idea and we should just rip it out altogether.

- If a piece of kernel code is dealing with cpu-local data it needs to be
  running atomically, and that'll hold off hot hotplug anyway.

- If a piece of kernel code is dealing with per-cpu data and cannot run
  atomically then it should have its own cpu hotplug handlers anyway.  It
  is up to that code (ie: cpufreq) to provide its own locking against its
  own CPU hotplug callback.

Voila, no more lock_cpu_hotplug().
