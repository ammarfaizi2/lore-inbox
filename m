Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRH2ISZ>; Wed, 29 Aug 2001 04:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271929AbRH2ISR>; Wed, 29 Aug 2001 04:18:17 -0400
Received: from elin.scali.no ([62.70.89.10]:23056 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S271928AbRH2ISG>;
	Wed, 29 Aug 2001 04:18:06 -0400
Subject: Re: Usage of SIOCADDMULTI ?
From: Terje Eggestad <terje.eggestad@scali.no>
To: Peter Enderborg <pme@ufh.se>
Cc: linux kermel <linux-kernel@vger.kernel.org>,
        linux net <linux-net@vger.kernel.org>
In-Reply-To: <3B8C056A.A3114FE1@ufh.se>
In-Reply-To: <3B8C056A.A3114FE1@ufh.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 29 Aug 2001 10:18:18 +0200
Message-Id: <999073098.23176.3.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to ip(7) you should use setsockopt, the following works for me
(PS: I'm running 2.4.3 and I get EPERM as non root and EINVAL as root
when running your code.)

#include <net/if.h>
#include <netinet/in.h>
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netdb.h>

#define ASSERT(a, op, b, m...) do { if ( a op b) { \
fprintf(stderr, "ASSERT (" #a " " #op " " #b ") at %s line %d:",
__FILE__, __LINE__); \
fprintf(stderr, m);\
fprintf(stderr, "\n"); \
fflush(stderr); exit(-1); }} while(0)
 

struct ifreq ir;
struct ip_mreq mr;

int createmcast()
{
  int s, rc;
  struct hostent * he;
  struct sockaddr_in to;

  s = socket(AF_INET, SOCK_DGRAM, 0);

  ASSERT (s, == , -1, "socket failed errno=%d", errno);
  mr.imr_interface.s_addr = (in_addr_t) htonl(INADDR_ANY);

  to.sin_family = AF_INET;
  to.sin_port = 0;
  to.sin_addr.s_addr = htonl(INADDR_ANY);
  //  bind(s, &to, sizeof(struct sockaddr_in));


  he = gethostbyname("172.16.0.116");
  ASSERT (he, ==, NULL, "gethostbyname if failed %d", h_errno);
  //  memcpy (&mr.imr_interface, &he->h_addr_list[0], sizeof (struct
sockaddr_in));

  he = gethostbyname("225.0.0.100");
  ASSERT (he, ==, NULL, "gethostbyname mc failed %d", h_errno);
  memcpy (&mr.imr_multiaddr, he->h_addr_list[0], sizeof (struct
sockaddr_in));
  errno = 0;
  printf ("%#x %#x\n", mr.imr_multiaddr.s_addr,
mr.imr_interface.s_addr);
 
  rc = setsockopt (s, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mr, sizeof(struct
ip_mreq));

  ASSERT (rc, <, 0, "setsockopt (.., IPPROTO_IP, IP_ADD_MEMBERSHIP, ..)
failed errno=%d", errno);
  
  rc = setsockopt (s, IPPROTO_IP, IP_MULTICAST_IF, &mr.imr_interface,
sizeof(struct in_addr));

  ASSERT (rc, <, 0, "setsockopt (.., IPPROTO_IP, IP_MULTICAST_IF, ..)
failed errno=%d", errno);

  return s;
};

int createudp()
{
  int s, rc;
  struct sockaddr_in to;
  s = socket(AF_INET, SOCK_DGRAM, 0);

  to.sin_family = AF_INET;
  to.sin_port = htons(12345);
  to.sin_addr.s_addr = htonl(INADDR_ANY);
  rc = bind(s, &to, sizeof(struct sockaddr_in));
  ASSERT (rc, ==, -1, "bind failed %d", errno);
  return s;
};

int sendmcast (int s, char * payload, int plen)
{
  int rc;
  struct sockaddr_in to;

  to.sin_family = AF_INET;
  to.sin_port = htons(12345);
  memcpy(&to.sin_addr,  &mr.imr_multiaddr.s_addr, sizeof(struct
in_addr));

  if (plen == 0) plen = strlen(payload);

  rc = sendto (s,  payload, plen , 0, &to, sizeof(struct sockaddr_in));

  printf ("sendto returned %d\n", rc);
  ASSERT (rc, <, 0, "snndto () failed errno=%d", errno);

};

char * getdgram(int s)
{
  struct sockaddr_in from;
  int rc;
  static char buffer[1024];
  static char addrbuf[100];
  socklen_t fromlen;

  fromlen = sizeof(struct sockaddr_in);
  rc = recvfrom(s, buffer, 1024, 0, &from, &fromlen);
  inet_ntop(AF_INET, &from.sin_addr, addrbuf, 100);
  printf ("from socket %d, we got a message %s sender %s:%d (%d)\n", 
          s, buffer, addrbuf , ntohs(from.sin_port), fromlen);
  return buffer;
};
main()
{
  int ms, us;
  int rc;

  ms = createmcast();
  us = createudp();

  sendmcast(us, "heihei", 0);

  sleep(3);
  getdgram(us);

  exit(0);

  //  rc = ioctl (s, SIOCGIFADDR, &ir);

  //ASSERT (rc, <, 0, "ioctl failed errno=%d", errno);
};


Den 28 Aug 2001 22:56:10 +0200, skrev Peter Enderborg:
> Im trying to grab some ethernet multicasts. And the ioctl that should do
> that is SIOCADDMULTI.
> But I can't get it to work. And I have not found any who use that from
> userlevel so
> this is my guess who to do it. (I don't work but dont gives any error
> message)
> 
> 
> #include        <stdio.h>
> #include        <sys/ioctl.h>
> #include        <net/if.h>
> #include        <arpa/inet.h>
> #include        <errno.h>
> #include        <sys/un.h>
> 
> int main()
> {
>   int i,res,sock,from_len;
>   struct sockaddr_in eb_addr,from_addr;
>   char databuf[1500];
>   struct ifreq req;
> 
> 
>   if((sock = socket(AF_INET, SOCK_DGRAM, 0)) == -1)
>     {
>       printf("%s",strerror(errno));
>       exit(1);
>     }
> 
>   eb_addr.sin_family      = AF_INET;
>   /*    eb_addr.sin_family      = AF_UNSPEC; */
>   eb_addr.sin_addr.s_addr = inet_addr("0.0.0.0");
>   eb_addr.sin_port        = htons(4711);
> 
>   for (i = 0; i < 8; ++i)
>     eb_addr.sin_zero[i] = 0;
>   if(bind(sock,(struct sockaddr*)  &eb_addr, sizeof(struct sockaddr_in))
> == -1)
>     {
>       printf("Unable to bind the socket\n");
>       exit(1);
>     }
>   strcpy(req.ifr_name,"eth0");
>   req.ifr_ifru.ifru_addr.sa_data[0] = 0x01;
>   req.ifr_ifru.ifru_addr.sa_data[1] = 0x80;
>   req.ifr_ifru.ifru_addr.sa_data[2] = 0xc2;
>   req.ifr_ifru.ifru_addr.sa_data[3] = 0x00;
>   req.ifr_ifru.ifru_addr.sa_data[4] = 0x00;
>   req.ifr_ifru.ifru_addr.sa_data[5] = 0x00;
>   /* req.ifr_flags = IFF_ALLMULTI;   | IFF_PROMISC;  */
>   res = ioctl(sock,SIOCADDMULTI,&req);
>   if(res == -1)
>     {
>     printf("%s",strerror(errno));
>     exit(1);
>   }
> 
>   while (1)
>     {
>       printf("enter recvfrom\n");
>       res = recvfrom(sock,  databuf, sizeof(databuf), 0,(struct
> sockaddr*) &from_addr, &from_len);
>       printf("Received %d bytes\n", res );
>     }
>   return 0;
> }
> 
> This on a 2.4.9 kernel on SMP P2. Im trying to grab some 802 bridge
> packets and I see them
> with tcpdump but that is using a other interface. (BPF or what ever) Any
> ideas whats wrong ?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

