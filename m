Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUIBUaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUIBUaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269039AbUIBU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:29:56 -0400
Received: from mail.shareable.org ([81.29.64.88]:2763 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S269020AbUIBU0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:26:17 -0400
Date: Thu, 2 Sep 2004 21:25:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tonnerre <tonnerre@thundrix.ch>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com, vonbrand@inf.utfsm.cl
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902202512.GD24932@mail.shareable.org>
References: <20040829191044.GA10090@thundrix.ch> <3247172997-BeMail@cr593174-a> <20040831081528.GA14371@thundrix.ch> <20040901201608.GD31934@mail.shareable.org> <1094118649.4847.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094118649.4847.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-09-01 at 21:16, Jamie Lokier wrote:
> > (For example, if I edit an HTML file which is encoded in iso-8859-1,
> > change it to utf-8 and indicate that in a META element, and save it
> > under the same name, the full content-type should change from
> > "text/html; charset=iso-8859-1" to "text/html; charset=utf-8".)
> > 
> > I don't see how you can do that without kernel support.
> > 
> > Don't say dnotify or inotify, because neither would work.
> 
> inotify done right is useful here as well as in a lot of other desktop
> cases where dnotify doesn't really scale. Its enough to let me
> 
> 	- Find the new file
> 	- Virus scan it
> 	- Classify its possible type heirarchies
> 	- Index it

Indeed it does, but it fails for the example I was commenting on to
which you replied..

      1. The file /var/www/site/index.html's written in vi.
      2. "The daemon" (that's what I objected to) receives inotify.
         blocks waiting for scheduler, however...
      3. Seeing that vi is now finished, I phone person on other side
         of world and say the updated file is now available.
      4. Person fetches http://site/index.html
         ...oh!  They receive the wrong content-type (bollocks!)
      5. Eventually after paging & scheduling deems it appropriate,
         "The daemon" gets to run, looks at file, updates content-type.

In other words I was criticising Tonnerre's idea of a daemon which
updates the xattrs by looking at file contents...  by definition, a
daemon runs in the background, and the whole point of it updating a
content-type xattr was obviously so that programs like httpd could
just _use_ that xattr.

That doesn't work, even if that daemon uses inotify.

Basically, anytime where you want an ordering guarantee that something
will be recalculated in the interval after a file is modified and
before the calculated result is used, you have to be very careful
about exactly which code is using dnotify or inotify to achieve that.
Single threaded programs can use it easily, but a multi-threaded file
server has to be very careful about ordering if it's to avoid glitches.

It is exactly a real problem I have faced in a multi-threaded HTTP
server which uses dnotify to detect changes to prerequisite files and
also changes to the path walked and permissions on it, and thus
invalidate cached generated pages, thus giving strong cache
guarantees.  Performance is great, if you ignore the race conditions...

(One of the more popular small web servers, lighttpd (PHP people seem
to like it), also uses dnotify.  Apparently it provides a big
performance boost, just by avoiding stat() calls.  So I'm not alone in
using dnotify for such things.)

-- Jamie

