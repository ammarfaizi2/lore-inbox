Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283641AbRK3MhB>; Fri, 30 Nov 2001 07:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283642AbRK3Mgv>; Fri, 30 Nov 2001 07:36:51 -0500
Received: from hermes.domdv.de ([193.102.202.1]:38928 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283641AbRK3Mgj>;
	Fri, 30 Nov 2001 07:36:39 -0500
Message-ID: <XFMail.20011130133403.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E169mBE-0003Fw-00@the-village.bc.nu>
Date: Fri, 30 Nov 2001 13:34:03 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kapm-idled no longer idling CPU?
Cc: linux-kernel@vger.kernel.org, <dglidden@illusionary.com (Derek Glidden)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30-Nov-2001 Alan Cox wrote:
>> application that uses more than very minor system resources is running,
>> (i.e. mozilla, netscape, xemacs, apache, Tomcat, just to name a few
>> common ones I've seen this behaviour with) kapm-idled no longer receives
>> scheduling time from what I can tell and I assume that means my CPU is
>> never getting idled when nothing is scheduled.
> 
> kapm_idled will get scheduling time when there is nothing else to run, 
> whether it wants it or is using it is more of the question.
> 

Well, that's exactly the problem. in apm_mainloop the following happens:

                timeout = 2 * timeout;
                if (timeout > APM_CHECK_TIMEOUT)
                        timeout = APM_CHECK_TIMEOUT;
                schedule_timeout(timeout);

...

                if (!system_idle())
                        continue;

...

if (apm_do_idle() != -1) {

...

                        timeout = 1;
                }


This just means that after a busy condition we start at 1 and increase the
scheduling delay until the timeout reaches HZ.

system_idle itself just checks, if nr_running is 1. This means that if any
single other process is runnable every HZ time when apm_idled checks the system
state it won't switch to idle state even if the system is otherwise idle. I do
see this behaviour e.g. all the time with KDE.

Just create a process that does a select timeout every HZ and down the drain
goes your laptop battery, when the select call meets kapm-idled polling time.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
