Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278101AbRJWRRm>; Tue, 23 Oct 2001 13:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278102AbRJWRRd>; Tue, 23 Oct 2001 13:17:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50818 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278101AbRJWRRQ>; Tue, 23 Oct 2001 13:17:16 -0400
Date: Tue, 23 Oct 2001 13:17:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Behavior of poll() within a module
In-Reply-To: <001401c15bdb$85030e60$010411ac@local>
Message-ID: <Pine.LNX.3.95.1011023124944.14694A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Manfred Spraul wrote:

> >
> > The following actual module code:
> >
> > static unsigned int vxi_poll(struct file *fp, struct poll_table_struct *wait)
> > {
> >     unsigned long flags;
> >     unsigned int mask;
> >     DEB(printk("vxi_poll\n"));
> >     info->poll_active++;
> >     poll_wait(fp, &info->wait, wait);
> >     spin_lock_irqsave(&vxi_lock, flags);
> >     mask = info->poll_mask;
> >     if(!--info->poll_active)
> >         info->poll_mask = 0;
> >     spin_unlock_irqrestore(&vxi_lock, flags);
> >     DEB(printk("vxi_poll returns\n"));
> >     return mask;
> > }
> Which module is that? I can't find it in Linus tree.
> Is "info" a global variable?

info is a global, a structure in allocated memory.

> 
> * poll is called without any SMP locking, "info->poll_active++" is
 not SMP safe. Use atomic_inc, or even better just delete that
> line.
> * Clearing poll_mask during poll is wrong.

> poll should return the events that are currently available,
> i.e. what would happen if read() or write() would be called now.
>

In this module, there isn't any read() or write() event that can
clear the poll mask. Instead, the sole purpose of poll is to tell
the user-mode caller that there is new status available as a result
of an interrupt. This is a module that controls a motor. It runs
<forever> on its own. It gets new parameters via an ioctl(). It
reports exceptions (like overload conditions) using the poll
mechanism.

The caller reads the cached status via an ioctl(). Any caller sleeping
in poll must be awakened as a result of the interrupt event. Any caller
can read the cached status at any time. If this was allowed to
clear the poll mask, only one caller would be awakened. 

If I don't clear the poll mask when the last caller has been awakened,
then any subsequent call to poll results in an immediate bogus return.

Although the code may need to be changed, the logic is correct and
it must work as specified. The problem is that sometimes it works
and sometimes it doesn't. In particular, if one user is sleeping
in poll() it works. If two users are sleeping in poll() sometimes
one of the callers doesn't get awakened. If three users are sleeping
in poll(), all bets are off and I get strange return values, not
related to the poll mask. It four users are sleeping in poll(),
they all return immediately <forever>. Going to a single poll-caller
doesn't fix the problem, some history is left in the kernel. I have
to remove the module, then insert the module to "fix" the problem.

Here is a little test program that shows the same problem when
executed using /dev/console, (or any other device you chose) etc., for
input multiple times..


/*
 *   This tests select() in various modules.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/poll.h>
#include <errno.h>
#include <string.h>


int main(int args, char *argv[])
{
    int fd, retval;
    fd_set rfds;
    char buf[0x1000];

    if(args < 2)
    {
        fprintf(stderr,"Usage:\n%s device\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if((fd = open(argv[1], O_RDWR)) < 0)
    {
        fprintf(stderr, "Can't open device, %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }
    for(;;)
    {
        FD_ZERO(&rfds);
        FD_SET(fd, &rfds);
        if((retval = select(fd+1, &rfds, NULL, NULL, NULL)) < 0) 
            fprintf(stderr, "Error was %s\n", strerror(errno));
        else
        {
//            printf("Return = %d\n", retval);
            if(FD_ISSET(fd, &rfds))
            {
                  fprintf(stderr,".");
//                  (void)read(fd, buf, sizeof(buf));
            }
//                printf("Input is available\n");
        }
    }
    if(close(fd) < 0)
    {
        fprintf(stderr, "Can't close device, %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }
    return 0;
}




Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


