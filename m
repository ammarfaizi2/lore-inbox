Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVALS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVALS43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVALSyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:54:53 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:27096 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261280AbVALSvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:51:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Date: Wed, 12 Jan 2005 19:51:47 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
References: <20050106002240.00ac4611.akpm@osdl.org> <200501081610.57625.rjw@sisk.pl> <20050108154439.GA24771@elf.ucw.cz>
In-Reply-To: <20050108154439.GA24771@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200501121951.48102.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H,

On Saturday, 8 of January 2005 16:44, Pavel Machek wrote:
[-- snip --]
> > > > The regression is caused by the timer driver.  Obviously, turning 
> > > > timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go
> > > > away. 
[-- snip --]
> > > 
> > > ..you might want to look at i386 time code, they have common
> > > ancestor, and i386 one seems to work.

Well, I've changed timer_resume() in arch/x86_64/kernel/time.c into the 
following function:

static int timer_resume(struct sys_device *dev)
{
	unsigned long flags;
	unsigned long sec;
	unsigned long ctime = get_cmos_time();
	long sleep_length = (ctime - sleep_start) * HZ;

	if (vxtime.hpet_address)
		hpet_reenable();

	sec = ctime + clock_cmos_diff;
	write_seqlock_irqsave(&xtime_lock,flags);
	xtime.tv_sec = sec;
	xtime.tv_nsec = 0;
	write_sequnlock_irqrestore(&xtime_lock,flags);
	printk ("jiffies = %lu, sleep_length = %ld\n", jiffies, sleep_length);
	return 0;
}

and that's what I get from the log:

Jan 12 19:43:42 albercik kernel: jiffies = 4294847120, sleep_length = 
-3189288131000

(for example - the second number is always negative and huge).  Would it mean 
that get_cmos_time() needs fixing?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
