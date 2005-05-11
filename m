Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVEKF4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVEKF4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 01:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVEKF4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 01:56:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62891 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261899AbVEKF4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 01:56:02 -0400
Date: Wed, 11 May 2005 01:55:40 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jack F Vogel <jfv@bluesong.net>, Andi Kleen <ak@muc.de>,
       notting@redhat.com
Subject: Re: [PATCH] check nmi watchdog is broken
Message-ID: <20050511055540.GA27052@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jack F Vogel <jfv@bluesong.net>, Andi Kleen <ak@muc.de>,
	notting@redhat.com
References: <200505011704.j41H4SUQ021132@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505011704.j41H4SUQ021132@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 10:04:28AM -0700, Linux Kernel wrote:
 > tree 6adb8d33585f8eee20794827c79e40991aeeaee5
 > parent fd51f666fa591294bd7462447512666e61c56ea0
 > author Jack F Vogel <jfv@bluesong.net> Sun, 01 May 2005 22:58:48 -0700
 > committer Linus Torvalds <torvalds@ppc970.osdl.org> Sun, 01 May 2005 22:58:48 -0700
 > 
 > [PATCH] check nmi watchdog is broken
 > 
 > A bug against an xSeries system showed up recently noting that the
 > check_nmi_watchdog() test was failing.
 > 
 > I have been investigating it and discovered in both i386 and x86_64 the
 > recent change to the routine to use the cpu_callin_map has uncovered a
 > problem.  Prior to that change, on an SMP box, the test was trivally
 > passing because all cpu's were found to not yet be online, but now with the
 > callin_map they are discovered, it goes on to test the counter and they
 > have not yet begun to increment, so it announces a CPU is stuck and bails
 > out.
 > 
 > On all the systems I have access to test, the announcement of failure is
 > also bougs...  by the time you can login and check /proc/interrupts, the
 > NMI count is happily incrementing on all CPUs.  Its just that the test is
 > being done too early.
 > 
 > I have tried moving the call to the test around a bit, and it was always
 > too early.  I finally hit on this proposed solution, it delays the routine
 > via a late_initcall(), seems like the right solution to me.

My EM64T Dell Precision 470 seems to have problems both before
and after this change, though the behaviour changes.

With -rc3..
testing NMI watchdog ... CPU#1: NMI appears to be stuck (0)!

With -rc4...
Testing NMI watchdog ... CPU#4: NMI appears to be stuck (0)!

The CPU #'s are consistent across reboots (Ie, they're always the same).
Though the rc4 behaviour seems odd, as my CPUs are numbered 0-3.

Bill (Cc'd) also reports that with -rc4, he sees around
a 10 second delay when it does that 'Testing NMI watchdog'
message.

		Dave

