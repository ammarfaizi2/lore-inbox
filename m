Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUI2V4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUI2V4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUI2V4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:56:43 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:27837 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269070AbUI2V4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:56:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-rc2-mm[2-4]: zaphod-scheduler.patch makes swsusp incredibly slow (was: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64)
Date: Wed, 29 Sep 2004 23:58:54 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Peter Williams <pwil3058@bigpond.net.au>
References: <200409251214.28743.rjw@sisk.pl> <20040926132036.GG826@openzaurus.ucw.cz> <200409280123.54857.rjw@sisk.pl>
In-Reply-To: <200409280123.54857.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409292358.54609.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have verified that the odd symptoms described previously in this thread 
result from the zaphod-scheduler.patch.

To show this, I took the 2.6.9-rc2-mm2 kernel, reverted the 
zaphod-scheduler.patch and applied the following changes to swsusp.c:

--- a/kernel/power/swsusp.c	2004-09-29 21:45:15.000000000 +0200
+++ b/kernel/power/swsusp.c	2004-09-29 22:08:33.971404368 +0200
@@ -295,18 +295,20 @@
 	int error = 0;
 	int i;
 	unsigned int mod = nr_copy_pages / 100;
+	unsigned long start_time =  jiffies;
 
 	if (!mod)
 		mod = 1;
 
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
+	printk( "Writing data to swap (%d pages)...                ", 
nr_copy_pages );
 	for (i = 0; i < nr_copy_pages && !error; i++) {
 		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
+			printk( "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b%3d%%, time: %3ld",
+					i / mod, (jiffies - start_time)/HZ);
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
-	printk("\b\b\b\bdone\n");
+	printk(" ... done\n");
 	return error;
 }
 
Then, I obtained the following result:

Stopping tasks: ===============================|
Freeing memory... done (17507 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 0x582].............................................swsusp: 
Need to copy 10738 pages
suspend: (pages needed: 10738 + 512 free: 120141)
..<7>[nosave pfn 0x582].............................................swsusp: 
critical section/: done (10866 pages copied)
PM: writing image.
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:02.1 to 64
PCI: Setting latency timer of device 0000:00:02.2 to 64
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
 swsusp: Version: 132617
 swsusp: Num Pages: 130880
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: albercik
 swsusp: UTS Release: 2.6.9-rc2-mm2
 swsusp: UTS Version: #4 Wed Sep 29 22:09:48 CEST 2004
 swsusp: UTS Machine: x86_64
 swsusp: UTS Domain:
 swsusp: CPUs: 1
 swsusp: Image: 10866 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (10866 pages)... 100%, time:   2 ... done
Writing pagedir (85 pages)
S|
Powering off system
Shutdown: hdc
acpi_power_off called

which is OK, IMO.  However, for the vanilla 2.6.9-rc2-mm2 (with the same 
changes to swsusp.c), I get:

[-- snip --]
 swsusp: Version: 132617
 swsusp: Num Pages: 130880
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: albercik
 swsusp: UTS Release: 2.6.9-rc2-mm2
 swsusp: UTS Version: #2 Wed Sep 29 23:12:00 CEST 2004
 swsusp: UTS Machine: x86_64
 swsusp: UTS Domain:
 swsusp: CPUs: 1
 swsusp: Image: 11115 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (11115 pages)...   6%, time: 738<6>SysRq : Resetting

which should give you an idea what kind of a slowdown I was talking about 
earlier.

Well, zaphod-scheduler.patch is a big patch and I know to little to be able to 
figure out what's wrong with it so it causes the observed symptoms to appear.  
If you can, please help me fix this.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
