Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTETNsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTETNsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:48:51 -0400
Received: from leonis.nus.edu.sg ([137.132.1.18]:58324 "EHLO leonis.nus.edu.sg")
	by vger.kernel.org with ESMTP id S263779AbTETNsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:48:43 -0400
Subject: IP_HDRINCL and IP_PKTINFO on RAW sockets with sendmsg
From: Eng Se-Hsieng <g0202512@nus.edu.sg>
To: linux-kernel@vger.kernel.org
Cc: linux-newbie@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-XgWlff3fRz1C3niLfHYR"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 May 2003 22:01:54 -0800
Message-Id: <1053496915.16331.10.camel@nusnet-165-146.dynip.nus.edu.sg>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XgWlff3fRz1C3niLfHYR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I am using IP_HDRINCL and IP_PKTINFO (to choose by which interface the
packet leaves) on a RAW socket.

I'm using the udphdr structure with IPPROTO_RAW but I keep Malformed
Packet in the Ethereal traces and the IP header can't even be read by
Ethereal.

Is there something wrong with my approach? Please advise. Thank you.

Regards,
Se-Hsieng

Attached: test_iphdr.c



--=-XgWlff3fRz1C3niLfHYR
Content-Disposition: attachment; filename=test_rawhdr.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=test_rawhdr.c; charset=UTF-8

#include <sys/socket.h>=0D
#include <sys/uio.h>=0D
#include <unistd.h>=0D
#include <resolv.h>=0D
#include <net/if.h>=0D
#include <netinet/udp.h>=0D
#include <netinet/ip.h>=0D
=0D
#define BUFFER_SIZE 36000=0D
=0D
int main(void)=0D
{=0D
char *buffer;=0D
int buffer_size =3D BUFFER_SIZE;=0D
int s =3D socket(PF_INET, SOCK_RAW, IPPROTO_RAW);=0D
struct sockaddr_in sin;			      =20=0D
struct msghdr msg;=0D
struct cmsghdr *cmsg;=0D
struct in_pktinfo *pktinfo;=0D
char outcmsg[CMSG_SPACE(sizeof(struct in_pktinfo))];=0D
struct iovec io;=0D
int yes=3D1;=0D
int i, bytes;=0D
char *interface=3D"eth0";=0D
struct ip *iph;=0D
int iphdrSz;=0D
struct udphdr* udph;=0D
int if_index1=3D0;=0D
int if_index2=3D0;=0D
=0D
bzero(&sin, sizeof(sin));=0D
sin.sin_family=3DAF_INET;=0D
sin.sin_addr.s_addr=3DINADDR_ANY;=0D
sin.sin_port=3Dhtons(10000);=0D
if (bind(s, (struct sockaddr *)&sin, sizeof(sin))<0) {=0D
  printf("bind: UH-OH.\n");=0D
  exit(1);=0D
}=0D
=0D
bzero(&sin,sizeof(sin));=0D
bzero(&msg,sizeof(msg));=0D
=0D
sin.sin_family=3DAF_INET;=0D
sin.sin_port=3Dhtons(10000);=0D
sin.sin_addr.s_addr=3Dinet_addr("137.132.165.146");=0D
=0D
msg.msg_name=3D&sin;=0D
msg.msg_namelen=3Dsizeof(sin);=0D
msg.msg_control=3D outcmsg;=0D
msg.msg_controllen=3Dsizeof(outcmsg);=0D
msg.msg_flags=3D0;=0D
=0D
buffer=3D(char*)malloc(buffer_size);=0D
=0D
if (setsockopt(s,SOL_IP,IP_HDRINCL,&yes,sizeof(yes))=3D=3D0) {=0D
  printf("Construct IP header ok.\n");=0D
}  =20=0D
=0D
/*  Construct IP header */=0D
iph=3D(struct ip*)buffer;=0D
iph->ip_hl=3D5;=0D
iph->ip_v=3D4;=0D
iphdrSz=3Dsizeof(struct ip);=0D
iph->ip_len =3D htons(buffer_size+iphdrSz);=0D
iph->ip_id=3D0;=0D
iph->ip_off=3D0x40;=0D
iph->ip_p=3D132;=0D
iph->ip_sum=3D0;=0D
iph->ip_src.s_addr=3D0;=0D
iph->ip_dst.s_addr=3D0; =20=0D
=0D
udph=3D(struct udphdr*) ((u_long)buffer+sizeof(struct ip));=0D
udph->source=3Dhtons(10000);=0D
udph->dest=3Dhtons(10000);=0D
udph->len=3Dhtons(buffer_size);=0D
udph->check=3D0;=0D
=0D
io.iov_base=3Dbuffer;=0D
io.iov_len=3Dstrlen(buffer);=0D
=0D
=0D
if (setsockopt(s, SOL_IP, IP_PKTINFO,&yes,sizeof(yes))=3D=3D0) {=0D
  printf("sok opt OK\n");=0D
}=0D
=0D
cmsg=3DCMSG_FIRSTHDR(&msg);=0D
cmsg->cmsg_level=3DSOL_IP;=0D
cmsg->cmsg_type=3DIP_PKTINFO;=0D
cmsg->cmsg_len=3DCMSG_LEN(sizeof(struct in_pktinfo));=0D
=0D
msg.msg_controllen=3Dcmsg->cmsg_len;=0D
pktinfo=3D(struct in_pktinfo *)CMSG_DATA(cmsg);=0D
memset(pktinfo, 0x00, sizeof(struct in_pktinfo));=0D
=0D
=0D
msg.msg_iov=3D&io;=0D
msg.msg_iovlen=3D1;=0D
=0D
=0D
	for (i=3D0;i<10;i++) {=0D
=0D
=0D
=0D
		   if_index1 =3D if_nametoindex("eth0");=0D
=0D
		   printf("eth0, %d\n", if_index1);=0D
=0D
		   if (!if_index1) {=0D
			printf("Interface %s unknown\n", interface);=0D
			exit(1);=0D
		   }=0D
=0D
=0D
=0D
pktinfo->ipi_ifindex=3Dif_index1;=0D
//pktinfo->ipi_spec_dst.s_addr=3Dinet_addr("137.132.53.46");=0D
if ( (bytes=3Dsendmsg(s,&msg,0))<0 ) printf("cannot send \n");=0D
=0D
		   if_index2 =3D if_nametoindex("eth1");=0D
=0D
		   printf("eth1, %d\n", if_index2);=0D
		   if (!if_index2) {=0D
			printf("Interface %s unknown\n", interface);=0D
			exit(1);=0D
		   }=0D
=0D
=0D
=0D
pktinfo->ipi_ifindex=3Dif_index2;=0D
=0D
if ( (bytes=3Dsendmsg(s,&msg,0))<0 ) printf("cannot send \n");=0D
=0D
=0D
}=0D
=0D
close (s);=0D
free(buffer);=0D
=0D
=0D
}=0D

--=-XgWlff3fRz1C3niLfHYR--

