Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbUKXRzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUKXRzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUKXRxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:53:37 -0500
Received: from fsmlabs.com ([168.103.115.128]:13213 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262812AbUKXRwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:52:49 -0500
Date: Wed, 24 Nov 2004 09:42:16 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
In-Reply-To: <1101296166.5805.279.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411240931470.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
 <1101296166.5805.279.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Nigel Cunningham wrote:

> + * SMP support:
> + * All SMP processors enter this routine during suspend. The one through
> + * which the suspend is initiated (which, for simplicity, is always CPU 0)
> + * sends the others here using an IPI during do_suspend2_suspend_1. They
> + * remain here until after the atomic copy of the kernel is made, to ensure
> + * that they don't mess with memory in the meantime (even just idling will
> + * do that). Once the atomic copy is made, they are free to carry on idling.
> + * Note that we must let them go, because if we're using compression, the
> + * vfree calls in the compressors will result in IPIs being called and hanging
> + * because the CPUs are still here.
> + *
> + * At resume time, we do a similar thing. CPU 0 sends the others in here using
> + * an IPI. It then copies the original kernel back, restores its own processor
> + * context and flushes local tlbs before freeing the others to do the same.
> + * They can then go back to idling while CPU 0 reloads pageset 2, cleans up
> + * and unfreezes the processes.
> + *
> + * (Remember that freezing and thawing processes also uses IPIs, as may
> + * decompressing the data. Again, therefore, we cannot leave the other processors
> + * in here).
> + * 
> + * At the moment, we do nothing about APICs, even though the code is there.

Ok,
	Do you see anything missing (from an implementation point of view) 
for the following?

Suspend:
	1) suspend all cpus, save cpu0
	2) proceed with state saving on cpu0 only
	3) begin suspend
	
Resume:
	1) begin resume
	2) offline all currently online cpus
	3) proceed with state restoring
	4) online all previously online cpus

A lot of the subsystems which have work split across cpus will now have 
work migrated across to cpu0, in that regard, which have you made swsusp 
savvy? It looks like the timer changes might need looking at any others?

Thanks,
	Zwane
