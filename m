Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUHBV22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUHBV22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUHBV22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:28:28 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:18818 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S263733AbUHBV2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:28:25 -0400
Message-ID: <410EB30F.3060001@am.sony.com>
Date: Mon, 02 Aug 2004 14:33:03 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Initial bits to help pull jiffies out of drivers
References: <20040727195939.GA20712@devserv.devel.redhat.com>
In-Reply-To: <20040727195939.GA20712@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This is really for comment, the basic idea is to add some relative
> timer functionality. This gives us timeout objects as well as pulling
> jiffies use into one place in the timer code.

This is very welcome.  Here are some random thoughts:

It looks like there are a few "jiffy-usage" idioms that this patch
deals with:
  1. use of jiffies for timing debug output, in a printk
  2. checking to see if a time period has elapsed or not
  3. conversion from absolute time units to relative time units
  4. conversion from polled timeout to sleep (msleep)

Your solution to 1) is to just remove the printk output:
 > -		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
 > +		printk("serdatr = %d ...", lsr);

I have some code that allows one to configure the kernel so every
printk includes timing data (based on sched_clock().  I trim to
microsecond resolution on x86).

Would it be worth adding a feature like this to compensate
for removing the debug timing information?

Alternatively, I could cook up a macro using sched_clock() to provide
a substitute value to use to print timing info, in cases where it
was desirable to preserve it.

----
I noticed that some comments in the original code
are wrong based on an assumed value for HZ:

-static void moxadelay(int tick)
-{
-	unsigned long st, et;
-
-	st = jiffies;
-	et = st + tick;
-	while (time_before(jiffies, et));
-}
...
 > -				moxadelay(1);	/* delay 10 ms */
 > +				msleep(10);	/* delay 10 ms */

So reworking the code may give a nice comment cleanup, or possibly
clean up the code to actually delay the amount intended.
This is a nice side effect of this work.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
