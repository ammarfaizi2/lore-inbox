Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTDXIbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTDXIbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:31:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:27902 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261823AbTDXIbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:31:09 -0400
Message-Id: <200304240843.h3O8h4902765@owlet.beaverton.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2 
In-reply-to: Your message of "Wed, 23 Apr 2003 15:14:44 CDT."
             <200304231514.44451.habanero@us.ibm.com> 
Date: Thu, 24 Apr 2003 01:43:04 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Well on high load, you shouldn't have an idle cpu anyway, so you would never 
    pass the requirements for the agressive -idle- steal even if it was turned 
    on.   On low loads on HT, without this agressive balance on cpu bound tasks, 
    you will always load up one core before using any of the others.

For a brief period of time.   But with active_load_balance() being called
on the idle processors, they will steal from a core/sibling pair to give
themselves something to do in, I should think, relatively short order.

Myself, I'm getting odd results on kernbench (kernel compiles).  On a
4-proc + 4-sibling HT machine, I'm seeing:

            2.5.68    HW HT on, regular scheduler
        2.5.68-ht2    HW HT on, A9 hyperthreading scheduler siblings=2

The HT scheduler seems to give us wins in every category but elapsed time.
This was *with* the aggressive steal, so I've a bit more testing to try
without it, collecting more information to identify why elapsed time is
not dropping too.

Rick

make -j2
                       User     System    Elapsed   %CPU
            2.5.68    471.19     34.14     263.25   191%
        2.5.68-ht2    335.54     24.46     257.86   139%

make -j4
                       User     System    Elapsed   %CPU
            2.5.68    581.93     40.37     164.36   378%
        2.5.68-ht2    421.77     28.64     165.06   272%

make -j8
                       User     System    Elapsed   %CPU
            2.5.68    946.24     60.05     138.13   728%
        2.5.68-ht2    685.05     43.38     138.59   525%

make -j16
                       User     System    Elapsed   %CPU
            2.5.68    954.35     61.12     139.17   729%
        2.5.68-ht2    690.11     43.91     138.52   529%

