Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280892AbRKHBzA>; Wed, 7 Nov 2001 20:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281252AbRKHByv>; Wed, 7 Nov 2001 20:54:51 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:53404 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280892AbRKHByj>; Wed, 7 Nov 2001 20:54:39 -0500
Date: Thu, 8 Nov 2001 01:26:10 +0000
From: Stephen Tweedie <sct@redhat.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, acl-devel@bestbits.at,
        linux-xfs@oss.sgi.com
Subject: Re: [Acl-Devel] Re: [RFC][PATCH] extended attributes
Message-ID: <20011108012610.C12638@redhat.com>
In-Reply-To: <20011107111224.C591676@wobbly.melbourne.sgi.com> <20011107023218.A4754@wotan.suse.de> <20011107141956.F591676@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107141956.F591676@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Wed, Nov 07, 2001 at 02:19:56PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 07, 2001 at 02:19:56PM +1100, Nathan Scott wrote:
> On Wed, Nov 07, 2001 at 02:32:18AM +0100, Andi Kleen wrote:
> > EA_FIRST_ENTRY to reset the fd the first entry, EA_READ_ENTRY to 
> > read the next one.
> 
> I'm not sure this would work for the extattr/lextattr variants where
> we don't have an fd to hold the state.

> eg. the opening of the file before allowing a list operation could
> have implications for XFSs DMAPI support (open might recall data from
> tape),

There are other much more immediate obstacles: opening /dev/* is not
possible if the devices beneath the inodes don't exist.

O_OPENONLY (implying neither read nor write access) to get a stub file
handle for such inodes is possible, if a bit hackish.  There's a
problem in the kernel there --- kernel file descriptor operations on
"special" inodes such as named sockets/pipes or device nodes don't
pass file operations on to the underlying filesystem.  

As long as you're doing the ACL stuff via inode operations internally,
that's not a problem.  However, inode operations generally don't take
a file descriptor as an argument so you don't have access to the
cursor in that case.

The DMAPI and special inode problems go away if you don't demand a
file descriptor to the file.  (Having a file descriptor that
specifically belongs to the ACL stream is a different matter
entirely.)

--Stephen
