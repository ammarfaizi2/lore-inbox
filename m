Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277408AbRJOLfr>; Mon, 15 Oct 2001 07:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277413AbRJOLfh>; Mon, 15 Oct 2001 07:35:37 -0400
Received: from pcephc56.cern.ch ([137.138.38.92]:37760 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S277408AbRJOLfX>; Mon, 15 Oct 2001 07:35:23 -0400
Date: Mon, 15 Oct 2001 13:35:06 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011015133506.B4269@kushida.jlokier.co.uk>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com> <20011013214603.A1144@kushida.jlokier.co.uk> <200110132241.f9DMfmD28263@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110132241.f9DMfmD28263@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, Oct 13, 2001 at 04:41:48PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> > There are applications (GCC comes to mind) which are using mmap() to
> > read files now because it is measurably faster than read(), for
> > sufficiently large source files.
> 
> So? MAP_PRIVATE is just fine for these. The simple solution if you
> care about an edit in the middle of a compile is to have your editor
> write a new file and do an atomic rename. No half-and-half data
> problems, and the VM logic is kept simple (well, relative to what we
> have now;-).

This does not work.  Example:

  1. JamieEmacs loads file using MAP_PRIVATE.
  2. Something else writes to the file.
  3. Scroll to the bottom of the file in JamieEmacs.  It displays some
     of the newly written data, though not all of it.

--> Wrong editor semantics.

Note that the something else which modifies the file in step 2 is not an
editor written especially to cooperate with JamieEmacs.  So it does not
do renaming -- why should it?  You might have just loaded
/var/log/messages into JamieEmacs, for example, and syslog is the
program in step 2.

What you need is read() or an equivalent.  I don't know of a
memory-efficient equivalent to read.  MAP_PRIVATE doesn't do it because
you have to dirty every page before you can be sure that file
modifications won't change your view of the data, and the dirtying
creates just as many page duplicates as read() does.

cheers,
-- Jamie
