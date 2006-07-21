Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWGUTC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWGUTC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWGUTC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 15:02:58 -0400
Received: from pat.uio.no ([129.240.10.4]:43143 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751106AbWGUTC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 15:02:57 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Theodore Tso <tytso@mit.edu>
Cc: Bill Davidsen <davidsen@tmr.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060721143619.GB2290@thunk.org>
References: <20060705125956.GA529@fieldses.org>
	 <1152128033.22345.17.camel@lade.trondhjem.org> <44AC2D9A.7020401@tmr.com>
	 <1152135740.22345.42.camel@lade.trondhjem.org> <44B01DEF.9070607@tmr.com>
	 <1152562135.6220.7.camel@lade.trondhjem.org> <44B2D6AA.3090707@tmr.com>
	 <1152585383.10156.9.camel@lade.trondhjem.org> <44C045B4.3040609@tmr.com>
	 <1153483570.21909.8.camel@localhost>  <20060721143619.GB2290@thunk.org>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 15:02:35 -0400
Message-Id: <1153508555.7534.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-21 at 10:36 -0400, Theodore Tso wrote:
> On Fri, Jul 21, 2006 at 08:06:10AM -0400, Trond Myklebust wrote:
> > > By keeping lazy track of access time it's possible to still have that 
> > > data, with minimal disk access cost. And to some people that can be 
> > > really useful, such as those of us who have to justify expenditures.
> > 
> > What you propose violates both POSIX and SuSv3. close() does not update
> > the atime on a file. I can't see anyone accepting that there is a need
> > for this.
> 
> Nope, it doesn't violate POSIX/SuSv3.  The specifications only control
> what happens if the system is cleanly shutdown.  What happens on an
> unclean shutdown is explicitly undefined.  Hence, lazy atime update
> where there is a "dirty" and "mostly clean" (i.e., atime-dirty) bit,
> and where "mostly clean" inodes are only flushed out to disk when they
> become fully dirty and then written out to disk, or when the
> filesystem is unmounted, or when the filesystem feels like it (i.e.,
> when we need to clear out in-core inodes in response to memory
> pressure), would in fact be completely POSIX/SuSv3 compliant.

I agree that POSIX does not place any requirements on caching, but what
you propose is impossible to implement on NFS: you may be able to get
the atime 'right' (assuming that you are using something like ntp to
ensure that client and server are in sync) but the NFS SETATTR
primitives do not permit you to set the ctime, so that will be set to
the time on the server it processed your SETATTR call (i.e. the close
time). That violates POSIX semantics.

Cheers,
  Trond

