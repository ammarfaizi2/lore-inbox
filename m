Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289030AbSBGQeQ>; Thu, 7 Feb 2002 11:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289106AbSBGQeH>; Thu, 7 Feb 2002 11:34:07 -0500
Received: from hal.grips.com ([62.144.214.40]:43910 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S289030AbSBGQdx>;
	Thu, 7 Feb 2002 11:33:53 -0500
Message-Id: <200202071633.g17GXWB20895@hal.grips.com>
From: Gerold Jury <gjury@hal.grips.com>
To: root@chaos.analogic.com
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
Date: Thu, 7 Feb 2002 17:33:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020207084153.4784A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020207084153.4784A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VN86YFZ5HZBJ55BIQMI6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_VN86YFZ5HZBJ55BIQMI6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This is off topic but close.
UDP packets are not dropped when the UDP socket is shutdown(socket,0); for 
receive at least on 2.4.17.
attached is a small proof.
Anyone with a hint or a fix ?

Thanks
Gerold


On Thursday 07 February 2002 14:44, Richard B. Johnson wrote:
>
>        ENOBUFS
>               The output queue for a network interface was  full.
>               This  generally  indicates  that  the interface has
>               stopped sending, but may  be  caused  by  transient
>               congestion.   (This  cannot occur in Linux, packets
>               are just silently dropped when a device queue over­
>               flows.)
>
>
> Linux Man Page              July 1999                           1
>

--------------Boundary-00=_VN86YFZ5HZBJ55BIQMI6
Content-Type: text/x-c++;
  charset="iso-8859-1";
  name="udpshutdown.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="udpshutdown.c"

#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

char hello[] = "hello socket";
char buf[2048];

int main( int argc, char *argv[] )
{
  int iFd, ret;
  socklen_t fromlen;
  short port = 15678;
  struct sockaddr_in addr, from;

  if((iFd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
    perror("create socket");
    exit( 0 );
  }
  addr.sin_family = AF_INET;
  addr.sin_port = htons( port );
  addr.sin_addr.s_addr = htonl( INADDR_LOOPBACK );
  if (bind( iFd, (struct sockaddr *)&addr, sizeof( addr ) ) < 0) {
    fprintf(stderr,"bind to %d failed %s\n",port,strerror(errno));
    exit( 0 );
  }
  shutdown( iFd, 0 ); // shutdown receive
  // addr.sin_addr.s_addr = htonl( INADDR_LOOPBACK );
  if( sendto( iFd, hello, sizeof( hello ), 0, (struct sockaddr *)&addr, sizeof( addr ) ) < 0 ) {
    perror("sendto");
    exit( 0 );
  }
  ret = recvfrom( iFd,  buf, sizeof( buf ), 0, (struct sockaddr *)&from, &fromlen );
  if( ret < 0 ) {
    perror("recvfrom");
    exit( 0 );
  }
  printf( "received %d bytes [%s]\n", ret, buf );

  shutdown( iFd, 1 ); // shutdown send
  if( sendto( iFd, hello, sizeof( hello ), 0, (struct sockaddr *)&addr, sizeof( addr ) ) < 0 ) {
    perror("sendto");
    exit( 0 );
  }
  return 0;
}

--------------Boundary-00=_VN86YFZ5HZBJ55BIQMI6--
