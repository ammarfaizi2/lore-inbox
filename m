Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVBJAVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVBJAVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVBJAVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:21:13 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:8836 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261981AbVBJAVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:21:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume [update]
Date: Thu, 10 Feb 2005 01:22:02 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <20050208110418.GA878@elte.hu> <200502091735.07834.rjw@sisk.pl>
In-Reply-To: <200502091735.07834.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502100122.03064.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 9 of February 2005 17:35, Rafael J. Wysocki wrote:
> On Tuesday, 8 of February 2005 12:04, Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > The warning is printed right after the image is restored (ie somewhere
> > > around the local_irq_enable() above, but it goes before the "PM: Image
> > > restored successfully." message that is printed as soon as the return
> > > is executed).  Definitely, less than 1 s passes between the resoring
> > > of the image and the warining.
> > > 
> > > BTW, I've also tried to put touch_softlockup_watchdog() before
> > > device_power_up(), but it didn't change much.
> > 
> > this is a single-CPU box, right?
> 
> Yes.
> 
> OK, I think I've sorted it out.  The solution is to use your patch and the
> following change against swsusp.c:

Well, I was to quick with this,  sorry.
 
> --- linux-2.6.11-rc3-mm1-orig/kernel/power/swsusp.c	2005-02-08 18:16:34.000000000 +0100
> +++ new/kernel/power/swsusp.c	2005-02-09 17:31:16.000000000 +0100
> @@ -870,7 +870,9 @@
>  	/* Restore control flow magically appears here */
>  	restore_processor_state();
>  	restore_highmem();
> +	touch_softlockup_watchdog();
>  	device_power_up();
> +	touch_softlockup_watchdog();
>  	local_irq_enable();
>  	return error;
>  }

The following patch (instead of the above) seems to work much better:

--- linux-2.6.11-rc3-mm1-orig/kernel/power/swsusp.c	2005-02-08 18:16:34.000000000 +0100
+++ new/kernel/power/swsusp.c	2005-02-10 00:45:45.000000000 +0100
@@ -870,6 +870,7 @@
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();
 	return error;
--- linux-2.6.11-rc3-mm1-orig/arch/x86_64/kernel/time.c	2005-02-05 20:49:26.000000000 +0100
+++ new/arch/x86_64/kernel/time.c	2005-02-10 00:46:48.000000000 +0100
@@ -988,6 +988,7 @@
 	write_sequnlock_irqrestore(&xtime_lock,flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
+	touch_softlockup_watchdog();
 	return 0;
 }
 
--- linux-2.6.11-rc3-mm1-orig/arch/i386/kernel/time.c	2005-02-05 20:49:26.000000000 +0100
+++ new/arch/i386/kernel/time.c	2005-02-10 00:47:03.000000000 +0100
@@ -378,6 +378,7 @@
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
+	touch_softlockup_watchdog();
 	return 0;
 }
 

I tested it only on x86-64, so the change for i386 is a guess, albeit
educated. ;-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
