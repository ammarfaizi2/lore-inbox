Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSKTXRj>; Wed, 20 Nov 2002 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSKTXRj>; Wed, 20 Nov 2002 18:17:39 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:25252 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263291AbSKTXRf>; Wed, 20 Nov 2002 18:17:35 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Steve Pratt" <slpratt@us.ibm.com>
Date: Thu, 21 Nov 2002 10:24:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.6578.878775.208602@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Steve Pratt on Wednesday November 20
References: <OF6B381288.73386F52-ON85256C77.00543682@pok.ibm.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, slpratt@us.ibm.com wrote:
> 
> Neil Brown wrote;
> 
> >I would like to propose a new layout, and to receive comment on it..
> 
> 
>  >/* constant this-device information - 64 bytes */
>     >u64  address of superblock in device
>     >u32  number of this device in array  /* constant over reconfigurations
>     */
> 
>  Does this mean that there can be holes in the numbering for disks that die
>     and are replaced?

Yes.  When a drive is added to an array it gets a number which it
keeps for it's life in the array.  This is completely separate from
the number that says what it's role in the array is.  This number,
together with the set_uuid, forms the 'name' of the device as long as
it is part of the array.  So there could well be holes in the
numbering of devices, but in general the set of numbers would be
fairly dense (max number of holes is max number of hot-spaces that you
have had in the array at any one time).

> 
>     >u32  device_uuid[4]
>     >u32  pad3[9]
> 
>  >/* array state information - 64 bytes */
>     >u32  utime
>     >u32  state    /* clean, resync-in-progress */
>     >u32  sb_csum
> 
>  These next 2 fields are not 64 bit aligned. Either rearrange or add
>     padding.

Thanks.  I think I did check that once, but then I changed things
again :-(
Actually, making utime a u64 makes this properly aligned again, but I
will group the u64s together at the top.

> 
>     >u64  events
>     >u64  resync-position     /* flag in state if this is valid)
>     >u32  number of devices
>     >u32  pad2[8]
> 
> 
> 
> >Other features:
>    >A feature map instead of a minor version number.
> 
> Good.
> 
>    >64 bit component device size field.
> 
> Size in sectors not blocks please.

Another possibility that I considered was a size in chunks, but
sectors is less confusing.

> 
> 
>    >no "minor" field but a textual "name" field instead.
> 
> Ok, I assume that there will be some way for userspace to query the minor
>    which gets dynamically assigned when the array is started.

Well, actually it is user-space which dynamically assigns a minor.
It then has the option of recording, possibly as a symlink in /dev, the
relationship between the 'name' of the array and the dynamically
assigned minor.

> 
>    >address of superblock in superblock to avoid misidentifying superblock.
>    e.g. is it >in a partition or a whole device.
> 
> Really needed this.
> 
> 
> >The interpretation of the 'name' field would be up to the user-space
> >tools and the system administrator.
> 
> Yes, so let's leave this out of this discussion.

... except to show that is is sufficient to meet the needs of users.


Thanks for your comments,
NeilBrown
