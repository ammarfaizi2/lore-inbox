Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269436AbUHZTnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269436AbUHZTnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbUHZTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:39:45 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:60619 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S269410AbUHZTf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:35:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.15061.549250.611694@gargle.gargle.HOWL>
Date: Thu, 26 Aug 2004 15:32:37 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Rik van Riel <riel@redhat.com>, Christophe Saout <christophe@saout.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826165351.GM5733@mail.shareable.org>
References: <20040826154446.GG5733@mail.shareable.org>
	<Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
	<20040826165351.GM5733@mail.shareable.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie> Rik van Riel wrote:
>> And if an unaware application reads the compound file
>> and then writes it out again, does the filesystem
>> interpret the contents and create the other streams ?

Jamie> Yes, exactly that.  The streams are created on demand of
Jamie> course, and by userspace helpers when that's appropriate which
Jamie> I suspect it almost always is.

So how would a program that converts between a JPEG file (with exif
data) and a PNG work, such as ImageMagick?  Are we proposing to teach
the VFS (or worse yet each filesystem) how to do this?  

I've been following this discussion a bit and I'm not sure that I've
actually seen any concrete examples of where this is a *good* thing to
have.  People talk about only having to modify 20 bytes at a time
instead of reading and writing 1mb of data.  Isn't that what mmap()
does?

Now I can sorta understand the idea that having a directory look like
a file is neat, and certainly simplifies some aspects, but I think
that going all the way down to the logical conclusion here is a bit
silly.

To use the principle of blowing things up to make them very large or
very small, what happens if I decide that the best idea is to make all
files just be directories which contain single byte files?  Isn't that
the logical extreme here?  So my 1mb JPEG file is not just some image
data and header info in multiple files, but it's really just 1
million (ok 1024 * 1024) individual files that the VFS knows how to
put together.  Seems like the logical extreme.  Oh wait, maybe we
should be exposing a single file per bit instead! 

>From my point of view, there lies madness.  As Rik pointed out, how do
backup and restore tools work with this stuff?  Most people could care
less about how their data is organized, but they certainly care when
they can't restore it from backups.  

I'd really like to see a concrete example from Hans or other
proponents about why this makes things easier/faster/better to do.
Mostly, I've just seen "proof by vigorous handwaving" that it's a good
thing.

In alot of ways, I think people are going in the wrong direction, you
want to excapsulate and hide the details more, not expose them.
That's what a good API does, it hides the details while giving you a
rich set of semantics to manage your data.  

God knows I'm not smart enough or driven enough to actually come up
with my own ideas, but I certainly haven't seen anyone else (even
Linus) come up with an earth shattering arguement to say why this is
the right move to make.

As Linus says, most of the OS's job is to mediate access to
objects/data.  Why do we want to expose such low level data then?

John

   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
