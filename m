Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280972AbRKCPd6>; Sat, 3 Nov 2001 10:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKCPds>; Sat, 3 Nov 2001 10:33:48 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:53407 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280968AbRKCPda>;
	Sat, 3 Nov 2001 10:33:30 -0500
Date: Sat, 03 Nov 2001 15:33:26 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: [PATCH] IBM T23; quirks force enable interrupts in APM set power state, causes crash on suspend
Message-ID: <520483122.1004801606@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven et al,

Summary: dmi_scan.c forces interrupt enable on during PCI BIOS call for
         all IBM machines, which breaks T23, which needs it off it seems.

(Steven: hope you don't mind lkml copy)

>>> My only worry is I have some people saying (admittedly on laptops
>>> pre the T23) that disabling this opption whilst udma is still enabled
>>> is a sure way to kill your entire filing system. Well, guess I've
>>> got most of it backed up ...
>>
>> You could try this in single user mode with all your file systems mounted
>> read only (or not mounted if possible).
>
> I will try it this evening - I think with UDMA off (somehow), single
> user mode, no other apps, immediate reboot afterwards,
> it should be worth the risk :-)
>
> I have 2 x T23 here which are not (yet) doing vital stuff, so if you
> want any information on them, I'm happy to do testing.

Well, lo and behold, if I /do/ disable interrupts (i.e. change
APM_DO_CLI to just cli() ), it seems to suspend and restore
correctly. So it looks like the BIOS in the T23 has the opposite
bug from other boxes - i.e. it doesn't work if you have interrupts
/enabled/ (grrrr...).

So now 'all' I have to worry is all the dire warnings about
enabling this.

>>> I shall try it - is this any different (I think no) from turning OFF
>>> the config option which says enable IRQs in interrupts?
>>
>> It is different, because we automatically detect all IBM thinkpads and
>> turn that option on at runtime.  We currently do not distinguish between
>> different Thinkpad models because up until (at least) the T22, they all
>> had the problem and I do not have access to a T23.
>
> OK - obviously hadn't read the code sufficiently closely.

Found it :-)

Looks like the test for IBM laptops in dmiscan.c is too specific,
and needs to be made less so. I changed dmi_printk
to just do a printk() and have included what I think is all
the relevant information below, so you can exclude matching the T23.

I have attached a patch which fixes this (against 2.4.12-ac5),
and the dmi dump.

--
Alex Bligh

DMI dump on standard build:

All processors have done init_idle
DMI 0.0 present.
48 structures occupying 1720 bytes.
DMI table at 0x27F7C000.
BIOS Vendor: IBM
BIOS Version: 1AET38WW (1.01b)
BIOS Release: 07/27/2001
System Vendor: IBM.
Product Name: 26479LU.
Version Not Available.
Serial Number 787PR4K.
Board Vendor: IBM.
Board Name: 26479LU.
Board Version: Not Available.
Asset Tag: No Asset Information.
IBM machine detected. Enabling interrupts during APM calls.


--- kernel-source-2.4.12ac5clean/arch/i386/kernel/dmi_scan.c  Tue Oct 23 10:00:14 2001
+++ kernel-source-2.4.12ac5dev/arch/i386/kernel/dmi_scan.c  Wed Oct 31 22:09:14 2001
@@ -277,6 +277,23 @@
        return 0;
 }

+/*
+ * ... but some other (more specific) variants of the above laptops
+ * do not like interrupts being enabled during APM calls
+ * For instance though IBM laptops apparently crash if interrupts
+ * are not enabled during APM calls, the IBM T23 appears to crash
+ * if interrupts /are/ enabled during APM calls - sigh - alex@alex.org.uk
+ */
+static __init int set_no_apm_ints(struct dmi_blacklist *d)
+{
+       if (apm_info.allow_ints)
+       {
+               apm_info.allow_ints = 0;
+               printk(KERN_INFO "%s machine detected. Re-disabling interrupts during APM calls.\n", d->ident);
+       }
+       return 0;
+}
+
 /*
  * Some APM bioses corrupt memory or just plain do not work
  */
@@ -458,6 +475,11 @@
                        MATCH(DMI_SYS_VENDOR, "IBM"),
                        NO_MATCH, NO_MATCH, NO_MATCH
                        } },
+       { set_no_apm_ints, "IBM T23", { /* Disable interrupts during suspend on IBM T23 laptops */
+                       MATCH(DMI_SYS_VENDOR, "IBM"),
+                       MATCH(DMI_PRODUCT_NAME, "26479"),
+                       NO_MATCH, NO_MATCH
+                       } },
        { set_apm_ints, "Dell Inspiron", {      /* Allow interrupts during suspend on Dell Inspiron laptops*/
                        MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
                        MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),

