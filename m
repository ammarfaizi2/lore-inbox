Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129704AbQK1X1h>; Tue, 28 Nov 2000 18:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129996AbQK1X11>; Tue, 28 Nov 2000 18:27:27 -0500
Received: from u91n224.hfx.eastlink.ca ([24.222.91.224]:37380 "EHLO
        llama.nslug.ns.ca") by vger.kernel.org with ESMTP
        id <S129704AbQK1X1Q>; Tue, 28 Nov 2000 18:27:16 -0500
Date: Tue, 28 Nov 2000 18:56:09 -0400
To: Andries Brouwer <aeb@veritas.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
Message-ID: <20001128185609.A2960@llama.nslug.ns.ca>
In-Reply-To: <20001126233522.A436@llama.nslug.ns.ca> <20001127134251.A8164@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001127134251.A8164@veritas.com>; from aeb@veritas.com on Mon, Nov 27, 2000 at 01:42:51PM +0100
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 01:42:51PM +0100, Andries Brouwer wrote:
> On Sun, Nov 26, 2000 at 11:35:22PM -0400, Peter Cordes wrote:
> 
> >  While doing some hdparm hacking, after booting with init=/bin/sh, I noticed
> > that open(1) doesn't work when / is mounted read only.
> 
> Already long ago open(1) was renamed to openvt(1), so it may be that
> have a very old version. See a recent kbd or console-tools.

 In the Debian package, on my Woody system, open is a symlink to openvt.
I've got console-tools 0.2.3.  The source uses access here:

  /* Maybe we are suid root, and the -c option was given.
     Check that the real user can access this VT.
     We assume getty has made any in use VT non accessable */
  if (access(vtname, R_OK | W_OK) < 0)
  {
     fprintf(stderr, _("Cannot open %s read/write (%s)\n"), vtname,
             strerror(errno));
     return (5);
  }

  That code could be "fixed" to work with the current kernel behaviour by
checking that errno != EROFS.  I thought access was supposed to tell you
whether open will work, except for directories, where you do different
things to write to them.  (I've seen your messages up to Tue, 28 Nov 2000
22:37:21 +0100, but I'm replying to this one, so you don't have to repeat
your arguments for me :)


> > access("/dev/tty2", R_OK|W_OK)          = -1 EROFS (Read-only file system)
> 
> >  However, this is wrong.  You _can_ write to device files on read-only
> > filesystems.  (open shouldn't bother calling access(), but the kernel should
> > definitely give the right answer!)
> 
> You misunderstand the function of access(). The standard says
> 
> [EROFS] write access shall fail if write access is requested
>         for a file on a read-only file system
> 
> It does not look at whether you ask write access to a directory
> or a special device file (and whether the filesystem was mounted nodev or not).

 In the case of a directory, "writing" to it is creating or deleting files
in it: the list of filename:inode changes.  If the dir is on a read-only FS,
you can't write, so access() should fail.  Writing to a device file doesn't
change anything stored with the file, so it works even if the file is on a
read-only FS.

> So, probably you found a flaw in openvt: the use of access is almost always
> a bug - it doesnt tell you what you want to know. You may send me a patch
> if you want to.

 What do you think access is for then?  Is it defined by the standard in
such a way that it isn't useful for anything?

 I'm of the opinion that Linux should work in the way that is most useful,
as long as that doesn't stop us from running stuff written for other unices.
Unix is mostly good, but parts of it suck.  There's no reason to keep the
parts that suck, except when needed for compatibility.  Changing the
behaviour of access here would not introduce security holes in anything, so
I think it should be changed to the more sensible way.

(That last paragraph is purely my opinion.  I'm pretty sure not everyone
shares it!)

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
