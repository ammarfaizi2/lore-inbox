Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTKVUsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 15:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTKVUsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 15:48:33 -0500
Received: from pod.tau.ac.il ([132.66.10.227]:27803 "EHLO pod.tau.ac.il")
	by vger.kernel.org with ESMTP id S262762AbTKVUsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 15:48:24 -0500
Date: Sat, 22 Nov 2003 22:48:22 +0200 (IST)
From: Oded Comay <comay@pod.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Is PACKET_RX_RING broken in 2.6.0-test?
Message-ID: <Pine.LNX.4.44.0311222244450.9491-100000@pod.tau.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0311222244452.9491@pod.tau.ac.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PACKET_RX_RING mechanism (enabled by CONFIG_PACKET_MMAP) appears to be 
somewhat broken in 2.6.0-test* (2.6 for short). There are 3 issues:

1. Performance in 2.6 is much lower than in 2.4. As an example, using the 
same hardware and under the same traffic load, the sample program below
could process 177K packets/sec in 2.4, but only 70K packets/sec in 2.6.

2. In 2.4 one could call bind() and setsockopt(PACKET_RX_RING) in any 
order.  In 2.6, when calling setsockopt() after calling bind(), no error 
is returned, but also no packet is delivered to the userspace ring.

3. The getsockopt(PACKET_STATISTICS) call returns 0 dropped packets, 
although some packets were apparently dropped. This is assumed since in 
the above test, and although some 100K packets/sec were not processed, the 
call returned no dropped packets.

Steps to reproduce:

The program below, based on Gianni Tedesco's lincap.c, demonstrates the 
3 issues.

Usage: ./lincap -i device -b -a -p

-i device    device to sniff.
-b           bind before setsockopt.
-a           bind after setsockopt.
-p           print packets.

When invoked with -b the program will not process packets under 2.6, but
works fine in 2.4. With -a it works in both 2.6 and 2.4.

The output of the program when run in 2.4.20 and 2.6.0-test4 under heavy 
traffic load is shown below. It shows the performance difference, as well 
as the fact that in 2.6 the packet per poll() ratio is 1, while it is 24 
in 2.4.20. It also shows that no dropped packets are reported in 2.6.

Things to note: The performance tests were run on a dual 2.8GHz Xeon, 
using an Intel e1000 NIC. The NIC drivers included in the corresponding 
kernels are very different.

Oded.
---------------------------- Sample Output ----------------------------
Linux b2 2.4.20-8smp #1 SMP Thu Mar 13 17:45:54 EST 2003 i686 i686 i386 
GNU/Linux
# time /tmp/lincap -b
Creating socket
binding to eth0
Calling setsockopt PACKET_RX_RING
Mmaping ring buffer
Polling for packets (without printing). ^C to quit
pps=177466 mbps=58 packets/poll=24.61
recieved 4054110 packets, dropped 307

real    0m22.846s
user    0m0.460s
sys     0m0.710s
CPU utilization: usr 2% sys 3%

Linux b2 2.6.0-0.test4.1.33smp #1 SMP Fri Sep 5 08:14:16 EDT 2003 i686 
i686 i386 GNU/Linux
[root@b2 root]# time /tmp/lincap -a
Creating socket
Calling setsockopt PACKET_RX_RING
binding to eth0
Mmaping ring buffer
Polling for packets (without printing). ^C to quit
pps=69410 mbps=23 packets/poll=1.00
recieved 1702432 packets, dropped 0

real    0m24.623s
user    0m1.856s
sys     0m6.232s
CPU utilization: usr 7.5% sys 25% 
---------------------------- Sample Program ----------------------------
/* Copyright (c) 2002 Gianni Tedesco
* Released under the terms of the GNU GPL version 2 */

#ifndef __linux__
#error "Are you loco? This is Linux only!"
#endif

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define __USE_XOPEN
#include <sys/poll.h>
#include <sys/socket.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <features.h>    /* for the glibc version number */
#if __GLIBC__ >= 2 && __GLIBC_MINOR >= 1
#include <netpacket/packet.h>
#include <net/ethernet.h>     /* the L2 protocols */
#else
#include <asm/types.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h>   /* The L2 protocols */
#endif
#include <string.h>
#include <netinet/in.h>
#include <asm/system.h>
#include <signal.h>

char *names[]={
	"<", /* incoming */
	"B", /* broadcast */
	"M", /* multicast */
	"P", /* promisc */
	">", /* outgoing */
};

int fd=-1;
char *map;
struct tpacket_req req;
struct iovec *ring;

double packets= 0, polls= 1e-6, bytes= 0;
struct timeval tv0, tv1;

void sigproc(int sig)
{
	struct tpacket_stats st;
	int len=sizeof(st);
        double dt;

        gettimeofday(&tv1, NULL);
        dt= tv1.tv_sec + tv1.tv_usec*1e-6-
           (tv0.tv_sec + tv0.tv_usec*1e-6);
        printf("pps=%.0f mbps=%.0f packets/poll=%.2f\n", 
            packets/dt, bytes*8/dt/1e6, packets/polls);

	if (!getsockopt(fd,SOL_PACKET,PACKET_STATISTICS,(char *)&st,&len)) {
		fprintf(stderr, "recieved %u packets, dropped %u\n",
			st.tp_packets, st.tp_drops);
	}
	
	if ( map ) munmap(map, req.tp_block_size * req.tp_block_nr);
	if ( fd>=0 ) close(fd);
	if ( ring ) free(ring);

	exit(0);
}

static int bind_dev(int fd, char *device)
{
	struct sockaddr_ll addr;
	struct ifreq	ifr;

	printf("Binding to %s\n", device);
	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, device, sizeof(ifr.ifr_name));

	if (ioctl(fd, SIOCGIFINDEX, &ifr) == -1) {
		munmap(map, req.tp_block_size * req.tp_block_nr);
		perror("ioctl(SIOCGIFINDEX)");
		return -1;
	}

	/* bind the packet socket */
	memset(&addr, 0, sizeof(addr));
	addr.sll_family=AF_PACKET;
	addr.sll_protocol=htons(0x03);
	addr.sll_ifindex=ifr.ifr_ifindex;
	addr.sll_hatype=0;
	addr.sll_pkttype=0;
	addr.sll_halen=0;
	if ( bind(fd, (struct sockaddr *)&addr, sizeof(addr)) ) {
		perror("bind()");
		return -1;
	}
}
	
static void usage(char *myname)
{
	fprintf(stderr, "Usage: %s -i device -b -a -p\n\n", myname);
	fprintf(stderr, "-i device    device to sniff.\n");
	fprintf(stderr, "-b           bind before setsockopt.\n");
	fprintf(stderr, "-a           bind after setsockopt.\n");
	fprintf(stderr, "-p           print packets.\n");
}

int main ( int argc, char **argv ) 
{
	struct pollfd pfd;
	int i;
	char opt;
        char *device= NULL;
        int before= 0, after= 0, print= 0;
	
	while ((opt= getopt(argc, argv, "i:bap")) != EOF) {
		switch (opt) {
			case 'i': device= optarg;
				break;
			case 'b': before= 1;
				break;
			case 'a': after= 1;
				break;
			case 'p': print= 1;
				break;
			default:
				usage(argv[0]);
				exit(1);
		}
	}
	if (optind < argc)
		usage(argv[0]);
	if (device == NULL)
		device= "eth0";

	signal(SIGINT, sigproc);

	/* Open the packet socket */
	printf("Creating socket\n");
	if ( (fd=socket(PF_PACKET, SOCK_DGRAM, 0))<0 ) {
		perror("socket()");
		return 1;
	}

        if (before && bind_dev(fd, device) < 0) {
                return 1;
        }

	/* Setup the fd for mmap() ring buffer */
	printf("Calling setsockopt PACKET_RX_RING\n");
	req.tp_block_size=4096;
	req.tp_frame_size=1024;
	req.tp_block_nr=64;
	req.tp_frame_nr=4*64;
	if ( (setsockopt(fd,
		SOL_PACKET,
		PACKET_RX_RING,
		(char *)&req,
		sizeof(req))) != 0 ) {
		perror("setsockopt()");
		close(fd);
		return 1;
	};

        if (after && bind_dev(fd, device) < 0) {
//		munmap(map, req.tp_block_size * req.tp_block_nr);
		return 1;
        }

	/* mmap() the sucker */
	printf("Mmaping ring buffer\n");
	map=mmap(NULL,
		req.tp_block_size * req.tp_block_nr,
		PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, fd, 0);
	if ( map==MAP_FAILED ) {
		perror("mmap()");
		close(fd);
		return 1;
	}

	/* Setup our ringbuffer */
	ring=malloc(req.tp_frame_nr * sizeof(struct iovec));
	for(i=0; i<req.tp_frame_nr; i++) {
		ring[i].iov_base=(void *)((long)map)+(i*req.tp_frame_size);
		ring[i].iov_len=req.tp_frame_size;
	}
	
        gettimeofday(&tv0, NULL);
	printf("Polling for packets %s printing. ^C to quit\n", 
		print ? "and" : "without");
	for(i=0;;) {
		while(*(unsigned long*)ring[i].iov_base) {
			struct tpacket_hdr *h=ring[i].iov_base;
			struct sockaddr_ll *sll=(void *)h + TPACKET_ALIGN(sizeof(*h));
			unsigned char *bp=(unsigned char *)h + h->tp_mac;

			packets++;
			bytes+= h->tp_len;
			if (print) {
				printf("%u.%.6u: if%u %s %u bytes\n",
					h->tp_sec, h->tp_usec,
					sll->sll_ifindex,
					names[sll->sll_pkttype],
					h->tp_len);
			}

			/* tell the kernel this packet is done with */
			h->tp_status=0;
			mb(); /* memory barrier */
			
			i=(i==req.tp_frame_nr-1) ? 0 : i+1;
		}

		/* Sleep when nothings happening */
		pfd.fd=fd;
		pfd.events=POLLIN|POLLERR;
		pfd.revents=0;
		poll(&pfd, 1, -1);
                polls++;
	}
	
	return 0;
}


