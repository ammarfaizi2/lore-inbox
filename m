Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKQDOX>; Thu, 16 Nov 2000 22:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQDOO>; Thu, 16 Nov 2000 22:14:14 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:32011 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129145AbQKQDOC>; Thu, 16 Nov 2000 22:14:02 -0500
Date: Thu, 16 Nov 2000 20:40:29 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: NCPFS not returning Volume Size (???)
Message-ID: <20001116204029.A15356@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

NCPFS in 2.2.18-pre21 is not returning volume size via df -h.  I checked
your code and found this comment:

static int ncp_statfs(struct super_block *sb, struct statfs *buf, int bufsiz)
{
	struct statfs tmp;

	/* We cannot say how much disk space is left on a mounted
	   NetWare Server, because free space is distributed over
	   volumes, and the current user might have disk quotas. So
	   free space is not that simple to determine. Our decision
	   here is to err conservatively. */

	tmp.f_type = NCP_SUPER_MAGIC;
	tmp.f_bsize = 512;
	tmp.f_blocks = 0;
	tmp.f_bfree = 0;
	tmp.f_bavail = 0;
	tmp.f_files = -1;
	tmp.f_ffree = -1;
	tmp.f_namelen = 12;
	return copy_to_user(buf, &tmp, bufsiz) ? -EFAULT : 0;
}

NCP Code

2222/17E6   Get Object's Remaining Disk Space

(I have docs on this one and can send if you need it).

will return in NetWare sized blocks the space remaining for this 
user (which will be the user ID used to login).  The fact that quota's 
are present for a user (user space restriction node -- in NWDIR.H) 
should be irrelevant, since from the view of a Linux client attached to 
a NetWare server, this is their assigned storage.

This NCP also speaks in hardcoded blocksizes of 4096 bytes, so that's 
the factor for free space for whatever login ID was used to mount 
the NetWare Volume that can be used in ncpfs_statfs() to return 
free space.

I have not gone through your userspace code as of yet, but to make 
this work, you need the ObjectID for the User Account you used to
connect to the server in order to make this work.  

I noticed I could not get free space from my Server with NCPFS with
df -h, and tracked it down.  Several NetWare customers migrating 
installations of NetWare to Linux pointed it out when they were 
moving Oracle databases over to Linux from NetWare.

I noticed that 2.4 also is not reporting Volume free space.  

The current NCPFS code, like a lot of Linux code, is structured
in a manner that's very different from Novell's internal code,
(the names are shorter for one, which is an improvement).  The 
way the NCP codes are peeled off is different and not the 
large case and switch structure employed in NetWare, so it's
a little hard for me to follow since I am used to NCPs being 
grouped into case/switch classes.  If you can point me to 
where 1) the login ID is stored and B) where NCP packet 
request/reponse headers are constructed, i.e. a skeleton 
to send/receive the requests I can grab, I'll try to 
code this for you.

:-)

Jeff 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
