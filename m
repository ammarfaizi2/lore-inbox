Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVLCCVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVLCCVS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVLCCVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:21:18 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:33225 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751157AbVLCCVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:21:17 -0500
Date: Sat, 3 Dec 2005 10:26:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [SCSI BUG 2.6.15-rc3-mm1] scheduling while atomic on boot time
Message-ID: <20051203022618.GA3560@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20051202141455.GA10038@mail.ustc.edu.cn> <20051202113147.600b80cd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202113147.600b80cd.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 11:31:47AM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > My server occasionally crashes on boot time, this has been happening in many
> > recent kernel versions(at least from 2.6.14-rcx). It is rare enough, I setup
> > netconsole and rebooted numerous times, but still failed to catch it. Luckily
> > it happened again this time, and does not panic. Here is the logs. 
> > 
> > Thanks,
> > Wu
> > 
> > Error messages:
> > [4294676.927000] scheduling while atomic: ksoftirqd/0/0x00000200/3
> 
> Which device driver are you using?
> 
> This is just a warning - it won't necessarily cause a crash and in this
> case it didn't appear to do so.

I'm compiling in

CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y

Here is the boot message, notice that the error message appears immediately after the megaraid messages:

[4294674.139000] megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
[4294674.139000] megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
[4294674.139000] megaraid: probe new device 0x1028:0x000f:0x1028:0x014a: bus 4:slot 3:func 0
[4294674.140000] ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 18 (level, low) -> IRQ 193
[4294674.144000] megaraid: fw version:[412W] bios version:[H406]
[4294674.145000] scsi0 : LSI Logic MegaRAID driver
[4294674.145000] scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
[4294674.914000]   Vendor: PE/PV     Model: 1x3 SCSI BP       Rev: 1.1 
[4294674.915000]   Type:   Processor                          ANSI SCSI revision: 02
[4294676.927000] scheduling while atomic: ksoftirqd/0/0x00000200/3

# lsmod
Module                  Size  Used by
nfsd                  234180  8
exportfs                6688  1 nfsd
lockd                  65192  2 nfsd
nfs_acl                 4224  1 nfsd
sunrpc                154460  3 nfsd,lockd,nfs_acl
ipx                    32292  0
p8023                   2272  1 ipx
af_packet              23528  4
ipt_TOS                 2688  4
iptable_mangle          3136  1
iptable_nat             8004  0
iptable_filter          3296  0
ip_tables              23092  4 ipt_TOS,iptable_mangle,iptable_nat,iptable_filter
ip_nat_tftp             2112  0
ip_conntrack_tftp       4504  1 ip_nat_tftp
ip_nat_ftp              3552  0
ip_nat                 19820  3 iptable_nat,ip_nat_tftp,ip_nat_ftp
ip_conntrack_ftp        7824  1 ip_nat_ftp
ip_conntrack           51192  6 iptable_nat,ip_nat_tftp,ip_conntrack_tftp,ip_nat_ftp,ip_nat,ip_conntrack_ftp
serverworks             9192  0 [permanent]
generic                 4900  0 [permanent]
reiserfs              232560  7
ipv6                  270144  46
tun                    12160  0
rtc                    13876  0
floppy                 63204  0
pcspkr                  2436  0
i2c_piix4               9360  0
i2c_core               22144  1 i2c_piix4
sworks_agp              9568  0
agpgart                35224  1 sworks_agp
ohci_hcd               21348  0
usbcore               129860  2 ohci_hcd
tsdev                   8000  0
dm_mod                 61208  8
ipmi_devintf            8872  0
ipmi_watchdog          19296  0
ipmi_si                35972  1
ipmi_msghandler        31712  3 ipmi_devintf,ipmi_watchdog,ipmi_si
psmouse                41444  0
loop                   17352  0
sr_mod                 17156  0
evdev                  10016  0
mousedev               12112  1
unix                   29648  43

> I seem to recall diagnosing this exact locking problem a month or so ago,
> and cc'ing linux-scsi on that analysis.

I find it, thank you.
http://marc.theaimsgroup.com/?l=linux-scsi&m=112737270900397&w=2

Wu
