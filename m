Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287526AbRLaOkh>; Mon, 31 Dec 2001 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287528AbRLaOk1>; Mon, 31 Dec 2001 09:40:27 -0500
Received: from hermes.domdv.de ([193.102.202.1]:40971 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S287526AbRLaOkI>;
	Mon, 31 Dec 2001 09:40:08 -0500
Message-ID: <XFMail.20011231153723.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1009765430.9517.32.camel@thanatos>
Date: Mon, 31 Dec 2001 15:37:23 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Thomas Hood <jdthood@mail.com>
Subject: Re: APM driver patch okay?
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if the code was to unreadable for you.
I did just try to keep the apm code overhead small and I'm no friend of "local
local" variables. If the code is now better readable that's fine with me.

If you remove the apm module as far as I can see the system can't be in apm
idle state as during module removal the system is not idle, so the system idle
task is not called, so apm is in busy state as apm_cpu_idle() is called via the
system idle task function pointer and asserts that apm_do_busy() is called on
function exit when apm_do_idle was called.

As I can't get useful temperature data out of my laptop (CPU temp 5°C) I do have
to rely on not really measurable things like fan behaviour and estimated
battery lifetime. With the patch I'm back to 2.2 behaviour which is better than
unpatched 2.4 behaviour.

Even if the idle patch may not improve things for biosses that do work
correctly I can't see any degradation in this case. For broken biosses it is an
improvement in any case.

Furthermore the patch removes confusion where the apm kernel thread and the
idle task were both racing for idle time with the result that an idle system
seemed 'heavily loaded' by the apm kernel thread. This may even have caused
unexpected behaviour for processes that use system load information for
processing decisions.

I would suggest to submit the patch in the early 2.4.18pre stages for wider
testing after the hard lockup on module removal is solved as there seem to be no
other complaints.

Regarding the hard lockup there could be a problem in apm_exit(). Assuming that
sys_idle could be NULL if apm initialization was not complete a safer way would
be:

if (idle_threshold < 100 && sys_idle) {
        pm_idle = sys_idle;
        sys_idle = NULL;
}


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
