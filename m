Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWGKXuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWGKXuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWGKXuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:50:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16855 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932264AbWGKXux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:50:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c5zLfkcw5zrTdiA6L7uD02ovxA8CN4oTCIRm83K5/jzMnaoiWJFNg/1xvgEQz0zWS1yL3qcOLpCxQbALZE7nLyFraMw8EcIyDd/avjKJyiWoD5HtSlztXBy59KE9GEeSIi2eRwbqPn36sJKXJ7v6JK5mg1EnVS/73Nf80kepggY=
Message-ID: <9e4733910607111650m16630157ya8c27949ae639ffc@mail.gmail.com>
Date: Tue, 11 Jul 2006 19:50:51 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: "Theodore Tso" <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152657465.18028.72.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <20060711194456.GA3677@flint.arm.linux.org.uk>
	 <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
	 <1152657465.18028.72.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Maw, 2006-07-11 am 18:08 -0400, ysgrifennodd Jon Smirl:
> > What about adjusting things so the BKL isn't required? I tried
> > completely removing it and died in release_dev. tty_mutex is already
> > locks a lot of stuff, maybe it can be adjusted to allow removal of the
> > BKL.
>
> Thats what is happening currently. However it is being done piece by
> piece, slowly and carefully.
>
> > I see why no one works on this code, it is very intertwined with the
> > rest of the kernel and a lot of the reasons for locking are
> > non-obvious.
>
> You should follow l/k more closely. Since 2.6.15 Paul Fulghum and I have
> completely rewritten the entire buffering logic. In 2.6.14 or so I
> rewrote the line discipline locking and support code.

I had noticed that code looked new and quite clean, I have not seen
any problems with it.

> One hint by the way - stop looking at locks and code, look at locks and
> data structures. There is an old saying "lock data not code" and it
> really is true if you want to follow the locking and get it right.
>
> The open/close/hangup logic is last on the list to fix, because as
> you've noticed its the most horrible. Once the other locking is sane
> that bit should become more managable even with the strict and bizarre
> rules POSIX and SuS enforce on us in this area.

My original goal was to do some work on the VT layer but I got sucked
into the TTY code because of VT/TTY interactions. I think I understand
enough now that I can make changes in the VT code without breaking
everything. I also see now that the VT code wasn't as closely
intertwined into the TTY code as much as I initially thought it was.

So getting back to my VT problem, I want to fully decouple the VT code
from the TTY code. By decoupling I mean make the VT code use APIs and
not have #ifdef CONFIG_VT sprinkled all over the place. There are
fifteen #ifdef CONFIG_VT's is general kernel code and about twenty
more in arch specific code.

One #ifdef CONFIG_VT is in tty_init().  The tty layer is being
initialized via module_init(tty_init) which is the same as
device_initcall(fn).  Link order is pci, video, acpi, char, serial,
base. This doesn't look right to me since the video console drivers
need the tty code to function.

This may also explain why the init functions are all chained together.
tty_init() -> vty_init() -> vcs_init(), kbd_init(), prom_con_init(),
etc... Since the link order is wrong the chained init functions are
compensating.

The fix for this is to get things linking in the right order, add
module_init() where needed then all of the chained init()'s can be
removed.

-- 
Jon Smirl
jonsmirl@gmail.com
