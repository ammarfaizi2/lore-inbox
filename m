Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269578AbUIZREm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbUIZREm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269580AbUIZREm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:04:42 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:52417 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269578AbUIZREh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:04:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sun, 26 Sep 2004 19:06:10 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
References: <200409251214.28743.rjw@sisk.pl> <200409261202.34138.rjw@sisk.pl> <200409261345.10565.rjw@sisk.pl>
In-Reply-To: <200409261345.10565.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200409261906.10635.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 13:45, Rafael J. Wysocki wrote:
[-- snip --]
>  swsusp: Image: 11145 Pages
>  swsusp: Pagedir: 0 Pages
> Writing data to swap (11145 pages)...   0%
> 
> Here I have to press the red button unless I want to wait for a couple of 
> hours.  I'll send you more info when there's more.

I figured out that the slowdown occurs in device_resume(), so I put a printk() 
in dpm_resume(), like this:

--- drivers/base/power/resume.c 2004-09-26 16:44:09.000000000 +0200
+++ drivers/base/power/resume.c.rjw     2004-09-26 16:43:57.000000000 +0200
@@ -34,6 +34,7 @@
        while(!list_empty(&dpm_off)) {
                struct list_head * entry = dpm_off.next;
                struct device * dev = to_device(entry);
+               printk("%ld\n",  jiffies/HZ);
                list_del_init(entry);

                if (!dev->power.prev_state)

>From it, I have got the following results:

PM: writing image.
4294807
[ ... ]
4294807
PCI: Setting latency timer of device 0000:00:02.0 to 64
4294813
PCI: Setting latency timer of device 0000:00:02.1 to 64
4294817
PCI: Setting latency timer of device 0000:00:02.2 to 64
4294821
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
4294822
[ ... ]
4294822
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
4294822
4294825
4294828
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
4294828
[ ... ]
4294828
4294829
[ ... ]
4294829

As you can see, the difference between the first and the last timestamp is 22.  
However, if I make the same change in 2.6.9-rc2-mm1, I get:

PM: writing image.
4294761
[ ... ]
4294761
PCI: Setting latency timer of device 0000:00:02.0 to 64
4294761
PCI: Setting latency timer of device 0000:00:02.1 to 64
4294761
PCI: Setting latency timer of device 0000:00:02.2 to 64
4294761
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
4294762
[ ... ]
4294762
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
4294762
4294762
4294762
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
4294762
[ ... ]
4294762

so the difference between the first and the last timestamp is 1 (ie 22 times 
less).

Now, I have no idea about what may be responsible for such a slowdown, but I 
suspect that it's related to PCI.  I really don't know what to look for, so 
if you can give me any hint, please do.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
