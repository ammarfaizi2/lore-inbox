Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbRFGOIw>; Thu, 7 Jun 2001 10:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262640AbRFGOIm>; Thu, 7 Jun 2001 10:08:42 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:36007 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S262626AbRFGOI2>; Thu, 7 Jun 2001 10:08:28 -0400
Date: Thu, 7 Jun 2001 17:08:25 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Bug in nonlocal-bind (transparent proxy)?
Message-ID: <20010607170825.A18760@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Hebrew-Date: 16 Sivan 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a transparent-proxy-like application, that needs to be able to
bind a TCP socket with a non-local address (i.e., the proxy contacts the
origin-server, in the local network, pretending to be the original client.
The reply will get back to the proxy because it acts as the default
gateway, and the kernel needs to pass that reply to the socket).

Bind()ing a non-local address worked fine in the 2.2 line of kernels if a
certain compile-time option was enabled (TRANSPARENT_PROXY, or something
like that). But it no longer seems to be working in the 2.4 kernels (I
tried this on 2.4.2 coming from the Redhat 7.1 distribution).

First, bind() simply refused to work when given a non-local address (returning
EADDRNOTAVAIL). Reading the kernel's source I discovered that an undocumented
"ip_nonlocal_bind" sysctl makes the kernel agree to do such a bind (this
should really be in the bind() documentation...). Enabling this option
allowed bind to work (it can even catch the case of two sockets trying to
bind the same address), but the later connect() fails!
I tryed reading the kernel sources to figure out what's wrong with the
connect(), but failed to understand why it returns a EINVAL. I think this
is a bug, and include below a short program to reproduce it:

If you run the program below, connect() will fail with EINVAL (it will do
so before even trying to output a packet). To see that nothing's actually
wrong with the connect, change the #if 1 to #if 0, eliminating the bind(),
and see that the connect works (or at least fails with a connection refused,
as it should because of the random IP address).
Note that you must run the program as root, and do
	echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind 
to get the bind() to work at all. But once you do that, and bind() works,
how come connect() doesn't work?

Thanks in advance for any insights or fixes!

Here's the program to reproduce the bug:

/* try non-local bind on 2.4 kernel...

   echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
   doesn't seem to help :(
*/
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <sys/socket.h>
#include <arpa/inet.h>

main(){
    int s,c;
    struct sockaddr_in addr;

    s=socket(PF_INET,SOCK_STREAM,0);
    if(s<0)
        perror("socket");

#if 1
    printf("binding %d\n",s);
    addr.sin_family=AF_INET;
    addr.sin_port=htons(5678);
    inet_aton("2.3.4.5",&addr.sin_addr);
    /* this requires echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind */
    if(bind(s, (struct sockaddr *)&addr, sizeof(addr))<0)
        perror("bind");
#endif

    printf("connecting %d\n",s);
    addr.sin_family=AF_INET;
    addr.sin_port=htons(22);
    inet_aton("1.2.3.4",&addr.sin_addr);
    c=connect(s,(struct sockaddr *)&addr, sizeof(addr));
    if(c<0)
        perror("connect");

    printf("end.\n");
}


-- 
Nadav Har'El                        |     Thursday, Jun  7 2001, 16 Sivan 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |(On the back of a VW Beetle) Don't honk,
http://nadav.harel.org.il           |I'm peddling as fast as I can.
