Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284563AbRLDAVA>; Mon, 3 Dec 2001 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282991AbRLDAQb>; Mon, 3 Dec 2001 19:16:31 -0500
Received: from rj.SGI.COM ([204.94.215.100]:23779 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285399AbRLCXQS>;
	Mon, 3 Dec 2001 18:16:18 -0500
Date: Tue, 4 Dec 2001 10:14:39 +1100
From: Nathan Scott <nathans@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011204101439.E43856@wobbly.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <E16Agdh-0000BS-00@starship.berlin> <20011203115400.F39338@wobbly.melbourne.sgi.com> <E16AuSr-0000HG-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16AuSr-0000HG-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Dec 03, 2001 at 03:52:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Daniel,

On Mon, Dec 03, 2001 at 03:52:58PM +0100, Daniel Phillips wrote:
> On December 3, 2001 01:54 am, Nathan Scott wrote:
> > ...BTW, we have reworked the interfaces once more and
> > will send out the latest revision in the next couple of days -
> > it does away with commands and flags completely, except for this
> > one instance of flags in the set operation...
> 
> OK, well I can see some patterns emerging already:
> 
> long sys_getxattr(char *path, char *name, void *value, size_t size, int flags)
> long sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
> long sys_listxattr(char *path, char *name, void *value, size_t size, int flags)

Not sure where you got those from (one of the early patches?), but
it looks more like this now:
long sys_setxattr(char *path, char *name, void *value, size_t size, int flags);
long sys_getxattr(char *path, char *name, void *value, size_t size);
long sys_listxattr(char *path, char *list, size_t size);

> Why don't I see 'delxattr'?
> 

Hmm.. good question.  I had been achieving this through a flag to `set',
but was never real happy about that - I guess a separate remove operation
is the cleaner interface.

> Why is there a need for separate 'path' and 'fd' variants?

Applications - the ready example is the POSIX ACL API, which specifies
path and file descriptor variants of its functions.

> <nit>Is there any other kind of 'attr' in the syscall interface?
> Why not spell it 'attr' instead of 'xaddr'?  How about geta, seta,
> dela, lista?</nit>

We have "attr" inode_operations in the VFS, so the idea is to add...

        int (*revalidate) (struct dentry *);
        int (*setattr) (struct dentry *, struct iattr *);
        int (*getattr) (struct dentry *, struct iattr *);
+       int (*setxattr) (struct dentry *, char *, void *, size_t, int);
+       int (*getxattr) (struct dentry *, char *, void *, size_t);
+       int (*listxattr) (struct dentry *, char *, size_t);
 };

And I think I'll now separate out the remove operation too -
something like:
+       int (*removexattr) (struct dentry *, char *);

The system call names have been kept consistent with this VFS
naming convention.

> The idea of attribute class (namespace) isn't explicitly accomodated.
> I presume the intention is to encode the class as part of the
> attribute name and have the filesystem or vfs parse it out.

That's correct.

> Is that such a good idea?

It simplifies things.  It has worked for Andreas for awhile (its an
idea directly from his current implementation), and I don't have any
problems with it - it has proven quite simple to implement in XFS.

>  Why not pass the 
> class explicitly and worry about the namespace parsing in user space?
> 
> As far as listing attributes goes, is there ever a reason to list system
> and user attributes at the same time?

For this area of the design, we stuck with Andreas' implementation.

I suspect one of the main reasons Andreas did it this way is to be
able to get all attribute names at once - for efficiency in backup
programs, simplicity in file manager type programs, etc.

> IOW, the listxattr call needs a class
> parameter too.  It doesn't name a 'name', at least if you accept my
> argument that the class should not be parsed inside the kernel.

Not sure I do - we had an initial version which separated name
and namespace, but we eventually scrapped it.  In particular, we
ended up wanting this all-at-once list operation, which becomes
much simpler when using a "fully-qualified" name approach.

> There's no particular
> reason to force all the parameter lists to be the same is there?

No, I think you're looking at an early, draft version of the API.
See the XFS CVS tree - cmd/attr2/man/* in particular.  I'll post
new patches here soon, just waiting to hear back from Andreas on
a couple of issues (he's been away from mail for a few days).

cheers.

-- 
Nathan
