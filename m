Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137208AbRAHHS6>; Mon, 8 Jan 2001 02:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136990AbRAHHSv>; Mon, 8 Jan 2001 02:18:51 -0500
Received: from dsl081-146-215-chi1.dsl-isp.net ([64.81.146.215]:20743 "EHLO
	manetheren.eigenray.com") by vger.kernel.org with ESMTP
	id <S137201AbRAHHSg>; Mon, 8 Jan 2001 02:18:36 -0500
Date: Mon, 8 Jan 2001 01:16:27 -0600 (CST)
From: Paul Cassella <pwc@speakeasy.net>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:
 "No such process")
In-Reply-To: <200101080558.VAA02081@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0101080048460.2261-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, David S. Miller wrote:

>    Date: 	Sun, 7 Jan 2001 23:55:28 -0600 (CST)
>    From: Paul Cassella <pwc@speakeasy.net>
> 
>    [1.] One line summary of the problem:
> 
>    write() returns -1 and sets errno non-sensically.  2.4.0{,-ac[23]}
> 
> What you describe I can only say is "impossible".

Right.  That's why the code g_error()'s there.  :)

> None of them can occur via TCP socket writes (only netlink socket
> operations or socket control calls).

I didn't imagine that a TCP write could return any of these errors, which
is why I guessed that something's returning a value it thinks is positive,
but turns out to be negative in this case, for example, "return a - b;"
where due to, maybe, (but I guess not,) the peer shrunk window thing, a < b.

> Therefore I suspect you are perhaps getting rather some form of memory
> corruption or similar, really, please search the networking code for
> ESRCH value usage, you will see.

I believe that the tcp_sendmsg() path never tries to return -ESRCH, but I
don't see how userland memory corruption could cause the app to (1) open
such a socket instead of a TCP socket, and (2) get ESRCH or ENOEXEC
instead of EPERM or whatever a non-root process would get when it tried
such a thing.

I have seen no signs of bad memory on this machine, and of a fairly small
sample set, one (I was wrong when I said several) person is seeing the
same thing, with 2.4.0-test13-pre4, and I didn't see it with
2.4.0-test11-pre2.

The change I made to linux/fs/read_write.c:sys_write() checks

  file->f_op == &socket_file_ops

and then finds ret == -3; presumably this is the same 3 that my app gets.


Would it be more helpful if I were to check something like

  socki_lookup(file->f_dentry->f_inode)->ops == tcp_prot

instead?  Or do the check in tcp_sendmsg()?

-- 
Paul Cassella

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
