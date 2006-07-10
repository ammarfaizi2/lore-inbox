Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWGJNW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWGJNW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGJNW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:22:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23864 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751357AbWGJNWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:22:55 -0400
Date: Mon, 10 Jul 2006 15:25:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice() and file offsets
Message-ID: <20060710132529.GD5210@suse.de>
References: <20060710121110.26260@gmx.net> <20060710125150.GM25911@suse.de> <20060710130754.26280@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710130754.26280@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Michael Kerrisk wrote:
> Jens,
> 
> > > What are the semantics of splice() supposed to be with respect 
> > > to the current file offsets of 'fd_in' and 'fd_out', and how
> > > is the presence or absence (NULL) of 'off_in' and 'off_out'
> > > supposed to affect things.
> > > 
> > > Using the program below, here is what I observe for 
> > > fd_out/off_out:
> > > 
> > > 1. If off_out is NULL, then 
> > >    a) splice() changes the current file offset of fd_out.
> > > 
> > > 2. If off_out is not NULL, then splice() 
> > >    a) does not change the current file offset of fd_out, but 
> > >    b) treats off_out as a value result parameter, returning 
> > >       an updated offset of the file.
> > > 
> > > It is "2 a)" that surprises me.  But perhaps it's expected 
> > > behaviour; or I'm doing something dumb in my test program.
> > 
> > Not sure why you find that surprising, that is exactly what is supposed
> > to happen :-)
> >
> > If you don't give off_out, we use the current position. For most people,
> > that's probably what they want. If you are sharing the fd, that doesn't
> > work though. So you pass off_in/off_out as you please, and the kernel
> > uses those and passes the updated parameter back out so you don't have
> > to update it manually.
> 
> I'm still not clear here.  Let me phrase my question another way:
> why is it that the presence or absence of off_out affects whether
> or not splice() changes the current file offset for fd_out?

The logic is simple - either you don't give an explicit offset, and the
current position is used and updated. Or you give an offset, and the
current position is ignored (not read, not updated).

> > It's identical to how sendfile() works.
> 
> But it isn't: sendfile() never changes the file offset 
> of its 'in_fd'.

Ehm, yes it does. Would you expect the app to do an appropriate lseek()
on every sendfile() call?

-- 
Jens Axboe

