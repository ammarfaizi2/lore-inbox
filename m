Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUDEMgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUDEMgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:36:06 -0400
Received: from mail.shareable.org ([81.29.64.88]:56471 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262176AbUDEMgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:36:02 -0400
Date: Mon, 5 Apr 2004 13:35:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: jlnance@unity.ncsu.edu
Cc: Pavel Machek <pavel@ucw.cz>,
       =?utf-8?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405123556.GB19842@mail.shareable.org>
References: <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040405111033.GA1456@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405111033.GA1456@ncsu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
> Perhaps diff would run faster but that
> seems like a very special case thing, and diff will certainly work w/o it.

We are talking about a difference between 20 minutes and 1 second.
It's quite significant, when it's a regular part of your diffing &
patching day.

I agree with your general sentiment that we shouldn't expose
filesystem details, e.g. a 32-bit integer.  See below for an
alternative interface.

> Tar might also be faster creating archives if it had this information
> available.  However to make tar useful wrt cowlinks, it will need to be
> able to create these links at extract time from tarfiles which were created
> on non-cowlink filesystems, so I don't think there is a pressing need.

I agree.  The purpose of cowlinks is to be semantically invisible.  If tar
or some other archiver/transferer wanted to use this information, it
should really be checking for equivalent files in general (like cmp)
and use this call as an optimisation only.

Btw, when we treat cowlinks as a semantically invisible, there is no
problem searching an entire filesystem for files with identical
content and linking them together to save space, in a cron job.  It's
invisible to applications, except that space is saved and sometimes
the first write takes longer.

That still permits the get_data_id() optimisation, but that now
strictly means "kernel knows and returns a unique id of the data
(unique in this filesystem)".

Instead of get_data_id(), we'd use a POSIX attribute called "data-id"
returned by getxattr().  An absence of the attribute indicates that no
data-id is known.  Otherwise, it's a unique id for that data in the
current filesystem.

It's a short byte string (another reason for making it a POSIX
attribute).  On ext2/ext3, it's just the bytes of the shared inode
number plus a filesystem-wide generation number.  On a hypothetical
httpfs, it could be the host name and ETag (a strong validator).  On
any filesystem, it could be the SHA1 digest if that is known.  It
would have the nice property of working over NFSv4, too.

-- Jamie
