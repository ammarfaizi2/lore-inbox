Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSGGUzT>; Sun, 7 Jul 2002 16:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSGGUzS>; Sun, 7 Jul 2002 16:55:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:37390 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316573AbSGGUzR>;
	Sun, 7 Jul 2002 16:55:17 -0400
Date: Sun, 7 Jul 2002 13:55:44 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020707205543.GA18298@kroah.com>
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <3D27390E.5060208@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D27390E.5060208@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 09 Jun 2002 19:34:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<copied to lkml, as people there deserve to also see this>

On Sat, Jul 06, 2002 at 11:38:06AM -0700, Dave Hansen wrote:
> Rik van Riel wrote:
> >On Thu, 4 Jul 2002, Dave Hansen wrote:
> >
> >>Greg KH wrote:
> >>
> >>>How about another extreme example.  When you removed the BKL from the
> >>>input subsystem, you created a zillion race conditions.  I can dig up
> >>>the email reference if you really want.  Hopefully that mess is finally
> >>>cleaned up now.
> >>
> >>But it is mostly BKL-free now, right?  It may have been painful for
> >>some, but it is better than before I broke it.
> >
> >If there is no contention on the lock, why is the BKL a problem?
> 
> It is not just a matter of scalability, but maintainability.  I find 
> it hard to read and understand code which uses the BKL.  As Greg said 
> in his OLS coding style talk, I want you to be able to read my code to 
> find _my_ mistakes.  Your ability to do that will be impaired by every 
> bad indentation, typedef, and BKL use.

Excuse me, but please do NOT compare coding style with using the BKL!  I
can use the BKL in my code just fine, and it does not impare your
ability to use, modify, or understand my code.  As long as I comment why
I am using the BKL.

> A lock with a single purpose, guarding relatively small amounts of 
> data is much easier to understand than one such as the BKL.  Would you 
> want a simple VM operation to take 1 second as the TTY layer and ext3 
> take their sweet time with the BKL?

If ext3 is spinning on the BKL, then try to fix that, as it seems like a
worthwhile task (like the ext2 changes proved.)  If you want to remove
the BKL from the tty layer, be my guest, that will involve rewriting
that whole subsystem :)

> There seems to be a lot of fear that we'll scale the kernel into 
> oblivion by creating a different lock for every single bit in every 
> single data structure in the kernel with horribly complex locking 
> hierarchies.  We know the implications of locks which are too finely 
> grained and we see them magnified 20-fold on our NUMA-Q boxes (cache 
> bouncing there is painful).  Linux may approach that point sometime in 
> the future, but BKL use is about as far from this situation as possible.

Yes, there is that fear of scaling into oblivion, because other
operating systems have done this in the past.  Learn from their
mistakes, don't redo them yourself.  Go talk to the IRIX developers, and
ask their experiences.  I know one of them is a few rows away from you
at work.

> I would mind the BKL a lot less if it was as well understood 
> everywhere as it is in VFS.  The funny part is that a lock like the 
> BKL would not last very long if it were well understood or documented 
> everywhere it was used.

I would mind it a whole lot less if when you try to remove the BKL, you
do it correctly.  So far it seems like you enjoy doing "hit and run"
patches, without even fully understanding or testing your patches out
(the driverfs and input layer patches are proof of that.)  This does
nothing but aggravate the developers who have to go clean up after you.

Also, stay away from instances of it's use WHERE IT DOES NOT MATTER for
performance.  If I grab the BKL on insertion or removal of a USB device,
who cares?  I know you are trying to remove it entirely out of the
kernel, but please focus on places where it actually helps, and leave
the other instances alone.

thanks,

greg k-h
