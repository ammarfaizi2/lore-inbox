Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268920AbUIBUD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268920AbUIBUD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIBUAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:00:51 -0400
Received: from mail.shareable.org ([81.29.64.88]:64714 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268857AbUIBT7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:59:17 -0400
Date: Thu, 2 Sep 2004 20:58:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: Tonnerre <tonnerre@thundrix.ch>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com, vonbrand@inf.utfsm.cl
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902195825.GC24932@mail.shareable.org>
References: <20040829191044.GA10090@thundrix.ch> <3247172997-BeMail@cr593174-a> <20040831081528.GA14371@thundrix.ch> <20040901201608.GD31934@mail.shareable.org> <m3u0ugilj2.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u0ugilj2.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> 
> > (For example, if I edit an HTML file which is encoded in iso-8859-1,
> > change it to utf-8 and indicate that in a META element, and save it
> > under the same name, the full content-type should change from
> > "text/html; charset=iso-8859-1" to "text/html; charset=utf-8".)
> >
> > I don't see how you can do that without kernel support.
> 
> [code which runs in the program which needs to read the content-type]
> 
> This code is guaranteed to always give you an up to date charset for a
> file, provided that the mtime is guaranteed to change every time the
> file changes.

...which it isn't, but ignoring that.

Yes we all know that code will work, turning a blind eye to occasional
mtime failures.

What I objected to isn't that, but Tonerre's idea of a daemon (i.e. in
the background, that's what daemons do) updating xattrs.  Your code
will work.  Tonerre's has a serious race condition.

> > Don't say dnotify or inotify, because neither would work.
> 
> Why not?  The approach above works on any filesystem, even without
> dnotify or inotify but will be more efficient with them.

The above approach is in fact better with dnotify/inotify, when they
area available, because then it doesn't have mtime problems.

My objection is that dnotify & inotify don't fix the problems of a
"daemon" (i.e. in the background) updating an xattr - because the
daemon might not run scheduled between the write and when the file
needs to be used.

That said, yours has practical problems too.  The intended purpose (*)
of storing content-type in an xattr was so that programs which need to
read content without understanding it may just do so (e.g. mail agents,
httpd), and are distinct from the programs which compute and set it
(e.g. programs which understand specific content formats).

(*) I don't necessarily agree with that purpose.

-- Jamie
