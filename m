Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSLDNnF>; Wed, 4 Dec 2002 08:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLDNnF>; Wed, 4 Dec 2002 08:43:05 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29435 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266564AbSLDNnC>; Wed, 4 Dec 2002 08:43:02 -0500
Date: Wed, 4 Dec 2002 14:50:24 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Jochen Hein <jochen@delphi.lan-ks.de>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>, andrew.grover@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021204135024.GA2544@fs.tum.de>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <20021204114114.GD309@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204114114.GD309@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:41:19PM +0100, Pavel Machek wrote:

> Hi!

Hi Pavel!

> > When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
> 
> Enable SWSUSP... Then investigate why it is possible to select
> ACPI_SLEEP but not SWSUSP...

In drivers/acpi/Config.in in 2.5.44:

<--   snip  -->

...
if [ "$CONFIG_ACPI_HT_ONLY" != "y" ]; then
   bool     '  Sleep States' CONFIG_ACPI_SLEEP
...
   define_bool CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND
...
fi
...

<--  snip  -->


This double definition was at least confusing, a simple

  dep_bool '  Sleep States' CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND

would have expressed it better.


The transition to the new kconfig converted this confusing Config.in 
snipped to the following code in drivers/acpi/Kconfig:

<--  snip  -->

...
config ACPI_SLEEP
        bool "Sleep States"
        depends on X86 && ACPI && !ACPI_HT_ONLY
        default SOFTWARE_SUSPEND
...

<--  snip  -->


The following patch makes it work the way it was intended:

--- linux-2.5.50/drivers/acpi/Kconfig.old	2002-12-04 14:24:14.000000000 +0100
+++ linux-2.5.50/drivers/acpi/Kconfig	2002-12-04 14:27:17.000000000 +0100
@@ -58,7 +58,7 @@
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
+	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
 	default SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 


Another thing that seems to be suboptimal is that the question for 
SOFTWARE_SUSPEND comes _after_ the question for ACPI_SLEEP, IOW someone 
doing a "make config" to configure his kernel doesn't have a chance to 
select ACPI_SLEEP. To fix this (and it seems to be logical) the 
SOFTWARE_SUSPEND question should be moved to the "Power management 
options" menu. The patch below tries to solve this and it makes ACPI 
dependant on PM as the comments in PM indicate:
- move "Software Suspend" to the "Power management options" menu above
  the ACPI entry
- let ACPI depend on PM

Any comments on this patch?

> 							Pavel

cu
Adrian


--- linux-2.5.50/arch/i386/Kconfig.old	2002-12-04 14:47:03.000000000 +0100
+++ linux-2.5.50/arch/i386/Kconfig	2002-12-04 14:43:48.000000000 +0100
@@ -789,8 +789,6 @@
 
 menu "Power management options (ACPI, APM)"
 
-source "drivers/acpi/Kconfig"
-
 config PM
 	bool "Power Management support"
 	---help---
@@ -811,6 +809,37 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SOFTWARE_SUSPEND
+        bool "Software Suspend (EXPERIMENTAL)"
+        depends on EXPERIMENTAL && PM
+        ---help---
+          Enable the possibilty of suspendig machine. It doesn't need APM.
+          You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
+          (patch for sysvinit needed).
+
+          It creates an image which is saved in your active swaps. By the next
+          booting the, pass 'resume=/path/to/your/swap/file' and kernel will
+          detect the saved image, restore the memory from
+          it and then it continues to run as before you've suspended.
+          If you don't want the previous state to continue use the 'noresume'
+          kernel option. However note that your partitions will be fsck'd and
+          you must re-mkswap your swap partitions/files.
+
+          Right now you may boot without resuming and then later resume but
+          in meantime you cannot use those swap partitions/files which were
+          involved in suspending. Also in this case there is a risk that buffers
+          on disk won't match with saved ones.
+
+          SMP is supported ``as-is''. There's a code for it but doesn't work.
+          There have been problems reported relating SCSI.
+
+          This option is about getting stable. However there is still some
+          absence of features.
+
+          For more information take a look at Documentation/swsusp.txt.
+
+source "drivers/acpi/Kconfig"
+
 config APM
 	tristate "Advanced Power Management BIOS support"
 	depends on PM
@@ -1516,35 +1545,6 @@
 
 menu "Kernel hacking"
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
--- linux-2.5.50/drivers/acpi/Kconfig.old	2002-12-04 14:39:24.000000000 +0100
+++ linux-2.5.50/drivers/acpi/Kconfig	2002-12-04 14:42:57.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 menu "ACPI Support"
+	depends on PM
 
 config ACPI
 	bool "ACPI Support" if X86

