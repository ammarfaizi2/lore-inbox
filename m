Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270438AbRH1U4b>; Tue, 28 Aug 2001 16:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRH1U4N>; Tue, 28 Aug 2001 16:56:13 -0400
Received: from c213.89.215.252.cm-upc.chello.se ([213.89.215.252]:18823 "EHLO
	pescadero.ampr.org") by vger.kernel.org with ESMTP
	id <S270131AbRH1U4F>; Tue, 28 Aug 2001 16:56:05 -0400
Message-ID: <3B8C056A.A3114FE1@ufh.se>
Date: Tue, 28 Aug 2001 22:56:10 +0200
From: Peter Enderborg <pme@ufh.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kermel <linux-kernel@vger.kernel.org>,
        linux net <linux-net@vger.kernel.org>
Subject: Usage of SIOCADDMULTI ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im trying to grab some ethernet multicasts. And the ioctl that should do
that is SIOCADDMULTI.
But I can't get it to work. And I have not found any who use that from
userlevel so
this is my guess who to do it. (I don't work but dont gives any error
message)


#include        <stdio.h>
#include        <sys/ioctl.h>
#include        <net/if.h>
#include        <arpa/inet.h>
#include        <errno.h>
#include        <sys/un.h>

int main()
{
  int i,res,sock,from_len;
  struct sockaddr_in eb_addr,from_addr;
  char databuf[1500];
  struct ifreq req;


  if((sock = socket(AF_INET, SOCK_DGRAM, 0)) == -1)
    {
      printf("%s",strerror(errno));
      exit(1);
    }

  eb_addr.sin_family      = AF_INET;
  /*    eb_addr.sin_family      = AF_UNSPEC; */
  eb_addr.sin_addr.s_addr = inet_addr("0.0.0.0");
  eb_addr.sin_port        = htons(4711);

  for (i = 0; i < 8; ++i)
    eb_addr.sin_zero[i] = 0;
  if(bind(sock,(struct sockaddr*)  &eb_addr, sizeof(struct sockaddr_in))
== -1)
    {
      printf("Unable to bind the socket\n");
      exit(1);
    }
  strcpy(req.ifr_name,"eth0");
  req.ifr_ifru.ifru_addr.sa_data[0] = 0x01;
  req.ifr_ifru.ifru_addr.sa_data[1] = 0x80;
  req.ifr_ifru.ifru_addr.sa_data[2] = 0xc2;
  req.ifr_ifru.ifru_addr.sa_data[3] = 0x00;
  req.ifr_ifru.ifru_addr.sa_data[4] = 0x00;
  req.ifr_ifru.ifru_addr.sa_data[5] = 0x00;
  /* req.ifr_flags = IFF_ALLMULTI;   | IFF_PROMISC;  */
  res = ioctl(sock,SIOCADDMULTI,&req);
  if(res == -1)
    {
    printf("%s",strerror(errno));
    exit(1);
  }

  while (1)
    {
      printf("enter recvfrom\n");
      res = recvfrom(sock,  databuf, sizeof(databuf), 0,(struct
sockaddr*) &from_addr, &from_len);
      printf("Received %d bytes\n", res );
    }
  return 0;
}

This on a 2.4.9 kernel on SMP P2. Im trying to grab some 802 bridge
packets and I see them
with tcpdump but that is using a other interface. (BPF or what ever) Any
ideas whats wrong ?


