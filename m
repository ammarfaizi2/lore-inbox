Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRINUUy>; Fri, 14 Sep 2001 16:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270495AbRINUUf>; Fri, 14 Sep 2001 16:20:35 -0400
Received: from fungus.teststation.com ([212.32.186.211]:58377 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S270201AbRINUUd>; Fri, 14 Sep 2001 16:20:33 -0400
Date: Fri, 14 Sep 2001 22:20:49 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] at smbfs umount in linux-2.4.10-pre5
In-Reply-To: <3B9CA37F.22D7B20@baldauf.org>
Message-ID: <Pine.LNX.4.30.0109142204051.1445-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Xuan Baldauf wrote:

> this oops just happened now when trying to unmount an smbfs
> mount entry

...

> >>EIP; c013033e <fput+6/c0>   <=====
> Trace; c529a140 <[smbfs]smb_sops+0/40>
> Trace; c52970ea <[smbfs]smb_put_super+26/a8>

fput(server->sock_file), where sock_file is NULL ... ?

> Sep 10 13:09:52 router kernel: smb_dont_catch_keepalive: did
> not get valid server!

This complaint is about 'server' or 'server->sock_file' being NULL,
probably the sock_file.

I think what happens is that at umount it enters this code:
	if (server->sock_file) {
		smb_proc_disconnect(server);
		smb_dont_catch_keepalive(server);
		fput(server->sock_file);
	}

The problem here is that smb_proc_disconnect may run into trouble if the
connection is gone. And by the messages smbfs is having connection
problems. That will cause smbfs to close the socket and request a new from
smbmount.

A fix would be to simply do the disconnect first, and then test sock_file
again. Or simply make smb_proc_disconnect not do anything if the
connection is bad.

I wonder why this doesn't always crash when the connection is bad.
Can you repeat the oops?


> Trying to remount the same smb share at the same mount point
> fails. Strace shows that the mount process is stuck in the
> "mount" call. Also trying to mount the same samba share at
> another mount point hangs.

Once it has crashed here, it holds locks preventing anyone from accessing
it.

/Urban


