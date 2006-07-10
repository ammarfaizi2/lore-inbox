Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWGJOUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWGJOUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWGJOUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:20:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4711 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030400AbWGJOUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:20:09 -0400
Date: Mon, 10 Jul 2006 16:22:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice() and file offsets
Message-ID: <20060710142245.GG5210@suse.de>
References: <20060710121110.26260@gmx.net> <20060710125150.GM25911@suse.de> <20060710130754.26280@gmx.net> <20060710132529.GD5210@suse.de> <20060710135427.26270@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710135427.26270@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Michael Kerrisk wrote:
> Jens,
> 
> > > I'm still not clear here.  Let me phrase my question another way:
> > > why is it that the presence or absence of off_out affects whether
> > > or not splice() changes the current file offset for fd_out?
> > 
> > The logic is simple - either you don't give an explicit offset, and the
> > current position is used and updated. Or you give an offset, and the
> > current position is ignored (not read, not updated).
> 
> Yes, I understand what the code is doing, but *why* do 
> things this way?  (To put things another way: why not *always 
> have splice() update the file offset?)  I realise there may be
> some good reason for this, and if there is, it will go into the
> man page!

The good reason is why update the current position? I just told the
kernel to ignore the current position and use the given offset, why
would I bother updating the current position? The whole point of
providing an offset is to ignore the current position.

I must say I cannot understand why you are confused or find this
illogical, it makes perfect sense to me.

> > > > It's identical to how sendfile() works.
> > > 
> > > But it isn't: sendfile() never changes the file offset 
> > > of its 'in_fd'.
> > 
> > Ehm, yes it does. Would you expect the app to do an appropriate lseek()
> > on every sendfile() call?
> 
> No!  It does not!  See the sendfile.2 man page: "sendfile() 
> does not modify the current file offset of in_fd."  

I didn't read the man page, I read the source. And it clearly updates
the file offset, in fact the actual sendfile portion is just a supplied
actor to the generic page cache read functions.

> (You had me worried -- I just now went and *tested* 
> the operation of sendfile().)  The app does not need to 
> do an lseek() call because the 'offset' argument is *always* 
> updated with the new "virtual" offset.  This is part of why I 
> am disturbed/confused: sendfile() always updates its 'offset' 
> argument and *never* changes the file offset; splice() only 
> does that if its 'offset' argument is non-NULL.

Maybe you didn't understand me correctly. Basically what sys_sendfile()
ends up doing is:

        if (offset_given)
                ppos = &offset_given;
        else
                ppos = &in_fd->current_position;

ppos is always updated. sendfile() behaves as I described, it updates
ppos which is _EITHER_ the supplied offset _OR_ the current file offset.
You said that sendfile() never changes in in_fd offset, which is clearly
false as it always updates it if you don't pass in an offset. If you do
pass in an offset, that and only that is changed. The lseek() comment of
course applied to the case where you _don't_ give an explicit offset and
the current position is used.

If you don't believe me, read the source and do another test app.
splice() behaves identically, as previously stated.

-- 
Jens Axboe

