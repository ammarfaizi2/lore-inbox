Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282934AbRK0Uas>; Tue, 27 Nov 2001 15:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282936AbRK0Uaj>; Tue, 27 Nov 2001 15:30:39 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:37040 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S282934AbRK0Uaa>; Tue, 27 Nov 2001 15:30:30 -0500
Message-ID: <3C03F85B.ACF072D4@oracle.com>
Date: Tue, 27 Nov 2001 21:32:27 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-i8k i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Kamil Iskra <kamil@science.uva.nl>, linux-kernel@vger.kernel.org
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <Pine.LNX.4.33.0111270958320.3391-100000@krakow.science.uva.nl> <3C03CEFB.780622F1@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Kamil,
> 
> thank you for the clear and convincing problem description.
> 
> It's becoming increasingly clear that we need to do something with
> ext3 and laptops.

My Dell Latitude CPx J750GT running RH7.2 and all-ext3 (except
 for my Oracle 9012 database partition) suspends just fine by
 hitting Fn-Suspend without doing anything special. Has been
 working forever and moving to ext3 (built in kernel) hasn't
 changed anything. Resume also works fine - recent log:

Nov 25 20:43:19 dolphin cardmgr[766]: executing: './network suspend xircom_tulip_cb'
Nov 25 20:43:19 dolphin kernel: xircom_suspend(eth0)
Nov 25 20:43:20 dolphin modprobe: modprobe: Can't locate module irlan0
Nov 25 20:43:20 dolphin apmd[704]: User Suspend
Nov 25 23:55:27 dolphin kernel: xircom_remove_one(eth0)
Nov 25 23:55:27 dolphin kernel: tty04 unloaded
Nov 25 23:55:27 dolphin cardmgr[766]: shutting down socket 0
Nov 25 23:55:27 dolphin cardmgr[766]: executing: './network stop xircom_tulip_cb'
Nov 25 23:55:27 dolphin cardmgr[766]: stop cmd exited with status 1
Nov 25 23:55:27 dolphin cardmgr[766]: executing: 'modprobe -r xircom_cb'
Nov 25 23:55:27 dolphin cardmgr[766]: executing: 'modprobe -r cb_enabler'
Nov 25 23:55:27 dolphin kernel: cs: cb_free(bus 2)
Nov 25 23:55:27 dolphin kernel: cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
Nov 25 23:55:27 dolphin kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Nov 25 23:55:27 dolphin kernel: PCI: Setting latency timer of device 02:00.0 to 64
Nov 25 23:55:27 dolphin kernel: eth0: Xircom Cardbus Adapter rev 3 at 0x4000, 00:10:A4:F9:19:A0, IRQ 11.
Nov 25 23:55:27 dolphin kernel: eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
Nov 25 23:55:27 dolphin kernel: PCI: Enabling device 02:00.1 (0000 -> 0003)
Nov 25 23:55:27 dolphin /etc/hotplug/pci.agent: ... no drivers for PCI slot 
Nov 25 23:55:27 dolphin cardmgr[766]: initializing socket 0
Nov 25 23:55:27 dolphin cardmgr[766]: socket 0: Xircom CBEM56G-100 CardBus 10/100 Ethernet + 56K Modem
Nov 25 23:55:27 dolphin kernel: ttyS04 at port 0x4080 (irq = 11) is a 16550A
Nov 25 23:55:27 dolphin kernel: xircom_resume(eth0)
Nov 25 23:55:28 dolphin /etc/hotplug/pci.agent: ... no drivers for PCI slot 
Nov 25 23:55:28 dolphin cardmgr[766]: executing: 'modprobe cb_enabler'
Nov 25 23:55:28 dolphin cardmgr[766]: executing: 'modprobe xircom_cb'
Nov 25 23:55:28 dolphin cardmgr[766]: executing: './network start xircom_tulip_cb'
Nov 25 23:55:28 dolphin sysctl: net.ipv4.ip_forward = 0
Nov 25 23:55:28 dolphin sysctl: net.ipv4.conf.default.rp_filter = 1
Nov 25 23:55:28 dolphin sysctl: kernel.sysrq = 1

...etc, etc...

> I don't understand what can be causing the behaviour which you
> report.  Presumably, some application is generating disk writes,
> and kjournald is thus performing disk IO every five seconds.
> But I don't know why this should prevent the machine from suspending,
> nor why it's different with other filesystems.

[asuardi@dolphin asuardi]$ mount
/dev/hda8 on / type ext3 (rw,noatime)
none on /proc type proc (rw)
/dev/hda2 on /vmware type ext3 (rw,noatime)
/dev/hda3 on /oradata type ext2 (rw,noatime)
/dev/hda6 on /share type ext3 (rw,noatime)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)

> If possible, could you please edit fs/jbd/journal.c and change
> 
>       journal->j_commit_interval = (HZ * 5);
> to
>       journal->j_commit_interval = (HZ * 30);
> 
> Thanks.
> 
> Kamil Iskra wrote:
> >
> > Hi,
> >
> > Kernel 2.4.15 has problems with APM suspend if ext3 filesystem is compiled
> > into the kernel.
> >
> > I noticed the problems on my just acquired Compaq Armada E500 notebook.
> > The problem was also there with kernel 2.4.14 + ext3 patch.  BUT I am
> > almost sure that it worked fine on my old Compaq Armada 7800 with the same
> > 2.4.14 + ext3, so the problem might in some way be influenced by the
> > hardware/BIOS/whatever.
> >
> > The problem is that, when I press the suspend button on the laptop or when
> > I invoke "apm -s", the screen blanks, but the laptop doesn't suspend.

[snipped problem description]

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
