Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSG2PAn>; Mon, 29 Jul 2002 11:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSG2PAn>; Mon, 29 Jul 2002 11:00:43 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:42225 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317466AbSG2PAl>; Mon, 29 Jul 2002 11:00:41 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 29 Jul 2002 09:02:11 -0600
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jan Hudec <bulb@ucw.cz>, linux-fsdevel@sd3.mailbank.com,
       linux-kernel@vger.kernel.org, "Peter J. Braam" <braam@clusterfs.com>
Subject: Re: Race in open(O_CREAT|O_EXCL) and network filesystem
Message-ID: <20020729150211.GC3077@clusterfs.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Jan Hudec <bulb@ucw.cz>, linux-fsdevel@sd3.mailbank.com,
	linux-kernel@vger.kernel.org,
	"Peter J. Braam" <braam@clusterfs.com>
References: <20020728165256.GA4631@vagabond> <15685.11287.43065.570783@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15685.11287.43065.570783@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29, 2002  21:50 +1000, Neil Brown wrote:
> On Sunday July 28, bulb@ucw.cz wrote:
> > maybe I'm blind, but I think there is a race featuring
> > open(O_CREAT|O_EXCL) and nfs or any other network fs.
> > 
> > What may happen is:
> > 
> > client A: open_namei looks up the inode
> > 	driver queries server and gets ENOENT
> > client B: open_namei looks up the inode
> > 	driver queries server and gets ENOENT
> > client A: open_namei calls create method
> > 	driver requests file to be created and is successful
> > client B: open_namei calls create method
> > 	dirver requests file to be created and since it does not know,
> > 	cant specify exclusion, thus is succesful
> > client A: open_namei does no more checks and thus open succeeds
> > client B: open succeeds too here - and it shouldn't
> > 
> > Since many applications rely on this working correctly (especialy
> > mailboxes are locked using exclusive creates and mounting them over NFS
> > is quite common).
> > 
> > So, can someone please answer:
> > 
> > 1) Is there some reason this can't happen that I overlooked?
> 
> No.  You are correct.
> 
> > 2) If it is a problem (comment in NFS suggest so), I can see two ways of
> > handling this. Either pass the flags to the create method, or restart
> > the open when create returns EEXISTS. Which one would be prefered?
> 
> Well.. at OLS in the Lustre talk Peter Braam talked about something
> that could be used.  Unfortunately it doesn't seem to be included in
> the paper in the proceedings but the idea was to include some "intend"
> in the lookup request.  e.g. "lookup with intent to create" or
> "lookup with intent to delete" or maybe "lookup with intent to open
> for exclusive write access".  The filesystem could then, at it's
> option, carry out the intended operation (possibly only partially) as
> part of the lookup.  A simple filesystem wouldn't bothe and the VFS
> would continue with the normal process. A networked filesystem could
> do that whole operation including intent atomically.

The intent-based lookup code is available as part of the Lustre CVS.
See lustre/patches/patch-2.4.18 at the SF lustre project.  There are
a couple of other changes in the patch that are unrelated to intents,
but those are fairly obvious (i.e. ext3/jbd changes, some exports, etc).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

