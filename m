Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTIDJf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTIDJf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:35:57 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:50308 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S264832AbTIDJfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:35:53 -0400
Date: Thu, 4 Sep 2003 11:34:15 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Patrick Mochel <mochel@osdl.org>
Cc: maverick@eskuel.com, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Power Management Update
Message-ID: <20030904093414.GA25219@lps.ens.fr>
References: <3F55B738.4070200@eskuel.com> <Pine.LNX.4.33.0309031522200.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0309031522200.944-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 03:41:14PM -0700, Patrick Mochel wrote:
> > It solves the ide-cd problem, and the suspend process get to next step. 
> > It frees memory. However, just after that, the system get in a loop 
> > displaying "Bad: scheduling while atomic". I'm not able to capture the 
> > output of this, the laptop only responding to syrq.
> > Hope it helps you.
> 
> Definitely. I take it you have preempt enabled, right? 

I don't have preempt enabled, so I thought that this patch wasn't
concerning me, but I tried it anyway. Result is a definite regression.

standby/S1 or mem/S3 make the kernel oops and hangs. Call strace:
	enter_state
	suspend_prepare
	enter_state
	state_store
	subsys_attr_store
	fill_write_buffer
	sysfs_write_file
	vfs_write
	sys_write
	sysenter_past_esp
or
	acpi_system_write_sleep
	acpi_system_write_sleep
	vfs_write
	sys_write
	sysenter_past_esp
(depending on whether I use /sys/power/state or /proc/acpi/sleep)

Before the patch, S1 and S3 would have the screen blink and computer
immediately resume to normal operation. Sometimes, S1 would actually
standby (screen lit and hard disk spinning, though) waiting for a
keypress.

disk/S4 don't suspend anymore. It starts very well, but the computer
immediately resume to normal operation:
Stopping tasks: ====================================================|
Freeing memory: ........|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
/critical section: Counting pages to copy[nosave c0377000] (pages needed:
46357+512=46869 free: 82650)
Alloc pagedir
[nosave c0377000]critical section/: done (46357 pages copied)
Packet log: input REJECT eth1 PROTO=17 207.34.121.71:1184
192.168.1.8:1434 L=404 S=0x00 I=38123 F=0x0000 T=112 (#14)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue df60d800, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done

Prior to the patch, the computer would suspend and bug at resume time.

> Andrew, please apply this to -test4-mm5. I realize I said I would not
> touch swsusp any more, and this patch may become irrelevant in the future. 
> But, it fixes a real bug now. 

Thank you for actually improving swsusp, despite what you said.

Éric
