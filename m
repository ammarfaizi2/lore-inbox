Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVGMBWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVGMBWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVGMBTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:19:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38055 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262612AbVGMBSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:18:53 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050704111648.GA11073@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de>
	 <200506301952.22022.annabellesgarden@yahoo.de>
	 <20050630205029.GB1824@elte.hu>
	 <200507010027.33079.annabellesgarden@yahoo.de>
	 <20050701071850.GA18926@elte.hu>
	 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
	 <1120269723.12256.11.camel@mindpipe>
	 <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org>
	 <20050704111648.GA11073@elte.hu>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 21:18:51 -0400
Message-Id: <1121217531.26266.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-04 at 13:16 +0200, Ingo Molnar wrote:
> i'd first suggest to try the latest kernel, before changing your X 
> config - i think the bug might have been fixed meanwhile.

I have found that heavy network traffic really kills the interactive
performance.  In the top excerpt below, gtk-gnutella is generating about
320KB/sec of traffic.

These priorities do not look right:

   14 root     -50  -5     0    0 S  0.0  0.0   0:00.00    0    0    0    0 [IRQ 9]                                        irqd     
  686 root     -49  -5     0    0 S  0.0  0.0  87:58.18    0    0    0    0 [IRQ 8]                                        irqd     
  689 root     -48  -5     0    0 S  0.0  0.0   0:00.00    0    0    0    0 [IRQ 7]                                        irqd     
  694 root     -47  -5     0    0 S  0.0  0.0   0:00.00    0    0    0    0 [IRQ 12]                                       irqd     
  714 root     -46  -5     0    0 S  2.5  0.0   5:25.33    0    0    0    0 [IRQ 15]                                       irqd     
  731 root     -45  -5     0    0 S  0.0  0.0   0:04.74    0    0    0    0 [IRQ 1]                                        irqd     
    3 root     -44 -10     0    0 S  0.0  0.0   1:42.55    0    0    0    0 [softirq-timer/0]                              ksoftirqd
    5 root     -44 -10     0    0 S  2.5  0.0   5:06.49    0    0    0    0 [softirq-net-rx/]                              ksoftirqd
 1541 root     -44  -5     0    0 S  0.0  0.0   9:39.03    0    0    0    0 [IRQ 10]                                       irqd     
 5650 rlrevell -44   0  2804 1616 S 14.8  0.4   5:52.83 1188   52  784    1 /usr/lib/gamin/gam_server                      stext    
30313 rlrevell -44   0 24572  19m S 99.9  4.4  68:15.42 4520 1800  12m   31 gtk-gnutella                                   stext    
 2285 root     -43  -5     0    0 S  0.0  0.0   3:47.34    0    0    0    0 [IRQ 11]                                       irqd     
 2807 root     -42  -5     0    0 S  0.0  0.0   0:00.00    0    0    0    0 [IRQ 14]                                       irqd     
    9 root      -2  -5     0    0 S  0.0  0.0   0:16.05    0    0    0    0 [events/0]                                     worker_th
    4 root       5 -10     0    0 S  0.0  0.0   0:25.95    0    0    0    0 [softirq-net-tx/]                              ksoftirqd
    7 root       5 -10     0    0 S  0.0  0.0   0:01.22    0    0    0    0 [softirq-tasklet]                              ksoftirqd
    8 root       5 -10     0    0 S  0.0  0.0   0:01.30    0    0    0    0 [desched/0]                                    desched_t
28988 root       5 -10  106m  30m S  4.9  6.9 242:59.04  76m 1556  32m    3 /usr/X11R6/bin/X :0 -audit 0 -auth /var/lib/gd stext    
    2 root      10 -10     0    0 S  0.0  0.0   0:00.00    0    0    0    0 [softirq-high/0]                               ksoftirqd
    6 root      10 -10     0    0 S  0.0  0.0   0:00.00    0    0    0    0 [softirq-scsi/0]

Why do gtk-gnutella and gam_server get a higher priority than the disk
(14) and network (11) IRQs?  And shouldn't the softirq threads run at
lower priority than all the hardirq threads?

Looking at the top output I'd expect the machine to be crawling, and
that's what it does.

Lee

