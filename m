Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSFMKkL>; Thu, 13 Jun 2002 06:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317584AbSFMKkK>; Thu, 13 Jun 2002 06:40:10 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:35847 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317580AbSFMKkJ>; Thu, 13 Jun 2002 06:40:09 -0400
Date: Thu, 13 Jun 2002 03:40:04 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020613034004.A15498@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020612192526.B6679@pegasys.ws> <Pine.LNX.4.21.0206131003550.1596-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 10:58:39AM +0100, Hugh Dickins wrote:
> On Wed, 12 Jun 2002, jw schultz wrote:
> > On Wed, Jun 12, 2002 at 03:52:34PM +0100, Hugh Dickins wrote:
> > > On Wed, 12 Jun 2002, Andrew Morton wrote:
> > > > 
> > > > 1: Map the page to disk at fault time, generate SIGBUS on
> > > >    ENOSPC  (the standards don't seem to address this issue, and
> > > >    this is a non-standard overload of SIGBUS).
> > > 
> > > I believe your option 1 is closest to the right direction; and SIGBUS
> > > is entirely appropriate, I don't see it as a non-standard overload.
> > 
> > I concur that #1 is closest.  I'd prefer it to happen on a
> > write fault rather read but the frequency with which
> > this should occur is low enough i wouldn't sweat it.
> > 
> > It is a non-standard overload of SIGBUS.  SIGBUS is to
> > indicate an unaligned memory access or otherwise malformed
> > address. Many confuse SIGBUS with SIGSEGV because they are
> > usually symptoms of the same problems but a SIGSEGV is to
> > indicate memory protection violation (unresolvable page
> > fault) which is not the same as a malformed address.  I
> > believe Linux, at least on x86 maps both errors to SIGSEGV.
> > I would think SIGXFSZ might be a better fit.
> 
> No.  I think you're looking back too far in UNIX history.
> I imagine SIGBUS was originally defined as you describe,
> but got hijacked by the inventors of the mmap system call
> (only a limited number of signals available).  That overload
> has been enshrined in standards for ten(?) years.

Perhaps.  I guess i'm showing my age but i remember when the
hardware MMU would generate a "buss error" and more than
once the distinction between buss error and segmentation
violation actually pointed to the programming error.  If so
it is way past time to alias SIGBUS and deprecate the old
name.  We're also overdue for fixing the manpages where
signal(7) defines SIGBUS as "Bus error (bad memory access)"
which has nothing to do with space availabilty.

> SIGSEGV is used where mapping itself cannot be accessed (no mapping
> or insufficient permission); SIGBUS where mapped object cannot be
> accessed - I/O error or, more usually, beyond end of (last page of)
> file.  Linux just follows the standards on those.
> 
> It would be inappropriate to use anything but SIGBUS for no space.

I would dispute that; as the only signal that even hints at
out-of-space is SIGXFSZ which is why i mentioned it.  Since
we are going beyond POSIX and SUS we could use an altogether
new signal but that is a much bigger discussion.  SIGFULL
anyone?  I seem to recall a discussion regarding a mechanism
that would allow notifying processes that memory is tight,
but that should by default ignore not terminate so should not
shared with this.

The main thing is the signal should be catchable and by
default should terminate without core.  As long as a corrupt
pointer doesn't cause the same signal as running out of
space i'm ok with it.

I've said my piece and I'll shut up now.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
