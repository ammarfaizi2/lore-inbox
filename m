Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJEeA>; Tue, 9 Jan 2001 23:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJEdk>; Tue, 9 Jan 2001 23:33:40 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:14088 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129431AbRAJEd2>; Tue, 9 Jan 2001 23:33:28 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrea Arcangeli <andrea@suse.de>
Date: Wed, 10 Jan 2001 15:32:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14939.58859.451177.942437@notabene.cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, nfs-devel@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: kNFSd maintenance in 2.2.19pre
In-Reply-To: message from Andrea Arcangeli on Monday January 1
In-Reply-To: <14913.22373.943123.320678@notabene.cse.unsw.edu.au>
	<20010101183729.C13560@athlon.random>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 1, andrea@suse.de wrote:
> On Thu, Dec 21, 2000 at 12:05:41PM +1100, Neil Brown wrote:
> >  So, I have started putting some patches together and they can be
> >  found at
> >     http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/
> 
> I included the interesting ones in my tree.

But aren't they all interesting :-)

I've up-dated and re-organised them and added some more.  The new set
can be found at 
  http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/2.2.19-pre7

There is a list of the patches below. 
I plan to send (most of) the to Alan shortly.

> 
> Here two fixes against the vfs backport:
> 
> --- ./fs/nfsd/vfs.c.~1~	Fri Dec 29 18:02:01 2000
> +++ ./fs/nfsd/vfs.c	Mon Jan  1 18:09:46 2001
> @@ -1603,9 +1603,11 @@
>  	eof = !cd.eob;
>  
>  	if (cd.offset) {
> +#ifdef CONFIG_NFSD_V3
>  		if (rqstp->rq_vers == 3)
>  			(void)enc64(cd.offset, file.f_pos);
>  		else
> +#endif /* CONFIG_NFSD_V3 */
>  			*cd.offset = htonl(file.f_pos);
>  	}

I deliberately removed the #ifdef here because I don't like ifdefs (I
have learned from the master) and this one wan't really needed.
Ofcourse, it may not compile like this unless you change "enc64" to
"xdr_encode_hyper" as a later patch did.

>  
> @@ -1624,6 +1626,7 @@
>  	return err;
>  
>  out_nfserr:
> +	up(&inode->i_sem);
>  	err = nfserrno(-err);
>  	goto out_close;
>  }

Oops. Thanks for catching this.

NeilBrown

  From my web page: http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2

2.2.19-pre7
          Last Changed: 10 January 2001, 2:52pm GMT--11 Click me for more detailed patch descriptions

     

     patch-A-maint
                    Update the MAINTAINERS file
     patch-B-sema
                    Broaden the range of effect of the s_nfsd_free_path_sem semphore
     patch-C-access
                    Allow ACCESS checks on special files - plus bug fix
     patch-D-nfsirix
                    Make nfsd treat devices/pipes in a way that works with IRIX
     patch-E-wdelay
                    Modify the wdelay handling
     patch-F-stablewrite
                    Tidyup communication of stable-write flag - backport from 2.4
     patch-G-errtidy
                    Tidy up handling of error codes - back port from 2.4
     patch-H-dotent
                    move define oif dotent and change memcpyto xdr_encode_string
     patch-I-backport
                    Further back port of bits and pieces from 2.4
     patch-J-return
                    backport changes to RETURN macros in nfs*proc.c
     patch-K-enc64
                    replace enc64/dec64 by xdr_encode_hyper/xdr_decode_hyper
     patch-L-noigetinuse
                    Remove iget_in_use
     patch-M-hash
                    Calculate hash correctly for new names
     patch-N-arrangedentry
                    Tidy up the choosing of a dentry given an inode.
     patch-O-backportvfs
                    backport some 2.4 changes to vfs.c
     patch-P-create
                    modify exclusive create to not return negative times
     patch-Q-dotdot
                    move guard against creating dot or dotdot earlier
     patch-R-noexperiment
                    Remove 'experimental' tag from nfsv3 server support
     patch-S-setport
                    allow explicit setting of port number for lockd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
