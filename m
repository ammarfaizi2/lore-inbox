Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTKYM3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 07:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTKYM3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 07:29:53 -0500
Received: from fw.nextra.sk ([195.168.29.2]:36360 "EHLO Maxim.Platon.SK")
	by vger.kernel.org with ESMTP id S262397AbTKYM3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 07:29:51 -0500
Date: Tue, 25 Nov 2003 13:20:18 +0100 (CET)
From: Ondrej Jombik <nepto@pobox.sk>
Reply-To: Ondrej Jombik <nepto@pobox.sk>
To: linux-kernel@vger.kernel.org
Subject: POSSIBLE BUG: certain writes to pipe block (after select())
Message-ID: <Pine.LNX.4.50.0311251258420.27648-100000@Maxim.Platon.SK>
X-Mailer: Pine 4.53 (Nepto config; Linux Maxim 2.4.21 on i686)
Organization: Platon Software Development Group (http://platon.sk/)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC me in the answer as I am not in the list. ]

I discovered that certain writes to filedescriptor created with pipe()
system call will block even if select() previously returned change on
that filedescriptor -- of course select() returned change in "write"
fd_set.

While doing a deep investigation, I find out, that this write only
blocks if more than 4096 bytes are written. This is certain for 2.4.20,
2.4.21 and 2.6.0-test7 kernels. Other kernels were untested. What is
more interesting is the fact, that PIPE_BUF kernel constant (defined in
the file /usr/include/linux/limits.h) has value equal to 4096 bytes.

So when writting 4097 bytes write() blocks. When writting 4096 bytes it
does not. However I had never seen during my information hunt an
information, that only maximum PIPE_BUF bytes can be written into
filedescriptor created with pipe() system call. I think this is the
point of the whole thing, but I'm confused why this is not written
anywhere.

But anyway, I would like to mention, that expected behaviour is, that
write() will write 4096 bytes (so return value from write() syscall is
4096) and the rest should be up to user. So it has to be userspace deal
to wait for writing remaining byte(s).

Here is a simple demonstration program:

#include <stdio.h>
#include <unistd.h>
#include <sys/select.h>
#include <linux/limits.h>

#define TO_WRITE    (PIPE_BUF + 1) /* 4097 */

int main(void)
{
    int p[2];                 /* pipe */
    char to_write[TO_WRITE];  /* just memory-holder */
    fd_set wfds;              /* write fd_set */

    if (pipe(p) != 0)
        return 1;

    FD_ZERO(&wfds);
    FD_SET(p[1], &wfds);

    if (select(p[1] + 1, NULL, &wfds, NULL, NULL) > 0) {
        fprintf(stderr, "select() passed, can write to fd %d\n", p[1]);
        fprintf(stderr, "%d bytes written\n",
                write(p[1], to_write, TO_WRITE) /* this will block */
               );
    }

    return 0;
}


When you will strace this code, you will see how write() blocks:

pipe([4, 6])                            = 0
select(7, NULL, [6], NULL, NULL)        = 1 (out [6])
write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4097

Changing the TO_WRITE constant from (PIPE_BUF + 1) to PIPE_BUF will make
write() in the example not to block.

Please let me know one important thing: if this is desirable behaviour
or it has to be considered as a bug.

[ Please CC me in the answer as I am not in the list. ]

--
  _/|   Ondrej Jombik - nepto@php.net - http://nepto.sk - ICQ #122428216
 <_  \  Platon SDG - open source software development - http://platon.sk
   `\|  UNIX is user friendly. It's selective about who its friends are!
    '`
