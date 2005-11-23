Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVKWNRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKWNRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKWNRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:17:47 -0500
Received: from canardo.mork.no ([148.122.252.1]:56201 "EHLO canardo.mork.no")
	by vger.kernel.org with ESMTP id S1750788AbVKWNRq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:17:46 -0500
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Organization: DoD
References: <87zmoa0yv5.fsf@obelix.mork.no>
	<200511220026.55589.dtor_core@ameritech.net>
	<20051122184739.GB1748@elf.ucw.cz> <200511222315.31033.rjw@sisk.pl>
	<20051122225120.GI1748@elf.ucw.cz> <87hda3d6b8.fsf@obelix.mork.no>
	<20051123120142.GA18403@elf.ucw.cz>
Date: Wed, 23 Nov 2005 14:14:41 +0100
In-Reply-To: <20051123120142.GA18403@elf.ucw.cz> (Pavel Machek's message of
	"Wed, 23 Nov 2005 13:01:42 +0100")
Message-ID: <87veyjbj5q.fsf@obelix.mork.no>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> I don't think so.  The example said
>> 
>>  "Strange, kseriod not stopped"
>> 
>> This names a process that admittedly took a long time to stop, but not
>> the real *cause* of the failure.  There was nothing wrong with kseriod.
>> 
>> FWIW, debugging this was way out of my league.  I might have had a
>> better chance if it mentioned a short, fixed timeout.  I also noticed
>> that it wasn't very obvious to you either at first.  The first thought
>> was a failing serio driver, although that admittedly might be because
>> I mislead you in my attempt to pinpoint the failure.
>
> Ok, can you suggest better wording?

maybe something like 

--- linux-2.6.15-rc1/kernel/power/process.c.orig	2005-11-18 10:15:12.000000000 +0100
+++ linux-2.6.15-rc1/kernel/power/process.c	2005-11-23 13:38:41.000000000 +0100
@@ -83,7 +83,7 @@
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			printk(KERN_ERR " stopping tasks timed out after %d seconds (%d tasks remaining)\n", TIMEOUT/HZ, todo );
 			break;
 		}
 	} while(todo);


?

Or basically any text that makes it clear that we didn't really try
that hard to stop the task.  We just gave up early.

I thought about adding /sys/power/timeout too, but realised that it is
way overkill for this.  Ideally, the default should never need to be
changed by anynoe.

I'd really prefer Dmitry's approach with an indefinite timeout on
resume, but I also understand your wish to avoid letting this code
know whether it's suspending or resuming.  No, I don't know how to
satisfy both of those requirements either.  Increasing the default
TIMEOUT to a pretty-sure-to-never-be-reached value is probably an
acceptable workaround.



Bjørn
