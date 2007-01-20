Return-Path: <linux-kernel-owner+w=401wt.eu-S965059AbXATBFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbXATBFx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 20:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbXATBFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 20:05:53 -0500
Received: from colo.lackof.org ([198.49.126.79]:32848 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965059AbXATBFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 20:05:52 -0500
Date: Fri, 19 Jan 2007 18:05:44 -0700
From: dann frazier <dannf@dannf.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Santiago Garcia Mantinan <manty@debian.org>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Message-ID: <20070120010544.GY26210@colo>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070119010040.GR16053@colo>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 06:00:40PM -0700, dann frazier wrote:
> On Wed, Jan 17, 2007 at 10:55:19PM +0100, Willy Tarreau wrote:
> > @@ -505,8 +510,13 @@
> >  		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
> >  		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
> >  
> > -		mnt->flags = (oldmnt->file_mode >> 9);
> > +		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
> > +			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
> >  	} else {
> > +		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> > +						S_IROTH | S_IXOTH | S_IFREG;
> > +		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> > +						S_IROTH | S_IXOTH | S_IFDIR;
> >  		if (parse_options(mnt, raw_data))
> >  			goto out_bad_option;
> >  	}
> > 
> > 
> > See above ? mnt->dir_mode being assigned 3 times. It still *seems* to do the
> > expected thing like this but I wonder if the initial intent was
> > exactly this.
> 
> Wow - sorry about that, that's certainly a cut & paste error. But the
> end result appears to match current 2.6, which was the intent.
> 
> > Also, would not it be necessary to add "|S_IFLNK" to the file_mode ? Maybe
> > what I say is stupid, but it's just a guess.
> 
> I really don't know the correct answer to that, I was merely copying
> the 2.6 flags. 
> 
> [Still working on getting a 2.4 smbfs test system up...]

Ah, think I see the problem now:

--- kernel-source-2.4.27.orig/fs/smbfs/proc.c	2007-01-19 17:53:57.247695476 -0700
+++ kernel-source-2.4.27/fs/smbfs/proc.c	2007-01-19 17:49:07.480161733 -0700
@@ -1997,7 +1997,7 @@
 		fattr->f_mode = (server->mnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFDIR;
 	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
 	          !(S_ISDIR(fattr->f_mode)) )
-		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFREG;
+		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | (fattr->f_mode & S_IFMT);
 
 }
 
Santiago: Thanks for reporting this - can you test this patch out on
your system and let me know if there are still any problems?

Willy: I'll do some more testing and get you a patch that fixes this
and the double assignment nonsense. Would you prefer a single patch or
two?

-- 
dann frazier

