Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbRGZMHr>; Thu, 26 Jul 2001 08:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267825AbRGZMHi>; Thu, 26 Jul 2001 08:07:38 -0400
Received: from smtp2.koti.soon.fi ([212.63.10.50]:14982 "EHLO
	smtp2.koti.soon.fi") by vger.kernel.org with ESMTP
	id <S267739AbRGZMHS>; Thu, 26 Jul 2001 08:07:18 -0400
From: "M. Tavasti" <tawz@nic.fi>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
In-Reply-To: <Pine.LNX.3.95.1010725114322.520A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Date: 26 Jul 2001 15:06:24 +0300
In-Reply-To: "Richard B. Johnson"'s message of "Wed, 25 Jul 2001 11:45:19 -0400 (EDT)"
Message-ID: <m2u1zznbcv.fsf@akvavitix.vuovasti.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> > But now there is nothing coming from device, and typing + pressing
> > enter won't make select() return like it should. 
> 
> It works here...........

You're testing different thing. You're not reading anything, so at
least I get endlessly 'Input is available from /dev/random', and
whenever you type something, also in terminal there's data available. 
If nobody reads data from /dev/random, of course there is data
availble.

I modified your program (see end), and results: on 2.2.19 and 2.2.16
everything works ok, in 2.4.5 not, terminal input (with return)
randomly makes select return. When looking from random.c, in 2.2.19
poll_wait is called once, like this:

	poll_wait(file, &random_poll_wait, wait);

And in 2.4.5:

	poll_wait(file, &random_read_wait, wait);
	poll_wait(file, &random_write_wait, wait);


I think I got idea how to do it right, make one wait queue for poll,
which is woken up when read OR write queue is woken up. 

So, now everybody just check your driver how does it do poll. 


----

Here is modified test. Try this to get real results: 

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
    char buff[1024];

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
        if(FD_ISSET(fd, &rfds)) {
            printf("Input is available from %s\n", dev);
            read(fd,buff,1024);
        }
        if(FD_ISSET(STDIN_FILENO, &rfds)) {         
            printf("Input is available from %s\n", "terminal");
            read(STDIN_FILENO,buff,1024);            
        }
            
    }
    if(close(fd) < 0)
    {
        fprintf(stderr, "Can't close device, %s\n", dev);
        exit(EXIT_FAILURE);
    }
    return 0;
}

-- 
M. Tavasti /  tavastixx@iki.fi  /   +358-40-5078254
 Poista sähköpostiosoitteesta molemmat x-kirjaimet 
     Remove x-letters from my e-mail address
