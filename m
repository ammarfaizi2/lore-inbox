Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUJAT3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUJAT3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUJAT0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:26:51 -0400
Received: from scrye.com ([216.17.180.1]:10194 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S266245AbUJATZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:25:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 1 Oct 2004 13:25:27 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
To: rjw@sisk.pl ("Rafael J. Wysocki")
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
X-Draft-From: ("scrye.linux.kernel" 72499)
References: <415C2633.3050802@0Bits.COM> <20041001102351.GC18786@elf.ucw.cz>
	<20041001160333.1D229774C3@voldemort.scrye.com>
	<200410012055.29406.rjw@sisk.pl>
Message-Id: <20041001192532.A0714A6017@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Rafael" == Rafael J Wysocki <rjw@sisk.pl> writes:

Rafael> On Friday 01 of October 2004 18:03, Kevin Fenzi wrote:
>> >>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
>> 
Pavel> Hi!
>> >> Anyone noticed that pmdisk software suspend stopped working in
>> -rc3 >> ?  In -rc2 it worked just fine. My script was
>> >>
>> >> chvt 1 echo -n shutdown >/sys/power/disk echo -n disk >>
>> >/sys/power/state chvt 7
>> >>
>> >> In -rc3 it appears to write pages out to disk, but never shuts
>> down >> the machine. Is there something else i need to do or am
>> missing ?
>> 
Pavel> You are not missing anything, it is somehow broken. I'll try to
Pavel> find out what went wrong and fix it. In the meantime, look at
Pavel> -mm series, it works there.  Pavel
>> I finally had a chance to try 2.6.9-rc3 here last night.
>> 
>> It suspended ok for me, but on resume it would load in the cache
>> and then reboot. :(

Rafael> Always?  I mean, is it reproducible?  I have a similar
Rafael> problem, but it is not reproducible, apparently.  Sometimes it
Rafael> reboots, sometimes it reports a double fault, but most often
Rafael> it resumes just fine.

Well, I only tried it twice, but it rebooted both times. 

After applying the patch below from Pavel on top of 2.6.9-rc3 it now
seems to work (again, I have only done a few cycles). 

Do you have HIMEM enabled? Does the patch below make it more stable
for you? 

Rafael> Greets, RJW

kevin

- --- clean/kernel/power/swsusp.c	2004-10-01 00:30:32.000000000 +0200
+++ clean-mm/kernel/power/swsusp.c	2004-09-26 01:34:27.000000000 +0200
@@ -856,7 +860,9 @@
 	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_suspend();
+	/* Restore control flow magically appears here */
 	restore_processor_state();
+	restore_highmem();
 	local_irq_enable();
 	return error;
 }
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBXa8q3imCezTjY0ERAv55AKCHAvg2sqBYi4p2cR+ZIJ6Y1bZeiwCfc1cN
9m/3MpImIeu1LfchBRK8LEE=
=fIt6
-----END PGP SIGNATURE-----
