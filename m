Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161332AbWALWHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbWALWHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWALWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:07:47 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:56810 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161332AbWALWHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:07:46 -0500
Date: Thu, 12 Jan 2006 23:08:25 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: john stultz <johnstul@us.ibm.com>
Subject: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060112220825.GA3490@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <15632.83.103.117.254.1136989660.squirrel@picard.linux.it> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111184027.GB4735@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111184027.GB4735@inferi.kami.home>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cleaned up some Cc as this is not interesting to all MLs]

Andrew,

first bisection spotted the cause of the stalls at boot (happening while
starting portmap and after usb-storage scan):

time-clocksource-infrastructure.patch
time-generic-timekeeping-infrastructure.patch
time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
time-i386-conversion-part-2-rework-tsc-support.patch
time-i386-conversion-part-3-enable-generic-timekeeping.patch
time-i386-conversion-part-4-remove-old-timer_opts-code.patch
time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
time-i386-clocksource-drivers.patch
time-fix-cpu-frequency-detection.patch

Cc-ed john stultz

actually git bisect[1] pointed to time-fix-cpu-frequency-detection.patch
but it's clearly wrong. Reverting all the above patches (I suppose they
are somewhat related) fixes the stalls I experience. I can test
corrections if necessary.

eh, see: during the multiple boots I noticed that just hitting sysrq
make the boot process go on when stuck

...
sda: assuming drive cache: write through
 sda: sda1
 sd 0:0:0:0: Attached scsi removable disk sda
 /etc/rcS.d/S04udev: line 224:  2347 Quit                    sleep 0.2
...
Starting portmap daemon: portmap.
/etc/rcS.d/S43portmap: line 24:  2678 Quit                    sleep 1
...

I'll re-bisect the thing tomorrow to spot what's causing reiserfs oops

[1]: I imported the patches into git by means of:
while [ $(quilt next) ] ; do 
	quilt push && git add && git commit -a -m "$(quilt top)" ; 
done
-- 
mattia
:wq!
