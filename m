Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTFCUFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTFCUFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:05:21 -0400
Received: from gw.netgem.com ([195.68.2.34]:38667 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S264091AbTFCUFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:05:16 -0400
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
From: Jocelyn Mayer <jma@netgem.com>
To: Ben Collins <bcollins@debian.org>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603185421.GB10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
	 <20030602163443.2bd531fb.georgn@somanetworks.com>
	 <1054588832.4967.77.camel@jma1.dev.netgem.com>
	 <20030603113636.GX10102@phunnypharm.org>
	 <1054663917.4967.99.camel@jma1.dev.netgem.com>
	 <20030603185421.GB10102@phunnypharm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054671619.4951.139.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jun 2003 22:20:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 20:54, Ben Collins wrote:
> > First, I never trust hotplug or other tools like this:
> > I do all insmod by hand, so I know all drivers have been loaded.
> > What is hotplug supposed to do (but wasn't in previous driver
> > version...) ?
> 
> I didn't say CONFIG_HOTPLUG, I said hotplug. Basically SCSI in 2.4 will
> not let recognize devices that were not present when the scsi-host was
> initially registered with the SCSI stack. You have to run
> rescan-scsi-bus.sh (or manually send the add/remove commands via
> procfs).
> 
> Please read the linux-kernel and/or linux1394-devel mailing list
> archives. I really hate dredging this all up again.

Well, I did understand well hotplug...
I did read what's said about SBP2 on linux1394.org, BUT:

please read my latest mail, I did some try with the 2.4.21-rc1 ieee1394
stack, without /sbin/hotplug, and it worked.
I have neither rescan-scsi-bus.sh, nor scsiadd anywhere on this machine.
So, I'm sure that no user-space tool have been called by the kernel.

- I NEVER need to do an "echo ... > /proc/scsi/scsi" to see the device
  (I tell again that I never use automatic tools to do this kind of
   low level stuffs).
- I NEVER have to do this to see an USB mass-storage device:
  I'm *REALLY* sure of this, as I wrote a very simple hotplug
  and automounter for some embedded hardware which uses USB mass
  storage devices. So, I don't see why SBP2 should need this...

- Please take a look at this session:
First, I reboot the Ibook:

root:~$ reboot
root:~$ 
Broadcast message from root (pts/0) (Tue Jun  3 22:06:13 2003):

The system is going down for reboot NOW!
Connection to mac closed by remote host.
Connection to mac closed.
jma ~ > ssh jocelyn@mac
jocelyn@mac's password: 
jocelyn:~$ su -
Password: 
root:~$ ls -l /bin/hotplug
ls: /bin/hotplug: No such file or directory
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ cat
/proc/sys/kernel/hotplug 
/sbin/hotplug
root:~$ cd /lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394/
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
./ieee1394.o
 
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
./cmp.o 
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ cat
/proc/scsi/scsi
 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
  Type:   CD-ROM                           ANSI SCSI revision: 02
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
./ohci1394.o
 
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
./amdtp.o 
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
../scsi/sd_m
od.o 
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ insmod
./sbp2.o 
root:/lib/modules/2.4.21-rc6-compat/kernel/drivers/ieee1394$ cat
/proc/scsi/scsi
 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX800E   Rev: 1.3p
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor 6 Model: Y080L0           Rev: YAR4
  Type:   Direct-Access                    ANSI SCSI revision: 06


So I NEVER write anything to /proc/scsi/scsi,
I got NO /sbin/hotplug, I use only insmod,
so I can have no side-effect due to modprobe usage,
and it works PERFECTLY on the Ibook, 
using the 2.4.21-rc1 ieee1394 stack.

So, I'm sorry, but I keep thinking the new driver is buggy:
what used to work and doesn't...


Regards.

-- 
Jocelyn Mayer <jma@netgem.com>

