Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKGShk>; Thu, 7 Nov 2002 13:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSKGShk>; Thu, 7 Nov 2002 13:37:40 -0500
Received: from [202.88.171.30] ([202.88.171.30]:19631 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S261411AbSKGShk>;
	Thu, 7 Nov 2002 13:37:40 -0500
Date: Fri, 8 Nov 2002 00:11:11 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
Message-ID: <20021108001111.A23292@dikhow>
Reply-To: dipankar@gamebox.net
References: <3DC9719B.AC139E50@digeo.com> <121150000.1036615519@flay> <3DC975DC.77231191@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC975DC.77231191@digeo.com>; from akpm@digeo.com on Wed, Nov 06, 2002 at 12:04:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 12:04:44PM -0800, Andrew Morton wrote:
> > >
> > > The softirq storage is initialised inside the CPU_UP_PREPARE call.
> > > So we're ready for interrupts on that CPU when your architecture's
> > > __cpu_up() is called.  And no sooner than this.
> > 
> > All interrupts, or just softints?
> > 
> 
> I don't know.  This sequencing really needs to be thought about
> and written down, else we'll just have an ongoing fiasco trying
> to graft stuff onto it.
> 
> In this case I'd say "all interrupts".  The secondary really
> should be 100% dormant until all CPU_UP_PREPARE callouts have
> been run and have returned NOTIFY_OK.

Well, the secondaries atleast cannot take the local timer interrupt
since things hooked off it, like timers and RCU, are initiliazed
using CPU_UP_PREPARE callouts. I would agree that it is unsafe to
allow *any* interrupt until CPU_UP_PREPARE callouts are completed.

So, the current way of enabling interrupts in secondaries during
delay calibration is unsafe. For that matter, it seems to me
that with no proper mixed CPU support, calibrate_delay() for
secondaries is meaningless.

Thanks
Dipankar
