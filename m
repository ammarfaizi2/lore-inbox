Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTBRElC>; Mon, 17 Feb 2003 23:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBRElC>; Mon, 17 Feb 2003 23:41:02 -0500
Received: from tomts15.bellnexxia.net ([209.226.175.3]:20713 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267597AbTBREk7>; Mon, 17 Feb 2003 23:40:59 -0500
Message-ID: <3E51BBC3.503@nortelnetworks.com>
Date: Mon, 17 Feb 2003 23:51:15 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fcntl and flock wakeups not FIFO?
References: <20030218010054.J28902@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
 > [cc'ing the person or list mentioned in MAINTAINERS would get you
 > a better response :-P]

Hmm...that might be a good idea.  :)

 >>I've been doing some experimenting with locking on 2.4.18 and have
 >>noticed that if I have a number of writers waiting on a lock, they are
 >>not woken up in the order in which they requested the lock.
 >>
 >>Is this expected? If so, what was the reasoning for this and are there
 >>any patches to give FIFO wakeups?
 >
 >
 > That certainly isn't what's supposed to happen.  They should get woken
 > up in-order.  The code in 2.4.18 seems to be doing that.  Are you
 > doing anything clever with scheduling?

Well maybe a little bit on the production box, but I don't think its the
cause since the same thing happens on my home machine with a stock
Mandrake 9 kernel (2.4.19-16mdk).

Here's the test app:

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/file.h>

int main(int argc, char **argv)
{
     int fd = open("/dev/null", O_RDWR);
     if (fd < 0)
     {
        perror("open");
        exit(-1);
     }

     printf("aquiring exclusive lock\n");
     int rc = flock(fd, LOCK_EX);
     if (rc < 0)
     {
        perror("flock");
        exit(-1);
     }

     printf("got lock\n");

     while(1)
        pause();

     return 0;
}

I start up four different instances of it in different windows, then
kill them (ctrl-c) in the order that I started them.

It doesn't happen every time, but they don't always get the lock in the
same order that I started them.

Chris



