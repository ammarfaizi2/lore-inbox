Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbUDBUJi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUDBUJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:09:38 -0500
Received: from mail.shareable.org ([81.29.64.88]:7318 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264169AbUDBUJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:09:35 -0500
Date: Fri, 2 Apr 2004 21:09:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402200921.GC653@mail.shareable.org>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402182357.GB410@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Okay, now I have to start talking about implementation. Assume ext2 as
> a base. Theres new object "cowid" which contains, well, id for
> get_data_id() and usage count. Each inode either has pointer to
> "cowid" object, or it is plain old regular file.

Pavel has it exactly right.

A simple way to store COWID objects in the filesystem itself is as
another ordinary inode.  The attributes of that inode (mtime, mode
etc.) aren't important (except to fsck), only the size and data
pointers are important.  The files which point to a COWID need a flag
to indicate that, too.

Someone said that a problem with using sendfile() to create cowlinks
is that sendfile() takes a length parameter.  It's a size_t, which
isn't large enough to copy Large files.

Actually that isn't a problem.  The COWID inodes contain the real
length of the shared data.  It would be possible for the individual
cowlink inodes to have a smaller length, indicating that they don't
have all the data.  Then a cp implementation which calls sendfile()
repeatedly could copy large files and still share the data.  Provided
the offset and length are compatible with sharing, the first
sendfile() would create the COWID (if it doesn't exist already), and
subsequent ones would simply enlarge the individual cowlink's length
attribute.  It's not the cleanest interface; I only mention it because
sendfile() exists already and could be used.

get_data_id() is one way to detect equivalent files.  Another would be
a function files_equal(fd1, fd2) which returns a boolean.
get_data_id() has the advantage that it can report immediately whether
a file has _any_ cowlink peers, which is important for programs that
scan trees.  Perhaps getxattr() would be reasonable interface, using a
named attribute "data-id".

-- Jamie
