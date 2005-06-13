Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVFMRS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVFMRS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVFMRS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:18:56 -0400
Received: from [62.138.14.87] ([62.138.14.87]:10256 "EHLO mail.hk30.de")
	by vger.kernel.org with ESMTP id S261398AbVFMRSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:18:51 -0400
Message-ID: <39833.212.114.70.5.1118683110.squirrel@62.138.14.87>
Date: Mon, 13 Jun 2005 19:18:30 +0200 (CEST)
From: "Hans Korneder" <hans@korneder.de>
To: linux-kernel@vger.kernel.org
Reply-To: hans@korneder.de
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: hans@korneder.de
Subject: alarms do not get fired when booting thru pxelinux
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.0 (built Tue, 27 Jul 2004 15:39:04 +0200)
X-SA-Exim-Scanned: Yes (on mail.hk30.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just stumbled over a strange behaviour of 2.6-Kernels when being bootet
thru pxelinux: alarms do not occur.

Example:
/* ------------------------------------------------------- */
#include <stdio.h>
#include <signal.h>

void catch_sig(int sig_num)
{
fprintf(stderr,"catch_sig %d\n", sig_num);
(void)signal(sig_num, catch_sig);
}

main()
{

catch_sig(SIGALRM);

alarm(3);
pause();
exit(0);
}
/* ---------------------------------------------- */

The program sleeps endlessly in pause().

The problem occurs with kernel 2.6.11, 2.6.11.4, 2.6.11.11
when being booted thru pxelinux (tested with 3.08 and 2.11) only,
that is the program behaves as intended when exactly the same kernel
is booted with lilo or grub.
The problem did not occur on 2.4-kernels (the latest running version I
tested was 2.4.25).
The same problem happens when using setitimer() as within the following
example:
/* ---------------------------------------------- */
#include <stdio.h>
#include <signal.h>
#include <sys/time.h>

void catch_sig(int sig_num)
{
fprintf(stderr,"catch_sig %d\n", sig_num);
(void)signal(sig_num, catch_sig);
}

main()
{
int res;
struct itimerval itimer;

catch_sig(SIGALRM);

itimer.it_value.tv_sec = 0;
itimer.it_value.tv_usec = 200*1000;

itimer.it_interval.tv_sec = 0;
itimer.it_interval.tv_usec = 300*1000;

res = setitimer(ITIMER_REAL, &itimer, (struct itimerval *)0);
fprintf(stderr,"setitimer: res=%d\n", res);

for(;;)  pause() ;
}
/* ---------------------------------------------- */

Any ideas?
Any ideas for tracking down the problem?

Regards,
Hans


-- 
Hans Korneder         hans (at) korneder (dot) de

