Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWGJRrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWGJRrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWGJRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:47:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31112 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422730AbWGJRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:47:14 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 19:05:08 +0100
Message-Id: <1152554708.27368.202.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 13:27 -0400, ysgrifennodd Jon Smirl:
> > Its explained in the comment in do_SAK.
> 
> This problem seems to be aggravated by reusing the tty_struct for that
> tty. With the refcount patch it is now easy to disassociate an
> existing tty (and the processes attached to it) from the array
> tracking tty minors. 

The real problem is the rather deeper one - the lack of revoke(). Its
possible to paper over that with SELinux but really we need revoke() and
when you get revoke() you get the handle stuff cleaned up

We hold file_list_lock because we have to find everyone using that tty
and hang up their instance of it, then flip the file operations not
because we need to protect against tty structs going away. It's needed
in order to walk the file list and protects against the file list itself
changing rather than the tty structs. It may well be possible to move
that to a tty layer private lock with care, but it would need care to
deal with VFS operations.

We hold the ->files->file_lock because we have to walk other processes
file tables in a safe fashion in SAK. That one is fairly clear.

Alan

