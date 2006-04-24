Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWDXXCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDXXCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWDXXCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:02:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:42189 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751144AbWDXXB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:01:59 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: herbert@13thfloor.at, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20060424150314.2de6373d.akpm@osdl.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	 <20060421110140.GC14841@MAIL.13thfloor.at>
	 <1145655097.15389.12.camel@linuxchandra>
	 <20060422005851.GA22917@MAIL.13thfloor.at>
	 <1145913967.1400.59.camel@linuxchandra>
	 <20060424150314.2de6373d.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 24 Apr 2006 16:01:57 -0700
Message-Id: <1145919717.1400.67.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 15:03 -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > Thanks for the steps. With that i was able to reproduce the problem and
> > i found the bug.
> > 
> > While i go ahead and generate the patch, i wanted to hear if my
> > conclusion is correct.
> > 
> > The problem is due to the fact that most notifier registrations
> > incorrectly use __devinitdata to define the callback structure, as in:
> > 
> > static struct notifier_block __devinitdata hrtimers_nb = {
> >         .notifier_call = hrtimer_cpu_notify,
> > };
> > 
> > devinitdata'd  data is not _expected to be available_ after the
> > initialization(unless CONFIG_HOTPLUG is defined).
> > 
> > I do not know how it was working until now :), anybody has a theory that
> > can explain it (or my conclusion is wrong) ?
> 
> That sounds right.  There are several __devinitdata notifier_blocks in the
> tree - please be sure to check them all.

Yes, I am covering all notifier blocks.

Another issue... many of the notifier callback functions are marked as
init calls (__cpuinit, __devinit etc.,) as in:

static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
                unsigned long action,
                void *hcpu)

I am generating a separate patch to take care of those too.
> 
> btw, it'd be pretty trivial to add runtime checking for this sort of thing:
> 
> int addr_in_init_section(void *addr)
> {
> 	return addr >= __init_begin && addr < __init_end;
> }

I will add this to kernel/sys.c, and put a BUG_ON to check for both the
notifier block and the callback function.

BTW, which header file you want me to export this through ? 
> 
> (x86-specific)
> (need to add __init_end to vmlinux.lds.S)

I see __init_end in arch/i386/kernel/vmlinux.lds.S.

> 
> then we could use that to check various things in various places...
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


