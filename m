Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbQK3XXG>; Thu, 30 Nov 2000 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQK3XW5>; Thu, 30 Nov 2000 18:22:57 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:38113 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S129942AbQK3XWn>; Thu, 30 Nov 2000 18:22:43 -0500
Date: Thu, 30 Nov 2000 22:57:09 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: "David S. Miller" <davem@redhat.com>
cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: TCP push missing with writev()
In-Reply-To: <200011302015.MAA06647@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0011302238190.813-100000@bagpipe.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, David S. Miller wrote:

>    Date:   Thu, 30 Nov 2000 19:14:14 +0100
>    From: Andi Kleen <ak@suse.de>
>
>    > The problem is that if data happens to be written via method (2),
>    > then the PUSH flag is never set on any packets generated. This is
>    > a bug, surely?
>
>    I just tried it on 2.2.17 and 2.4.0test11 and it sets PUSH for
>    writev() for both cases just fine. Maybe you could supply a test
>    program and tcpdump logs for what you think is wrong ?
>
> One thing which could affect the behavior is if the Zeus
> folks are futzing around with the TCP_CORK socket option.
> Ben, are you guys playing with it?
>
> Finally, are you doing these writes from a userspace program
> or directly inside of a kernel module?

Nope, nothing cunning going on here. Its from userspace, TCP_CORK
untouched. TCP_NODELAY is set, and I was using non-blocking IO (though
that doesn't seem to affect it)

Anyway, I've just hacked together a quick & nasty piece of code that
demonstrates the issue. Run the program with no arguments to get write()
behaviour, or give an argument and you'll get writev()

write() trace: (bagpipe=server, 2.4.0-test10, baphomet=client, 2.2.17)
22:36:38.430774 baphomet.4126 > bagpipe.4000: S 2380162569:2380162569(0) win 32120 <mss 1460,sackOK,timestamp 337446754 0,nop,wscale 0> (DF) [tos 0x10]
22:36:38.432410 bagpipe.4000 > baphomet.4126: S 2375849323:2375849323(0) ack 2380162570 win 5792 <mss 1460,sackOK,timestamp 4813031 337446754,nop,wscale 0> (DF)
22:36:38.432581 baphomet.4126 > bagpipe.4000: . ack 1 win 32120 <nop,nop,timestamp 337446754 4813031> (DF) [tos 0x10]
22:36:38.433494 bagpipe.4000 > baphomet.4126: P 1:128(127) ack 1 win 5792 <nop,nop,timestamp 4813032 337446754> (DF)
22:36:38.433685 baphomet.4126 > bagpipe.4000: . ack 128 win 32120 <nop,nop,timestamp 337446754 4813032> (DF) [tos 0x10]
22:36:40.442471 bagpipe.4000 > baphomet.4126: P 128:255(127) ack 1 win 5792 <nop,nop,timestamp 4813233 337446754> (DF)
22:36:40.455945 baphomet.4126 > bagpipe.4000: . ack 255 win 32120 <nop,nop,timestamp 337446957 4813233> (DF) [tos 0x10]
22:36:42.452473 bagpipe.4000 > baphomet.4126: P 255:382(127) ack 1 win 5792 <nop,nop,timestamp 4813434 337446957> (DF)
22:36:42.465812 baphomet.4126 > bagpipe.4000: . ack 382 win 32120 <nop,nop,timestamp 337447158 4813434> (DF) [tos 0x10]
[...]

writev() trace:
22:37:57.214625 baphomet.4129 > bagpipe.4000: S 2458096423:2458096423(0) win 32120 <mss 1460,sackOK,timestamp 337454633 0,nop,wscale 0> (DF) [tos 0x10]
22:37:57.214682 bagpipe.4000 > baphomet.4129: S 2451832783:2451832783(0) ack 2458096424 win 5792 <mss 1460,sackOK,timestamp 4820910 337454633,nop,wscale 0> (DF)
22:37:57.214830 baphomet.4129 > bagpipe.4000: . ack 1 win 32120 <nop,nop,timestamp 337454633 4820910> (DF) [tos 0x10]
22:37:57.215017 bagpipe.4000 > baphomet.4129: . 1:128(127) ack 1 win 5792 <nop,nop,timestamp 4820910 337454633> (DF)
22:37:57.215204 baphomet.4129 > bagpipe.4000: . ack 128 win 32120 <nop,nop,timestamp 337454633 4820910> (DF) [tos 0x10]
22:37:59.222458 bagpipe.4000 > baphomet.4129: . 128:255(127) ack 1 win 5792 <nop,nop,timestamp 4821111 337454633> (DF)
22:37:59.720572 baphomet.4129 > bagpipe.4000: . ack 255 win 32120 <nop,nop,timestamp 337454884 4821111> (DF) [tos 0x10]
22:38:01.232460 bagpipe.4000 > baphomet.4129: . 255:382(127) ack 1 win 5792 <nop,nop,timestamp 4821312 337454884> (DF)
22:38:01.730440 baphomet.4129 > bagpipe.4000: . ack 382 win 32120 <nop,nop,timestamp 337455085 4821312> (DF) [tos 0x10]
[...]


If you vary the 'CHUNK_SIZE' value to change how much data gets sent out
between each sleep(), you can provoke the PUSH flag to be set.
In fact, I've just noticed something; setting it to 1700, and after
leaving it to merrily writev() for a while, I do eventually see the PUSH
flag:

22:51:56.302460 bagpipe.4000 > baphomet.4135: P 15301:16749(1448) ack 1 win 5792 <nop,nop,timestamp 4904819 337538396> (DF)
...
22:52:16.402458 bagpipe.4000 > baphomet.4135: P 32301:33749(1448) ack 1 win 5792 <nop,nop,timestamp 4906829 337540407> (DF)
...
22:52:36.502454 bagpipe.4000 > baphomet.4135: P 49301:50749(1448) ack 1 win 5792 <nop,nop,timestamp 4908839 337542417> (DF)
...
22:52:56.602449 bagpipe.4000 > baphomet.4135: P 66301:67749(1448) ack 1 win 5792 <nop,nop,timestamp 4910849 337544427> (DF)



Ben


==============




#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <sys/uio.h>

#define CHUNK_SIZE 127


char data[ CHUNK_SIZE ];

int main( int argc, char *argv[] )
{
    int serverfd, clientfd, i, client_size;
    struct sockaddr_in server_addr, client_addr;
    struct iovec vector[ 2 ];

    for( i = 0; i < CHUNK_SIZE; i++ ) data[ i ] = 'a';

    serverfd = socket( PF_INET, SOCK_STREAM, 0 );
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl( INADDR_ANY );
    server_addr.sin_port = htons( 4000 );

    if( bind( serverfd, ( struct sockaddr * ) &server_addr,
	      sizeof( server_addr )) ) {
	perror( "bind" );
	exit( 1 );
    }

    listen( serverfd, 10 );
    clientfd = accept( serverfd, ( struct sockaddr * ) &client_addr,
 		       &client_size );
    i = 1;
    setsockopt( clientfd, SOL_TCP, TCP_NODELAY, &i, sizeof( i ));

    for( ;; ) {
	if( argc > 1 ) {
	    vector[ 0 ].iov_base = data;
	    vector[ 0 ].iov_len = CHUNK_SIZE;
	    vector[ 1 ].iov_base = NULL;
	    vector[ 1 ].iov_len = 0;
	    writev( clientfd, vector, 2 );
	} else {
	    write( clientfd, &data, CHUNK_SIZE );
	}
	sleep( 2 );
    }
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
