Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWCBEsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWCBEsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWCBEsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:48:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:60628 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750730AbWCBEsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:48:46 -0500
Date: Thu, 2 Mar 2006 05:48:44 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: janak@us.ibm.com, akpm@osdl.org, ak@muc.de, hch@lst.de, paulus@samba.org,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <Pine.LNX.4.64.0603011959340.22647@g5.osdl.org>
Subject: Re: unhare() interface design questions and man page
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <1101.1141274924@www008.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, 

> On Thu, 2 Mar 2006, Michael Kerrisk wrote:
> > > >>>>>
> > > >>>>> That is, CLONE_FS, CLONE_FILES, and CLONE_VM *reverse* the 
> > > >>>>> effects of the clone() flags of the same name, but CLONE_NEWNS 
> > > >>>>> *has the same meaning* as the clone() flag of the same name.
> 
> Well, if this is the only problem, who cares? CLONE_NEWNS itself is 
> actually a reversal of clone flags: unlike the others, that tell to 
> _share_ things that normally aren't shared across a fork(), CLONE_NEWNS 
> does the opposite: it asks to unshare something that normally is shared.
> 
> So the fact that it then acts not as a reversal when doing "unshare()" 
> is 
> actually consistent with the fact that it's a already a "unshare" event 
> for clone() itself.

I care about this from an (kernel-userland) *interface* point 
of view.  I see a small but steady stream of unnecessarily 
confusing interfaces going into the kernel-userland interface; 
the problem is that no-one (or not enough people) seem to really
care about this.

The key point is this: if it looks like a duck, I expect it
to behave like a duck.  When interfaces have the same name, 
then users expect the interfaces to provide the same 
behaviour.  Now with unshare() we have the situation that
a set of flags with the same name reverses the 
corresponding flags for clone().  From an interface design 
point of view that might almost be okay.  But one flag
breaks the pattern: CLONE_NEWNS, does the same thing in 
both clone() and unshare().

Inflicting this sort of messiness on userland is a recipe 
for programmer confusion, with bugs and security holes 
in userland programs as the possible result. If you agree
that that is a possible result, then why not avoid the
possibility?  It does not cost much to do so.

> > Do you have any further response on this point?
> > (There was none in your last message?)
> 
> I personally don't think it's worth makign UNSHARE_NEWNS just because 
> it's
> a flag that acts differently from the other CLONE_xxx flags.

See my comments above.  (And in case it wasn't clear, I meant 
make a complete set of UNSHARE_* flags that mirror the 
corresponding CLONE_* flags.)
 
> As to whether allow or not allow unknown unshare() flags, I don't think 
> it's a huge deal either way. Right now we don't check the flags to 
> "clone()" either, I think.

No checking in clone() was probably a mistake (now difficult 
to rectify because it could break bad userland apps).
Is that past mistake a rationale for making the same
mistake in future interfaces?  Without checks such as I've 
described, the kernel is not providing ABI stability (i.e.,
if some bit that was meaningless in the past acquires a meaning
in later kernels, then (older) application behaviour arbitrarily
and unexpectedly changes.  Why does that possibility not matter?
Making the change I suggest would help userland programmers.
What is the cost of making it?  (i.e., is there some good reason
not to do it?)

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
