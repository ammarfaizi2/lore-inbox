Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTHUQLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbTHUQLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:11:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31939 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262784AbTHUQKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:10:33 -0400
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <200308211056.29876.habanero@us.ibm.com>
References: <200308201658.05433.habanero@us.ibm.com>
	 <200308210910.07722.habanero@us.ibm.com>
	 <1061477929.18883.1633.camel@nighthawk>
	 <200308211056.29876.habanero@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061482159.19036.1716.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Aug 2003 09:09:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 08:56, Andrew Theurer wrote:
> On Thursday 21 August 2003 09:58, Dave Hansen wrote:
> > On Thu, 2003-08-21 at 07:10, Andrew Theurer wrote:
> > > So we only loop for the actual number processors found in mpparse.c? 
> > > This seems to work for me.
> >
> > I think there's a reason it was done that way.  I think your patch
> > breaks the visws subarch, too.
> >
> > Could you mark up that loop a bit and printk a bit, so we can see which
> > continue you're missing?
> >
> > <pasting patch lazily in email because I can't be bothered to actually copy
> > it from the machine I"m working on> diff -urp
> > linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c
> > linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c ---
> > linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c  Wed Aug 20 19:54:29
> > 2003 +++ linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c   Wed Aug 20
> > 20:19:41 2003 @@ -1020,24 +1020,30 @@ static void __init
> > smp_boot_cpus(unsigne
> >         Dprintk("CPU present map: %lx\n",
> > physids_coerce(phys_cpu_present_map));
> >
> >         kicked = 1;
> > -       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
> > +       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++, kicked++)
> 
> This patch (plus your first one) seems to work.  Perhaps the addition of 
> kicked++ above helped?  Attached is the boot log.

I missed that.  But, it's incorrect.  You're doubly incrementing kicked
in the case of CPUs that are booted correctly and getting to kicked >=
NR_CPUS a lot quicker.  That's why you're booting correctly.

Secondly, we can actually boot up to NR_CPUS cpus, and we can *fail* to
boot a lot more than that.  At least that's what the code is trying to
do.  Whether it is "the right thing" is debatable.

-- 
Dave Hansen
haveblue@us.ibm.com

