Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSBXV53>; Sun, 24 Feb 2002 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291471AbSBXV5U>; Sun, 24 Feb 2002 16:57:20 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:17852 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S291460AbSBXV5D>; Sun, 24 Feb 2002 16:57:03 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Chow <davidchow@rcn.com.hk>
Date: Mon, 25 Feb 2002 08:49:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15481.24560.606915.28779@notabene.cse.unsw.edu.au>
Cc: David Chow <davidchow@shaolinmicro.com>,
        "Peter J. Braam" <braam@clusterfs.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net
Subject: Re: tmpfs, NFS, file handles
In-Reply-To: message from David Chow on Monday February 25
In-Reply-To: <20020220094649.X25738@lustre.cfs>
	<3C73D548.648C5D64@mandrakesoft.com>
	<20020220122116.C28913@lustre.cfs>
	<15476.10488.442232.634169@notabene.cse.unsw.edu.au>
	<1014266633.17471.8.camel@star9.planet.rcn.com.hk>
	<15476.32747.865192.538172@notabene.cse.unsw.edu.au>
	<3C790FB2.50503@rcn.com.hk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 25, davidchow@rcn.com.hk wrote:
> 
> 
> Neil Brown wrote:
> 
> >On  February 21, davidchow@shaolinmicro.com wrote:
> >
> >>What I suggest is nfsd should export a symbol called
> >>generic_fh_to_dentry() such that it will be more generic like
> >>generic_file_read() to handle gneeric calls for every fs.
> >>
> >
> >But every filesystem is really very different in this reguard.
> >
> >What would you think this "generic_fh_to_dentry" should do?
> >
> >We actually already have one.  You set ->fh_to_dentry to NULL, and the
> >it used "iget". 
> >
> >NeilBrown
> >
> You know, we have serious problem implementing non block device 
> filesystems with NFS.  I actually spend quite a long while understanding 
> the nfsd code in 2.4 . Here is the problems that I suffer....

Well, you are not alone.  NFS appears to have been designed with UFS -
the original Unix File System, or close relatives - specifically in
mind.
The further a file system diverges from this, the harder it is to
provide NFS support.

> 
> nfsd calling iget to read an inode info directly into the dcache even 
> though there is no valid linked dentry in the dcache that is in the 
> list_empty(inode->i_dentry) list, but what we have implement in our non 
> block device filesystem is that our inode is dynamically generated using 
> lookup(), that means the inode is only valid if we have dentry 
> information and going through a normal 
> lookup(neg-dentry)=>read_inode(ino) procedure. When we implement a non 
> block device fs and want to serve it with nfsd we also suffer from this 
> problem. Usually non block device system is some kind of fs related with 
> name space, and name space in terms of kernel space is dentry. I bet 
> most of the non block device fs hvae some similar problem.

The "iget" approach is really a hack that sort-of works for ext2 and
pretty much doesn't work for any other filesystem.
Some time in 2.5, this "iget" approach will go away.  Any filesystem
that wants to be NFS-exportable will have to define explicit methods
for exporting, quite similiar to (but sibtly different from)  the
current  fh_to_dentry and dentry_to_fh methods.  
In 2.4, you should not even consider supporting iget usage by kNFSd,
you should supply fh_to_dentry  and dentry_to_fh.

> 
> I suggests the fh handle mechanism can handle this kind of situation so 
> that non block device filesystems can work with NFS . The current nfs 
> have to maintain a stateless design so there are no easy way to not 
> allowing VFS to not touch the dcache during a request verification.
> 
> I suggest the fh_verify should go through a proper lookup process for 
> inodes that have an empty inode->i_dentry list. This will make life for 
> non block device filesystem much easier.

What do you mean by "a proper lookup process"?  Do you mean having a
full path name from the filesystem root and following that?
That might make it easy for the filesystem, but it would make it
impossible for the NFS server.
Not only does the NFS server not know the name of the file, it cannot
know as the file might have been renamed by some other process since the
NFS server last knew the name.

NFSv4 has a concept of a "volatile" file handle that is supposed to
help with this:  The server can tell the client "that file handle
doesn't work any more", and then the client might re-issue the
filename look requests.  But there are still possible issues with
files being renamed between accesses.

> 
> I think all non block device fs and non-Unix based fs (fs that don't use 
> inode number identification) will have the same problem because they 
> simply use iunique and ino have no meaning to them unless the procedure 
> lookup()=>read_inode() sequece is properly executed.

Yes.  It is a difficult problem.
But to work with NFS (v2 or v3) the filesystem *MUST* be able to
provide a stable, fixed length identifier for a file that is not
changed by rename, truncate, or server restart (or anything else, but
those are often the difficult ones).
The extent to which your filesystem cannot provide such an identifier
is the extent to which it cannot support NFS.
FAT based filesystems are a good example.  We provide 90% support.  If
you try to access a FAT filesystem from Linux (with no_subtree_check),
it will mostly work.
But if you open a file on the client, truncate it, rename it, reboot
the server, and then write to it, it will fail.  The same is not true
of ext2.

I hope this helps.

NeilBrown
