Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292313AbSBUEoo>; Wed, 20 Feb 2002 23:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292323AbSBUEog>; Wed, 20 Feb 2002 23:44:36 -0500
Received: from [210.176.202.14] ([210.176.202.14]:19072 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S292313AbSBUEoY> convert rfc822-to-8bit; Wed, 20 Feb 2002 23:44:24 -0500
Subject: Re: tmpfs, NFS, file handles
From: David Chow <davidchow@shaolinmicro.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: "Peter J. Braam" <braam@clusterfs.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net
In-Reply-To: <15476.10488.442232.634169@notabene.cse.unsw.edu.au>
In-Reply-To: <20020220094649.X25738@lustre.cfs>
	<3C73D548.648C5D64@mandrakesoft.com> <20020220122116.C28913@lustre.cfs> 
	<15476.10488.442232.634169@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 21 Feb 2002 12:43:52 +0800
Message-Id: <1014266633.17471.8.camel@star9.planet.rcn.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

¦b ¶g¥|, 2002-02-21 06:53, Neil Brown ¼g¹D¡G
> On Wednesday February 20, braam@clusterfs.com wrote:
> > Hi, 
> > 
> > > "Peter J. Braam" wrote:
> > ...
> > > > Is there a suggested solution for fh_to_dentry and dentry_to_fh for
> > > > tmpfs?
> > > > 
> > > > An "iget" based solution might work but at present tmpfs inodes are
> > > > not hashed.
> > On Wed, Feb 20, 2002 at 11:56:40AM -0500, Jeff Garzik wrote:
> > ...
> > > I talked to neil brown about NFS and ramfs... he mentioned using
> > > iunique()
> ... but Trond had a better idea....
> > 
> > 
> > So do I understand that hashing tmpfs inodes is perhaps the way to go?
> > 
> > Would the following also work? 
> > 
> >  - have a 32 bit counter: set inode->i_ino to count++
> >  - up the generation number each time the counter warps. 
> 
> You don't just need a number in inode->i_ino.  You also need to be
> able to find an inode given that number.
> So you need to store all the inodes in a hash table.
> But you don't want to penalise non-NFS users.
> 
> I would probably:
>    leave i_ino as set by new_inode
>    initialise inode->i_generation to CURRENT_TIME
> 
>    in dentry_to_fh,
>      check if list_empty(&inode->i_hash)
>        if it is, then add the inode to some hash table indexed by the
>            address of the inode
>        put the address of the inode, i_ino and i_generation in the filehandle
> 
>    in fh_to_dentry,
>      lookup the given address in the hash table.
>      if it is found, check the i_ino and i_generation
> 
> 
> That means you are only hashing inodes exported by NFS, and you have
> a pretty good guarantee of uniqueness (providing time doesn't go
> backwards).
> 
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

What I suggest is nfsd should export a symbol called
generic_fh_to_dentry() such that it will be more generic like
generic_file_read() to handle gneeric calls for every fs.

Thanks,

David

