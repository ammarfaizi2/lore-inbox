Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVCKNQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVCKNQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVCKNQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:16:39 -0500
Received: from smtp-out.panservice.it ([212.66.96.30]:20139 "EHLO
	smtp-out.panservice.it") by vger.kernel.org with ESMTP
	id S262726AbVCKNQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:16:34 -0500
Message-ID: <42319A30.1010802@swintel.it>
Date: Fri, 11 Mar 2005 14:16:32 +0100
From: Giovambattista Pulcini <gpulcini@swintel.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Problem with NTP on (embedded) PPC, patch and RFC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On an embedded device based on the IBM 405GP, but this may be a general 
problem for most PPC platforms except for chrp and gemini, the NTP 
utility 'ntptime' always returns error code 5 (TIME_ERROR) even after 
that NTP status reaches the PLL and FLL state. Analysis of problem 
showed that the time_state variable set to TIME_ERROR by 
do_settimeofday() is never set back to TIME_OK.
I found the problem in 2.4.10-1 (Lynuxworks BlueCat) but I also checked 
the 2.6.11 and found similar problem. Many architectures under arch/ppc 
may be affected with the exception of chrp and gemini.

Steps to reproduce:
On a PowerPC (non-CHRP) platform, set the system date with 'date', 
configure and start the NTP daemon as client of a working NTP server. 
Wait for it to reach the PLL/FLL state. Issue the 'ntptime' command and 
check that the following two errors never disappear no matter how long 
you let it running: "ntp_gettime() returns code 5 (ERROR)", 
"ntp_adjtime() returns code 5 (ERROR)".

Detailed analysis:
AFAIK NTP relies on the global time_state variable which is statically 
initialized to TIME_OK (kernel/timer.c). The ntptime utility calls 
adjtimex() which results in a call to do_adjtimex() and prints its 
return value which is basically the value of time_state. It is changed 
by (kernel/timer.c)second_overflow() and by the 
(kernel/time.c)do_adjtimex() state machine.
These two functions never set time_state to TIME_OK once it has been set 
to TIME_ERROR.
Also, do_settimeofday() sets the STA_UNSYNC flag in time_status and sets 
time_state to TIME_ERROR (in ppc but not in ppc64 nor in x86).
The function (arch/ppc/kernel/time.c)timer_interrupt() calls the 
ppc_md.set_rtc_time() when certain conditions are met, as follows 
(time.c:171):

        if ( ppc_md.set_rtc_time && (time_status & STA_UNSYNC) == 0 &&
             xtime.tv_sec - last_rtc_update >= 659 &&
             abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
             jiffies - wall_jiffies == 1) {
              if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)

In the CHRP architecture (see arch/ppc/platforms/chrp_*) the specific 
implementation of the set_rtc_time(), chrp_set_rtc_time(), has a check 
like this (chrp_time.c:76):

        if ( (time_state == TIME_ERROR) || (time_state == TIME_BAD) )
                time_state = TIME_OK;

which is the only chance for the time_state to be set back to TIME_OK 
after a do_settimeofday(). In other platforms this is not done.


Proposed patch:
This change should make NTP to work on any ppc platform, while not 
breaking chrp and gemini. Although I've tested it only on mine.
--- linux-2.6.11/arch/ppc/kernel/time.c 2005-03-02 08:38:17.000000000 +0100
+++ linux/arch/ppc/kernel/time.c        2005-03-08 14:16:56.000000000 +0100
@@ -272,7 +272,6 @@

        time_adjust = 0;                /* stop active adjtime() */
        time_status |= STA_UNSYNC;
-       time_state = TIME_ERROR;        /* p. 24, (a) */
        time_maxerror = NTP_PHASE_LIMIT;
        time_esterror = NTP_PHASE_LIMIT;
        write_sequnlock_irqrestore(&xtime_lock, flags);


My question:
I've read some documentation but I am by no means an expert in the NTP 
kernel support implementation. So I ask you where the time_state should 
be reset to TIME_OK. Should this be done by the <platform>set_rtc_time() ?
Or, as in the x86 case, do_settimeofday should not set time_state to 
TIME_ERROR ?


Giovambattista Pulcini



