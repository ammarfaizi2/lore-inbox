Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSKUAYq>; Wed, 20 Nov 2002 19:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSKUAYp>; Wed, 20 Nov 2002 19:24:45 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:47784 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265285AbSKUAYl>; Wed, 20 Nov 2002 19:24:41 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Thu, 21 Nov 2002 11:31:35 +1100
Message-ID: <15836.10599.736315.623964@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Lars Marowsky-Bree on Thursday November 21
References: <20021120234743.GF29881@marowsky-bree.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 21, lmb@suse.de wrote:
>   
> However, for none-RAID devices like multipathing I believe that activating a
> drive on multiple hosts should be possible; ie, for these it might not be
> necessary to scribble to the superblock every time.
> 
> (The md patch for 2.4 I sent you already does that; it reconstructs the
> available paths fully dynamic on startup (by activating all paths present);
> however it still updates the superblock afterwards)

I haven't thought much about multipat I admit.....

Mt feeling is that a multipath superblock should never be updated.
Just writen once at creation and left like that (raid0 and linear are
much the same) The only lose would be the utime update, and I don't
think that is a real lose.

> >	/* constant this-device information - 64 bytes */
> >   u64  address of superblock in device
> >   u32  number of this device in array  /* constant over reconfigurations 
> >   */
> >   u32  device_uuid[4]
> 
> What is "address of superblock in device" ? Seems redundant, otherwise you
> would have been unable to read it, or am missing something?

Suppose I have a device with a partition that ends at the end of the
device (and starts at a 64k align location).  Then if there is a
superblock in the whole device, it will also be in the final
partition... but which is right?  Storing the location of the
superblock allows us to disambiguate.

> 
> Special case here might be required for multipathing. (ie, device_uuid == 0)
> 
> >   u32  pad3[9]
> >
> >	/* array state information - 64 bytes */
> >   u32  utime
> 
> Timestamps (also above, ctime) are always difficult. Time might not be set
> correctly at any given time, in particular during early bootup. This field
> should only be advisory.

Indeed, they are only advisory.

> 
> >   u32  state    /* clean, resync-in-progress */
> >   u32  sb_csum
> >   u64  events
> >   u64  resync-position	/* flag in state if this is valid)
> >   u32  number of devices
> >   u32  pad2[8]
> >
> >	/* device state information, indexed by 'number of device in array' 
> >	   4 bytes per device */
> >   for each device:
> >     u16 position     /* in raid array or 0xffff for a spare. */
> >     u16 state flags  /* error detected,  in-sync */
> 
> u16 != u32; your position flags don't match up. I'd like to be able to take
> the "position in the superblock" as a mapping here so it can be found in this
> list, or what is the proposed relationship between the two?

u16 for device flags.  u32 (over kill for) array flags.  Is there are
problem that I am missing?

There is an array of
   struct {
	u16 position;	/* aka role.  0xffff for spare */
	u16 state;	/* error/insync */
   }
in each copy of the superblock.  It is indexed by 'number of this
device in array' which is constant for any given device despite any
configuration changes (until the device is removed from the array).
If you have two hot spares, then their 'postition' (aka role) will
initially be 0xffff.  After a failure, one will be swapped in and it's
position becomes (say) 3.  Once rebuild is complete, the insync flag
is set and the device becomes fully active.

Does that make it clear?

NeilBrown
