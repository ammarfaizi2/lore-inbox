Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289989AbSAWTlo>; Wed, 23 Jan 2002 14:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290010AbSAWTlg>; Wed, 23 Jan 2002 14:41:36 -0500
Received: from [63.204.6.12] ([63.204.6.12]:13204 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S289989AbSAWTl1>;
	Wed, 23 Jan 2002 14:41:27 -0500
Date: Wed, 23 Jan 2002 14:41:06 -0500
From: "Mark Frazer" <mark@somanetworks.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: how best to handle multiple readers on a fifo?
Message-ID: <20020123144106.A11013@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Message-Flag: Lookout!
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, I have a daemon process which I want to periodically check
a fifo node made with mknod (STAT_FILE, S_IFIFO | 0444, 0) and spit up
a status message.

Something like this:
        writefd = open (STAT_FILE, O_NDELAY | O_WRONLY);
        if (writefd > 0) {
                int len;
                len = give_ctrl_status (writefd);
                close (writefd);
        } else if (errno != ENXIO) {
                error ("Error (%s) reading " STAT_FILE, strerror (errno));
                all_done = 1;
        }


Yay.  All's well until there's multiple processes consuming the message
out of STAT_FILE.

The bash script below simulates the problem.  If there's multiple readers,
only one of them gets the message out of the fifo.  This is not a Linux
specific deal, Solaris does it too.

Here's the output of the script on Linux:
[mjfrazer@frogger fifo]$ ./fifo.test 
after 1000 iterations:
winner[1] = 999
winner[2] = 1
winner[3] = 0
winner[4] = 0
[mjfrazer@frogger fifo]$ uname -a
Linux frogger 2.4.17 #1 Fri Jan 18 16:06:33 EST 2002 i686 unknown

and on Solaris:
[mjfrazer@toronto-fs fifo]$ ./fifo.test 
after 100 iterations:
winner[1] = 19
winner[2] = 18
winner[3] = 16
winner[4] = 47
[mjfrazer@toronto-fs fifo]$ uname -a
SunOS toronto-fs 5.8 Generic_108528-10 sun4u sparc SUNW,Ultra-4

As far as I can tell, I'm borked.  What think the filesystem types
of adding a flag to mknod or something to tell the pipe not to boot off
unserviced readers?

-mark


#!/bin/bash

if [ `uname` = Linux ] ; then
        MAX=1000
        WAIT='usleep 100000'
elif [ `uname` = SunOS ] ; then
        MAX=100
        WAIT='sleep 1'
else
        echo "Only runs on Solaris or Linux"
        exit 1
fi

readers="1 2 3 4"

for i in $readers ; do
        winner[$i]=0
done

iter=0
while [ $iter -lt $MAX ] ; do
        echo -ne "  $(( $iter + 1 )) \r"

        /bin/rm -f fifo
        mkfifo fifo

        trap "echo hello > fifo" INT

        for i in $readers ; do
                cat fifo > out.$i &
        done
        $WAIT

        # ps -ef | grep 'cat fifo' | grep -v grep
        echo hello > fifo

        trap - INT

        wait
        ps -ef | grep 'cat fifo' | grep -v grep

        for i in $readers ; do
                if [ -s out.$i ] ; then
                        # echo winner is $i
                        winner[$i]=$(( ${winner[$i]} + 1 )) ;
                fi
        done
        iter=$(( $iter + 1 ))
done

echo "after $iter iterations:"
for i in $readers ; do
        echo winner\[$i] = ${winner[$i]}
done
