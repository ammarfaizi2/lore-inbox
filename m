Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSKTXmN>; Wed, 20 Nov 2002 18:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSKTXmK>; Wed, 20 Nov 2002 18:42:10 -0500
Received: from gate.in-addr.de ([212.8.193.158]:1546 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S263899AbSKTXl7>;
	Wed, 20 Nov 2002 18:41:59 -0500
Date: Thu, 21 Nov 2002 00:47:43 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021120234743.GF29881@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The md driver in linux uses a 'superblock' written to all devices in a
>RAID to record the current state and geometry of a RAID and to allow
>the various parts to be re-assembled reliably.
>
>The current superblock layout is sub-optimal.  It contains a lot of
>redundancy and wastes space.  In 4K it can only fit 27 component
>devices.  It has other limitations.

Yes. (In particular, getting all the various counters to agree with each other
is a pain ;-)

Steven raises the valid point that multihost operation isn't currently
possible; I just don't agree with his solution:

- Activating a drive only on one host is already entirely possible.
  (can be done by device uuid in initrd for example)
- Activating a RAID device from multiple hosts is still not possible.
  (Requires way more sophisticated locking support than we currently have)
  
However, for none-RAID devices like multipathing I believe that activating a
drive on multiple hosts should be possible; ie, for these it might not be
necessary to scribble to the superblock every time.

(The md patch for 2.4 I sent you already does that; it reconstructs the
available paths fully dynamic on startup (by activating all paths present);
however it still updates the superblock afterwards)

Anyway, on to the format:

>The code in 2.5.lastest has all the superblock handling factored out so
>that defining a new format is very straight forward.
>
>I would like to propose a new layout, and to receive comment on it..
>
>My current design looks like:
>	/* constant array information - 128 bytes */
>   u32  md_magic
>   u32  major_version == 1
>   u32  feature_map     /* bit map of extra features in superblock */
>   u32  set_uuid[4]
>   u32  ctime
>   u32  level
>   u32  layout
>   u64  size		/* size of component devices, if they are all
>			 * required to be the same (Raid 1/5 */
>   u32  chunksize
>   u32  raid_disks
>   char name[32]
>   u32  pad1[10];

Looks good so far.

>	/* constant this-device information - 64 bytes */
>   u64  address of superblock in device
>   u32  number of this device in array  /* constant over reconfigurations 
>   */
>   u32  device_uuid[4]

What is "address of superblock in device" ? Seems redundant, otherwise you
would have been unable to read it, or am missing something?

Special case here might be required for multipathing. (ie, device_uuid == 0)

>   u32  pad3[9]
>
>	/* array state information - 64 bytes */
>   u32  utime

Timestamps (also above, ctime) are always difficult. Time might not be set
correctly at any given time, in particular during early bootup. This field
should only be advisory.

>   u32  state    /* clean, resync-in-progress */
>   u32  sb_csum
>   u64  events
>   u64  resync-position	/* flag in state if this is valid)
>   u32  number of devices
>   u32  pad2[8]
>
>	/* device state information, indexed by 'number of device in array' 
>	   4 bytes per device */
>   for each device:
>     u16 position     /* in raid array or 0xffff for a spare. */
>     u16 state flags  /* error detected,  in-sync */

u16 != u32; your position flags don't match up. I'd like to be able to take
the "position in the superblock" as a mapping here so it can be found in this
list, or what is the proposed relationship between the two?

>The interpretation of the 'name' field would be up to the user-space
>tools and the system administrator.
>I imagine having something like:
>	host:name
>where if "host" isn't the current host name, auto-assembly is not
>tried, and if "host" is the current host name then:

Oh, well. You seem to sort of have Steven's idea here too ;-) In that case,
I'd go with the idea of Steven. Make that field a uuid of the host.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
