Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWHFF7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHFF7A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 01:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWHFF7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 01:59:00 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:62058 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932288AbWHFF67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 01:58:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:Reply-To:To:Cc:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=z1fMCxeACLEKyJPGM3A1SdC0lf6KfavlPkyd0bBML7TLAgpYj4p9sEFymYx/WTDg7duKzmRWJRQTq8FiQ0wUTo3z60cjEvID1etgF4kKwEE67oBLFZSaBVIS9CCDyVpmfNwv46i9drFjgGdv+NGPE3w+SJsAZu/Lq+Uilu2Mgxw=  ;
Subject: register_timer_hook fails on realtime kernel with
	CONFIG_PROFILE_NMI
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
       Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 01:59:37 -0400
Message-Id: <1154843977.7027.33.camel@moblin.mtmk.phub.net.cable.rogers.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I wrote a "Very Simple Timer Notification Module", which calls
register_timer_hook to register a function to be called using the timer
interrupt. This is essentially what OProfile would do in timer interrupt
mode. The standard kernel allows you to do this even if
CONFIG_PROFILE_NMI is defined but the realtime kernel does not. With the
realtime kernel register_timer_hook succeeds but the timer hooks is
never called. From patch-2.6.17-rt8 the following modifies
linux/include/linux/clockchips.h
+#ifndef CONFIG_PROFILE_NMI
+#define CLOCK_CAP_PROFILE	0x000008
+#else
+#define CLOCK_CAP_PROFILE	0x000000
+#endif

So, it's simple enough to work around, by just making CLOCK_CAP_PROFILE
0x000008 regardless of whether CONFIG_PROFILE_NMI is defined or not, but
I would like to understand the intention of the authors here. Is there a
good reason to disallow the timer interrupt mode of profiling if
CONFIG_PROFILE_NMI is defined? (other than arguing that NMI profiling is
superior)

I have included vstnm.tar.bz2 in case it is of any help examinig the
problem. Just do:
tar xjf vstnm.tar.bz2
cd vstnm
make
make install
then use the script load_vstnm to load the module and unload_vstnm to
unload the module. If the timer_tick function is called it will print a
rate limited message to the console that it was called.

Thank you


