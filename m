Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVLGDaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVLGDaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVLGDaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:30:00 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:3993 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S964814AbVLGD37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:29:59 -0500
Message-ID: <C2EEB4E538D3DC48BF57F391F422779321AE8F@srmanning.eng.emc.com>
From: "goggin, edward" <egoggin@emc.com>
To: "'Patrick Mansfield'" <patmans@us.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: "goggin, edward" <egoggin@emc.com>,
       "'Rolf Eike Beer'" <eike-kernel@sf-tec.de>,
       "'Andrew Morton'" <akpm@osdl.org>,
       Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
Subject: RE: oops with USB Storage on 2.6.14
Date: Tue, 6 Dec 2005 22:29:13 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.12.6.36
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __C230066_P3_4 0, __CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __IMS_MSGID 0, __IMS_MUA 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Patrick Mansfield [mailto:patmans@us.ibm.com] 
> Sent: Tuesday, November 08, 2005 4:33 PM
> To: James Bottomley
> Cc: goggin, edward; 'Rolf Eike Beer'; 'Andrew Morton'; 
> Masanari Iida; linux-kernel@vger.kernel.org; 
> linux-usb-devel@lists.sourceforge.net; linux-scsi@vger.kernel.org
> Subject: Re: oops with USB Storage on 2.6.14
> 
> On Tue, Nov 08, 2005 at 04:08:43PM -0500, James Bottomley wrote:
> > On Tue, 2005-11-08 at 15:02 -0500, goggin, edward wrote:
> > > Thanks!  Here's a better one.
> > 
> > It's line wrapped, but I fixed that up.
> 
> What code path triggered this?

I was testing multipath responsiveness to FC transport failures
by inducing scsi target device removal by writing into the
delete attribute of the scsi device kobject for scsi target
devices managed by multipathd.  The test is simple and involves no
user block read/write IO to the multipath mapped or target devices.
After initial multipath discovery is complete, the only IO going on
to target devices is periodic test paths, for my devices this
amounts to issuing an EVPD page 0xc0 inquiry to each target
device every 10 seconds.

My kernel call stack at the time of panic looks very similar to
the one originally reported by Masanari Iida.  I've shown
Masanari's kernel stack trace below.

> Call Trace:
>  [<c0103abf>] show_stack+0x7f/0xa0
>  [<c0103c72>] show_registers+0x162/0x1d0
>  [<c0103e90>] die+0x100/0x1a0
>  [<c039d7ae>] do_page_fault+0x31e/0x640
>  [<c0103763>] error_code+0x4f/0x54
>  [<c02b4612>] scsi_next_command+0x22/0x30
>  [<c02b473f>] scsi_end_request+0xcf/0xf0
>  [<c02b4b2e>] scsi_io_completion+0x26e/0x470
>  [<c02b4fc7>] scsi_generic_done+0x37/0x50
>  [<c02af9e5>] scsi_finish_command+0x85/0xa0
>  [<c02af89c>] scsi_softirq+0xcc/0x140
>  [<c0122085>] __do_softirq+0xd5/0xf0
>  [<c01220d8>] do_softirq+0x38/0x40
>  [<c0122685>] ksoftirqd+0x95/0xe0
>  [<c0131cfa>] kthread+0xba/0xc0
>  [<c0100ecd>] kernel_thread_helper+0x5/0x18

The scsi command being terminated by scsi_end_request is
an inquiry issued by the multipathd target device testing
thread.

> 
> I mean we get a ref to the sdev in the upper level driver 
> opens, scan, and
> sd flush. So where are we not getting a ref?

Good question.

The ref to the sdev obtained by the device scan has been
dropped by device_del() called from scsi_remove_device()
since the scsi_device has been removed via sysfs control.

The ref held by the dm open of the target device has been
closed when multipathd updates the multipath map to not
include the target device being removed.

The ref held by the multipathd initiated open of the target
device for purposes of issuing a test IO gets removed as
soon as the multipathd test thread is notified of the
completion of its test SG_IO ioctl via the scsi_end_request()
call on the inquiry request I mentioned earlier.
Soon after this point, the target device is closed by
multipathd since there is no more need for test IOs to
be issued to that target device.  Note that this is the last
ref held on the target scsi device by opens or scans and
that it is highly possible on an SMP host for this ref to be
released BEFORE the scsi_end_request() actually returns to
its soft interrupt stack.

At this point, the only refs held on the target scsi device
are from ones for active scsi commands for that device
or for an invocation of scsi_request_fn() servicing the
device's queue.  If the queue is not actively being
serviced and this is the last active command for the
device, the call to scsi_put_command() from
scsi_next_command() will free the memory for both the
scsi device and its request queue will be freed in
scsi_release_dev_release() when the device's kobject's
kref count goes to zero.

> 
> Shouldn't the get be done at a higher level?

As you can see, there are plenty of gets being done at
higher levels.

BTW, I have since reproduced this problem without
multipath at all, just two simple concurrently executing
processes -- one issues an ioctl to a scsi device
although any IO type would likely do) and closes its file
descriptor while the second one removes the device via sysfs.  
It seems like the prerequisite sequence of events are

open device
issue io to device
device gets reaped
io completes up to scsi_end_request()
device is closed
scsi_put_command() reduces device kref count to zero, device is freed
scsi_next_command() can reference freed scsi device memory

> 
> -- Patrick Mansfield
> 
