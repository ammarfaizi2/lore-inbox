Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFJTpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFJTpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFJTpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:45:46 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:51105 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261187AbVFJTpX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:45:23 -0400
X-IronPort-AV: i="3.93,190,1115010000"; 
   d="scan'208"; a="252994226:sNHT26205692"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Date: Fri, 10 Jun 2005 14:45:22 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3BC@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Thread-Index: AcVsTHu6pXOc5sF6T2+92wDymh/IQgBprSrg
From: <Abhay_Salunke@Dell.com>
To: <dtor_core@ameritech.net>, <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>,
       <ranty@debian.org>
X-OriginalArrivalTime: 10 Jun 2005 19:45:22.0634 (UTC) FILETIME=[F09F32A0:01C56DF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > -----Original Message-----
> > > > From: Greg KH [mailto:greg@kroah.com]
> > > > Sent: Wednesday, June 08, 2005 11:10 AM
> > > > To: Salunke, Abhay
> > > > Cc: dtor_core@ameritech.net; linux-kernel@vger.kernel.org;
> > > akpm@osdl.org;
> > > > Domsch, Matt; ranty@debian.org
> > > > Subject: Re: [patch 2.6.12-rc3] modifications in
firmware_class.c to
> > > > support nohotplug
> > > >
> > > > On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com
> > > wrote:
> > > > > > I think it would be better if you just have request_firmware
and
> > > > > > request_firmware_nowait accept timeout parameter that would
> > > override
> > > > > > default timeout in firmware_class. 0 would mean use default,
> > > > > > MAX_SCHED_TIMEOUT - wait indefinitely.
> > > > >
> > > > > But we still need to avoid hotplug being invoked as we need it
be
> a
> > > > > manual process.
> > > >
> > > > No, hotplug can happen just fine (it happens loads of times
today
> for
> > > > things that people don't care about.)
> > > >
> > > If hotplug happens the complete function is called which makes the
> > > request_firmware return with a failure.
> >
> > If this was true, then the current code would not work at all.
> >
> 
> What Abhay is trying to say is that default firmware.agent when it
> does not find requested firmware file writes -1 (abort) to "loading"
> attribute causing firmware_request to fail.
> 
> I think it should be fixed in firmware.agent though, not in kernel -
> the agent shoudl just recognoze that sometimes not having firmware
> file is ok.
> 
I tired to do the following 
1. echo 0 > /sys/class/firmware/timeout
2. modify the firmware.agent by commenting echo -1 when file is not
present as below.

    if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
        echo 1 > $SYSFS/$DEVPATH/loading
        cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
        echo 0 > $SYSFS/$DEVPATH/loading
    else
   #     echo -1 > $SYSFS/$DEVPATH/loading
    Fi
3. load the dell_rbu driver : see dell_rbu code snipped below

device_initialize(&rbu_device);

strncpy(rbu_device.bus_id,"dell_rbu", BUS_ID_SIZE);

rc = request_firmware_nowait(THIS_MODULE,
		"dell_rbu", &rbu_device,
		&context,
		callbackfn);
	if(rc) {
		printk(KERN_ERR 
			"dcdrbu_init:"
			" request_firmware_nowait failed %d\n", rc);
	}

But this created a kernel Oops message as follows. Also note that
uncomment the line in firmware.agents fixed the Oops message.

Jun 10 19:29:39 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Jun 10 19:29:39 localhost kernel:  printing eip:
Jun 10 19:29:39 localhost kernel: c0188b71
Jun 10 19:29:39 localhost kernel: *pde = 1fabe001
Jun 10 19:29:39 localhost kernel: Oops: 0000 [#2]
Jun 10 19:29:39 localhost kernel: SMP
Jun 10 19:29:39 localhost kernel: Modules linked in: dell_rbu(U) smbfs
parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack
iptable_filter ip_tables button battery ac md5 ipv6 ohci_hcd tg3 floppy
sg dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod mptscsih mptbase sd_mod
scsi_mod
Jun 10 19:29:39 localhost kernel: CPU:    1
Jun 10 19:29:39 localhost kernel: EIP:    0060:[<c0188b71>]    Not
tainted VLI
Jun 10 19:29:39 localhost kernel: EFLAGS: 00010286   (2.6.9-5.ELsmp)
Jun 10 19:29:39 localhost kernel: EIP is at object_path_length+0x10/0x25
Jun 10 19:29:39 localhost kernel: eax: 00000000   ebx: 00000001   ecx:
ffffffff   edx: e0a8fb24
Jun 10 19:29:39 localhost kernel: esi: de3c089c   edi: 00000000   ebp:
dde2b000   esp: d7a3fe4c
Jun 10 19:29:40 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jun 10 19:29:40 localhost kernel: Process bash (pid: 2825,
threadinfo=d7a3f000 task=d739e630)
Jun 10 19:29:40 localhost kernel: Stack: 00000003 e0a8fb24 c0188cf8
e0a8fb24 c031fdc0 de3c089c e0a8fb24 de1ff188
Jun 10 19:29:40 localhost kernel:        c0188dfa dde2b000 dde2b000
fffffff4 de3c089c d7a3ff0c c0188e47 d7a3f000
Jun 10 19:29:40 localhost kernel:        00000000 de3c089c d7a3ff0c
c0161400 dfe84b00 de3c089c 00000000 dfe84b00
Jun 10 19:29:40 localhost kernel: Call Trace:
Jun 10 19:29:40 localhost kernel:  [<c0188cf8>]
sysfs_get_target_path+0x19/0x59
Jun 10 19:29:40 localhost kernel:  [<c0188dfa>] sysfs_getlink+0xc2/0xe9
Jun 10 19:29:40 localhost kernel:  [<c0188e47>]
sysfs_follow_link+0x26/0x3e
Jun 10 19:29:40 localhost kernel:  [<c0161400>]
link_path_walk+0x8fa/0xba9
Jun 10 19:29:40 localhost kernel:  [<c01619c2>] path_lookup+0x144/0x174
Jun 10 19:29:40 localhost kernel:  [<c0161b06>] __user_walk+0x21/0x51
Jun 10 19:29:40 localhost kernel:  [<c015d0ad>] vfs_stat+0x14/0x3a
Jun 10 19:29:40 localhost kernel:  [<c015d6b6>] sys_stat64+0xf/0x23
Jun 10 19:29:40 localhost kernel:  [<c02c62a3>] syscall_call+0x7/0xb
Jun 10 19:29:40 localhost kernel: Code: fe ff ff e8 82 b1 13 00 e9 3a ff
ff ff 90 31 d2 8b 40 24 42 85 c0 75 f8 89 d0 c3 57 89 c2 53 bb 01 00 00
00 8b 3a 31 c0 83 c9 ff <f2> ae f7 d1 49 8b 52 24 8d 5c 0b 01 85 d2 75
e9 89 d8 5b 5f c3

I guess we need to modify the firmware_class.c code to fix it.
Please let me know your opinions.

Thanks
Abhay

