Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131202AbRCGVpR>; Wed, 7 Mar 2001 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRCGVpI>; Wed, 7 Mar 2001 16:45:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12302 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131202AbRCGVo6>;
	Wed, 7 Mar 2001 16:44:58 -0500
Date: Wed, 7 Mar 2001 22:44:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Derek Fawcus <dfawcus@cisco.com>
Cc: Pozsar Balazs <pozsy@sch.bme.hu>, linux-kernel@vger.kernel.org
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <20010307224424.R4653@suse.de>
In-Reply-To: <20010307210848.E4653@suse.de> <Pine.GSO.4.30.0103072128180.6575-100000@balu> <20010307213632.H4653@suse.de> <20010307213625.A28742@uk-view2.cisco.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20010307213625.A28742@uk-view2.cisco.com>; from dfawcus@cisco.com on Wed, Mar 07, 2001 at 09:36:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07 2001, Derek Fawcus wrote:
> > > hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
> > > hdd: packet command error: error=0x50
> > > ATAPI device hdd:
> > >   Error: Illegal request -- (Sense key=0x05)
> > >   Invalid field in command packet -- (asc=0x24, ascq=0x00)
> > >   The failed "Send DVD Structure" packet command was:
> > >   "ad 00 00 00 00 00 02 00 00 54 00 00 "
> > > Could not read Physical layer 2
> > > Copyright: CPST=1, RMI=0xfd
> > 
> > I don't know the program you mention, but it's definitely buggy. It
> > sets byte 6 to 0x02 which is not valid at all.
> 
> The program is attempting to read from the third layer!  Thats why it
> fails.  This value gets set from the .layer_num element supplied
> in the struct dvd_physical supplied to the ioctl call.
> 
> > Byte 7 is the format code, but 0x02 is reserved there too. Who wrote
> > this program? Tell him it's buggy, it's not the driver.
> 
> Originally me (a couple of years ago),  and I'm not supprised at it 
> being buggy,  it was a simple program to explore a couple of the
> ioctl calls.  I never got particularly sensible data from a multi-layer
> DVD (maybe the firmware in my drives is dodgy).

The report sense was buggy, and that fooled me. The cdb is not wrong
at all, apart from the length which you mention further on. It's a
READ_DVD_STRUCTURE command, not a SEND_DVD_STRUCTURE.

> the original code was something like:
> 
>   dvd_struct d;
>   int layer, layers = 4;
> 
>   d.physical.type = DVD_STRUCT_PHYSICAL;
> 
>   for (layer = 0; layer < layers; ++layer) {
>     d.physical.layer_num = layer;
> 
>     ioctl(fd, DVD_READ_STRUCT, &d);
> 
>     printf("Layer %d[%d]\n", layer, layers);
>     display data in d.physical.layer[layer]
> 
>     layers = d.physical.layer[layer].nlayers + 1;
>   }

Much the same today, the program was forwarded to me ;-)

> The way I interpreted this API is that one requests the layer number to
> read the data from,  and that index in the array would be filled in with
> data.  However this seems a bit pointless - if only one layers worth of
> data will be returned at a time,  then why have an array of 4 entries?

Really good question, I sent this patch in the private thread between
me and Pozsar just in case the length is what the drive complains about.

-- 
Jens Axboe


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dvd-read-phys-1

--- /opt/kernel/linux-2.4.3-pre2/drivers/cdrom/cdrom.c	Thu Feb 22 14:55:22 2001
+++ drivers/cdrom/cdrom.c	Wed Mar  7 22:25:14 2001
@@ -1172,7 +1172,7 @@
 static int dvd_read_physical(struct cdrom_device_info *cdi, dvd_struct *s)
 {
 	int ret, i;
-	u_char buf[4 + 4 * 20], *base;
+	u_char buf[20], *base;
 	struct dvd_layer *layer;
 	struct cdrom_generic_command cgc;
 	struct cdrom_device_ops *cdo = cdi->ops;

--zhXaljGHf11kAtnf--
