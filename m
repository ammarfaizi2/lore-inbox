Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbULCRrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbULCRrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbULCRrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:47:35 -0500
Received: from www1.cdi.cz ([194.213.194.49]:59019 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S262445AbULCRrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:47:10 -0500
Date: Fri, 3 Dec 2004 18:46:52 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <piggin@cyberone.com.au>
Subject: Re: sched isolcpus=1 related OOPS in 2.6.9
In-Reply-To: <41B09FFD.6070706@osdl.org>
Message-ID: <Pine.LNX.4.33.0412031839270.493-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, I have more info. I setup bochs smp emulator and hacked
> > printk to output into e9 port which is then directed to a file.
> > Also I turned sched_domains debugging. From the result (below)
> > is clear that there is bug in isolated domains setup.
>
> You are correct, of course.  If "isolcpus" is used, the isolated
> cpu(s) (in <cpu_isolated_map>) are not init like the remaining
> cpus are.

The problem seems worse to me. See:
Brought up 2 CPUs
<7>CPU0:  online
<7> domain 0: span 3
<7>  groups: 1[128] 2[0]
<7>ERROR groups don't span domain->span
<7>CPU1:  online
<7> domain 0: span 2
<7>ERROR domain->cpu_power not set
<7>  groups: 2[0]
<1>divide error: 0000 [#1]

I added code which dumps cpu_power for each group (in brackets)
and it seems that only for the first group the power is computed
(even for regular non isolated domain).
Also the span for cpu0 should be 1 (it can be fixed by:
  sd->span = cpu_possible_map; => sd->span = cpu_default_map;
at line 4484).
Even then the group list is still bad. I'll dig more into it...

devik

