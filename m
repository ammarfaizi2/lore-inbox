Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWCQG2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWCQG2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbWCQG2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:28:53 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:29403 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752546AbWCQG2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:28:52 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Fri, 17 Mar 2006 09:17:40 +0800."
             <3ACA40606221794F80A5670F0AF15F840B37ABA9@pdsmsx403> 
Date: Fri, 17 Mar 2006 06:28:47 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FK8S7-0003ZD-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm,  we can continue to have fun with debugging. Right?

Definitely, I haven't given up.

>> The second sleep.sh hangs going to sleep.  It is in an endless loop
>> printing the following line, once per second (from the
>> polling_frequency):
>>
>>  Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

I don't think these lines are a problem.  They just reflect that
thermal polling is happening once per second.  So even though the ACPI
system is hanging in the SMPI loop (as you say below), it is alive
enough to poll the temperature sensors.

> Also please mute THM0 polling.

I retested the hacked kernel (with faked thermal_active/passive)
but with no thermal polling, just doing

  cat THM*/polling_frequency (they were all 'polling disabled')
  sleep.sh  (works)
  sleep.sh  (hangs in the usual SMPI loop)

and it hangs as usual.

> This should be the different problem from the previous reported hang.
> I recall it was hanging at a loop in SMPI waiting for BIOS's response.
> Please confirm, 

I just retested vanilla 2.6.16-rc5 (vanilla kernel, vanilla DSDT),
with polling_interval=1 (second).  My earlier tests with that kernel
had polling_interval=100, and the easiest way to reproduce the hang
was:

  echo 100 > THM0/polling_interval
  modprobe -r thermal ; modprobe thermal
  sleep.sh  (this hangs)

With this method, the system would hang on the *first* sleep cycle.
The other method to produce the hang, with thermal polling muted, was:

  echo 0 > THM0/polling_interval (and the rest of them, to make sure)
  sleep.sh  (it comes back)
  sleep.sh  (this one hangs)

I tried the same method but with 1 second instead of 100 seconds:

  echo 1 > THM0/polling_interval
  sleep.sh  (this one works, maybe because I didn't do the modprobing)
  sleep.sh  (this hangs)

The second sleep.sh hangs in the usual loop, which produces the
ex-region etc. loop, but interspersed in that dmesg output
is the output from the thermal polling.  So I also see 

  Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

plus its associated function traces (ec_intr_write or something like
that -- I saved all the log files).

One other point is that we haven't yet used a piece of information:
that the system never hangs if I boot with ec_intr=0.  Actually,
that's why I tried commenting out the \_SB.PCI0.ISA0.EC0.UPDT () line
in _TMP method, and it did 'solve' the problem (at least, it did with
AC0 faked -- I haven't tried keeping AC0 but taking out just that
line).

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
