Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWGJL2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWGJL2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGJL2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:28:21 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:43788 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1751387AbWGJL2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:28:21 -0400
Date: Mon, 10 Jul 2006 13:28:10 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.17.4] slabinfo.buffer_head increases
Message-ID: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am obsering a steadily increasing buffer_head value in slabinfo under 
2.6.17.4. I searched the net / archives and didn't find anything 
directly relevant. Does anyone have an idea or how shall we debug it?

I first noticed this "feature" on a 2.6.17-rc5 based ARM-system, where if 
I stop some user-space applications, the number stop increasing.

I was also able to reproduce it on a SuSE-9.0 system, where I wasn't able 
to stop this growth even as I stopped all possible services. Then the 
process list looked like this:

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:00 init [5]  
    2 ?        SWN    0:00 [ksoftirqd/0]
    3 ?        SW     0:00 [watchdog/0]
    4 ?        SW<    0:00 [events/0]
    5 ?        SW<    0:00 [khelper]
    6 ?        SW<    0:00 [kthread]
    8 ?        SW<    0:00 [kblockd/0]
    9 ?        SW<    0:00 [kacpid]
   82 ?        SW<    0:00 [kseriod]
  108 ?        SW     0:00 [pdflush]
  109 ?        SW     0:00 [pdflush]
  110 ?        SW     0:00 [kswapd0]
  111 ?        SW<    0:00 [aio/0]
  721 ?        SW<    0:00 [kpsmoused]
  726 ?        SW<    0:00 [reiserfs/0]
 1560 ?        SW     0:00 [khpsbpkt]
 4015 ?        S      0:00 login -- gl     
 4016 tty3     S      0:00 /sbin/mingetty tty3
 4017 tty4     S      0:00 /sbin/mingetty tty4
 4018 tty5     S      0:00 /sbin/mingetty tty5
 4019 tty6     S      0:00 /sbin/mingetty tty6
 4480 ?        S      0:00 login -- root     
 5051 tty1     R      0:00 -bash
 5330 tty2     S      0:00 -bash
 5601 tty2     S      0:00 sleep 5
 5602 tty1     R      0:00 ps ax

the "sleep 5" comes from the script:

while true; do grep buffer_head /proc/slabinfo; sleep 5; done

Does it look like a memory leak? Here's a fragment of the output:

buffer_head         8110   8112     48   78    1 : tunables  120   60    0 : slabdata    104    104      0
buffer_head         8148   8190     48   78    1 : tunables  120   60    0 : slabdata    105    105      0
buffer_head         8144   8190     48   78    1 : tunables  120   60    0 : slabdata    105    105      0
buffer_head         8166   8190     48   78    1 : tunables  120   60    0 : slabdata    105    105      0
buffer_head         8181   8190     48   78    1 : tunables  120   60    0 : slabdata    105    105      0
buffer_head         8189   8190     48   78    1 : tunables  120   60    0 : slabdata    105    105      0
buffer_head         8226   8268     48   78    1 : tunables  120   60    0 : slabdata    106    106      0
buffer_head         8244   8268     48   78    1 : tunables  120   60    0 : slabdata    106    106      0
buffer_head         8240   8268     48   78    1 : tunables  120   60    0 : slabdata    106    106      0
buffer_head         8260   8268     48   78    1 : tunables  120   60    0 : slabdata    106    106      0
buffer_head         8304   8346     48   78    1 : tunables  120   60    0 : slabdata    107    107      0
buffer_head         8340   8346     48   78    1 : tunables  120   60    0 : slabdata    107    107      0
buffer_head         8332   8346     48   78    1 : tunables  120   60    0 : slabdata    107    107      0
buffer_head         8343   8346     48   78    1 : tunables  120   60    0 : slabdata    107    107      0

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
