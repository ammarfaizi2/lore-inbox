Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJGQ3w>; Mon, 7 Oct 2002 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbSJGQ3w>; Mon, 7 Oct 2002 12:29:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5609 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261224AbSJGQ3u>;
	Mon, 7 Oct 2002 12:29:50 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 3/4: evms_ioctl.h
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEADEC58E.F70F8BE4-ON85256C4B.004F8C03@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Mon, 7 Oct 2002 11:43:30 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/07/2002 12:34:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2002 at 10:00 AM, Christoph Hellwig wrote:

> > +#ifdef __KERNEL__

> Nuke this.  kernel he3aders aren't for userspace anyway.

At one point, userspace did share this header file.
That hasn't been the case for a while, so this has
been removed.

> > +#define EVMS_CHECK_MEDIA_CHANGE         _IO(EVMS_MAJOR, >
EVMS_CHECK_MEDIA_CHANGE_NUMBER)
> > +
> > +#define EVMS_REVALIDATE_DISK_STRING     "EVMS_REVALIDATE_DISK"
> > +#define EVMS_REVALIDATE_DISK            _IO(EVMS_MAJOR,
EVMS_REVALIDATE_DISK_NUMBER)

> Can't you use normal revalidate/media change operations?

For most plugins, except the device manager, this operation
was nothing more than an exercise in routing the operation
requests to the underlying devices. Since this routing code
already exists in the ioctl interface, it seemed reasonable
to just reuse it for this purpose as well. As a result,
each plugin had to add 0 lines of code to support this.

> > +
> > +#define EVMS_OPEN_VOLUME_STRING         "EVMS_OPEN_VOLUME"
> > +#define EVMS_OPEN_VOLUME                _IO(EVMS_MAJOR,
EVMS_OPEN_VOLUME_NUMBER)
> > +
> > +#define EVMS_CLOSE_VOLUME_STRING        "EVMS_CLOSE_VOLUME"
> > +#define EVMS_CLOSE_VOLUME               _IO(EVMS_MAJOR,
EVMS_CLOSE_VOLUME_NUMBER)

> if you need open/close ioctl you got some abstraction wrong..

In EVMS, because of removable media devices, we chose to
open/close the underlying devices only when an actual
open/close is received for a volume residing on the
devices. This allows removable media devices to remain
unlocked until they are in use.

> > +/**
> > + * struct evms_sector_io_pkt - sector io ioctl packet definition
> > + * @disk_handle:   disk handle of target device
> > + * @io_flag:       0 = read, 1 = write
> > + * @starting_sector:     disk relative starting sector
> > + * @sector_count:  count of sectors
> > + * @buffer_address:      user buffer address
> > + * @status:        return operation status
> > + *
> > + * ioctl packet definition for EVMS_SECTOR_IO ioctl
> > + **/
> > +struct evms_sector_io_pkt {
> > + u64 disk_handle;
> > + s32 io_flag;
> > + u64 starting_sector;
> > + u64 sector_count;
> > + u8 *buffer_address;
> > + s32 status;
> > +};

> You don't use an ioctl to read into a user supplied buffer??

This ioctl is used by our userspace tools. EVMS stores
metadata at the very end of devices. This ioctl was
initially done to avoid the problem of "short writes"
to those last sectors. It also allows the core to
control which devices userspace can address.

> > +/**
> > + * struct evms_compute_csum_pkt - compute checksum ioctl packet
definition
> > + * @buffer_address:
> > + * @buffer_size:
> > + * @insum:
> > + * @outsum:
> > + * @status:
> > + *
> > + * ioctl packet definition for EVMS_COMPUTE_CSUM ioctl
> > + **/
> > +struct evms_compute_csum_pkt {
> > + u8 *buffer_address;
> > + s32 buffer_size;
> > + u32 insum;
> > + u32 outsum;
> > + s32 status;
> > +};

> An ioctl to compute a checksum??

MD uses checksum routines. Rather than duplicating
this code, we provided a method, for our usertools,
of using the kernel routines, especially considering
there is multiple methods based on various
characteristics.


