Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270474AbTGXDSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 23:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270475AbTGXDSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 23:18:39 -0400
Received: from user145.net484.nc.sprint-hsd.net ([65.40.169.145]:23725 "EHLO
	mail1.lvwnet.com") by vger.kernel.org with ESMTP id S270474AbTGXDSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 23:18:37 -0400
Message-ID: <3F1F5397.8000001@lvwnet.com>
Date: Wed, 23 Jul 2003 23:33:43 -0400
From: Vinnie <listacct1@lvwnet.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 (and newer) - prob with the new adaptec aic7xxx driver and
 Promise UltraTrak100 TX2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Yep, I know... 2.4.19 is old news.  But I have tried this with newer 
official kernels also, same results.  Not expecting anybody to have a quick 
fix (although any suggestions would be really welcome!), but I do feel that 
this should be reported, since I have not seen many other posts indicating 
problems like this with "the new adaptec drivers".

Our primary file server is a dual 1.4GHz Tualatin 512K machine, with a Tyan 
S2688 Serverworks HE-SLt mainboard, 2GB of registered ECC SDRAM (4x512 
modules), which also has an AIC7899 dual channel U160 host adapter onboard.

The only SCSI device currently attached is a Promise UltraTrak100 TX8 - an 
8-bay SCSI-to-ATA RAID subsystem, with eight 120GB Western Digital drives 
configured as a 7-drive RAID5 array and 1 non-assigned hot spare.  The 
unit's SCSI interface can run 80MB/sec U2W/LVD (and unit's SCSI ID is 
configured appropriately in the HA BIOS.  The internal ribbon cable from 
motherboard to external connector is a custom-made Granite Digital teflon 
cable, and I am also using a Granite Digital Active Terminator to terminate 
the bus (at the TX8).  Using the external cable supplied by Promise with the 
unit.

Note: Problem is reproducible with an Adaptec AHA-2940U2W used as the host 
adapter instead.

In a nutshell, the problem goes like this:

If I compile the kernel to use the NEW aic7xxx adaptec driver, the SCSI bus 
hangs almost immediately upon commencement of a large write operation, such 
as attempting to copy a 500MB file from one of the internal client machines 
to a SMB shared directory on this server.  The problem is reproducible on 
2.4.19 and 2.4.20 kernels, if I use the "new" aic7xxx driver.

The SCSI bus completely hangs, leaving the "SEL" (SCSI Select signal) light 
of my SCSIVue LED pack lit solid yellow until I cycle the power on the 
Promise unit.  The screen fills up with details of SCSI errors, data 
overruns, sending  abort commands, etc.  Unfortunately very few of them make 
it into the system log, because by then, the server can't write to the logs 
anymore.  I have to restart the server once this happens.

On the kernel I normally run (a customized 2.4.18 kernel), I have no such 
problems.  I did have to do a bit of tweeking to the HA settings when I 
first got the promise unit, discovering for example that I needed to turn 
"Allow Disconnect" OFF for the unit's SCSI ID, to keep things running well. 
  Not a problem really since it's the only device on the chain (right now, 
anyway... )


Unfortunately since this server also runs mdp-style "partitioned" md raid1 
arrays with pairs of IDE drives (Neil Brown's mdp patches), I am limited to 
trying kernels for which a good set of mdp patches exist for.

 From the documentation I have on the Promise unit, I know it can handle up 
to 32 tagged commands queued, so I have 32 set in the kernel config options 
instead of the default 253.

One snip from the logs I have been able to find, though:

Jul 21 21:16:13 vince500 kernel: scsi logging level set to 0x00000003
Jul 21 21:18:14 vince500 kernel: (scsi1:A:0:0): data overrun detected in 
Data-out phase.  Tag == 0x3.
Jul 21 21:18:14 vince500 kernel: (scsi1:A:0:0): Have seen Data Phase. 
Length = 524288.  NumSGs = 128.
Jul 21 21:18:14 vince500 kernel: sg[0] - Addr 0x03169f000 : Length 4096
Jul 21 21:18:14 vince500 kernel: sg[1] - Addr 0x03169e000 : Length 4096
Jul 21 21:18:14 vince500 kernel: sg[2] - Addr 0x03169d000 : Length 4096
(50+ lines like the 3 lines above continue in the logs)

I have seen a few other people report similar problems with other devices, 
hard drives, CDROM's, etc.  I have a little trouble believing it is a defect 
in the SCSI implementation on the Promise unit, since it does work OK with 
the 2.4.18 and previous drivers.  I'm not saying it's impossible, just that 
I am hesitant to blame it on the unit.

Also, just to note - I have a symlink to the scsi includes 
(/usr/include/scsi) which points to /usr/src/linux/include/scsi 
(/usr/src/linux is itself a symlink which points to the current kernel 
source tree, so when I build a kernel on a different version of the source, 
I change the /usr/src/linux symlink to point to it and the rest are 
automatically fixed also).  I have the same for /usr/include/asm (to 
/usr/src/linux/include/asm-i386 and /usr/include/linux to 
/usr/src/linux/include/linux).

If anybody does have any suggestions, thanks in advance.  But I mainly 
wanted to just report this.  If need be, I can make a mount point for the 
system logs on one of the RAID1 pairs, so that I can capture more of the 
error messages and post them.

Thanks,
vinnie










