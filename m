Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUCCAQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUCCAQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:16:37 -0500
Received: from bay14-f17.bay14.hotmail.com ([64.4.49.17]:3847 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261806AbUCCAQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:16:23 -0500
X-Originating-IP: [24.136.227.168]
X-Originating-Email: [filamoon2@hotmail.com]
From: "johnny zhao" <filamoon2@hotmail.com>
To: mblack@csi-inc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: udp packet loss even with large socket buffer
Date: Tue, 02 Mar 2004 19:16:22 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F17ddMfz4yhKU00038111@hotmail.com>
X-OriginalArrivalTime: 03 Mar 2004 00:16:22.0285 (UTC) FILETIME=[C20B4BD0:01C400B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for you reply. Unfortunately, it doesn't help :-(

I have uploaded libosip and you can find it here:
http://www.ee.duke.edu/~zw8/msn_linux/libosip-0.9.7.tar.gz

I would appreciate it if you would look into this problem.

Moreover, I'm sure that the usleep() calls in the source tree are not 
actually executed. All these files are not compiled and linked, except 
mediastreamer/msv4l.c, whose usleep calls will not be executed unless it 
fails to open the webcam.

Thank you!

>From: "Mike Black" <mblack@csi-inc.com>
>To: "Charlie (Zhanglei) Wang" <filamoon2@hotmail.com>
>Subject: Re: udp packet loss even with large socket buffer
>Date: Tue, 2 Mar 2004 09:29:21 -0500
>
>I was going to try and duplicate your problem but I can't find the source 
>for libosip (gnu has taken it down from their ftp site).
>However, if your packets are blasting across < 1 ms between than you might 
>need to bump your receive queue like this:
>Default is 300:
>sysctl net.core.netdev_max_backlog
>net.core.netdev_max_backlog = 300
>sysctl -w net.core.netdev_max_backlog=2000
>net.core.netdev_max_backlog = 2000
>Ref: http://datatag.web.cern.ch/datatag/howto/tcp.html
>
>Perhaps your processing is taking long enough that the traffic queue is 
>building up.
>One thing is your usleep and nanosleep I think will be a minimum of 2ms 
>because of timer limitations.
>#include <stdio.h>
>#include <time.h>
>#include <unistd.h>
>
>main()
>{
>    time_t mytime=time(NULL);
>    struct timespec t1,t2;
>    int i=0;
>    while(mytime == time(NULL));
>    mytime = time(NULL);
>    while(mytime == time(NULL)) {
>        t1.tv_sec=0;
>        t1.tv_nsec=100000;
>        nanosleep(&t1,&t2);
>        i++;
>    }
>    printf("i=%d\n",i);
>}
>
>You'll find this program spits out approximately "i=500" no matter how 
>small you make tv_nsec.
>You should also get rid of the usleep()'s in your code.  It's been 
>superceded by nanosleep and could be screwing things up too.
>                usleep(20000);
>./console/sipomatic.c
>                    usleep(pts - now);
>./ffmpeg-0.4.8/ffmpeg.c
>            usleep(100);
>            usleep(100);
>            usleep(100);
>            usleep(100);
>            usleep(100);
>            usleep(10);
>./ffmpeg-0.4.8/libavformat/grab.c
>        }else usleep(20000);
>        }else usleep(20000);
>        }else usleep(20000);
>./mediastreamer/msv4l.c
>        //  usleep(80);
>./oRTP/src/rtpsession.c
>
>
>----- Original Message -----
>From: "Charlie (Zhanglei) Wang" <filamoon2@hotmail.com>
>To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>; 
><linux-kernel@vger.kernel.org>
>Sent: Monday, March 01, 2004 9:12 PM
>Subject: Re: udp packet loss even with large socket buffer
>
>
> > hi,
> >
> > Thanks for your reply. If you want to exactly reproduce my problem, 
>please
> > use the following
> > commands to download my codes from cvs:
> >
> > cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/gaim-vv login
> > cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/gaim-vv co
> > linphone
> >
> > Simply hit enter when prompted for passwd.
> > (1) Please download and install libosip before compiling.
> > (2) Before ./configure, please run command 'rm -Rf ffmpeg; ln -s
> > ffmpeg-0.4.8 ffmpeg'.
> > (3) After 'make' and 'make install', use 'linphonec' to run the program.
> > (4) Under linphonec, use the following commands to communicate with 
>windows
> > messenger:
> >    r www-db.research.bell-labs.com
> >    c <sip:username_of_windows_messenger@www-db.research.bell-labs.com>
> >
> > www-db.research.bell-labs.com is a public sip server.
> >
> > Under Windows Messenger (which runs only under WinXP), use SIP login
> > method. Sign-in name should be
> > username_of_windows_messenger@www-db.research.bell-labs.com
> >
> > Please note that Windows Messenger is different from MSN Messenger.
> >
> > I know it's kind of complicated... :( Thank you in advance!
> > PS: My Linux box and Windows XP box run in the same LAN.
> >
> > Johnny
> >
> > ----- Original Message -----
> > From: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
> > To: "johnny zhao" <filamoon2@hotmail.com>; 
><linux-kernel@vger.kernel.org>
> > Sent: Saturday, February 28, 2004 4:22 PM
> > Subject: Re: udp packet loss even with large socket buffer
> >
> >
> > > On Saturday 28 February 2004 03:09, johnny zhao wrote:
> > > > Hi,
> > > >
> > > > I have a problem when trying to receive udp packets containing video
> > data
> > > > sent by Microsoft Windows Messenger. Here is a detailed description:
> > > >
> > > > Linux box:
> > > >     Linux-2.4.21-0.13mdksmp, P4 2.6G HT
> > > > socket mode:
> > > >     blocked mode
> > > > code used:
> > > >     while ( recvfrom(...) )
> > > > socket buffer size:
> > > >     8388608, set by using sysctl -w net.core.rmem_default and 
>rmem_max
> > > >
> > > > I used ethereal(using libpcap) to monitor the network traffic. All 
>the
> > > > packets were transferred and captured by libpcap. But my program
> > constantly
> > > > suffers from packet loss. According to ethereal, the average time
> > interval
> > > > between 2 packets  is 70-80ms, and the minimum interval can go down 
>to
> > > > ~1ms. Each packet is smaller than 1500 bytes (ethernet MTU).
> > > >
> > > > Can anybody help me? I googled and found a similar case that had 
>been
> > > > solved by increasing the socket buffer size. But it doesn't work for 
>me.
> > I
> > > > think 8M is a crazily large size :(
> > >
> > > Post a small program demonstrating your problem.
> > > (I'd test udp receive with netcat too)
> > > --
> > > vda
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
Fast. Reliable. Get MSN 9 Dial-up - 3 months for the price of 1! 
(Limited-time Offer) http://click.atdmt.com/AVE/go/onm00200361ave/direct/01/

