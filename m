Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317389AbSFMJ7A>; Thu, 13 Jun 2002 05:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSFMJ7A>; Thu, 13 Jun 2002 05:59:00 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64710 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317389AbSFMJ67>; Thu, 13 Jun 2002 05:58:59 -0400
Date: Thu, 13 Jun 2002 10:58:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <20020612192526.B6679@pegasys.ws>
Message-ID: <Pine.LNX.4.21.0206131003550.1596-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, jw schultz wrote:
> On Wed, Jun 12, 2002 at 03:52:34PM +0100, Hugh Dickins wrote:
> > On Wed, 12 Jun 2002, Andrew Morton wrote:
> > > 
> > > 1: Map the page to disk at fault time, generate SIGBUS on
> > >    ENOSPC  (the standards don't seem to address this issue, and
> > >    this is a non-standard overload of SIGBUS).
> > 
> > I believe your option 1 is closest to the right direction; and SIGBUS
> > is entirely appropriate, I don't see it as a non-standard overload.
> 
> I concur that #1 is closest.  I'd prefer it to happen on a
> write fault rather read but the frequency with which
> this should occur is low enough i wouldn't sweat it.
> 
> It is a non-standard overload of SIGBUS.  SIGBUS is to
> indicate an unaligned memory access or otherwise malformed
> address. Many confuse SIGBUS with SIGSEGV because they are
> usually symptoms of the same problems but a SIGSEGV is to
> indicate memory protection violation (unresolvable page
> fault) which is not the same as a malformed address.  I
> believe Linux, at least on x86 maps both errors to SIGSEGV.
> I would think SIGXFSZ might be a better fit.

No.  I think you're looking back too far in UNIX history.
I imagine SIGBUS was originally defined as you describe,
but got hijacked by the inventors of the mmap system call
(only a limited number of signals available).  That overload
has been enshrined in standards for ten(?) years.

SIGSEGV is used where mapping itself cannot be accessed (no mapping
or insufficient permission); SIGBUS where mapped object cannot be
accessed - I/O error or, more usually, beyond end of (last page of)
file.  Linux just follows the standards on those.

It would be inappropriate to use anything but SIGBUS for no space.

Hugh

