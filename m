Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWGJSJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWGJSJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWGJSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:09:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49171 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964937AbWGJSJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:09:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CONc1U/ipRMDmjUtxwFG2qBJZl8mBBS94qoo9uYxCxFmMyXNB5xbxRYiqrH1yIBMxPRFQ2OT8moa+CqlFk1wLprthj24e/nRTmb8wtzqQqRH/8M/mnG6j5Bq/KWkGl0E2FwMemFOtWugyCRNtDN6WhFO+tgZ0Z0S6MOyFu07L3o=
Message-ID: <9e4733910607101109w46915fbbl19bdd8664e1ca4d@mail.gmail.com>
Date: Mon, 10 Jul 2006 14:09:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152554708.27368.202.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-10 am 13:27 -0400, ysgrifennodd Jon Smirl:
> > > Its explained in the comment in do_SAK.
> >
> > This problem seems to be aggravated by reusing the tty_struct for that
> > tty. With the refcount patch it is now easy to disassociate an
> > existing tty (and the processes attached to it) from the array
> > tracking tty minors.
>
> The real problem is the rather deeper one - the lack of revoke(). Its
> possible to paper over that with SELinux but really we need revoke() and
> when you get revoke() you get the handle stuff cleaned up
>
> We hold file_list_lock because we have to find everyone using that tty
> and hang up their instance of it, then flip the file operations not
> because we need to protect against tty structs going away. It's needed
> in order to walk the file list and protects against the file list itself
> changing rather than the tty structs. It may well be possible to move
> that to a tty layer private lock with care, but it would need care to
> deal with VFS operations.
>
> We hold the ->files->file_lock because we have to walk other processes
> file tables in a safe fashion in SAK. That one is fairly clear.

What if do_SAK did something like this?

copy the tty struct to new_tty
NULL out the file list in new_tty
insert new_tty into the array tracking tty minors so that open will
find the new one

in old_tty stub out all of it's routines that do read/write/etc
Now start a kernel thread doing the HUP/INT/KILL sequence, it has a
reference to old_tty so it can find everything.
When everything is clean, delete old_tty

The processes and file handles attached to old_tty won't be able to do
anything, all of their IO calls have been stubbed out. The file list
can't be changed since there there is no way to get to it anymore.

When init respawns it picks up new_tty which is guaranteed clean of
processes and open handles because it was just created.

-- 
Jon Smirl
jonsmirl@gmail.com
