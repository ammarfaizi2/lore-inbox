Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSJYBV3>; Thu, 24 Oct 2002 21:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265738AbSJYBV3>; Thu, 24 Oct 2002 21:21:29 -0400
Received: from adsl-64-160-137-6.dsl.lsan03.pacbell.net ([64.160.137.6]:25102
	"EHLO gate.debonne.net") by vger.kernel.org with ESMTP
	id <S265736AbSJYBV1>; Thu, 24 Oct 2002 21:21:27 -0400
Date: Thu, 24 Oct 2002 18:29:26 -0700 (PDT)
From: <kernelnewbie@gate.debonne.net>
To: <linux-kernel@vger.kernel.org>
Subject: Passing info from the top-half ISR to the bottom-half
Message-ID: <Pine.LNX.4.33.0210241827460.24173-100000@gate.debonne.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ISR is split into top-half and bottom-half processing. The bottom-half
is implemented as a tasklet (I'm using Kernel 2.4). The top-half knows
which physical device (minor number) caused the interrupt and that info
has to be passed to the tasklet somehow.

The DECLARE_TASKLET macro provides an unsigned long data argument, but it
appears that that argument must be constant. Rubini's book says it's fine
to pass a pointer via this data argument, and I'd like to pass the pointer
to my device control block, but since the argument must be a constant, the
best I can do is pass a pointer to a global which points to my DCB. But
this won't work because another device's interrupt will overwrite it.

Do I have to make a separate DECLARE_TASKLET for each physical device like
the following:

Declarations:

dev_t g_dev[4];

DECLARE_TASKLET (tasklet0, do_tasklet, (unsigned long) &g_dev[0]);
DECLARE_TASKLET (tasklet1, do_tasklet, (unsigned long) &g_dev[1]);
DECLARE_TASKLET (tasklet2, do_tasklet, (unsigned long) &g_dev[2]);
DECLARE_TASKLET (tasklet3, do_tasklet, (unsigned long) &g_dev[3]);

Top Half:
	...
        switch (minor) {
        case 0:
                tasklet_schedule(&tasklet0);
                break;
        case 1:
                tasklet_schedule(&tasklet1);
                break;
        case 2:
                tasklet_schedule(&tasklet2);
                break;
        case 3:
                tasklet_schedule(&tasklet3);
                break;
        }
	...

Tasklet:
        dev_t *dev = (dev_t*) arg;
	...

That seems kinda kludgy, but it's the only solution I can think of.


