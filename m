Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270593AbUJUEDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270593AbUJUEDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270586AbUJUD7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:59:51 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:22148 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S270581AbUJUDvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:51:53 -0400
Message-ID: <41773265.1010404@metaparadigm.com>
Date: Thu, 21 Oct 2004 11:52:05 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com>
In-Reply-To: <41772674.50403@metaparadigm.com>
Content-Type: multipart/mixed;
 boundary="------------090606030309010102030505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090606030309010102030505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I'm actually trying to write a test case to demonstrate
the problem in a repeatable way.

I first looked at socket(PF_INET, SOCK_RAW) to inject the
packets but it appears I have no control over the IP
checksum, and an invalid UDP sum didn't cause any problems
(the packet was accepted fine).

So i've hacked up something with socket(PF_PACKET, SOCK_RAW)
but the problem i'm getting (although tcpdumps of the packets
look perfect), they are not being accepted by my UDP listening
socket. It uses real interfaces, not loopback for the raw
packet injection as the checksumming appears to be bypassed
on the loopback interface (I always see bad UDP checksum
on normally originated packets on the loopback interface).

Anyway, i've probably done something dumb. Anyone care to look
at my test code? The current code sends the packets out on all
interfaces (using the correct associated IP and MAC). Can change
the #if in main() to make it use normal UDP not my cooked packets
(which currently have correct checksums).

~mc

--------------090606030309010102030505
Content-Type: text/x-csrc;
 name="udptest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udptest.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/select.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netpacket/packet.h>
#include <net/ethernet.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/udp.h>
#include <linux/if.h>


typedef struct cooked_packet {
  struct ether_header ethp;
  struct iphdr ipp;
  struct udphdr udpp;
} __attribute__ ((__packed__)) cooked_packet;


unsigned short ip_cksum(unsigned short *ptr, int nbytes)
{
  int sum;
  unsigned short oddbyte, answer;

  sum = 0;
  while (nbytes > 1)  {
    sum += *ptr++;
    nbytes -= 2;
  }

  /* mop up an odd byte, if necessary */
  if (nbytes == 1) {
    oddbyte = 0;		/* make sure top half is zero */
    *((unsigned char *) &oddbyte) =
      *(unsigned char *)ptr;   /* one byte only */
    sum += oddbyte;
  }

  /*
   * Add back carry outs from top 16 bits to low 16 bits.
   */
  sum  = (sum >> 16) + (sum & 0xffff);	/* add high-16 to low-16 */
  sum += (sum >> 16);			/* add carry */
  answer = ~sum;		/* ones-complement, then truncate to 16 bits */
  return(answer);
}

unsigned short udp_cksum(unsigned short *ptr, int nbytes, in_addr_t *src, in_addr_t *dst)
{
  int i;
  int sum;
  unsigned short oddbyte, answer;

  sum = 0;

  /* add the UDP pseudo header which contains the IP src and
   * destinationn addresses */
  sum += *((unsigned short*)src);
  sum += *((unsigned short*)src+1);
  sum += *((unsigned short*)dst);
  sum += *((unsigned short*)dst+1);

  /* add protocol number + packet length */
  sum += htons(17) + htons(nbytes);

  while (nbytes > 1)  {
    sum += *ptr++;
    nbytes -= 2;
  }

  /* mop up an odd byte, if necessary */
  if (nbytes == 1) {
    oddbyte = 0;		/* make sure top half is zero */
    *((unsigned char *) &oddbyte) =
      *(unsigned char *)ptr;   /* one byte only */
    sum += oddbyte;
  }

  /*
   * Add back carry outs from top 16 bits to low 16 bits.
   */
  sum  = (sum >> 16) + (sum & 0xffff);	/* add high-16 to low-16 */
  sum += (sum >> 16);			/* add carry */
  answer = ~sum;		/* ones-complement, then truncate to 16 bits */
  return(answer);
}

void cook_udp_packet(cooked_packet *p, int len,
		     char *ether_dhost, char *ether_shost,
		     in_addr_t src, in_addr_t dst,
		     unsigned short src_port, unsigned short dst_port)
{
  p->ethp.ether_type = htons(ETH_P_IP);
  memcpy(&p->ethp.ether_dhost, ether_dhost, ETH_ALEN);
  memcpy(&p->ethp.ether_shost, ether_shost, ETH_ALEN);
  p->ipp.version = 0x4;
  p->ipp.ihl = 0x5;
  p->ipp.tos = 0;
  p->ipp.tot_len = htons(sizeof(struct iphdr) + sizeof(struct udphdr) + len);
  p->ipp.id = 0;
  p->ipp.frag_off = htons(0x4000); /* DF */
  p->ipp.ttl = 64;
  p->ipp.protocol = 17; /* UDP */
  p->ipp.check = 0;
  p->ipp.saddr = src;
  p->ipp.daddr = dst;
  p->udpp.source = src_port;
  p->udpp.dest = dst_port;
  p->udpp.len = htons(sizeof(struct udphdr) + len);
  p->udpp.check = 0x0;
  p->udpp.check = udp_cksum((unsigned short*)&p->udpp,
			    sizeof(struct udphdr) + len, &src, &dst);
  p->ipp.check = ip_cksum((unsigned short*)&p->ipp, sizeof(struct ip));
}


void send_raw_udp(unsigned short src_port, unsigned short dst_port,
		  char *payload)
{
  int raw_sock, i;
  struct sockaddr_ll dest_addr;
  struct ifconf ifc;
  struct ifreq *ifr;
  char *packet = malloc(sizeof(cooked_packet) + strlen(payload));

  if((raw_sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL))) < 0) {
    perror("socket");
    exit(1);
  }

  ifc.ifc_len = 0;
  ifc.ifc_buf = NULL;
  if (ioctl(raw_sock, SIOCGIFCONF, &ifc) < 0) {
    perror("ioctl(SIOCGIFCONF)");
    exit(1);
  }
  ifc.ifc_buf = malloc(ifc.ifc_len);
  if (ioctl(raw_sock, SIOCGIFCONF, &ifc) < 0) {
    perror("ioctl(SIOCGIFCONF)");
    exit(1);
  }

  /* send the packet out on all interfaces - just while testing */
  ifr = ifc.ifc_req;
  for (i = ifc.ifc_len / sizeof(struct ifreq); --i >= 0; ifr++) {
      struct ifreq ixifr, ipifr, hwifr;
      struct sockaddr_in *ipaddr;
      char *hw;

      strcpy(ixifr.ifr_name, ifr->ifr_name);
      if(ioctl(raw_sock, SIOCGIFINDEX, &ixifr) < 0) continue;
      strcpy(ipifr.ifr_name, ifr->ifr_name);
      if(ioctl(raw_sock, SIOCGIFADDR, &ipifr) < 0) continue;
      ipaddr = (struct sockaddr_in*)&ipifr.ifr_addr;
      strcpy(hwifr.ifr_name, ifr->ifr_name);
      if(ioctl(raw_sock, SIOCGIFHWADDR, &hwifr) < 0) continue;
      hw = (char*)&hwifr.ifr_hwaddr.sa_data;

      printf("sending via %s addr=%s hw=%02X:%02X:%02X:%02X:%02X:%02X\n",
	     ifr->ifr_name, inet_ntoa(ipaddr->sin_addr),
	     (hw[0] & 0377), (hw[1] & 0377), (hw[2] & 0377),
	     (hw[3] & 0377), (hw[4] & 0377), (hw[5] & 0377));
      memcpy(packet + sizeof(cooked_packet), payload, strlen(payload)+1);
      cook_udp_packet((cooked_packet*)packet, strlen(payload)+1,
		      hw, hw, ipaddr->sin_addr.s_addr, ipaddr->sin_addr.s_addr,
		      src_port, dst_port);

      memset(&dest_addr, 0, sizeof(dest_addr));
      dest_addr.sll_family = AF_PACKET;
      dest_addr.sll_ifindex = ixifr.ifr_ifindex;

      sendto(raw_sock, packet, sizeof(cooked_packet) + strlen(payload)+1,
	     0, (struct sockaddr*)&dest_addr, sizeof(dest_addr));
  }
  close(raw_sock);
}

void send_normal_udp(unsigned short src_port, unsigned short dst_port,
		     char *payload)
{
  int udp_sock;
  struct sockaddr_in src_addr, dest_addr;

  src_addr.sin_family = AF_INET;
  src_addr.sin_port = src_port;
  src_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

  dest_addr.sin_family = AF_INET;
  dest_addr.sin_port = dst_port;
  dest_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

  if((udp_sock = socket(PF_INET, SOCK_DGRAM, 0)) < 0) {
    perror("socket");
    exit(1);
  }

  if(bind(udp_sock, (struct sockaddr*)&src_addr, sizeof(src_addr)) < 0 ) {
    perror("bind");
    exit(1);
  }

  sendto(udp_sock, payload, strlen(payload) + 1, 0,
	 (struct sockaddr*)&dest_addr, sizeof(dest_addr));

  close(udp_sock);
}


int main(int argc, char **argv)
{
  int listen_sock, ret, addr_len;
  struct sockaddr_in bind_addr, peer_addr;
  unsigned short src_port = htons(1234);
  unsigned short dst_port = htons(5678);
  char *payload = "hello";
  char buf[6];
  fd_set readfds;
  struct timeval timeout;

  bind_addr.sin_family = AF_INET;
  bind_addr.sin_port = dst_port;
  bind_addr.sin_addr.s_addr = INADDR_ANY;

  if((listen_sock = socket(PF_INET, SOCK_DGRAM, 0)) < 0) {
    perror("socket");
    exit(1);
  }

  if(bind(listen_sock, (struct sockaddr*)&bind_addr, sizeof(bind_addr)) < 0 ) {
    perror("bind");
    exit(1);
  }

#if 1
  send_raw_udp(src_port, dst_port, payload);
#else
  send_normal_udp(src_port, dst_port, payload);
#endif

  printf("calling select\n");
  FD_ZERO(&readfds);
  FD_SET(listen_sock, &readfds);
  if((ret = select(listen_sock+1, &readfds, NULL, NULL, NULL)) < 0) {
    perror("select");
    exit(1);
  }
  if(!FD_ISSET(listen_sock, &readfds)) {
    printf("hmmm, socket is not readable\n");
    exit(1);
  }
  printf("socket is readable\n");

  addr_len = sizeof(peer_addr);
  if(recvfrom(listen_sock, buf, sizeof(buf), 0,
	      (struct sockaddr*)&peer_addr, &addr_len) < 0) {
    perror("recvfrom");
    exit(1);
  }
  printf("recvfrom success: %s\n", buf);

}

--------------090606030309010102030505--
