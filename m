Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280306AbRKIX2S>; Fri, 9 Nov 2001 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280299AbRKIX16>; Fri, 9 Nov 2001 18:27:58 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:7665 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280293AbRKIX1s>;
	Fri, 9 Nov 2001 18:27:48 -0500
Date: Fri, 9 Nov 2001 16:27:19 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org,
        Nikita Danilov <nikita@namesys.com>
Subject: Re: writing a plugin for reiserfs compression
Message-ID: <20011109162719.H1778@lynx.no>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	reiser@namesys.com, linux-kernel@vger.kernel.org,
	Nikita Danilov <nikita@namesys.com>
In-Reply-To: <200111012017.VAA02942@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111012017.VAA02942@mustard.heime.net>; from roy@karlsbakk.net on Thu, Nov 01, 2001 at 08:17:24PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita <nikita@namesys.com> writes:
> Andreas Dilger writes:
> > As a note to whoever at namesys created the reiserfs patch to add the
> > "notail" flag (overloading the "nodump" flag).  I would much rather
> 
> It was me. Agree completely that allocating new flag would be better. I
> just wanted "notail" to actually work and be accessible through standard
> utilities, because it's really useful. "nodump" looked like least useful
> of flags for me, because dump(8) doesn't work with reiserfs (not that it
> worked with ext2 reliably either). I actually tried to contact Remy Card
> and Theodore Tso, to discuss how [ls|ch]attr can be modified to support
> different file-systems, but to no avail.
> 
> > that a new "notail" flag be allocated for this.  I will contact Ted
> > Ted Ts'o to get a flag assigned.  This will avoid any problems in the
> > future, and may also be useful at some time for ext2.

OK, FYI Nikita, Ted has allocated a EXT2_NOTAIL_FL flag for chattr/lsattr
(value 0x00008000) which can be used for setting files/directories to be
permanently notail.  It is obviously up to the reiserfs code to handle
this flag and inherit it for files created in a directory (e.g. /boot),
but starting with e2fsprogs 1.26 chattr/lsattr it will be able to set/get
this flag on ext2/ext3 (and reiserfs with your attributes patch).

> I would rather like to see lsattr/chattr to become file-system
> independent. This requires that all file-systems use the same ioctl cmds
> to set and get bitmasks associated with inodes and provide somehow a
> mapping between symbolic name of an attribute and bitmask. Support for
> octal bitmask (a la chmod) in chattr is also an option.

There is nothing really ext2-specific to the chattr/lsattr programs.  Yes,
they use an ioctl and flag values assigned to ext2, but as you have shown
it is also possible to use this ioctl on reiserfs without any problems.
These commands are for simple file attributes only.  If reiserfs has a need
for specific attributes, then Ted can probably allocate a fs-specific range.
If you want to store the values in a different format, you can always map in
the ioctl, although I don't see a real need for that right now.

For more complex extended attributes, there are [gs]etextattr and [gs]etacl
commands (I think) which the ext2 EA/ACL code uses, but again this
is not ext2 specific.  The author (Andreas Gruenbacher) is working
with the XFS folks to support a common kernel API and allow the same
user-space tools to work, even if the fs-internal and on-disk EA/ACL formats
are different.  However, I know for extended attributes that Hans has
other plans (reiser4/sandbox syscall) so I don't know if this will be
useful to you.  Maybe still yes, if the same user programs can interface
with the reiserfs syscall, and it may still be useful for ACL support.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

