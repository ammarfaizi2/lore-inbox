Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUH2QUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUH2QUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUH2QUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:20:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268066AbUH2QUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:20:30 -0400
Date: Sun, 29 Aug 2004 17:20:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829162027.GN21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com> <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:01:23PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 28 Aug 2004, Hans Reiser wrote:
> >
> > I object to openat().....
> 
> Sound slike you object to O_XATTRS, not openat() itself.
> 
> Realize that openat() works independently of any special streams, it's
> fundamentally a "look up name starting from this file" (rather than
> "starting from root" or "starting from cwd").

Linus, openat() is trivial to implement in userland *IF* we are talking
about stuff already in namespace.  Proof:

int openat(int fd, char *path, int flags, mode_t mode)
{
	int len = snprintf(NULL, 0, "/proc/self/%d/%s", fd, path);
	char name[len + 1];
	sprintf(name, "/proc/self/%d/%s", fd, path);
	return open(name, flags, mode);
}

7 lines.  Replace VLA with alloca() or malloc() in pre-C99 environment.

In other words, there's nothing magical about syscall itself - compatibility
with Solaris is not an issue here.  And basic functionality (i.e. what you've
described above) can be trivially achieved with no extra primitives at all.

Now, if you want to use that puppy as explicit indicator of magic steps taken,
fine, but that again says nothing about the primitives we want to express the
magic steps in question - reproducing openat() as one of the libc functions
won't be hard anyway.

So I have to agree with Hans on that one - I believe that as a fundamental
primitive it's wrong choice.  Convenient to have in libc - sure, why not?
