Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVAGA6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVAGA6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVAGA5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:57:39 -0500
Received: from mail.tyan.com ([66.122.195.4]:40720 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261210AbVAGAz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:55:56 -0500
Message-ID: <3174569B9743D511922F00A0C9431423072912EE@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>, Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: RE: 256 apic id for amd64
Date: Thu, 6 Jan 2005 17:06:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

I made the Opteron using apic id from 16 later in LinuxBIOS.

So leave 0-15 for ioapic.

The problem is that the kernel (caliberate_delay) doesn't like that.

If using lpj=2170880 as the command line for that, it works well.

What's the jiffies? The TSC is changing but it doesn't.

YH

Without offset:
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1019456k/1048576k available (3011k kernel code, 0k reserved, 1310k
data, 544k init)
LYH calibrating 0 jiffies = 4294667563, now=2922366256
LYH calibrating 1 jiffies = 4294667568, now=2934372713
LYH calibrating 3 jiffies = 4294667600, now=3003581909
4341.76 BogoMIPS (lpj=2170880)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0 -> Node 0
CPU: Physical Processor ID: 0

With apic id offset:
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1019456k/1048576k available (3011k kernel code, 0k reserved, 1310k
data, 544k init)
LYH calibrating 0 jiffies = 4294667296, now=1383947209
LYH calibrating 1 jiffies = 4294667296, now=1395952717


Please refer the print in init/main.c

void __devinit calibrate_delay(void)
{
        unsigned long ticks, loopbit;
        int lps_precision = LPS_PREC;
 +       unsigned long now;
 +
 +       rdtscl(now);
 +
 +        printk("LYH calibrating 0 jiffies = %lu, now=%lu\r\n", jiffies,
now);


        if (preset_lpj) {
                loops_per_jiffy = preset_lpj;
                printk("Calibrating delay loop (skipped)... "
                        "%lu.%02lu BogoMIPS preset\n",
                        loops_per_jiffy/(500000/HZ),
                        (loops_per_jiffy/(5000/HZ)) % 100);
        } else {
                loops_per_jiffy = (1<<12);

 +               rdtscl(now);
 +               printk("LYH calibrating 1 jiffies = %lu, now=%lu\r\n",
jiffies, now);
                printk(KERN_DEBUG "Calibrating delay loop... ");
                while ((loops_per_jiffy <<= 1) != 0) {
                        /* wait for "start of" clock tick */
                        ticks = jiffies;
                        while (ticks == jiffies)
                                /* nothing */;
                        /* Go .. */
                        ticks = jiffies;
                        __delay(loops_per_jiffy);
                        ticks = jiffies - ticks;
                        if (ticks)
                                break;
                }

                /*
                 * Do a binary approximation to get loops_per_jiffy set to
                 * equal one clock (up to lps_precision bits)
                 */
  +              rdtscl(now);
  +              printk("LYH calibrating 2 jiffies = %lu, now=%lu\r\n",
jiffies, now);

                loops_per_jiffy >>= 1;
                loopbit = loops_per_jiffy;
                while (lps_precision-- && (loopbit >>= 1)) {
                        loops_per_jiffy |= loopbit;
                        ticks = jiffies;
                       while (ticks == jiffies)
                                /* nothing */;
                        ticks = jiffies;
                        __delay(loops_per_jiffy);
                        if (jiffies != ticks)   /* longer than 1 tick */
                                loops_per_jiffy &= ~loopbit;
                }

  +              rdtscl(now);
  +              printk("LYH calibrating 3 jiffies = %lu, now=%lu\r\n",
jiffies, now);

                /* Round the value and print it */
                printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
                        loops_per_jiffy/(500000/HZ),
                        (loops_per_jiffy/(5000/HZ)) % 100,
                        loops_per_jiffy);
        }

}
