Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTKBBw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 20:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTKBBw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 20:52:59 -0500
Received: from b.frontend.um.mediaways.net ([62.53.231.7]:8070 "HELO
	b.frontend.um.mediaways.net") by vger.kernel.org with SMTP
	id S261309AbTKBBwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 20:52:51 -0500
From: Erich von Sinnen <leitzentrale@telebel.de>
Organization: Ministerium =?utf-8?q?f=C3=BCr?= =?utf-8?q?=20=C3=84u=C3=9Ferstes?=
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9: [8139too].[pmdisk] rmmod
Date: Sun, 2 Nov 2003 02:52:41 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311020252.42369.leitzentrale@telebel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Summary of bugs: 

1) ifdown eth[0-2] && rmmod 8139too ends in: 
kernel: unregister_netdevice: waiting for eth0 to become free. Usage 
count=1
(endless loop, machine unusable)

2) echo -n disk > /sys/power/state 
bad: scheduling while atomic!
kernel:  [<d10a624f>] rtl8139_suspend+0x6f/0xa0 [8139too]
kernel:  [pci_device_suspend+40/48] pci_device_suspend+0x28/0x30


The success story is: the kernel compiles, boots and does it's job. This
motherboard got tree rtl- network chips on board, two of them configured
and running. Now I'm playing with the suspend to disk features ...

First try as in 2) gives exactly tree Oops (full output below) while 
trying
suspending the ether devices.
So rebooted, and tried over with unloading the 8139too module first. 
pmdisk
worked(!) that way in test-3. But first look at this:

$ lsmod

Module                  Size  Used by
sg                     37336  0
sr_mod                 17156  0
via686a                19272  0
eeprom                  7016  0
i2c_sensor              2976  2 via686a,eeprom
i2c_dev                10400  0
i2c_viapro              6892  0
i2c_core               24840  5 
via686a,eeprom,i2c_sensor,i2c_dev,i2c_viapro
longhaul                6704  0
sd_mod                 14816  0
scsi_mod              116216  3 sg,sr_mod,sd_mod
ide_floppy             17728  0
ide_cd                 39396  0
cdrom                  33696  2 sr_mod,ide_cd
md5                     3968  1
ipv6                  247520  14
snd_seq_oss            32576  0
snd_seq_midi_event      7872  1 snd_seq_oss
snd_seq                53264  4 snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            52292  0
snd_mixer_oss          17856  1 snd_pcm_oss
snd_via82xx            23776  0
snd_pcm                96932  2 snd_pcm_oss,snd_via82xx
snd_timer              24868  2 snd_seq,snd_pcm
snd_ac97_codec         49796  1 snd_via82xx
snd_page_alloc         11492  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7392  1 snd_via82xx
snd_rawmidi            24736  1 snd_mpu401_uart
snd_seq_device          7784  3 snd_seq_oss,snd_seq,snd_rawmidi
snd                    51300  12
snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9152  1 snd
ipt_REJECT              6176  1
ipt_multiport           1824  2
ipt_LOG                 5280  7
ipt_limit               2304  23
ipt_state               1728  20
ipt_MASQUERADE          4264  1
iptable_nat            28556  2 ipt_MASQUERADE
ip_conntrack           39940  3 ipt_state,ipt_MASQUERADE,iptable_nat
iptable_filter          2624  1
ip_tables              20512  8
ipt_REJECT,ipt_multiport,ipt_LOG,ipt_limit,ipt_state,ipt_MASQUERADE,iptable_nat,iptable_filter
af_packet              21672  4
8139too                23008  0
mii                     4928  1 8139too
crc32                   4320  1 8139too
psmouse                16748  0
agpgart                31720  0
pcspkr                  3460  0
thermal                19280  0
processor              21284  1 thermal
fan                     5196  0
button                  7928  0
battery                12012  0
ac                      6668  0
uhci_hcd               31760  0
usbcore               107644  3 uhci_hcd
rtc                    12440  0


The 8139too counter is zero while two of tree devices are up.

$ lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] 
(rev
05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
AC97
Audio Controller (rev 50)
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 
(rev
6a)


$ /etc/init.d/network stop
[no problems]
$ rmmod 8139too

Oct 31 20:58:09 denon /sbin/hotplug: arguments (net) env (OLDPWD=/
DEVPATH=/class/net/eth0 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTI
ON=remove PWD=/etc/hotplug SHLVL=1 HOME=/ INTERFACE=eth0 DEBUG=yes
SEQNUM=159 _=/bin/env)
Oct 31 20:58:09 denon /sbin/hotplug: invoke /etc/hotplug/net.agent ()
Oct 31 20:58:09 denon /sbin/hotplug: arguments (net) env (OLDPWD=/
DEVPATH=/class/net/eth1 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTI
ON=remove PWD=/etc/hotplug SHLVL=1 HOME=/ INTERFACE=eth1 DEBUG=yes
SEQNUM=160 _=/bin/env)
Oct 31 20:58:09 denon /sbin/hotplug: invoke /etc/hotplug/net.agent ()
Oct 31 20:58:09 denon /etc/hotplug/net.agent: NET remove event not 
supported
Oct 31 20:58:09 denon /etc/hotplug/net.agent: NET remove event not 
supported
Oct 31 20:58:19 denon kernel: unregister_netdevice: waiting for eth1 to
become free. Usage count = 1
Oct 31 20:58:20 denon modprobe: FATAL: Module /dev/:0 not found.
Oct 31 20:58:30 denon kernel: unregister_netdevice: waiting for eth1 to
become free. Usage count = 1
Oct 31 20:58:50 denon last message repeated 2 times
Oct 31 20:58:50 denon modprobe: FATAL: Module /dev/:0 not found.
Oct 31 20:59:00 denon kernel: unregister_netdevice: waiting for eth1 to
become free. Usage count = 1
Oct 31 20:59:31 denon last message repeated 3 times
Oct 31 20:59:41 denon kernel: unregister_netdevice: waiting for eth1 to
become free. Usage count = 1
Oct 31 20:59:46 denon sudo:    chris : TTY=pts/4 ; PWD=/home/chris ;
USER=root ; COMMAND=/usr/bin/reboot
Oct 31 20:59:48 denon shutdown: shutting down for system reboot

[ fresh reboot, and now lets do a pmsuspend, eth0 and eth1 are up ]

Oct 31 20:45:49 denon kernel: Stopping tasks:
===================================================|
Oct 31 20:45:49 denon kernel: Freeing memory: .........................|
Oct 31 20:45:49 denon kernel: hdc: start_power_step(step: 0)
Oct 31 20:45:49 denon kernel: hdc: start_power_step(step: 1)
Oct 31 20:45:49 denon kernel: hdc: complete_power_step(step: 1, stat: 
50,
err: 0)
Oct 31 20:45:49 denon kernel: hdc: completing PM request, suspend
Oct 31 20:45:49 denon kernel: bad: scheduling while atomic!
Oct 31 20:45:49 denon kernel: Call Trace:
Oct 31 20:45:49 denon kernel:  [schedule+1494/1552] schedule+0x5d6/0x610
Oct 31 20:45:49 denon kernel:  [<c011c4f6>] schedule+0x5d6/0x610
Oct 31 20:45:49 denon kernel:  [__mod_timer+214/400] 
__mod_timer+0xd6/0x190
Oct 31 20:45:49 denon kernel:  [<c0126e16>] __mod_timer+0xd6/0x190
Oct 31 20:45:49 denon kernel:  [schedule_timeout+88/192]
schedule_timeout+0x58/0xc0
Oct 31 20:45:50 denon kernel:  [<c01278f8>] schedule_timeout+0x58/0xc0
Oct 31 20:45:50 denon kernel:  [process_timeout+0/16]
process_timeout+0x0/0x10
Oct 31 20:45:50 denon kernel:  [<c0127890>] process_timeout+0x0/0x10
Oct 31 20:45:50 denon kernel:  [pci_set_power_state+217/352]
pci_set_power_state+0xd9/0x160
Oct 31 20:45:50 denon kernel:  [<c01d7ee9>] 
pci_set_power_state+0xd9/0x160
Oct 31 20:45:50 denon kernel:  [__crc_ata_vlb_sync+462959/2583417]
rtl8139_suspend+0x6f/0xa0 [8139too]
Oct 31 20:45:51 denon kernel:  [<d10a624f>] rtl8139_suspend+0x6f/0xa0
[8139too]
Oct 31 20:45:51 denon kernel:  [pci_device_suspend+40/48]
pci_device_suspend+0x28/0x30
Oct 31 20:45:51 denon kernel:  [<c01da028>] pci_device_suspend+0x28/0x30
Oct 31 20:45:52 denon kernel:  [suspend_device+104/176]
suspend_device+0x68/0xb0
Oct 31 20:45:52 denon kernel:  [<c0232378>] suspend_device+0x68/0xb0
Oct 31 20:45:52 denon kernel:  [device_suspend+95/128]
device_suspend+0x5f/0x80
Oct 31 20:45:52 denon kernel:  [<c023241f>] device_suspend+0x5f/0x80
Oct 31 20:45:52 denon kernel:  [prepare+46/144] prepare+0x2e/0x90
Oct 31 20:45:52 denon kernel:  [<c013805e>] prepare+0x2e/0x90
Oct 31 20:45:52 denon kernel:  [pm_suspend_disk+6/176]
pm_suspend_disk+0x6/0xb0
Oct 31 20:45:52 denon kernel:  [<c01380c6>] pm_suspend_disk+0x6/0xb0
Oct 31 20:45:52 denon kernel:  [enter_state+133/144] 
enter_state+0x85/0x90
Oct 31 20:45:52 denon kernel:  [<c0136025>] enter_state+0x85/0x90
Oct 31 20:45:52 denon kernel:  [state_store+102/105] 
state_store+0x66/0x69
Oct 31 20:45:52 denon kernel:  [<c0136116>] state_store+0x66/0x69
Oct 31 20:45:52 denon kernel:  [subsys_attr_store+45/64]
subsys_attr_store+0x2d/0x40
Oct 31 20:45:52 denon kernel:  [<c018b06d>] subsys_attr_store+0x2d/0x40
Oct 31 20:45:52 denon kernel:  [flush_write_buffer+37/48]
flush_write_buffer+0x25/0x30
Oct 31 20:45:52 denon kernel:  [<c018b2d5>] flush_write_buffer+0x25/0x30
Oct 31 20:45:52 denon kernel:  [sysfs_write_file+56/80]
sysfs_write_file+0x38/0x50
Oct 31 20:45:52 denon kernel:  [<c018b318>] sysfs_write_file+0x38/0x50
Oct 31 20:45:52 denon kernel:  [vfs_write+186/240] vfs_write+0xba/0xf0
Oct 31 20:45:52 denon kernel:  [<c01563ba>] vfs_write+0xba/0xf0
Oct 31 20:45:52 denon kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Oct 31 20:45:52 denon kernel:  [<c015646d>] sys_write+0x2d/0x50
Oct 31 20:45:52 denon kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 31 20:45:52 denon kernel:  [<c01091e7>] syscall_call+0x7/0xb
Oct 31 20:45:52 denon kernel: 
Oct 31 20:45:52 denon kernel: bad: scheduling while atomic!
Oct 31 20:45:52 denon kernel: Call Trace:
Oct 31 20:45:52 denon kernel:  [schedule+1494/1552] schedule+0x5d6/0x610
Oct 31 20:45:52 denon kernel:  [<c011c4f6>] schedule+0x5d6/0x610
Oct 31 20:45:52 denon kernel:  [__mod_timer+214/400] 
__mod_timer+0xd6/0x190
Oct 31 20:45:52 denon kernel:  [<c0126e16>] __mod_timer+0xd6/0x190
Oct 31 20:45:52 denon kernel:  [schedule_timeout+88/192]
schedule_timeout+0x58/0xc0
Oct 31 20:45:52 denon kernel:  [<c01278f8>] schedule_timeout+0x58/0xc0
Oct 31 20:45:52 denon kernel:  [process_timeout+0/16]
process_timeout+0x0/0x10
Oct 31 20:45:52 denon kernel:  [<c0127890>] process_timeout+0x0/0x10
Oct 31 20:45:52 denon kernel:  [pci_set_power_state+217/352]
pci_set_power_state+0xd9/0x160
Oct 31 20:45:52 denon kernel:  [<c01d7ee9>] 
pci_set_power_state+0xd9/0x160
Oct 31 20:45:52 denon kernel:  [__crc_ata_vlb_sync+462959/2583417]
rtl8139_suspend+0x6f/0xa0 [8139too]
Oct 31 20:45:52 denon kernel:  [<d10a624f>] rtl8139_suspend+0x6f/0xa0
[8139too]
Oct 31 20:45:52 denon kernel:  [pci_device_suspend+40/48]
pci_device_suspend+0x28/0x30
Oct 31 20:45:52 denon kernel:  [<c01da028>] pci_device_suspend+0x28/0x30
Oct 31 20:45:52 denon kernel:  [suspend_device+104/176]
suspend_device+0x68/0xb0
Oct 31 20:45:52 denon kernel:  [<c0232378>] suspend_device+0x68/0xb0
Oct 31 20:45:52 denon kernel:  [device_suspend+95/128]
device_suspend+0x5f/0x80
Oct 31 20:45:52 denon kernel:  [<c023241f>] device_suspend+0x5f/0x80
Oct 31 20:45:52 denon kernel:  [prepare+46/144] prepare+0x2e/0x90
Oct 31 20:45:52 denon kernel:  [<c013805e>] prepare+0x2e/0x90
Oct 31 20:45:52 denon kernel:  [pm_suspend_disk+6/176]
pm_suspend_disk+0x6/0xb0
Oct 31 20:45:52 denon kernel:  [<c01380c6>] pm_suspend_disk+0x6/0xb0
Oct 31 20:45:52 denon kernel:  [enter_state+133/144] 
enter_state+0x85/0x90
Oct 31 20:45:52 denon kernel:  [<c0136025>] enter_state+0x85/0x90
Oct 31 20:45:52 denon kernel:  [state_store+102/105] 
state_store+0x66/0x69
Oct 31 20:45:52 denon kernel:  [<c0136116>] state_store+0x66/0x69
Oct 31 20:45:52 denon kernel:  [subsys_attr_store+45/64]
subsys_attr_store+0x2d/0x40
Oct 31 20:45:52 denon kernel:  [<c018b06d>] subsys_attr_store+0x2d/0x40
Oct 31 20:45:52 denon kernel:  [flush_write_buffer+37/48]
flush_write_buffer+0x25/0x30
Oct 31 20:45:52 denon kernel:  [<c018b2d5>] flush_write_buffer+0x25/0x30
Oct 31 20:45:52 denon kernel:  [sysfs_write_file+56/80]
sysfs_write_file+0x38/0x50
Oct 31 20:45:52 denon kernel:  [<c018b318>] sysfs_write_file+0x38/0x50
Oct 31 20:45:52 denon kernel:  [vfs_write+186/240] vfs_write+0xba/0xf0
Oct 31 20:45:52 denon kernel:  [<c01563ba>] vfs_write+0xba/0xf0
Oct 31 20:45:52 denon kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Oct 31 20:45:52 denon kernel:  [<c015646d>] sys_write+0x2d/0x50
Oct 31 20:45:52 denon kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 31 20:45:52 denon kernel:  [<c01091e7>] syscall_call+0x7/0xb
Oct 31 20:45:52 denon kernel: 
Oct 31 20:45:52 denon kernel: eth0: link up, 100Mbps, full-duplex, lpa
0x45E1
Oct 31 20:45:52 denon kernel: eth1: link up, 10Mbps, half-duplex, lpa 
0x0000
Oct 31 20:45:52 denon kernel: hdc: Wakeup request inited, waiting for
!BSY...
Oct 31 20:45:52 denon kernel: hdc: start_power_step(step: 1000)
Oct 31 20:45:52 denon kernel: blk: queue c139b600, I/O limit 4095Mb 
(mask
0xffffffff)
Oct 31 20:45:52 denon kernel: hdc: completing PM request, resume
Oct 31 20:45:52 denon kernel: Restarting tasks... done
Oct 31 20:45:54 denon modprobe: FATAL: Module /dev/apm_bios not found. 
Oct 31 20:46:12 denon kernel: spurious 8259A interrupt: IRQ7.


$ /sbin/ifconfig --version
net-tools 1.60
ifconfig 1.42 (2001-04-13)
$ /sbin/modprobe-25 --version
module-init-tools version 0.9.13


--
Christoph Rudorff
Wuppertal

