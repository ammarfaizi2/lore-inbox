Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285531AbRLGUvT>; Fri, 7 Dec 2001 15:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285532AbRLGUvK>; Fri, 7 Dec 2001 15:51:10 -0500
Received: from codepoet.org ([166.70.14.212]:60422 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S285531AbRLGUvD>;
	Fri, 7 Dec 2001 15:51:03 -0500
Date: Fri, 7 Dec 2001 13:51:01 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision.ag, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: On re-working the major/minor system
Message-ID: <20011207135100.A17683@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dalecki@evision.ag,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> <E16CJnv-0005c0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16CJnv-0005c0-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 07, 2001 at 12:08:35PM +0000, Alan Cox wrote:
> > > major/minors for old stuff still end up leaking into user space and
> > > mattering there. I'm not sure the best option for that
> > 
> > Thta's no problem. But they should be used as hash values no the
> > syscall implementation level and nowhere else.
> 
> We have apps that "know" about specific major/minors that need changing and
> will take time - also some of them are closed source so unfixable.

Right.  Tons of apps have illicit insider knowledge of kernel
major/minor representation and NEED IT to do their job.  Try
running 'ls -l' on a device node.  Wow, it prints out major and
minor number.  You can pack up a tarball containing all of /dev
so tar has to has insider major/minor knowledge too -- as does
the structure of every existant tarball!  Check out, for example,
Section 10.1.1 (page 210) of the IEEE Std. 1003.1b-1993 (POSIX)
and you will see every tarball in existance stores 8 chars for
the major, and 8 chars for the minor....

So we have POSIX, ls, tar, du, mknod, and mount and tons of other
apps all with illicit insider knowledge of what a dev_t looks
like.   A couple of months ago I patched up mkfs.jffs2 so it
could create device nodes on the target filesystem that don't
really exist in the source directory (avoids the need to be root
when building filesystems).

Right now, you will find that a zillion user space apps currently
have little snippets of code looking like:

    /* FIXME:  MKDEV uses illicit insider knowledge of kernel 
     * major/minor representation...  */
    #define MINORBITS       8
    #define MKDEV(ma,mi)    (((ma) << MINORBITS) | (mi))

To currently, to do pretty much anything nifty related to devices
in usespace, usespace has to peek under the kernel's skirt to
know how to change a major and minor number into a dev_t and/or
to sanely populate a struct stat.

To change things, we 1) need some sortof sane interface by which
userspace can refer sensibly to devices without resorting to evil
illicit macros and 2) we certainly need some sort of a static
mapping such that existing devices end up mapping to the same
thing they always did or 3) we will need a flag day where we say
that all pre-2.5.x created tarballs and user space apps are
declared broken...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
