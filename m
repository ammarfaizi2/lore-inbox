Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292561AbSBTWyz>; Wed, 20 Feb 2002 17:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292567AbSBTWym>; Wed, 20 Feb 2002 17:54:42 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63623 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292572AbSBTWyQ>; Wed, 20 Feb 2002 17:54:16 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Peter J. Braam" <braam@clusterfs.com>
Date: Thu, 21 Feb 2002 09:53:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15476.10488.442232.634169@notabene.cse.unsw.edu.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net
Subject: Re: tmpfs, NFS, file handles
In-Reply-To: message from Peter J. Braam on Wednesday February 20
In-Reply-To: <20020220094649.X25738@lustre.cfs>
	<3C73D548.648C5D64@mandrakesoft.com>
	<20020220122116.C28913@lustre.cfs>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 20, braam@clusterfs.com wrote:
> Hi, 
> 
> > "Peter J. Braam" wrote:
> ...
> > > Is there a suggested solution for fh_to_dentry and dentry_to_fh for
> > > tmpfs?
> > > 
> > > An "iget" based solution might work but at present tmpfs inodes are
> > > not hashed.
> On Wed, Feb 20, 2002 at 11:56:40AM -0500, Jeff Garzik wrote:
> ...
> > I talked to neil brown about NFS and ramfs... he mentioned using
> > iunique()
... but Trond had a better idea....
> 
> 
> So do I understand that hashing tmpfs inodes is perhaps the way to go?
> 
> Would the following also work? 
> 
>  - have a 32 bit counter: set inode->i_ino to count++
>  - up the generation number each time the counter warps. 

You don't just need a number in inode->i_ino.  You also need to be
able to find an inode given that number.
So you need to store all the inodes in a hash table.
But you don't want to penalise non-NFS users.

I would probably:
   leave i_ino as set by new_inode
   initialise inode->i_generation to CURRENT_TIME

   in dentry_to_fh,
     check if list_empty(&inode->i_hash)
       if it is, then add the inode to some hash table indexed by the
           address of the inode
       put the address of the inode, i_ino and i_generation in the filehandle

   in fh_to_dentry,
     lookup the given address in the hash table.
     if it is found, check the i_ino and i_generation


That means you are only hashing inodes exported by NFS, and you have
a pretty good guarantee of uniqueness (providing time doesn't go
backwards).

NeilBrown
