Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUH0SBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUH0SBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbUH0SBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:01:35 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:49609 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S266806AbUH0SBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:01:17 -0400
X-OB-Received: from unknown (208.36.123.34)
  by wfilter.us4.outblaze.com; 27 Aug 2004 18:01:16 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "J Leven" <jleven0@lycos.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Aug 2004 13:01:16 -0500
Subject: 2.6.8.1 ip_rt_bug using libipq to reroute packets to
    loopback,works on 2.4.x
X-Originating-Ip: 66.106.245.5
X-Originating-Server: ws7-5.us4.outblaze.com
Message-Id: <20040827180116.51FC9C6129@ws7-5.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use libipq to take all outbound packets destined for a
particular address (192.168.1.44) and reroute them to loopback.  I
have the program below, it works just fine in 2.4.x kernels but
produces a ip_rt_bug message in the 2.6 series.  Is there something I
am missing in the iptables configuration for 2.6, or is there a
workaround for this?
To test this, run setup_iptables.sh, compile and run test_server.c (on port 80)
and ipqtest.c.	Then "telnet 192.168.1.44 80".  The
expected behavior (that on 2.4 kernel), is a successful connection to
test_server.

Thanks in advance, and please CC jleven0@lycos.com on the response,
Jay

--------------------------------------------------------------
--------------------------- IPQTEST.C ------------------------
--------------------------------------------------------------
/* Compile with cc -lipq */
#include <linux/netfilter.h>
#include <libipq.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>

#define BUFSIZE 2048

struct in_addr dot_44;
struct in_addr loopback;

inline u_int16_t checksum_update_32(
	u_int16_t old_check,
	u_int32_t old,
	u_int32_t new)
{
	u_int32_t l;

	old_check = ~old_check;
	old = ~old;

	l = (u_int32_t)old_check + (old >> 16) + (old & 0xffff)
+ (new >> 16) + (new & 0xffff);
	return ~((u_int16_t)(l >> 16) + (l & 0xffff));
}

static void filter(
	unsigned char *packet)
{
	struct iphdr *ip;
	struct tcphdr *tcp;

	ip = (struct iphdr *)packet;
	if (ip->protocol == IPPROTO_TCP)
	{
		tcp = (struct tcphdr *)(((u_int32_t *)ip) + ip->ihl);

		if (ip->saddr == loopback.s_addr)
		{
			ip->check = checksum_update_32(

				ip->check,
				ip->saddr,
				dot_44.s_addr);
			tcp->check = checksum_update_32(
				tcp->check,
				ip->saddr,
				dot_44.s_addr);
			ip->saddr = dot_44.s_addr;
		}
		if (ip->daddr == dot_44.s_addr)
		{
			ip->check = checksum_update_32(
				ip->check,
				ip->daddr,
				loopback.s_addr);
			tcp->check = checksum_update_32(
				tcp->check,
				ip->daddr,
				loopback.s_addr);
			ip->daddr = loopback.s_addr;
		}
	}
}

static void die(struct ipq_handle *h)
{
	ipq_perror("passer");
	// ipq_destroy_handle(h);
	// exit(1);
}

int main(int argc, char **argv)
{
	int status;
	unsigned char buf[BUFSIZE];
	struct ipq_handle *h;

	inet_aton("192.168.1.44", &(dot_44));
	inet_aton("127.0.0.1", &(loopback));

	h = ipq_create_handle(0, PF_INET);
	if (!h)
		die(h);

	status = ipq_set_mode(h, IPQ_COPY_PACKET, BUFSIZE);
	if (status < 0)
		die(h);

	do{
		status = ipq_read(h, buf, BUFSIZE, 0);
		if (status < 0)
			die(h);

		switch (ipq_message_type(buf)) {
		case NLMSG_ERROR:
			fprintf(stderr, "Received error message %d\n",
					ipq_get_msgerr(buf));
			break;

		case IPQM_PACKET: {
			ipq_packet_msg_t *m = ipq_get_packet(buf);

			fprintf(stderr, "----------------
Accepting packet ----------------\n");
			if (m->data_len < sizeof(struct iphdr)) 
			{
				fprintf(
					stderr,
					"XXX BUG: %d < %d\n",
					m->data_len,
					sizeof(struct iphdr));
			}
			filter(m->payload);
			status = ipq_set_verdict(
				h,
				m->packet_id,
				NF_ACCEPT,
				m->data_len,
				m->payload);
			if (status < 0)
				die(h);
			break;
		}

		default:
			fprintf(stderr, "Unknown message type!\n");
			break;
		}
	} while (1);

	ipq_destroy_handle(h);
	return 0;
}
--------------------------------------------------------------
------------------------- TEST_SERVER.C ----------------------
--------------------------------------------------------------
#include <string.h>
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <unistd.h>
#include <sys/select.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>

int my_recv(
	int csock,
	char *bufptr,
	int read_len)
{
	fd_set fds;
	int rval;

	FD_ZERO(&fds);
	FD_SET(csock, &fds);
	do {
		select(csock + 1, &fds, NULL, NULL, NULL);

		rval = recv(csock, bufptr, read_len, 0); /* req1 */
		if (rval > 0)
		{
			bufptr += rval;
			read_len -= rval;
		}
		else if (rval < 0
				 && (errno == EAGAIN
					 || errno == EINTR
					 || errno == EWOULDBLOCK))
		{
			continue;
		}
		else
		{
			return -1;
		}
	} while (read_len);

	return 0;
}

int my_send(
	int csock,
	char *bufptr,
	int send_len)
{
	fd_set fds;
	int rval;

	FD_ZERO(&fds);
	FD_SET(csock, &fds);
	do {
		select(csock + 1, NULL, &fds, NULL, NULL);

		rval = send(csock, bufptr, send_len, 0); /* req1 */
		if (rval > 0)
		{
			bufptr += rval;
			send_len -= rval;
		}
		else if (rval < 0
				 && (errno == EAGAIN
					 || errno == EINTR
					 || errno == EWOULDBLOCK))
		{
			continue;
		}
		else
		{
			return -1;
		}
	} while (send_len);

	return 0;
}

static void usage() 
{
	fprintf(stderr, "\nusage : test_server -p port\n");
	exit(-1);
} 

int main(int argc, char **argv) {
	int ssock, csock[2000];
	struct sockaddr_in saddr;
	char res1[2048];
	char buf[204800];
	int sz, on, rval, i=0;
	int c, port;
	fd_set fds;
	
    /* get command line params */
    while ((c = getopt(argc, argv, "p:")) != -1) {
		switch(c) {
		  case 'p':
			  port = atoi(optarg); i++;
			  break;
	      default:
			  usage();
		}  /* switch end */
    }  /* while end */

	if (i < 1 )
	{
		usage();
	} 

	i=0;

	saddr.sin_family = AF_INET;
	saddr.sin_port = htons(port);
	saddr.sin_addr.s_addr = INADDR_ANY;

	ssock = socket(PF_INET, SOCK_STREAM, 0);
	on = 1;
	sz = 512 * 1024;
	setsockopt(ssock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
	setsockopt(ssock, SOL_SOCKET, SO_KEEPALIVE, &on, sizeof(on));
	setsockopt(ssock, SOL_SOCKET, SO_SNDBUF, &sz, sizeof(sz));
	setsockopt(ssock, IPPROTO_TCP, TCP_NODELAY, &on, sizeof(on));
	fcntl(ssock, F_SETFL, O_NONBLOCK | O_ASYNC);
	bind(ssock, (struct sockaddr *)&saddr, sizeof(struct sockaddr_in));
	listen(ssock, 100);

	FD_ZERO(&fds);
	FD_SET(ssock, &fds);
	
	while (1)
	{
		select(ssock + 1, &fds, NULL, NULL, NULL);
		csock[i] = accept(ssock, NULL, NULL);
		snprintf(res1,sizeof(res1),"[%d] Connected To
Test Server...",i);
		printf("%s\n",res1);
		my_send(csock[i], res1, strlen(res1)); 
		i++;
	}

	return 0;
}
--------------------------------------------------------------
------------------------- IPTABLES.SH ------------------------
--------------------------------------------------------------
#!/bin/sh
/sbin/iptables --flush
/sbin/iptables -A OUTPUT -j QUEUE
/sbin/iptables -A INPUT -j QUEUE
/sbin/iptables -A FORWARD -j QUEUE
/sbin/modprobe ip_queue
-- 
_______________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

