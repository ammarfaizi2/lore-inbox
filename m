Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbTEORTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTEORTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:19:19 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:17800 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264102AbTEORTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:19:03 -0400
Subject: Re: Problem with e100 driver and latency on different packet sizes
From: Jonathan Brown <jbrown@emergence.uk.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EC3AA1E.6050401@mvista.com>
References: <3EC3AA1E.6050401@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053019911.28121.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 15 May 2003 18:31:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sounds like the cpu cycle saver

check out networking/e100.txt

On Thu, 2003-05-15 at 15:54, Corey Minyard wrote:
> I'm seeing an odd thing with the e100 driver.  It seems to be this way
> with the 2.4 series and with 2.5.68, and I couldn't find anything with a
> search.
> 
> I've attached a small program to measure latency of round-trip time on
> UDP.  If I send 85-byte packets between two of my machines, I get 170us
> round-trip latency.  If I send 86-byte packets, I get 1329us latency. 
> This seems quite odd.  If I test on the eepro100 driver, I get expected
> linear increase in round-trip time as the packet size increases, and it
> never gets close to 1300us.
> 
> To run the program, do:
> 
> ./ip_lat -s <port>
> 
> on one machine to run the server, and then do
> 
> ./ip_lat <server IP> <port> 1000 85
> 
> to send 1000 85-byte packets from another machine.  Change the 85 to 86
> to see the latency go up.
> 
> -Corey
> 
> ______________________________________________________________________
> 
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <sys/poll.h>
> #include <sys/time.h>
> #include <fcntl.h>
> #include <netdb.h>
> #include <malloc.h>
> #include <errno.h>
> #include <popt.h>
> 
> static int server;
> 
> struct poptOption poptOpts[]=
> {
>     {
> 	"server",
> 	's',
> 	POPT_ARG_NONE,
> 	NULL,
> 	's',
> 	"Enable the server",
> 	""
>     },
>     POPT_AUTOHELP
>     {
> 	NULL,
> 	0,
> 	0,
> 	NULL,
> 	0		 
>     }	
> };
> 
> void
> do_server(int port)
> {
>     int                fd;
>     char               buffer[2048];
>     struct sockaddr    addr;
>     struct sockaddr_in ipaddr;
>     socklen_t          addrlen;
>     size_t             len;
>     int                rv;
> 
>     fd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
>     if (fd == -1) {
> 	perror("Could not bind to port");
> 	exit(1);
>     }
> 
>     ipaddr.sin_family = AF_INET;
>     ipaddr.sin_port = htons(port);
>     ipaddr.sin_addr.s_addr = INADDR_ANY;
> 
>     rv = bind(fd, (struct sockaddr *) &ipaddr, sizeof(ipaddr));
>     if (rv) {
> 	perror("Could not bind to port");
> 	exit(1);
>     }
> 
>     for (;;) {
> 	addrlen = sizeof(addr);
> 	len = recvfrom(fd, buffer, sizeof(buffer), 0, &addr, &addrlen);
> 	if (len > 0) {
> 	    rv = sendto(fd, buffer, len, 0, &addr, addrlen);
> 	    if (rv == -1)
> 		perror("error in sendto");
> 	} else {
> 	    perror("Error in recvfrom");
> 	}
>     }
> }
> 
> static long
> diff_timeval(struct timeval *left,
> 	     struct timeval *right)
> {
>     if (   (left->tv_sec < right->tv_sec)
> 	|| (   (left->tv_sec == right->tv_sec)
> 	    && (left->tv_usec < right->tv_usec)))
>     {
> 	/* If left < right, just force to zero, don't allow negative
>            numbers. */
> 	return 0;
>     }
> 
>     return (((left->tv_sec - right->tv_sec) * 1000000)
> 	    + (left->tv_usec - right->tv_usec));
> }
> 
> static long
> average(long *data, int size, long *max, long *min)
> {
>     int  i;
>     long rv = 0;
> 
>     *max = LONG_MIN;
>     *min = LONG_MAX;
>     for (i=0; i<size; i++) {
> 	if (data[i] < 0)
> 	    continue;
> 	if (data[i] > *max)
> 	    *max = data[i];
> 	if (data[i] < *min)
> 	    *min = data[i];
> 	rv += data[i];
>     }
> 
>     return (rv / size);
> }
> 
> void do_client(struct in_addr *dest_addr, int port, int count, int size)
> {
>     int                fd;
>     struct sockaddr_in ipaddr;
>     struct sockaddr    addr;
>     socklen_t          addrlen;
>     int                rv;
>     int                i;
>     size_t             len;
>     char               buffer[2048];
>     char               buffer2[2048];
>     long               *times;
>     long               avg, max, min;
>     int                curr_port;
> 
>     times = malloc(sizeof(long) * count);
>     if (!times) {
> 	fprintf(stderr, "Out of memory\n");
> 	exit(1);
>     }
> 
>     fd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
>     if (fd == -1) {
> 	fprintf(stderr, "Out of memory\n");
> 	exit(1);
>     }
> 
>     curr_port = 1000;
>     do {
> 	curr_port++;
> 	ipaddr.sin_family = AF_INET;
> 	ipaddr.sin_port = htons(curr_port);
> 	ipaddr.sin_addr.s_addr = INADDR_ANY;
> 
> 	rv = bind(fd, (struct sockaddr *) &ipaddr, sizeof(ipaddr));
>     } while ((curr_port < 65536) && (rv == -1));
> 
>     ipaddr.sin_family = AF_INET;
>     ipaddr.sin_port = htons(port);
>     ipaddr.sin_addr = *dest_addr;
> 
>     for (i=0; i<size; i++) {
> 	buffer[i] = i;
>     }
> 
>     for (i=0; i<count; i++) {
> 	struct timeval start_time;
> 	struct timeval end_time;
> 	struct timeval wait_time;
> 	fd_set read_set;
> 
> 	times[i] = -1;
> 
> 	FD_ZERO(&read_set);
> 	FD_SET(fd, &read_set);
> 	wait_time.tv_sec = 2;
> 	wait_time.tv_usec = 0;
> 
> 	gettimeofday(&start_time, NULL);
> 	rv = sendto(fd, buffer, size, 0,
> 		    (struct sockaddr *) &ipaddr, sizeof(ipaddr));
> 	if (rv == -1) {
> 	    perror("Error in sendto");
> 	    continue;
> 	}
>     retry:
> 	rv = select(fd+1, &read_set, NULL, NULL, &wait_time);
> 	gettimeofday(&end_time, NULL);
> 	if (rv == -1) {
> 	    if (errno == EINTR)
> 		goto retry;
> 	    perror("Error in select");
> 	    continue;
> 	}
> 	if (rv == 0) {
> 	    fprintf(stderr, "Timeout waiting for response %d\n", i);
> 	    continue;
> 	}
> 
> 	addrlen = sizeof(addr);
> 	len = recvfrom(fd, buffer2, sizeof(buffer2), 0, &addr, &addrlen);
> 	if (rv == -1) {
> 	    perror("Error in recvfrom");
> 	    continue;
> 	}
> 
> 	if (len != size) {
> 	    fprintf(stderr, "Invalid length in response to buffer %d,"
> 		    " waiting more\n", i);
> 	    goto retry;
> 	}
> 	if (memcmp(buffer, buffer2, size) != 0) {
> 	    fprintf(stderr, "Invalid data in response to buffer %d,"
> 		    " waiting more\n", i);
> 	    goto retry;
> 	}
> 
> 	times[i] = diff_timeval(&end_time, &start_time);
>     }
> 
>     avg = average(times, count, &max, &min);
>     printf("Average: %ldus, Max: %ldus, Min: %ldus\n", avg, max, min);
> }
> 
> int
> main(int argc, const char *argv[])
> {
>     int            o;
>     struct hostent *ent;
>     struct in_addr addr;
>     int            port;
>     int            count;
>     int            size;
>     
>     poptContext poptCtx = poptGetContext("ip_lat", argc, argv, poptOpts,0);
> 
>     while (( o = poptGetNextOpt(poptCtx)) >= 0)
>     {   
> 	switch( o )
> 	{
> 	    case 's':
> 		server = 1;
> 		break;
> 
> 	    default:
> 		poptPrintUsage(poptCtx, stderr, 0);
> 		exit(1);
> 	}
>     }
> 
>     argv = poptGetArgs(poptCtx);
> 
>     if (!argv) {
> 	fprintf(stderr, "Not enough arguments\n");
> 	exit(1);
>     }
> 
>     for (argc=0; argv[argc]!= NULL; argc++)
> 	;
> 
>     if ((server && (argc < 1)) || (!server && (argc < 4))) {
> 	fprintf(stderr, "Not enough arguments\n");
> 	exit(1);
>     }
> 
>     if (server) {
> 	port = atoi(argv[0]);
> 	do_server(port);
>     } else {
> 	ent = gethostbyname(argv[0]);
> 	if (!ent) {
> 	    fprintf(stderr, "gethostbyname failed: %s\n", strerror(h_errno));
> 	    exit(1);
> 	}
> 	memcpy(&addr, ent->h_addr_list[0], ent->h_length);
> 	port = atoi(argv[1]);
> 
> 	count = atoi(argv[2]);
> 	size = atoi(argv[3]);
> 	do_client(&addr, port, count, size);
>     }
> 
>     return 0;
> }

