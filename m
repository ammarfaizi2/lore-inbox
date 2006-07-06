Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWGFBsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWGFBsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWGFBsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:48:41 -0400
Received: from xenotime.net ([66.160.160.81]:23703 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964941AbWGFBsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:48:41 -0400
Date: Wed, 5 Jul 2006 18:51:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Thomas Tuttle" <thinkinginbinary+lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Create new LED trigger for CPU activity (ledtrig-cpu)
Message-Id: <20060705185125.398cb5bc.rdunlap@xenotime.net>
In-Reply-To: <e4cb19870607051824n6392fb2awf042bd754d0e09d8@mail.gmail.com>
References: <e4cb19870607051824n6392fb2awf042bd754d0e09d8@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 21:24:17 -0400 Thomas Tuttle wrote:

> Here is a patch I wrote that creates a new LED trigger for CPU
> activity.  It creates a new config option, CONFIG_LEDS_TRIGGER_CPU, as
> well as four suboptions to select the combination of user, nice,
> system, and iowait that should turn the LED on.

What "the LED" does it turn on/off?
I'm curious how I can use it.

> It's loosely based on the ledtrig-ide-disk plugin, but only for
> general guidance.  It doesn't modify anything in the CPU scheduling
> code, for better or for worse; it is less efficient, because it checks
> the CPU time every 5ms instead of "knowing" when the CPU is idle or
> active, but it doesn't require changes to any other code, and is much
> less hairy for not digging into the scheduling stuff.  (It's also more
> flexible, because it can deal with user/nice/system/iowait time
> without much effort.)
> 
> The same disclaimers from my last email (the asus_acpi LED support
> one) apply--I haven't written much kernel code; this is diffed against
> 2.6.17.1, not .3, but I don't think anything has changed; I've tested
> it, but no guarantees it's perfect; and I apologize for the MIME type
> of text/x-patch, but it should work.

It may not matter, but generally you should diff against the latest
linus-mainline kernel, e.g., 2.6.7-git25 or Linus's git tree.

> Constructive comments would be greatly appreciated.

The attachment makes it difficult to review/comment.  Apparently
gmail munges inline patches so that's not an option (from what I
have read here on lkml).

Oh, where is the LED IDE patch?

Patch comments:  all seem to be for style etc.

+#define UPDATE_INTERVAL (5) // ms

Don't use // style comments, use /* ... */.

+static cputime64_t cpu_usage(void) {

Function { and } should be on separate lines.

+	for_each_possible_cpu(i) {
+		user = cputime64_add(user, kstat_cpu(i).cpustat.user);
+		nice = cputime64_add(nice, kstat_cpu(i).cpustat.nice);
+		system = cputime64_add(system, kstat_cpu(i).cpustat.system);
+		idle = cputime64_add(idle, kstat_cpu(i).cpustat.idle);
+		iowait = cputime64_add(iowait, kstat_cpu(i).cpustat.iowait);
+	}

We don't like ifdefs in C code very much, but since there are some
below here, why not here also?

+	if (used_cputime > 0) {
+		led_trigger_event(ledtrig_cpu, LED_FULL);
+	} else {
+		led_trigger_event(ledtrig_cpu, LED_OFF);
+	}

No braces for 1-statement "blocks".

---
~Randy
