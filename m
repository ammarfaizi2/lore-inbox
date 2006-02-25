Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWBYBMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWBYBMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWBYBMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:12:32 -0500
Received: from 69-172-25-214.clvdoh.adelphia.net ([69.172.25.214]:13032 "EHLO
	ever.mine.nu") by vger.kernel.org with ESMTP id S964831AbWBYBMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:12:31 -0500
Date: Fri, 24 Feb 2006 20:12:12 -0500
Message-Id: <200602250112.k1P1CCqm009307@rhodes.mine.nu>
To: petero2@telia.com
CC: linux-kernel@vger.kernel.org
From: linuxer@ever.mine.nu
In-reply-to: <m3ek1v58qi.fsf@telia.com> (message from Peter Osterlund on 22
	Feb 2006 23:28:21 +0100)
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
	<m3r760cntz.fsf@telia.com>
	<200602182335.k1INZFoi012487@rhodes.mine.nu> <m3ek1v58qi.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 petero@p4.localdomain writes:
  > 
  > linuxer@ever.mine.nu writes:
  > 
  > > Peter Osterlund <petero2@telia.com> writes:
  > >   > 
  > >   > linuxer@ever.mine.nu writes:
  > >   > 
  > >   > > In drivers/block/pktcdvd.c it appears that in the case of DVD
  > >   > > rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
  > >   > > (the maximum writing speed reported by the drive). 
  > >   > > 
  > >   > > In my case, I have a new drive capable of 8x re-writing. However, all of
  > >   > > my existing media is rated for only 4x rewrite speed. 
  > >   > > 
  > >   > > When attempting to rw mount these disks, pktcdvd reports:
  > >   > > 
  > >   > > Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
  > >   > > Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
  > >   > > sense 00.54.9c (No sense)
  > >   > > Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
  > >   > > 
  > >   > > And then of course a huge heap of I/O errors on the disk. 
  > >   > 
  > >   > Have you verified that this is caused by the speed setting, ie does it
  > >   > work correctly if you hack the driver to write at 4x speed?
  > > 
  > > Correct. Adding a hard-coded manual setting of write_speed = 5540 to
  > > pkt_open_write results in functional operation (at least with 4x rated
  > > DVD+RW media).
  > 
  > Does this patch work for you?
  > 
  > 
  > pktcdvd: Don't try to write faster than the DVD media speed allows.
  > 
  > In theory the drive firmware should limit the speed to the fastest
  > allowed by the currently loaded media, but it doesn't always work in
  > practice.
  > 
  > Signed-off-by: Peter Osterlund <petero2@telia.com>
  > ---
  > 
  >  drivers/block/pktcdvd.c |   34 ++++++++++++++++++++++++++++++++--
  >  1 files changed, 32 insertions(+), 2 deletions(-)
  > 
  > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
  > index c1b8eae..94ff3ac 100644
  > --- a/drivers/block/pktcdvd.c
  > +++ b/drivers/block/pktcdvd.c
  > @@ -1780,7 +1780,7 @@ static char us_clv_to_speed[16] = {
  >  /*
  >   * reads the maximum media speed from ATIP
  >   */
  > -static int pkt_media_speed(struct pktcdvd_device *pd, unsigned *speed)
  > +static int pkt_cd_media_speed(struct pktcdvd_device *pd, unsigned *speed)
  >  {
  >  	struct packet_command cgc;
  >  	struct request_sense sense;
  > @@ -1852,6 +1852,33 @@ static int pkt_media_speed(struct pktcdv
  >  	}
  >  }
  >  
  > +static int pkt_dvd_media_speed(struct pktcdvd_device *pd, unsigned int *speed)
  > +{
  > +	struct packet_command cgc;
  > +	struct request_sense sense;
  > +	unsigned char buf[64];
  > +	int size, ret;
  > +
  > +	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
  > +	cgc.sense = &sense;
  > +	cgc.cmd[0] = GPCMD_GET_PERFORMANCE;
  > +	cgc.cmd[8] = 0;
  > +	cgc.cmd[9] = 1;			    /* Number of descriptors */
  > +	cgc.cmd[10] = 0x03;		    /* Write speed */
  > +	ret = pkt_generic_packet(pd, &cgc);
  > +	if (ret) {
  > +		pkt_dump_sense(&cgc);
  > +		return ret;
  > +	}
  > +	size = be32_to_cpu(*(int*)&buf[0]) + 4;
  > +	if (size < 8 + 16)
  > +		return -1;
  > +
  > +	*speed = be32_to_cpu(*(int*)&buf[8 + 12]);
  > +	DPRINTK("pktcdvd: Max. media speed: %dkB/s\n",*speed);
  > +	return 0;
  > +}
  > +
  >  static int pkt_perform_opc(struct pktcdvd_device *pd)
  >  {
  >  	struct packet_command cgc;
  > @@ -1889,14 +1916,17 @@ static int pkt_open_write(struct pktcdvd
  >  
  >  	if ((ret = pkt_get_max_speed(pd, &write_speed)))
  >  		write_speed = 16 * 177;
  > +	DPRINTK("pktcdvd: Max drive write speed %ukB/s\n", write_speed);
  >  	switch (pd->mmc3_profile) {
  >  		case 0x13: /* DVD-RW */
  >  		case 0x1a: /* DVD+RW */
  >  		case 0x12: /* DVD-RAM */
  > +			if (pkt_dvd_media_speed(pd, &media_write_speed) == 0)
  > +				write_speed = min(write_speed, media_write_speed);
  >  			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
  >  			break;
  >  		default:
  > -			if ((ret = pkt_media_speed(pd, &media_write_speed)))
  > +			if ((ret = pkt_cd_media_speed(pd, &media_write_speed)))
  >  				media_write_speed = 16;
  >  			write_speed = min(write_speed, media_write_speed * 177);
  >  			DPRINTK("pktcdvd: write speed %ux\n", write_speed / 176);
  > 

Unfortunately, no. It -should- work, but the extra DPRINTK's tell a further
story of the drives stupidity.

Upon running 
 % pktsetup 0 /dev/hde ; mkudffs /dev/pktcdvd/0'
I get the following output:

Feb 24 19:30:31 ever kernel: pktcdvd: inserted media is DVD+RW
Feb 24 19:30:31 ever kernel: pktcdvd: Max drive write speed 11080kB/s
Feb 24 19:30:31 ever kernel: pktcdvd: Max. media speed: 5540kB/s
Feb 24 19:30:31 ever kernel: pktcdvd: write speed 5540kB/s
Feb 24 19:30:48 ever kernel: pktcdvd: 4590208kB available on disc

All seems well and good. However, upon then issuing 
 % mount /dev/pktcdvd/0 /mnt/dvdrw -t auto -o noatime,rw

Feb 24 19:31:28 ever kernel: pktcdvd: inserted media is DVD+RW
Feb 24 19:31:28 ever kernel: pktcdvd: Max drive write speed 11080kB/s
Feb 24 19:31:28 ever kernel: pktcdvd: Max. media speed: 11080kB/s
Feb 24 19:31:28 ever kernel: pktcdvd: write speed 11080kB/s
Feb 24 19:31:30 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 - sense 00.54.1c (No sense)
Feb 24 19:31:30 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
Feb 24 19:31:30 ever kernel: pktcdvd: 4590208kB available on disc
Feb 24 19:31:31 ever kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2006/02/24 18:30 (1ed4)
Feb 24 19:31:40 ever kernel: hde: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
Feb 24 19:31:40 ever kernel: hde: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03 }
Feb 24 19:31:40 ever kernel: ide: failed opcode was: unknown
Feb 24 19:31:40 ever kernel: end_request: I/O error, dev hde, sector 1088
Feb 24 19:31:40 ever kernel: hde: command error: status=0x51 { DriveReady SeekComplete Error }
Feb 24 19:31:40 ever kernel: hde: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
.
. (and so on)

I'm somewhat confused as to what could be happening here, but my first
guess is that after being spun up to high speed for reading in
pkt_iosched_process_queue, the firmware promptly forgets whatever it knew
about the media speed. Perhaps it only stores a single speed value
internally, so calling pkt_set_speed (pd, pd->write_speed, pd->read_speed)
with a larger value of read_speed sets them both. And afterwards the drive
reports this as the maximum media speed on future opens? If you are curious
as to who would curse the market with such a buggy product, the drive is a
BenQ Q60.

Curiously, after the failed mount, running dvd+rw-mediainfo returns:

INQUIRY:                [BENQ    ][DVD DC DQ60     ][MRCC]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         1Ah, DVD+RW
 Media ID:              INFODISC/A10
 Current Write Speed:   8.0x1385=11080KB/s
 Write Speed #0:        8.0x1385=11080KB/s
 Write Speed #1:        6.0x1385=8310KB/s
 Write Speed #2:        4.0x1385=5540KB/s
 Write Speed #3:        2.4x1385=3324KB/s
 Speed Descriptor#0:    00/2295103 R@3.5x1385=4817KB/s W@8.0x1385=11080KB/s
 Speed Descriptor#1:    00/2295103 R@3.5x1385=4817KB/s W@6.0x1385=8310KB/s
 Speed Descriptor#2:    00/2295103 R@3.5x1385=4817KB/s W@4.0x1385=5540KB/s
 Speed Descriptor#3:    00/2295103 R@3.5x1385=4817KB/s W@2.4x1385=3324KB/s
READ DVD STRUCTURE[#0h]:
 Media Book Type:       92h, DVD+RW book [revision 2]
 Legacy lead-out at:    2295104*2KB=4700372992
READ DISC INFORMATION:
 Disc status:           complete
 Number of Sessions:    1
 State of Last Session: complete
 Number of Tracks:      1
 BG Format Status:      suspended
:-[ READ TRACK INFORMATION failed with SK=3h/ASC=11h/ACQ=05h]: Input/output
error

While before it returned:

INQUIRY:                [BENQ    ][DVD DC DQ60     ][MRCC]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         1Ah, DVD+RW
 Media ID:              INFODISC/A10
 Current Write Speed:   4.0x1385=5540KB/s
 Write Speed #0:        4.0x1385=5540KB/s
 Write Speed #1:        2.4x1385=3324KB/s
 Speed Descriptor#0:    00/2295103 R@3.5x1385=4817KB/s W@4.0x1385=5540KB/s
 Speed Descriptor#1:    00/2295103 R@3.5x1385=4817KB/s W@2.4x1385=3324KB/s
READ DVD STRUCTURE[#0h]:
 Media Book Type:       92h, DVD+RW book [revision 2]
 Legacy lead-out at:    2295104*2KB=4700372992
READ DISC INFORMATION:
 Disc status:           complete
 Number of Sessions:    1
 State of Last Session: complete
 Number of Tracks:      1
 BG Format Status:      suspended
READ TRACK INFORMATION[#1]:
 Track State:           complete incremental
 Track Start Address:   0*2KB
 Free Blocks:           0*2KB
 Fixed Packet Size:     16*2KB
 Track Size:            2295104*2KB
FABRICATED TOC:
 Track#1  :             17@0
 Track#AA :             17@2295104
 Multi-session Info:    #1@0
READ CAPACITY:          2295104*2048=4700372992

Ejecting and reloading the disc causes dvd+rw-mediainfo to return proper
info again.

