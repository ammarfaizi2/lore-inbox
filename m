Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSG2LrP>; Mon, 29 Jul 2002 07:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSG2LrP>; Mon, 29 Jul 2002 07:47:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:6587 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315437AbSG2LrO>; Mon, 29 Jul 2002 07:47:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jan Hudec <bulb@ucw.cz>
Date: Mon, 29 Jul 2002 21:50:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15685.11287.43065.570783@notabene.cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kerner.org, linux-kernel@vger.kernel.org
Subject: Re: Race in open(O_CREAT|O_EXCL) and network filesystem
In-Reply-To: message from Jan Hudec on Sunday July 28
References: <20020728165256.GA4631@vagabond>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday July 28, bulb@ucw.cz wrote:
> Hi all,
> 
> maybe I'm blind, but I think there is a race featuring
> open(O_CREAT|O_EXCL) and nfs or any other network fs.
> 
> What may happen is:
> 
> client A: open_namei looks up the inode
> 	driver queries server and gets ENOENT
> client B: open_namei looks up the inode
> 	driver queries server and gets ENOENT
> client A: open_namei calls create method
> 	driver requests file to be created and is successful
> client B: open_namei calls create method
> 	dirver requests file to be created and since it does not know,
> 	cant specify exclusion, thus is succesful
> client A: open_namei does no more checks and thus open succeeds
> client B: open succeeds too here - and it shouldn't
> 
> Since many applications rely on this working correctly (especialy
> mailboxes are locked using exclusive creates and mounting them over NFS
> is quite common).
> 
> So, can someone please answer:
> 
> 1) Is there some reason this can't happen that I overlooked?

No.  You are correct.

> 2) If it is a problem (comment in NFS suggest so), I can see two ways of
> handling this. Either pass the flags to the create method, or restart
> the open when create returns EEXISTS. Which one would be prefered?

Well.. at OLS in the Lustre talk Peter Braam talked about something
that could be used.  Unfortunately it doesn't seem to be included in
the paper in the proceedings but the idea was to include some "intend"
in the lookup request.  e.g. "lookup with intent to create" or
"lookup with intent to delete" or maybe "lookup with intent to open
for exclusive write access".  The filesystem could then, at it's
option, carry out the intended operation (possibly only partially) as
part of the lookup.  A simple filesystem wouldn't bothe and the VFS
would continue with the normal process. A networked filesystem could
do that whole operation including intent atomically.

Apparently Al Viro is not completely against the idea, but I haven't
actually seen any code or detailed specs (not that I have looked hard)
so it might all be vapourware.

> 3) How to fix NFS to add exclude flag to the NFSv3 request?

It's not easy... else it would already have been done.

NeilBrown
