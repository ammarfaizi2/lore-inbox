Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129525AbQKXPnp>; Fri, 24 Nov 2000 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129391AbQKXPnY>; Fri, 24 Nov 2000 10:43:24 -0500
Received: from gear.torque.net ([204.138.244.1]:59410 "EHLO gear.torque.net")
        by vger.kernel.org with ESMTP id <S129145AbQKXPnY>;
        Fri, 24 Nov 2000 10:43:24 -0500
Message-ID: <3A1E85C8.EF156623@torque.net>
Date: Fri, 24 Nov 2000 10:14:16 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.2.16: How to freeze the kernel
In-Reply-To: <3A1E309C.26058.40EA98@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> 
> Hello,
> 
> this is for your interest, amusement, and for "what not to do":
> 
> I managed to freeze the kernel (2.2.16 from SuSE Linux 7.0) in a way
> that I could not even switch virtual consoles. Completely silent
> eberything...
> 
> It all started when Windows/95 ruined another CD-R while trying to
> write an image to the media. So I decided to try it with Linux, using
> the same CD writer.
> 
> I plugged the device to the so far unused SCSI channel and used the
> "add-sigle-device" method to avoid reboot, and I succeeded:
> 
> kgate kernel: scsi singledevice 0 0 4 0
> kgate kernel:   Vendor: WAITEC    Model: WT624             Rev: 7.0F
> kgate kernel:   Type:   CD-ROM                             ANSI SCSI
> revision: 0
> kgate kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
> kgate kernel: (scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
> kgate kernel: sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda
> tray
> 
> Then I used "cdrecord-1.8.1" to simulate writing at "speed=8". It
> worked so far, but there was a warning about possible problems with
> "simulated fixation", and actually several minutes nothing happened
> while the simulated fixation was expected to take place.

Evidently some media/cdwriters don't like "simulated
fixation" hence the comment from cdrecord. In your
case the warning seems well founded.

When cdrecord issues the SCSI command to fixate
(0x5b on my Yamaha) it sets a long timeout (480.5
seconds (8 minutes)). To find out the current
state (in the lk 2.4 series) try:

$ cat /proc/scsi/sg/debug 
dev_max(currently)=9 max_active_device=3 (origin 1)
 scsi_dma_free_sectors=512 sg_pool_secs_aval=320 def_reserved_size=32768
 >>> device=sg2 scsi2 chan=0 id=6 lun=0   em=0 sg_tablesize=255 excl=0
   FD(1): timeout=480500ms bufflen=32768 (res)sgat=0 low_dma=0
   cmd_q=0 f_packid=0 k_orphan=0 closed=0
     act: id=4054 blen=0 t_o/elap=480500/9920ms sgat=0 op=0x5b

$ cat /proc/scsi/sg/debug 
dev_max(currently)=9 max_active_device=3 (origin 1)
 scsi_dma_free_sectors=512 sg_pool_secs_aval=320 def_reserved_size=32768
 >>> device=sg2 scsi2 chan=0 id=6 lun=0   em=0 sg_tablesize=255 excl=0
   FD(1): timeout=480500ms bufflen=32768 (res)sgat=0 low_dma=0
   cmd_q=0 f_packid=0 k_orphan=0 closed=0
     act: id=4054 blen=0 t_o/elap=480500/13840ms sgat=0 op=0x5b

The last line of these 2 commands shows that SCSI command
0x5b is active with a timeout value of 480500 milliseconds.
9.92 seconds has elapsed when the first 'cat'
was executed and 13.8 seconds had elapsed when
the second one was executed. In my test case
the "dummy fixate" concluded successfully. But what if
it locked up the cdwriter, as the warning hints at?

There is no way that I know of to cancel
a command once it is "active". The timeout
will get it (usually by the brute force
technique of resetting the SCSI bus). [I
have toyed with the idea of trying to shorten
the timeout of an active command.]
 
> At some point I hit ^C, returning to the prompt. As the device did not
> seem to be ready, I thought "remove the device and reconnect", so I did
> "remove-single-device" (possibly while a command was still "busy"). The
> remove suceeded, but a second later everything had stopped!

Things _not_ to do while there is an active
SCSI command still executing:
  - remove a module that it is using
    (e.g. sg, aic7xxx, scsi_mod).
    In most (but not all) cases rmmod will 
    report the module is busy.
  - use remove-single-device
 
> Should a device with busy commands be able to be removed? I guess no...

Correct.
 
> The last message in the syslog was:
> 
> kgate kernel: scsi : aborting command due to timeout : pid 8358,
>  scsi0, channel 0, id 4, lun 0 UNKNOWN(0x5b) 00 02 00 00 00 00 00 00 00
> 
> At that point I pressed "RESET", and interestingly the builtin BIOS of
> the Adaptec 2740 (EISA) hung while trying to detect the device.

In my experience cdwriters are not always well behaved
SCSI devices and can lockup and not respond to SCSI
bus resets. This means you need to power cycle them
to get them back into a functional mode. It is also
a good reason _not_ to have SCSI cdwriters (and scanners)
on the same SCSI bus as high speed modern SCSI disks.
Luckily they tend to use different SCSI parallel bus
types.
 
> Only after powering down both, the CD writer and the machine (a HP
> Netserver LD Pro), the BIOS detected the device again. So I guess
> something badly hung...
> 
> The driver being used was
> Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
> 
> After that, everything worked fine.

Thanks for the report. Hopefully everything worked ok
when you did _not_ use the "dummy" option in cdrecord.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
