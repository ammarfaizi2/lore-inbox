Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268578AbRGYPq5>; Wed, 25 Jul 2001 11:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbRGYPqh>; Wed, 25 Jul 2001 11:46:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268577AbRGYPq0>; Wed, 25 Jul 2001 11:46:26 -0400
Date: Wed, 25 Jul 2001 11:45:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "M. Tavasti" <tawz@nic.fi>
cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
In-Reply-To: <m2g0blkp0t.fsf@akvavitix.vuovasti.com>
Message-ID: <Pine.LNX.3.95.1010725114322.520A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 25 Jul 2001, M. Tavasti wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > Change: 
> >                  } else if(FD_ISSET(fileno(stdin),&rfds) ) {
> > To:
> >                  } if(FD_ISSET(fileno(stdin),&rfds) ) {
> > 
> > Both of these bits can be (probably are) set.
> 
> You are third person to suggest that. Yes, it's good point, but
> doesn't make any difference. Or it makes when both device and stdin
> have something, stdin is read on second round. 
> 
> But now there is nothing coming from device, and typing + pressing
> enter won't make select() return like it should. 

It works here...........


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/poll.h>
#include <errno.h>
#include <string.h>

static const char dev[]="/dev/random";

int main(int args, char *argv[])
{
    int fd, retval;
    fd_set rfds;

    if((fd = open(dev, O_RDONLY)) < 0)
    {
        fprintf(stderr, "Can't open device, %s\n", dev);
        exit(EXIT_FAILURE);
    }
    for(;;)
    {
        FD_ZERO(&rfds);
        FD_SET(fd, &rfds);
        FD_SET(STDIN_FILENO, &rfds);
        retval = select(fd+1, &rfds, NULL, NULL, NULL); 
        if(retval < 0)
            fprintf(stderr, "Error was %s\n", strerror(errno));
        printf("Return = %d\n", retval);
        if(FD_ISSET(fd, &rfds))
            printf("Input is available from %s\n", dev);
        if(FD_ISSET(STDIN_FILENO, &rfds))
            printf("Input is available from %s\n", "terminal");
    }
    if(close(fd) < 0)
    {
        fprintf(stderr, "Can't close device, %s\n", dev);
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


