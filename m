Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRCBPld>; Fri, 2 Mar 2001 10:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRCBPlZ>; Fri, 2 Mar 2001 10:41:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129250AbRCBPk5>; Fri, 2 Mar 2001 10:40:57 -0500
Date: Fri, 2 Mar 2001 10:40:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: John Being <olonho@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen similar          problem on PPC
In-Reply-To: <3A9FB760.15E6321F@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1010302103506.1920A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Christopher Friesen wrote:

> John Being wrote:
> 
> > gives following result on box in question
> > root@******:# ./clo
> > Leap found: -1687 msec
> > and prints nothing on all other  my boxes.
> > This gives me bunch of troubles with occasional hang ups and I found nothing
> > in kernel archives at
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
> > just some notes about smth like this for SMP boxes with ntp. Is this issue
> > known, and how can I fix it?
> 
> I've run into non-monotonic gettimeofday() on a PPC system with 2.2.17, but it
> always seemed to be almost exactly a jiffy out, as though it was getting
> hundredths of a second from the old tick, and microseconds from the new tick. 
> Your leap seems to be more unusual, and the first one I've seen on an x86 box.
> 
> Have you considered storing the results to see what happens on the next call? 
> Does it make up the difference, or do you just lose that time?
> 
> Chris

I think it's a math problem in the test code. Try this:

#include <stdio.h>
#include <sys/time.h>

#define DEB(f)

int main()
{
    struct timeval t;
    double start_us;
    double stop_us;
    for(;;)
    {
        gettimeofday(&t, NULL);
        start_us  = (double) t.tv_sec * 1e6;
        start_us += (double) t.tv_usec;
        gettimeofday(&t, NULL);
        stop_us  = (double) t.tv_sec * 1e6;
        stop_us += (double) t.tv_usec;
        if(stop_us <= start_us)
            break;
        DEB(fprintf(stdout, "Start = %f, Stop = %f\n", start_us, stop_us));
    }
    fprintf(stderr, "Start = %f, Stop = %f\n", start_us, stop_us);
    return 0;
}

Note that two subsequent calls to gettimeofday() must not return the
same time even if your CPU runs infinitely fast. I haven't seen any
kernel in the past few years that fails this test. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


