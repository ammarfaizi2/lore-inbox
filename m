Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUFUWev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUFUWev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUFUWdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:33:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:14033 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266492AbUFUWbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:31:39 -0400
Subject: Re: can TSC tick with different speeds on SMP=?koi8-r?Q?=3F?=
From: john stultz <johnstul@us.ibm.com>
To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
References: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
Content-Type: text/plain
Message-Id: <1087857100.21955.171.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 21 Jun 2004 15:31:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 12:02, =?koi8-r?Q?=22?=Kirill
Korotaev=?koi8-r?Q?=22=20?= wrote:
> I've got some stupid question to SMP gurus and would be very thankful
> for the details. I suddenly faced an SMP system where different P4
> cpus were installed (with different steppings). This resulted in
> different CPU clock speeds and different speeds of time stamp counters
> on these CPUs. I faced the problem during some timings I measured in
> the kernel.
> So the question is "is such system compliant with SMP specification?".

Linux doesn't really support this configuration at the moment.
Historically Intel hasn't supported different stepping cpus in the same
system, much less different frequency cpus. I know the TSC time source
code won't handle it properly, and there are other users of rdtsc that
might cause problems. Other concerns would be users of cpu_khz
(scheduler?) and cpufreq code. 

I've heard that AMD has introduced this as a possible configuration, and
Intel may have changed their support story as well, so this may need to
be addressed. 

> In old kernels there was a code to syncronize TSCs and to detect if
> they were screwed up. Current kernels do not have such code. Is it
> intentional? I suppose there is some code in kernel which won't work
> find on such systems (real-time threads timing accounting and so on).

The TSC syncing code is still there, but it runs only once at boot. Thus
it will sync the cpus, but then won't account for the TSC drift between
them.

The only way to get around this is to use an alternate time source, such
as the ACPI-PM time source (clock=pmtmr), or even the PIT (clock=pit).
ACPI-PM still uses the TSC for delay() so it may still have issues, so
be warned.

thanks
-john

