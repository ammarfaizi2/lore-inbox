Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268127AbRGWCVN>; Sun, 22 Jul 2001 22:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbRGWCVD>; Sun, 22 Jul 2001 22:21:03 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:51081 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268128AbRGWCUq>; Sun, 22 Jul 2001 22:20:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Gordon Lack <gmlack@freenet.co.uk>
Date: Mon, 23 Jul 2001 12:20:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15195.35313.83387.515099@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 pathname problems in 2.4 kernels
In-Reply-To: message from Gordon Lack on Sunday July 22
In-Reply-To: <3B5B32B2.B96E6BD3@freenet.co.uk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday July 22, gmlack@freenet.co.uk wrote:
>    I am seeing a problem at the client side when trying to obtain
> pathnames of NFS-mounted entries.  This occurs when the NFS servers
> involved are Linux2.4 kernels and the clients are SGI Irix 6.5 or
> Solaris 2.6 (Linux 2.4 clients are Ok - 2.2 ones won't be using
> NFSv3). 

This shouldn't be a problem for Solaris 2.6, but definately is for
Irix.

> 
>    As an example of what happens.
> 
> o The server side has a pathname of /raid/sources/prog1 - a directory.
> 
> o /raid is exported
> 
> o The client NFS mounts /raid/sources as /projects/sources
> 
> o I cd to /projects/sources/prog1 and type /bin/pwd
> 
>    I expect to get /projects/sources/prog1 as the result, but I actually get /sources/prog1.
> 
>    Similar mounts from Linux2.2. systems (presumably running NFSv2) produce the expected (correct) result.
> 
>    I've snoop'ed the network traffic and one thing I can see is that the filehandle used in the NFSv3 mount is reported as being a different length (shorter) than those for v2.
> 
>    So,
> 
> a) has anyone else encountered these problems?

Yes.  It has been reported on the nfs@lists.sourceforge.net list
several times.

> 
> b) if so, do they have a solution?

1/ Don't use irix.
2/ Don't use NFSv3
3/ Get a patch from Irix... I believe an upcoming release of Irix
fixed the problem, but I don't recall the details.

> 
> c) how is the filehandle calculated in the 2.4 kernel for NFSv3?
> Which routine is it in?  Perhaps I could try (optionally) forcing it
> to be the same length as a v2 filehandle to see whether that fixes
> things.  (I'd rather that the 2.4 kernel were optimally compatible
> rather than paranoically correct.
> 

Look in fs/nfsd/nfsfh.c, in fh_compose.
If you change:
	if (ref_fh &&
	    ref_fh->fh_handle.fh_version == 0xca &&
	    parent->d_inode->i_sb->s_op->dentry_to_fh == NULL) {
to
	if (parent->d_inode->i_sb->s_op->dentry_to_fh == NULL) {

you will probably get what you want, for ext2 at least.

As far as making Linux "optimally compatible", I tend to agree.
There are hacks in place for Solaris7 which confuses itself with
exclusive creates, and for Tru64 which doesn't include UID information
in locking requests.
However in this case it is a clear and blatant bug in Irix client
code, not a subtly different interpretation or anything forgivable.

It might make sense to have a "broken_client" export option which 
always uses long filehandles...

> 
>    Hoping someone can help...

"Best" option is to complain to SGI and get a patch.

NeilBrown
