Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291471AbSBSQl5>; Tue, 19 Feb 2002 11:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291473AbSBSQls>; Tue, 19 Feb 2002 11:41:48 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:64265 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S291471AbSBSQlf>;
	Tue, 19 Feb 2002 11:41:35 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 19 Feb 2002 17:40:58 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: gnome-terminal acts funny in recent 2.5 series
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
X-mailer: Pegasus Mail v3.50
Message-ID: <12434E62524D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 02 at 20:44, OGAWA Hirofumi wrote:
> 
> libzvt was using file descriptor passing via UNIX domain socket for
> pseudo terminal. Then because ->passcred was not initialized in
> sock_alloc(), unexpected credential data was passing to libzvt.
> 
> The following patch fixed this problem, but I'm not sure.
> Could you review the patch? (attached file are test program)

I sent simillar patch to Linus and DaveM on Sunday. Unfortunately it
did not found its way into either of these two trees (and IPX oops fix too). 
In addition to yours I moved these 'sock->XXX = NULL' into sock_alloc_inode,
as I see no reason why sock->wait should be initialized in sock_alloc_inode,
but all other members in sock_alloc. It caused confusion to me, and
from your comment it looks like that you missed it too. Besides that
root of sockfs uses sock's inode with sock->ops, sk and file being
0x5a5a5a5a without moving initialization from sock_alloc to sock_alloc_inode.

> --- socket.c.orig   Mon Feb 11 18:21:59 2002
> +++ socket.c    Tue Feb 19 16:20:18 2002
> @@ -501,6 +501,8 @@ struct socket *sock_alloc(void)
>     sock->ops = NULL;
>     sock->sk = NULL;
>     sock->file = NULL;
> +// init_waitqueue_head(&sock->wait);   this is needed?
> +   sock->passcred = 0;
>  
>     sockets_in_use[smp_processor_id()].counter++;
>     return sock;

                                  Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
