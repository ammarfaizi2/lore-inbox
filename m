Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTEKS23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTEKS23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:28:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26959 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261844AbTEKS2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:28:25 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4 (machine_power_off returning causes problems)
References: <8570000.1052623548@[10.10.2.4]>
	<20030510224421.3347ea78.akpm@digeo.com>
	<8880000.1052624174@[10.10.2.4]>
	<20030510231120.580243be.akpm@digeo.com>
	<12530000.1052664451@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 12:37:48 -0600
In-Reply-To: <12530000.1052664451@[10.10.2.4]>
Message-ID: <m17k8x72ir.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> >> Sorry if this is old news, haven't been paying attention for a week.
> >> >>  Bug on shutdown (just after it says "Power Down") from 68-mm4.
> >> >>  (the NUMA-Q).
> >> > 
> >> > Random guess: is it related to CONFIG_KEXEC?
> >> 
> >> Don't think so - I don't have that enabled. Config file is attatched.
> > 
> > It doesn't matter - the kexec patch tends to futz with stuff like that
> > regardless of CONFIG_KEXEC.
> > 
> > It doesn't happen here.  Could you please retest without the kexec
> > patch applied?
> 
> Yup, backing out kexec fixes it.


Ok.  Thinking it through the differences is that I have machine_power_off
call stop_apics (which is roughly equivalent to the old smp_send_stop).

In the kexec patch that does 2 things.
1) It shuts down the secondary cpus, and returns the bootstrap cpu to
   virtual wire mode. 
2) It calls set_cpus_allowed to force the reboot to be on the primary
   cpu.

After returning from machine_power_off. We run into a problem
in flush_tlb_mm.  Because we have a cpu disabled, that is still part
of the mm's vm mask.

Does anyone know why machine_halt, and machine_power_off return?

If not I am just going to disable the return path.

Eric
