Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUK2BLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUK2BLo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 20:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUK2BLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 20:11:44 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:38592 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261612AbUK2BLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 20:11:35 -0500
Date: Sun, 28 Nov 2004 17:11:33 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ralph Metzler <rjkm@metzlerbros.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: efficeon and longrun
In-Reply-To: <16810.26231.936086.930240@metzlerbros.de>
Message-ID: <Pine.LNX.4.61.0411281627420.4871@twinlark.arctic.org>
References: <16810.26231.936086.930240@metzlerbros.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Ralph Metzler wrote:

> I recently got a Sharp MP70G with a 1.6 GHz efficeon processor 
> and have some questions regarding longrun support. I am using 
> longrun-0.9-15 and kernel 2.6.10-rc2.
> 
> In arch/i386/kernel/cpu/proc.c the kernel seems to check bit 3
> for the lrti capability, longrun.c checks bit2. 

bit 3 is the correct bit for lrti... this is one of the few things we 
actually have in our scant public docs 
<http://www.transmeta.com/crusoe_docs/Crusoe_CPUID_5-7-02.pdf>, see page 
6.

the kernel appears to check the right bit, but the debian userland longrun 
tool doesn't...  it probably hasn't mattered until now because many crusoe 
with LRTI also have bit 2 set (bit 2 isn't documented, sorry).


> Are thermal extensions different on the efficeon compared to the crusoe?
> No matter what I choose (between 0 and 7) the level field in the ATM
> register is always 0. 

in theory they're backward compatible -- i've actually been using a 
longrun executable compiled years ago on crusoe and never bothered 
recompiling it on efficeon.  but there are definitely some quirks -- and 
the quirks appear to interfere poorly with the debian longrun-0.9-15 
package.  (i bet i'm using a longrun.c which is old enough to pre-date 
lrti...)

the tables defined for crusoe include information that's meaningless on 
efficeon -- crusoe has two memory controllers, and only one clock domain 
for the entire processor.  when crusoe is varying the frequency it also 
stops/starts the memory bus and possibly runs memory at different rates -- 
the longrun tables include all this divisor information.

efficeon has only one memory controller, and two clock domains, one for 
the "northbridge" and one for the "core".  only the core speed varies 
after boot -- the memory clocks at a fixed rate. so the divisors in the 
longrun table are essentially meaningless.  in fact it looks like they 
come back as all zeros... and this causes the debian longrun-0.9-15 some 
angst.

below is a patch to debian longrun-0.9-15 -- it passes the "works for me" 
test on my development efficeon board, but i don't have a crusoe handy 
from remote this weekend to verify it works there.  i've placed pre-built 
debs at <http://arctic.org/~dean/longrun/> ... if crusoe/efficeon users 
can verify them i'll submit my patch upstream (make sure "longrun -l", 
"-p" and "-s low hi" work).


> Are there any new efficeon features not yet supported in the kernel or
> the longrun utility? Is there any register information available
> anywhere? I looked on the transmeta pages but did not find anything
> about this.

we suck at publishing this stuff (it makes it out to our customers, but 
not out for general consumption).  i've no clue where it's all linked 
from, but google finds a bunch of stuff -- try a search for "crusoe_docs 
site:transmeta.com".  there's nothing apparently recent there though.

aside from the efficeon kernel patch i submitted (it's in 2.6.10-rc2, and 
i think -rc1) there aren't any efficeon-specific features that i think 
need supporting.  there's tweaking you could do -- but it's mostly 
userland (i.e. gcc -msse2 -mfpmath=sse).


> The BIOS also allows one to select C4 as possible power level,
> /proc/acpi/processor/CPU0/power only offers C1, C2 and C3. 
> 
> I ask because under Windows, if nothing is running, the fan will
> stay off. Under Linux it is turning on about every two minutes and
> will then run for about a minute (also with everything turned off, and
> about every daemon shut down).

maybe try building your kernel with HZ=100 instead of default 1000? maybe 
at HZ=1000 it wakes up just enough to cross some unfortunate power 
threshold.  my next suggestion beyond that would be to see if ext2 and/or 
noflushd do anything... i don't know if it's still true, but ext3 used to 
cause sync's every 5s... and didn't interact well with noflushd.

-dean

diff -ru longrun-0.9/debian/changelog longrun-0.9.dg1/debian/changelog
--- longrun-0.9/debian/changelog	2004-11-29 00:43:18.000000000 -0800
+++ longrun-0.9.dg1/debian/changelog	2004-11-29 00:39:46.000000000 -0800
@@ -1,3 +1,15 @@
+longrun (0.9-15.dg1) unstable; urgency=low
+
+  * LRTI is bit 3, not bit 2... the old code happens to have worked on
+    many crusoe because they also set bit 2, but this bit is not set on
+    all crusoe, nor is it set on efficeon.  (i'm not sure if bit 2 is
+    publically documented).
+  * mhz * millivolt * millivolt power estimation overflows 31-bit
+    signed integer once the clock is fast enough... use double instead.
+  * io_div (and most divisors) are 0 on efficeon, avoid div-by-0.
+
+ -- dean gaudet <dean@arctic.org>  Mon, 29 Nov 2004 00:38:13 -0800
+
 longrun (0.9-15) unstable; urgency=low
 
   * Fix mistake on man page. Closes: #249866
diff -ru longrun-0.9/longrun.c longrun-0.9.dg1/longrun.c
--- longrun-0.9/longrun.c	2004-11-29 00:43:18.000000000 -0800
+++ longrun-0.9.dg1/longrun.c	2004-11-29 00:42:23.000000000 -0800
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <sys/io.h>
 #include <sys/sysmacros.h>
+#include <locale.h>
 #define __USE_UNIX98	/* for pread/pwrite */
 #define __USE_FILE_OFFSET64 /* we should use 64 bit offset for pread/pwrite */
 #include <unistd.h>
@@ -68,7 +69,7 @@
 #define CPUID_TMx86_PROCESSOR_INFO	0x80860001
 #define CPUID_TMx86_LONGRUN_STATUS	0x80860007
 #define CPUID_TMx86_FEATURE_LONGRUN(x)	((x) & 0x02)
-#define CPUID_TMx86_FEATURE_LRTI(x)	((x) & 0x04)
+#define CPUID_TMx86_FEATURE_LRTI(x)	((x) & 0x08)
 
 /* Advanced Thermal Management */
 #define LR_NORTHBRIDGE "/proc/bus/pci/00/00.0"
@@ -242,21 +243,23 @@
 {
 	int max;
 	int junk;
-	int max_voltage, max_mhz, max_power;
+	int max_voltage, max_mhz;
+	double max_power;
 
 	read_msr(MSR_TMx86_LRTI_READOUT, &junk, &max);
 
 	write_msr(MSR_TMx86_LRTI_READOUT, 0, max);
 	read_msr(MSR_TMx86_LRTI_VOLT_MHZ, &max_mhz, &max_voltage);
 
-	max_power = max_mhz * max_voltage * max_voltage;
+	max_power = ((double)max_mhz * max_voltage) * max_voltage;
 
 	printf(_("# %%   MHz  Volts  usage  SDR  DDR  PCI\n"));
 
 	int i;
 	for (i = max; i >= 0; i--)
 	{
-		int percent, mhz, voltage, power;
+		int percent, mhz, voltage;
+		double power;
 		int ddr_mem_div, sdr_mem_div, ddr_freq, sdr_freq;
 		int io_div;
 		write_msr(MSR_TMx86_LRTI_READOUT, i, max);
@@ -267,9 +270,9 @@
 		read_msr(MSR_TMx86_LRTI_VOLT_MHZ, &mhz, &voltage);
 		printf(_("%5d %6.3f "), mhz, (voltage / 1000.0));
 
-                power = mhz * voltage * voltage;
+                power = ((double)mhz * voltage) * voltage;
 
-		printf(_("%6.3f "), ((float) power) / max_power);
+		printf(_("%6.3f "), ((double) power) / max_power);
 
 		// TODO:  Watch for zeros
 		read_msr(MSR_TMx86_LRTI_DIV_MEM, &sdr_mem_div, &ddr_mem_div);
@@ -289,9 +292,13 @@
 
 		printf(_("%4d %4d "), sdr_freq, ddr_freq);
 
-		// TODO:  Watch for zeros
 		read_msr(MSR_TMx86_LRTI_DIV_IO, &io_div, &junk);
-		printf(_("%4d\n"), mhz / io_div);
+		if (io_div) {
+			printf(_("%4d\n"), mhz / io_div);
+		}
+		else {
+			printf("%4s\n", "--");
+		}
 
                 /*
                 // Most of the rest of these flags don't appear too interesting
