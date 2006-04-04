Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWDDIpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWDDIpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWDDIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:45:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751843AbWDDIpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:45:25 -0400
Date: Tue, 4 Apr 2006 01:44:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Linux 2.6.17-rc1
Message-Id: <20060404014421.635b2c51.akpm@osdl.org>
In-Reply-To: <20060404080529.GM7849@charite.de>
References: <20060404080205.C8B29E007A12@knarzkiste.dyndns.org>
	<20060403180207.E849EE007A12@knarzkiste.dyndns.org>
	<Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
	<20060403190915.GA10584@charite.de>
	<20060403202539.65cf6e33.akpm@osdl.org>
	<20060404080529.GM7849@charite.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:
>

I might not have read your email for two days.  And you removed from Cc the
people who actually have a chance of fixing this.  Please always do
reply-to-all.

> * Andrew Morton <akpm@osdl.org>:
> 
> > In acpi_processor_unregister_performance(), pr->performance is NULL.
> > 
> > Can you add the below?  It should tell us who forgot to register the
> > performance data, as well as working around the crash.
> 
> I added the patch.
> in dmesg I now get:
> 
> > Apr  4 09:54:06 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> > Apr  4 09:54:06 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> > Apr  4 09:54:06 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> > Apr  4 09:54:06 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x2
> > Apr  4 09:54:06 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8
> 
> > Apr  4 09:54:25 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> > Apr  4 09:54:25 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> > Apr  4 09:54:25 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> > Apr  4 09:54:25 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x4
> 
> > Apr  4 09:54:44 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.1)
> > Apr  4 09:54:45 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> > Apr  4 09:54:45 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> > Apr  4 09:54:45 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x4
> 
> So, no more EIPs, but no conclusive messages either!

OK, thanks.  That indicates that we did install a
acpi_processor_performance structure, but something must have later on
zeroed it.

Hopefully the cpufreq guys will be able to reproduce this.

<tries it>

Actually, I cannot even rmmod the thing:

Module                  Size  Used by
p4_clockmod             6980  1 
speedstep_lib           5376  1 p4_clockmod

It looks like either it has a refcounting problem or it has been changed so
that it is deliberately pinned.

