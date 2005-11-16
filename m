Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVKPDiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVKPDiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVKPDiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:38:05 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:26003 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S965212AbVKPDiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:38:04 -0500
Message-ID: <437AA996.9080505@cfl.rr.com>
Date: Tue, 15 Nov 2005 22:37:58 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA SATA Raid needs a long time to recover from suspend
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been debugging a power management problem for a few days now, and 
I believe I have finally solved the problem.  Because it involved 
patching the kernel, I felt I should share the fix here in hopes that it 
can be improved and/or integrated into future kernels.  Right now I am 
running 2.6.14.2 on amd64, compiled myself, with the ubuntu breezy amd64 
distribution. 

First I'll state the fix.  It involved changing two lines in 
include/linux/libata.h:

static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
                   unsigned int max)
{
    u8 status;

    do {
        udelay(100);                                 <-- changed to 100 
from 10
        status = ata_chk_status(ap);
        max--;
    } while ((status & bits) && (max > 0));

    return status;
}

and:

static inline u8 ata_wait_idle(struct ata_port *ap)
{
    u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 
10000);             <-- changed to 10,000 from 1,000

    if (status & (ATA_BUSY | ATA_DRQ)) {
        unsigned long l = ap->ioaddr.status_addr;
        printk(KERN_WARNING
               "ATA: abnormal status 0x%X on port 0x%lX\n",
               status, l);
    }

    return status;
}

The problem seems to be that my VIA SATA raid controller requires more 
time to recover from being suspended.  It looks like the code in 
sata_via.c restores the task file after a resume, then calls 
ata_wait_idle to wait for the busy bit to clear.  The problem was that 
this function timed out before the busy bit cleared, resulting in 
messages like this:

ATA: abnormal status 0x80 on port 0xE007

Then if there was an IO request made immediately after resuming, it 
would timeout and fail, because it was issued before the hardware was 
ready.  Changing the timeout resolved this.  I tried changing both the 
udelay and ata_busy_wait lines to increase the timeout, and it did not 
seem to matter which I changed, as long as the total timeout was 
increased by a factor of 100. 

Since increasing the maximum timeout, suspend and hibernate work great 
for me.  While experiencing this bug, it may have exposed another bug, 
which I will mention now in passing.  As I said before, after a resume, 
if there was an IO request made immediately ( before the busy bit 
finally did clear ) it would timeout and fail.  It seemed the kernel 
filled the buffer cache for the requested block with garbage rather than 
retry the read.  It seems to me that at some point, the read should have 
been retried.  The symptoms of this were:

1) When suspend.sh called resume.sh immediately after the echo mem > 
/sys/power/state line, then on resume, the read would fail in a block in 
the resierfs tree that was required to lookup the resume.sh file.  This 
caused reiserfs to complain about errors in the node, and the script 
failed to execute.  Further attempts to touch the script, even with ls 
-al /etc/acpi/resume.sh failed with EPERM.  I would think that at worst, 
this should fail with EIO or something, not EPERM. 

2) At one point I tried running echo mem > /sys/power/state ; df.  After 
the resume, the IO read failed when trying to load df, and I got an 
error message saying the kernel could not execute the binary file.  
Further attempts to run df failed also.  Other IO at this point was fine. 

This leads me to think that when the IO failed, rather than inform the 
calling code of the failure, for example, with an EIO status, the buffer 
cache got filled with junk, and this should not happen.  Either the 
operation should succeed, and the correct data be returned, or it should 
fail, and the caller should be informed of the failure, and not given 
incorrect data. 

When the first IO immediately following the suspend failed, I got these 
messages:

[   32.013538] ata1: command 0x35 timeout, stat 0x50 host_stat 0x1
[   32.045510] ata2: command 0x35 timeout, stat 0x50 host_stat 0x1

As long as no IO was immediately requested after the resume ( i.e. if I 
echo mem > /sys/power/state on an otherwise idle system, rather than 
using suspend.sh ) then these errors did not happen, only the abnormal 
status messages did. 

For reference, my system is configured as follows:

Motherboard: Asus K8V Deluxe
CPU: AMD Athlon 64 3200+
RAM: 1 GB of Corsair low latency pc3200 ddr sdram
Video: ATI Radeon 9800 Pro with a Samsung 930B 19 inch LCD display
Disks: 2 WD 36 gig SATA 10,000 rpm raptors in a raid0 configuration on 
the via sata raid controller
Partitions:

/dev/mapper/via_hfciifae1: 40 gig winxp NTFS partition
/dev/mapper/via_hfciifae3: 10 gig experimental partition
/dev/mapper/via_hfciifae5: 50 meg ext2 /boot partition
/dev/mapper/via_hfciifae6: 1 gig swap partition
/dev/mapper/via_hfciifae7: 22 gig reiserfs root partition

If anyone has any suggestions of further tests I can perform to narrow 
down the problem, or a better solution for it, you have my full 
cooperation.  If this fix seems acceptable, then I hope it can be merged 
in the next kernel release. 

PS> Please CC me on any replies, as I am not subscribed to this list




