Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWCXBYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWCXBYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWCXBYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:24:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:52890 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932636AbWCXBYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:24:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-mm1
Date: Fri, 24 Mar 2006 02:23:15 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
References: <20060323014046.2ca1d9df.akpm@osdl.org> <200603240204.43294.rjw@sisk.pl> <1143162763.2299.50.camel@leatherman>
In-Reply-To: <1143162763.2299.50.camel@leatherman>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240223.16547.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 02:12, john stultz wrote:
> On Fri, 2006-03-24 at 02:04 +0100, Rafael J. Wysocki wrote:
> > On Friday 24 March 2006 01:49, john stultz wrote:
> > > On Thu, 2006-03-23 at 16:04 -0800, Andrew Morton wrote:
> > > > "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
> > > > >
> > > > > On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > > > > > 
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> > > > > 
> > > > > On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> > > > > just fine, .config attached):
> > > > 
> > > > hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.
> > > > 
> > > > > }-- snip --{
> > > > > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > > > > time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> > > > > time.c: Detected 1795.400 MHz processor.
> > > > > disabling early console
> > > > > Console: colour dummy device 80x25
> > > > > time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
> > > > > last cli 0x0
> > > > > last cli caller 0x0
> > > > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > > > > last cli 0x0
> > > > > last cli caller 0x0
> > > > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > > 
> > > It seems report_lost_ticks has been set to one w/ 2.6.16-mm1, thus these
> > > debug messages will be shown.
> > > 
> > > Rafael: To properly compare, could you boot 2.6.16-rc6-mm2 w/ the
> > > "report_lost_ticks" boot option and see if the same sort of messages do
> > > not appear?
> > 
> > It looks similar but not the same:
> 
> Yea, I think thats due to some new code from Andi.
> 
> The lost tick issue should be looked into (might be hardware SMIs), but
> it seems this is not caused by my patches.

You are right.  All of this is caused by report_lost_ticks set to 1.
The appended patch helps.

Thanks,
Rafael

---
 arch/x86_64/kernel/time.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-mm1/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.16-mm1.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.16-mm1/arch/x86_64/kernel/time.c
@@ -63,7 +63,7 @@ static unsigned long hpet_period;			/* f
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
 unsigned long vxtime_hz = PIT_TICK_RATE;
-int report_lost_ticks = 1;			/* command line option */
+int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
 
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */

