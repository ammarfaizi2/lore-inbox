Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271134AbTHRANT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271141AbTHRANT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:13:19 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:39436 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271134AbTHRANO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:13:14 -0400
Date: Sun, 17 Aug 2003 17:13:10 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ioctl vs xattr for the filesystem specific attributes
Message-ID: <20030818001310.GA10453@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <8765l67rvc.fsf@devron.myhome.or.jp> <bhogm4$2gb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhogm4$2gb$1@sea.gmane.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 07:14:28PM +0100, Rob North wrote:
> OGAWA Hirofumi wrote:
> >Hi,
> >
> >Bastien Roucaries <roucariesbastien@yahoo.fr> writes:
> >
> >
> >>This patch implement an "extended attributes" (XATTR) hook in aim to read 
> >>or
> >>modify specific  fatfs flags' like ARCHIVE or SYSTEM.
> >>
> >>I believe it's a good idea  because :
> >>	- PAX ( GNU replacement of tar) save and restore XATTRs, so you can 
> >>	make more
> >>exact save of FATfs without use of specific programs.
> >>	- It's an elegant means to avoid use of mattrib.
> >>	- Samba can use this .
> >>but CONS :
> >>	- use 2 Kb of kernel memory.
> >
> >
> >Bastien Roucaries <roucariesbastien@yahoo.fr> writes:
> >
> >
> >>Indeed some flags are shared by many namespace for instance immutable is 
> >>shared by xfs,ext2/3,jfs and by the fat ( with a special mount option). 
> >>Compress also is a very common flag
> >>This flags are in the "common" sub-namespace.
> >>
> >>But some are fs specifics for instance notail attr of reiserfs,shortname 
> >>of fat.They are in the the "spec"sub-namespace
> >
> >
> >I received the above email.
> >
> >This read/modify the file attributes of filesystem specific via xattr
> >interface (in this case, ARCHIVE, SYSTEM, HIDDEN flags of fatfs).
> >
> >Yes, also we can provide it via ioctl like ext2/ext3 does now.
> >
> >But if those flags provides by xattr interfaces and via one namespace
> >prefix, I guess the app can save/restore easy without dependency of
> >one fs.
> >
> >Which interface would we use for attributes of filesystem specific?
> >Also if we use xattr, what namepace prefix should be used?
> >
> >Any idea?
> >
> >Thanks.
> >

I suggested something like this to Andreas Gruenbacher in
March.  We dialoged briefly about it and I've heard nothing
since.

> I like the ideas that the patch seems to propose.
> Infact I'd like to see the use of xattr used for non-standard attributes
> applied to all fs.
> Specifically, I want to backup all partitions, and attribs from one OS:
> Linux. I do not want to loose fat attributes during backup.
> This would also be useful for the Wine developers.
> 
> 
> If you haven't got a response to your questions, maybe make your own 
> decisions and submit a patch anyway.
> 
> 
> One question:
> How does the patch deal with the fact that only some named xattrs are
> permitted?
> 
> I see 2 options:
> 1. all files/dirs in fat mount posess fat-specific xattrs. These xattrs 
> are initialised at file/dir create. No further attribs can be added, 
> none can be deleted. the fat attribute's Boolean value is defined by 
> extended attribute's value.
> 2. all fat-specific attribs are optional, absence/presence defines
> boolean value. All operations are permitted, but can only add the
> fat-specific attributes.
> 
> I prefer option 1, as it makes clear what attributes are available.

My suggested approach was to only read and write the
attributes as a complete set.  Modification would require a
read, modify what is read, write.  The EA name i suggested
was system.file-attr.  Unsupported attributes would be
silently ignored (no error).  If you wished to save unsupported
attributes for use in a foreign filesystem they could be
preserved in a user.* attribute.

The primary purpose of my suggestion was backups and file
transfers but this could easily be built on to make a
chattr/mattrib type utility that is filesystem agnostic.

The following is extracted from my portions of the exchange.

| It occurred to me that it might be desirable to added a
| facility to the extended attributes to allow reading and
| setting (as a block) the ext2 file attributes.
| 
| I'm referring to the file attributes mentioned in the chattr
| command.
| 
| Adding this facility would allow saving and restoring of
| these attributes with utilities not having specific ext[23]
| support.
| 
| I'd suggest using long attribute names consistent with mount
| options with comma delimiters.  I'd suggest the names:
| 	noatime
| 	append
| 	compress
| 	nodump
| 	immutable|readonly
| 	journal
| 	zero|scrub
| 	sync
| 	notail
| 	undelete

To this you could add archive, system and hidden for FAT.

| The extended attribute might look like
| 	system.file-attr: noatime,notail
| 	
| It might be reasonable to discuss this with the other
| filesystem groups so that a common set of attribute names
| could be agreed upon.  Unrecognized attributes would be
| silently ignored.

| i wasn't suggesting that. [referring to [no]option to set/unset
| attributes]  When i suggested notail
| and noatime options i was just aligning it with the mount
| options to which the attribute bits matched.  The flag tail
| would not exist or would be the same as as notail.  I wasn't
| suggesting that
| 	setfattr -n system.file-attr -v notail,append myfile
| would modify the flags but that it
| would replace the file attributes of myfile like
| 	chattr =ta myfile
|
| Attributes not listed in a setfattr call would be cleared.
| 
| It would be something like (borrowed from ext2/super.c:parse_options)
| 
| 	__u32 flags = 0;
|         for (this_char = strtok (options, ",");
|              this_char != NULL;
|              this_char = strtok (NULL, ",")) {
| 		if (!strcmp (this_char, "noatime"))
| 			flags |= EXT2_NOATIME_FL;
| 		else if (!strcmp (this_char, "append"))
| 			flags |= EXT2_APPEND_FL;
| 		else if (!strcmp (this_char, "compress"))
| 			flags |= EXT2_COMPR_FL;
| 		else if (!strcmp (this_char, "nodump"))
| 			flags |= EXT2_NODUMP_FL;
| 		else if (!strcmp (this_char, "readonly")
| 		      || !strcmp (this_char, "immutable"))
| 			flags |= EXT2_immutable_FL;
| 		else if (!strcmp (this_char, "scrub"))
| 			flags |= EXT2_SECRM_FL;
| 		else if (!strcmp (this_char, "undelete"))
| 			flags |= EXT2_UNRM_FL;
| 		else if (!strcmp (this_char, "sync"))
| 			flags |= EXT2_SYNC_FL;
| 		else if (!strcmp (this_char, "undelete"))
| 			flags |= EXT2_UNRM_FL;
| 	}
| 	inode->i_flags = flags;
| 
| outputting the flag set would be much easier.
                        

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
