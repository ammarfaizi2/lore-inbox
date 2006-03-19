Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWCSUB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWCSUB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWCSUB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:01:59 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:25323
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750792AbWCSUB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:01:59 -0500
Message-Id: <20060319102009.817820000@localhost.localdomain>
Date: Sun, 19 Mar 2006 20:02:15 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [patch 0/2] sys_setitimer and sys_alarm hotfixes (take #2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The hrtimer merge breaks sys_alarm() with a timeout value > INT_MAX
due to a unsigned to signed conversion. Timeout values > INT_MAX are
legitimate usage of alarm(), so this has to be corrected.

Due to a missing validation check of the userspace itimer values non
canonical timespecs can be provided to the setitimer code. While the
pre 2.6.16 code converted negative timevals to a long timeout 
(depending on HZ) the hrtimer code treats them as expired. Also on
32 bit machines non normalized timevals might cause random behaviour
of the optimized ktime_t operations. Due to the historical behaviour
we can not suddenly return -EINVAL in such cases, but we have to
fixup the values to avoid random behaviour.

	tglx

--

