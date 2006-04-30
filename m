Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWD3PFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWD3PFW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 11:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWD3PFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 11:05:22 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:57860 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751143AbWD3PFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 11:05:21 -0400
Date: Sun, 30 Apr 2006 15:21:55 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Log flood: "scheduling while atomic" (2.6.15.x, 2.6.16.x)
Message-ID: <4E1FB78B33%linux@youmustbejoking.demon.co.uk>
References: <4E1F56DC10%linux@youmustbejoking.demon.co.uk> <20060429182220.0a306fe2.akpm@osdl.org>
In-Reply-To: <20060429182220.0a306fe2.akpm@osdl.org>
User-Agent: Messenger-Pro/4.09b8 (MsgServe/3.24b1) (RISC-OS/4.02) POPstar/2.06+cvs
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sun, 4625 Sep 1993 15:21:55 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="622826571--31393191--260807643"
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format which your mailer apparently does not support.
You either require a newer version of your software which supports MIME, or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--622826571--31393191--260807643
Content-Type: text/plain; charset=us-ascii

I demand that Andrew Morton may or may not have written...

> Darren Salt <linux@youmustbejoking.demon.co.uk> wrote:

>> I'm seeing bouts of log flooding caused by something presumably not
>> releasing a lock. I've looked at some of the messages, but at around
>> 100/s, I'm not too keen to look through the whole lot :-)

>>    scheduling while atomic: swapper/0xafbfffff/0
>>     [show_trace+19/32]
>>     [dump_stack+30/32]
>>     [schedule+1278/1472]
>>     [cpu_idle+88/96]
>>     [stext+44/64]
>>     [start_kernel+574/704]
>>     [L6+0/2] 0xc0100199

>> (Trailing parts of some lines have been omitted; it's all repeated data.
>> And some sort of rate-limiting of these messages would be nice, but some
>> other way to draw attention to the problem, e.g. an occasional beep, would
>> be good.)

>> The most recent instance occurred a few minutes into recording a TV
>> programme (via vdr) from a cx88-based Nova-T. (I'm currently using stock
>> drivers rather than ones built from the v4l-dvb repository.)

> Thanks for the report.

> The below patch (against 2.6.17-rc3) should, if it still works, tell us
> which lock didn't get unlocked.

> You'll need to enable CONFIG_PREEMPT and CONFIG_DEBUG_PREEMPT and
> CONFIG_FRAME_POINTER.

Done, compiled, rebooted. I have a recording scheduled for later; I'll wait
and see what happens.

> Please cc video4linux-list@redhat.com on any result if it looks like v4l is
> indeed the culprit.

Will do.

BTW, patches applied:
  * the advansys patch from -mm;
  * BROKEN removed from the depends for advansys;
  * quietening of dprintk(0,...) (replaced with dprintk(1,...) in
    cx88-mpeg.c (these messages have some annoyance value);
  * a patch of my own for usbhid for a slightly weird USB+PS/2 mouse,
    connected via USB (I'll post this as directed in MAINTAINERS);
  * another of my own (attached for reference) which *should* rate-limit the
    "scheduling while atomic" messages somewhat.

The last one is new; the rest don't have any bearing on the problem, which
has occurred without them and, indeed, without the presence of advansys and
usbhid.

[snip]
-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Lobby friends, family, business, government.    WE'RE KILLING THE PLANET.

He is truly wise who gains wisdom from another's mishap.

--622826571--31393191--260807643
Content-Type: text/plain; charset=iso-8859-1; name="sched_atomic_ratelimit_hack.patch"
Content-Disposition: attachment; filename="sched_atomic_ratelimit_hack.patch"
Content-Transfer-Encoding: quoted-printable

--- 2.6.17-rc3/kernel/sched.c.orig
+++ 2.6.17-rc3/kernel/sched.c
@@ -2904,10 +2904,28 @@
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
 	if (unlikely(in_atomic() && !current->exit_state)) {
+	  /* Hack to avoid *serious* log-flooding. */
+	  static int skipped =3D -50; /* want to report the first 50 */
+	  static unsigned long last =3D 0;
+	  int doprint =3D 1;
+	  if (skipped < 0) {
+	    if (!++skipped)
+	      last =3D jiffies;
+	  } else if (jiffies - last < 5 * HZ) /* should be 5s */ {
+	    if (skipped < 0x7FFFFFFF)
+	      ++skipped;
+	    doprint =3D 0;
+	  }
+	  if (doprint) {
+	    last =3D jiffies;
+	    if (skipped)
+	      printk(KERN_ERR "[%d s-w-a not reported]\n", skipped);
+	    skipped =3D 0;
 		printk(KERN_ERR "BUG: scheduling while atomic: "
 			"%s/0x%08x/%d\n",
 			current->comm, preempt_count(), current->pid);
 		dump_stack();
+	  }
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
=20

--622826571--31393191--260807643--
