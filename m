Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbSKUTpd>; Thu, 21 Nov 2002 14:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSKUTpd>; Thu, 21 Nov 2002 14:45:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11511 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266987AbSKUTpb>; Thu, 21 Nov 2002 14:45:31 -0500
Date: Thu, 21 Nov 2002 14:54:06 -0500
From: Doug Ledford <dledford@redhat.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021121195406.GF14063@redhat.com>
Mail-Followup-To: Joel Becker <Joel.Becker@oracle.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <15836.7011.785444.979392@notabene.cse.unsw.edu.au> <20021121014625.GA14063@redhat.com> <20021121193424.GB770@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121193424.GB770@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 11:34:24AM -0800, Joel Becker wrote:
> On Wed, Nov 20, 2002 at 08:46:25PM -0500, Doug Ledford wrote:
> > I haven't yet played with the new dm code, but if it's like I expect it to 
> > be, then I predict that in a few years, or maybe much less, md and dm will 
> > be two parts of the same whole.  The purpose of md is to map from a single 
> 
> 	Most LVMs support mirroring as an essential function.  They
> don't usually support RAID5, leaving that to hardware.
> 	I certainly don't want to have to deal with two disparate
> systems to get my code up and running.  I don't want to be limited in my
> mirroring options at the block device level.
> 	DM supports mirroring.  It's a simple 1:2 map.  Imagine this LVM
> volume layout, where volume 1 is data and mirrored, and volume 2 is some
> scratch space crossing both disks.
> 
> 	[Disk 1]	[Disk 2]
> 	  [volume 1]	  [volume 1 copy]
>           [       volume 2              ]
> 	
> 	If DM handles the mirroring, this works great.  Disk 1 and disk
> 2 are handled either as the whole disk (sd[ab]) or one big partition on
> each disk (sd[ab]1), with DM handling the sizing and layout, even
> dynamically.
> 	If MD is handling this, then the disks have to be partitioned.
> sd[ab]1 contain the portions of md0, and sd[ab]2 are managed by DM.  I
> can't resize the partitions on the fly, I can't break the mirror to add
> space to volume 2 quickly, etc.

Not at all.  That was the point of me entire email, that the LVM code 
should handle these types of shuffles of space and simply use md modules 
as the underlying mapper technology.  Then, you go to one place to both 
specify how things are laid out and what mapping is used in those laid out 
spaces.  Basically, I'm saying how I think things *should* be, and you're 
telling me how they *are*.  I know this, and I'm saying how things *are* 
is wrong.  There *should* be no md superblocks, there should only be dm 
superblocks on LVM physical devices and those DM superblocks should 
include the data needed to fire up the proper md module on the proper 
physical extents based upon what mapper technology is specified in the 
DM superblock and what layout is specified in the DM superblock.  In my 
opinion, the existence of both an MD and DM driver is wrong because they 
are inherently two sides of the same coin, logical device mapping support, 
with one being better at putting physical disks into intelligent arrays 
and one being better at mapping different logical volumes onto one or more 
physical volume groups.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
