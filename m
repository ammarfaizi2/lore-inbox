Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRCGVhR>; Wed, 7 Mar 2001 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131207AbRCGVhI>; Wed, 7 Mar 2001 16:37:08 -0500
Received: from jaws.cisco.com ([198.135.0.150]:12508 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S131205AbRCGVg5>;
	Wed, 7 Mar 2001 16:36:57 -0500
Date: Wed, 7 Mar 2001 21:36:25 +0000
From: Derek Fawcus <dfawcus@cisco.com>
To: Jens Axboe <axboe@suse.de>, Pozsar Balazs <pozsy@sch.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <20010307213625.A28742@uk-view2.cisco.com>
In-Reply-To: <20010307210848.E4653@suse.de> <Pine.GSO.4.30.0103072128180.6575-100000@balu> <20010307213632.H4653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010307213632.H4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 09:36:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 09:36:32PM +0100, Jens Axboe wrote:
> On Wed, Mar 07 2001, Pozsar Balazs wrote:
> > Details: (dmesg)
> > 
> > When I run "dvdinfo /dev/hdd" I get:
> > Disc is encrypted.
> > Layer 0[3]
> >  Num Layers:     2
> >  Start Sector    0xd000
> >  End Sector      0xd000
> >  End Sector L0   0xd000

> > Layer 1[3]
> >  Num Layers:     2
> >  Start Sector    0xd000
> >  End Sector      0x1d000
> >  End Sector L0   0xd000

> > hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
> > hdd: packet command error: error=0x50
> > ATAPI device hdd:
> >   Error: Illegal request -- (Sense key=0x05)
> >   Invalid field in command packet -- (asc=0x24, ascq=0x00)
> >   The failed "Send DVD Structure" packet command was:
> >   "ad 00 00 00 00 00 02 00 00 54 00 00 "
> > Could not read Physical layer 2
> > Copyright: CPST=1, RMI=0xfd
> 
> I don't know the program you mention, but it's definitely buggy. It
> sets byte 6 to 0x02 which is not valid at all.

The program is attempting to read from the third layer!  Thats why it
fails.  This value gets set from the .layer_num element supplied
in the struct dvd_physical supplied to the ioctl call.

> Byte 7 is the format code, but 0x02 is reserved there too. Who wrote
> this program? Tell him it's buggy, it's not the driver.

Originally me (a couple of years ago),  and I'm not supprised at it 
being buggy,  it was a simple program to explore a couple of the
ioctl calls.  I never got particularly sensible data from a multi-layer
DVD (maybe the firmware in my drives is dodgy).

the original code was something like:

  dvd_struct d;
  int layer, layers = 4;

  d.physical.type = DVD_STRUCT_PHYSICAL;

  for (layer = 0; layer < layers; ++layer) {
    d.physical.layer_num = layer;

    ioctl(fd, DVD_READ_STRUCT, &d);

    printf("Layer %d[%d]\n", layer, layers);
    display data in d.physical.layer[layer]

    layers = d.physical.layer[layer].nlayers + 1;
  }

This was from observations of the data returned by my DVD drive,  where
the .nlayers was always returned as 0 or 1 for single or dual layer
discs,  and always as 0 for flippers.  Having a drive return the number
of layers as 2 doesn't agree with this.  Unless his drive is simply
returning 1 based numbers,  whereas mine returned 0 based numbers.

Actually I never forund the API especially sensible - this could just be
due to the data I saw back from my DVD drive.

The way I interpreted this API is that one requests the layer number to
read the data from,  and that index in the array would be filled in with
data.  However this seems a bit pointless - if only one layers worth of
data will be returned at a time,  then why have an array of 4 entries?

Or is it intended that you should be able to read identical data from
either layer (on either side).  That all layers on the disk would have
had this structure physically recorded identically,  and that for a
disk with n 'layers',  n elements of the array will be filled as
appropriate.

On my drive for array indicies > 0 the data in the structure elements
is always 0.  It also makes no difference which layer I read (assuming
that its actually dual layer),  the results of the 2 ioctl calls are
identical.

DF
