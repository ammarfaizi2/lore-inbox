Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290315AbSAPAxr>; Tue, 15 Jan 2002 19:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289804AbSAPAxl>; Tue, 15 Jan 2002 19:53:41 -0500
Received: from f232.law11.hotmail.com ([64.4.17.232]:28177 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290308AbSAPAv6>;
	Tue, 15 Jan 2002 19:51:58 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Suspected bug in getpeername and getsockname
Date: Tue, 15 Jan 2002 16:51:52 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F232Ej1I7QY9zK4unnr000139b2@hotmail.com>
X-OriginalArrivalTime: 16 Jan 2002 00:51:52.0984 (UTC) FILETIME=[FD126980:01C19E27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current code for sys_getpeername is shown below

asmlinkage long sys_getsockname(int fd, struct sockaddr *usockaddr, int 
*usockaddr_len)
{
        struct socket *sock;
        char address[MAX_SOCK_ADDR];
        int len, err;

        sock = sockfd_lookup(fd, &err);
        if (!sock)
                goto out;
        err = sock->ops->getname(sock, (struct sockaddr *)address, &len, 0);
        if (err)
                goto out_put;
        err = move_addr_to_user(address, len, usockaddr, usockaddr_len);

out_put:
        sockfd_put(sock);
out:
        return err;
}

The man page getpeername(2) says
========================================================
The namelen parameter should be initialized to
indicate the amount of  space  pointed  to  by name.
On return it  contains  the actual size of the name
returned (in bytes).  The name is truncated if the buffer
provided is too small.
=========================================================

The code does not copy_from_user the passed value of
length (by the user). It instead passes to the protocol
specific code a pointer in the stack (len). The copyout to
user space is correct. But still the value passed
from the user should also be considered. If this value
is less than what we want to copyout, the smaller value
should be used.

The same bug exists even in getsockname. The fix is
trivial.

1. Copy in the value the user passed.
2. Pass this value to the protocol (sock ops) getpeername
   or getsockname. Let it decide what to do if the user
   passed value is smaller than the size it wants to
   return.
3. Copyout the values
Am I missing something or is this a known bug.

If this fix is acceptable I can quickly send a patch
after testing it. Please cc me, I am no longer subscribed
to lkml.


Thanks,
Balbir

_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

