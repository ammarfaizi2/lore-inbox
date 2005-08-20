Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVHTSBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVHTSBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbVHTSBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 14:01:05 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:5771 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932662AbVHTSBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 14:01:02 -0400
Subject: Re: open("foo", 3)
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <Pine.LNX.4.58.0508200958260.3317@g5.osdl.org>
References: <E1E6WCz-0005ym-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0508200958260.3317@g5.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 20 Aug 2005 14:00:26 -0400
Message-Id: <1124560826.18408.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 10:30 -0700, Linus Torvalds wrote:
> 
> On Sat, 20 Aug 2005, Miklos Szeredi wrote:
> > 
> > My question is: is this deliberate or accidental?  Wouldn't it be more
> > logical to not require any permission to open such file?  Or is there
> > some security concern with that?
> 
> It's deliberate but historical. It's been a long time since I worked on
> it, but it was meant for "special opens".
> 
> I _think_ it was used for things like "open block device without media
> check" etc (we use O_NONBLOCK for that now), and it was used for directory
> opens before we had O_DIRECTORY. (It's literally been years, so my 
> recollection may be bogus).
> 
> I don't think anything uses it any more, and it should probably be 
> deprecated rather than extended upon.

It may also be dangerous, since I see several drivers using 

if ((filp->f_flags & O_ACCMODE) != RD_ONLY) {
  /* do something assuming we have write access */
   ...
}


Perhaps that access mode may not allow for getting to code like this,
but, since it's so old, you may have those that forget about the 3 mode,
and we lose the protection somewhere along the line.

It probably be better to not allow for it.  Or maybe an audit of such
code needs to be replaced with:

if (filp->f_mode & FMODE_WRITE) {
  ...
}

Just my $0.02

-- Steve



