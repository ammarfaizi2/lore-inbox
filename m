Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283578AbRLDXPG>; Tue, 4 Dec 2001 18:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282979AbRLDXOt>; Tue, 4 Dec 2001 18:14:49 -0500
Received: from [206.98.161.198] ([206.98.161.198]:6672 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S283579AbRLDXOd>; Tue, 4 Dec 2001 18:14:33 -0500
Subject: Re: Current NBD 'stuff'
From: Edward Muller <emuller@learningpatterns.com>
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112041644170.17617-400000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10112041644170.17617-400000@clements.sc.steeleye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 18:12:39 -0500
Message-Id: <1007507560.4520.19.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I am playing with ENBD now.

I think ENBD is targeted for inclusion in the kernel in 2.5, but it can
be found seperatly (sp) at http://www.it.uc3m.es/~ptb/nbd/

It looks much better than the nbd stuff that is currently in the kernel.
But that's mostly because Pavel doesn't have much time at the moment for
it AFAIK.

On Tue, 2001-12-04 at 17:26, Paul Clements wrote:
> On 3 Dec 2001, Edward Muller wrote:
> 
> > Anyone know where I can find the latest NBD stuff? Esp. client/server
> > code?
> 
> I have the same question. Maybe the user-level stuff is not being 
> actively maintained?
> 
> However, since we couldn't find current versions of this stuff, 
> my colleagues and I patched nbd-server and the nbd kernel module 
> to fix a few bugs and to make them a little more robust. I'll
> attach my versions of those files (which I think are derived from
> Pavel's .14.tar.gz versions).
> 
>  
> > Oh ... And one more question what's the best 2.4.X kernel to use with
> > nbd?
> 
> You'll want at least 2.4.4 (you'll probably want later than that for
> other reasons anyway) -- I think before that NBD was badly broken.
> 
> -- 
> Paul Clements
> Paul.Clements@SteelEye.com
> 
> ----
> 

> Index: linux/2.4/drivers/block/nbd.c
> diff -u linux/2.4/drivers/block/nbd.c:1.1.1.9 linux/2.4/drivers/block/nbd.c:1.1.1.9.4.3
> --- linux/2.4/drivers/block/nbd.c:1.1.1.9	Fri Jun 29 16:31:25 2001
> +++ linux/2.4/drivers/block/nbd.c	Tue Oct  2 13:34:03 2001
> @@ -91,17 +91,18 @@
>  	int result;
>  	struct msghdr msg;
>  	struct iovec iov;
> -	unsigned long flags;
> -	sigset_t oldset;
> +	//unsigned long flags;
> +	//sigset_t oldset;
>  
>  	oldfs = get_fs();
>  	set_fs(get_ds());
>  
> -	spin_lock_irqsave(&current->sigmask_lock, flags);
> -	oldset = current->blocked;
> -	sigfillset(&current->blocked);
> -	recalc_sigpending(current);
> -	spin_unlock_irqrestore(&current->sigmask_lock, flags);
> +	// JEJB: Allow signal interception
> +	//spin_lock_irqsave(&current->sigmask_lock, flags);
> +	//oldset = current->blocked;
> +	//sigfillset(&current->blocked);
> +	//recalc_sigpending(current);
> +	//spin_unlock_irqrestore(&current->sigmask_lock, flags);
>  
>  
>  	do {
> @@ -122,6 +123,13 @@
>  		else
>  			result = sock_recvmsg(sock, &msg, size, 0);
>  
> +		// JEJB: Detect signal issue here
> +		if(signal_pending(current)) {
> +			printk(KERN_WARNING "NBD caught signal\n");
> +			result = -EINTR;
> +			break;
> +		}
> +
>  		if (result <= 0) {
>  #ifdef PARANOIA
>  			printk(KERN_ERR "NBD: %s - sock=%ld at buf=%ld, size=%d returned %d.\n",
> @@ -133,10 +141,11 @@
>  		buf += result;
>  	} while (size > 0);
>  
> -	spin_lock_irqsave(&current->sigmask_lock, flags);
> -	current->blocked = oldset;
> -	recalc_sigpending(current);
> -	spin_unlock_irqrestore(&current->sigmask_lock, flags);
> +	//JEJB: didn't modify signal mask, so no need to restore it
> +	//spin_lock_irqsave(&current->sigmask_lock, flags);
> +	//current->blocked = oldset;
> +	//recalc_sigpending(current);
> +	//spin_unlock_irqrestore(&current->sigmask_lock, flags);
>  
>  	set_fs(oldfs);
>  	return result;
> @@ -333,8 +342,27 @@
>  		spin_unlock_irq(&io_request_lock);
>  
>  		down (&lo->queue_lock);
> +		if(!lo->file) {
> +			up(&lo->queue_lock);
> +			spin_lock_irq(&io_request_lock);
> +			printk(KERN_ERR "NBD: FAIL BETWEEN ACCEPT AND SEMAPHORE, FILE LOST\n");
> +			req->errors++;
> +			nbd_end_request(req);
> +			continue;
> +		}
> +		
>  		list_add(&req->queue, &lo->queue_head);
>  		nbd_send_req(lo->sock, req);	/* Why does this block?         */
> +		if(req->errors) {
> +			printk(KERN_ERR "NBD: NBD_SEND_REQ FAILED\n");
> +			list_del(&req->queue);
> +
> +			up(&lo->queue_lock);
> +			spin_lock_irq(&io_request_lock);
> +			nbd_end_request(req);
> +
> +			continue;
> +		}
>  		up (&lo->queue_lock);
>  
>  		spin_lock_irq(&io_request_lock);
> @@ -384,12 +412,14 @@
>  			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
>  			return -EBUSY;
>  		}
> -		up(&lo->queue_lock);
>  		file = lo->file;
> -		if (!file)
> +		if (!file) {
> +			up(&lo->queue_lock);
>  			return -EINVAL;
> +		}
>  		lo->file = NULL;
>  		lo->sock = NULL;
> +		up(&lo->queue_lock);
>  		fput(file);
>  		return 0;
>  	case NBD_SET_SOCK:
> @@ -430,9 +460,29 @@
>  		if (!lo->file)
>  			return -EINVAL;
>  		nbd_do_it(lo);
> +		/* on return tidy up in case we have a signal */
> +		printk(KERN_WARNING "NBD: nbd_do_it returned\n");
> +		/* Forcibly shutdown the socket causing all listeners
> +		 * to error
> +		 *
> +		 * FIXME: This code is duplicated from sys_shutdown, but
> +		 * there should be a more generic interface rather than
> +		 * calling socket ops directly here */
> +		lo->sock->ops->shutdown(lo->sock, 2);
> +		down(&lo->queue_lock);
> +		printk(KERN_WARNING "NBD: lock acquired\n");
> +		nbd_clear_que(lo);
> +		file = lo->file;
> +		lo->file = NULL;
> +		lo->sock = NULL;
> +		up(&lo->queue_lock);
> +		if(file)
> +			fput(file);
>  		return lo->harderror;
>  	case NBD_CLEAR_QUE:
> +		down(&lo->queue_lock);
>  		nbd_clear_que(lo);
> +		up(&lo->queue_lock);
>  		return 0;
>  #ifdef PARANOIA
>  	case NBD_PRINT_DEBUG:
> @@ -492,7 +542,7 @@
>  		return -EIO;
>  	}
>  #ifdef MODULE
> -	printk("nbd: registered device at major %d\n", MAJOR_NR);
> +	printk("nbd: (version Steeleye-8) registered device at major %d\n", MAJOR_NR);
>  #endif
>  	blksize_size[MAJOR_NR] = nbd_blksizes;
>  	blk_size[MAJOR_NR] = nbd_sizes;
> @@ -507,7 +557,7 @@
>  		init_MUTEX(&nbd_dev[i].queue_lock);
>  		nbd_blksizes[i] = 1024;
>  		nbd_blksize_bits[i] = 10;
> -		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */
> +		nbd_bytesizes[i] = ((u64)0x7ffffc00) << 10; /* 2TB */
>  		nbd_sizes[i] = nbd_bytesizes[i] >> BLOCK_SIZE_BITS;
>  		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &nbd_fops,
>  				nbd_bytesizes[i]>>9);
> ----
> 

> /*
>  * Network Block Device - server
>  *
>  * Copyright 1996-1998 Pavel Machek, distribute under GPL
>  *  <pavel@atrey.karlin.mff.cuni.cz>
>  *
>  * Version 1.0 - hopefully 64-bit-clean
>  * Version 1.1 - merging enhancements from Josh Parsons, <josh@coombs.anu.edu.au>
>  * Version 1.2 - autodetect size of block devices, thanx to Peter T. Breuer" <ptb@it.uc3m.es>
>  */
> 
> #define VERSION "1.3"
> #define GIGA (1*1024*1024*1024)
> 
> /* use lseek64 exclusively */
> #define _LARGEFILE_SOURCE   // Some more functions for correct standard I/O.
> #define _LARGEFILE64_SOURCE // Additional functionality from LFS for large files
> 
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <netinet/tcp.h>
> #include <netinet/in.h>		/* sockaddr_in, htons, in_addr */
> #include <netdb.h>		/* hostent, gethostby*, getservby* */
> #include <syslog.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <fcntl.h>
> #include <arpa/inet.h>
> 
> #define _IO(a,b)
> #define ISSERVER
> #define MY_NAME "nbd_server"
> #include "cliserv.h"
> #undef _IO
> /* Deep magic: ioctl.h defines _IO macro (at least on linux) */
> 
> #include <sys/ioctl.h>
> #include <sys/mount.h>		/* For BLKGETSIZE */
> 
> // #define DODBG
> // #define DEBUG( a... ) printf( a )
> #define DEBUG( a... ) do { } while(0)
> 
> 
> inline void readit(int f, void *buf, int len)
> {
> 	int res;
> 	while (len > 0) {
> 		DEBUG("*");
> 		if ((res = read(f, buf, len)) <= 0)
> 			err("Read failed: %m");
> 		len -= res;
> 		buf += res;
> 	}
> }
> 
> inline void writeit(int f, void *buf, int len)
> {
> 	int res;
> 	while (len > 0) {
> 		DEBUG("+");
> 		if ((res = write(f, buf, len)) <= 0)
> 			err("Write failed: %m");
> 		len -= res;
> 		buf += res;
> 	}
> }
> 
> int port;			/* Port I'm listening at */
> char *exportname;		/* File I'm exporting */
> u64 exportsize = ~0, hunksize = ~0;	/* ...and its length */
> int flags = 0;
> int export[1024];
> #define F_READONLY 1
> #define F_MULTIFILE 2 
> 
> void cmdline(int argc, char *argv[])
> {
> 	int i;
> 
> 	if (argc < 3) {
> 		printf("This is nbd-server version " VERSION "\n");	
> 		printf("Usage: port file_to_export [size][kKmM] [-r]\n"
> 		       "	-r read only\n"
> 		       "	if port is set to 0, stdin is used (for running from inetd)\n"
> 		       "	if file_to_export contains '%%s', it is substituted with IP\n"
> 		       "		address of machine trying to connect\n" );
> 		exit(0);
> 	}
> 	port = atoi(argv[1]);
> 	for (i = 3; i < argc; i++) {
> 		if (*argv[i] == '-') {
> 			switch (argv[i][1]) {
> 			case 'r':
> 				flags |= F_READONLY;
> 				break;
> 			case 'm':
> 				flags |= F_MULTIFILE;
> 				hunksize = 1*GIGA;
> 				break;
> 			}
> 		} else {
> 			u64 es;
> 			int last = strlen(argv[i])-1;
> 			char suffix = argv[i][last];
> 			if (suffix == 'k' || suffix == 'K' ||
> 			    suffix == 'm' || suffix == 'M')
> 				argv[i][last] = '\0';
> 			es = (u64)atol(argv[i]);
> 			switch (suffix) {
> 				case 'm':
> 				case 'M':  es <<= 10;
> 				case 'k':
> 				case 'K':  es <<= 10;
> 				default :  break;
> 			}
> 			exportsize = es;
> 		}
> 	}
> 
> 	exportname = argv[2];
> }
> 
> int connectme(int port)
> {
> 	struct sockaddr_in addrin;
> 	int addrinlen = sizeof(addrin);
> 	int net, sock;
> 	int size = 1;
> 
> 	if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
> 		err("socket: %m");
> 	// SteelEye change - reuse the port number
> 	if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &size, sizeof(int)) < 0)
> 		err("setsockopt: %m");
> 
> 	DEBUG("Waiting for connections... bind, ");
> 	addrin.sin_family = AF_INET;
> 	addrin.sin_port = htons(port);
> 	addrin.sin_addr.s_addr = 0;
> 	if (bind(sock, (struct sockaddr *) &addrin, addrinlen) < 0)
> 		err("bind: %m");
> 	DEBUG("listen, ");
> 	if (listen(sock, 1) < 0)
> 		err("listen: %m");
> 	DEBUG("accept, ");
> 	if ((net = accept(sock, (struct sockaddr *) &addrin, &addrinlen)) < 0)
> 		err("accept: %m");
> 
> 	return net;
> }
> 
> #define SEND writeit( net, &reply, sizeof( reply ));
> #define ERROR { reply.error = htonl(-1); SEND; reply.error = 0; lastpoint = -1; }
> 
> u64 lastpoint = -1;
> 
> void maybeseek(int handle, u64 a)
> {
> 	if (a > exportsize)
> 		err("Can not happen\n");
> 	if (lastpoint != a) {
> 		if (lseek64(handle, a, SEEK_SET) < 0)
> 			err("Can not seek locally!\n");
> 		lastpoint = a;
> 	} else {
> 		DEBUG("@");
> 	}
> }
> 
> int expread(u64 a, char *buf, int len)
> {
> 	maybeseek(export[a/hunksize], a%hunksize);
> 	return (read(export[a/hunksize], buf, len) != len);
> }
> 
> int expwrite(u64 a, char *buf, int len)
> {
> 	maybeseek(export[a/hunksize], a%hunksize);
> 	return (write(export[a/hunksize], buf, len) != len);
> }
> 
> int mainloop(int net)
> {
> 	struct nbd_request request;
> 	struct nbd_reply reply;
> 	char zeros[300];
> 	int i = 0;
> 	u64 size_host;
> 
> 	bzero(zeros, 290);
> 	if (write(net, INIT_PASSWD, 8) < 0)
> 		err("Negotiation failed: %m");
> 	cliserv_magic = htonll(cliserv_magic);
> 	if (write(net, &cliserv_magic, sizeof(cliserv_magic)) < 0)
> 		err("Negotiation failed: %m");
> 	size_host = htonll(exportsize);
> 	if (write(net, &size_host, 8) < 0)
> 		err("Negotiation failed: %m");
> 	if (write(net, zeros, 128) < 0)
> 		err("Negotiation failed: %m");
> 
> 	DEBUG("Entering request loop!\n");
> 	reply.magic = htonl(NBD_REPLY_MAGIC);
> 	reply.error = 0;
> 	while (1) {
> 		/* SteelEye change - need dynamic buffer to work with elevator */
> 		static long max_nbd_request=131072; /* 128K */
> 		static char *buf=NULL;
> 		int len;
> 
> #ifdef DODBG
> 		i++;
> 		printf("%d: ", i);
> #endif
> 
> 		readit(net, &request, sizeof(request));
> 		request.from = ntohll(request.from);
> 		request.type = ntohl(request.type);
> 		len = ntohl(request.len);
> 
> 		if (request.magic != htonl(NBD_REQUEST_MAGIC))
> 			err("Not enough magic.");
> 
> 		DEBUG("request len: %d bytes\n", len);
> 
> 		while (len > max_nbd_request || !buf) {
> 			/* SteelEye change - (re)allocate the buffer */
> 			if (buf) 
> 				free(buf);
> 			if (len > max_nbd_request) 
> 				max_nbd_request = len;
> 			buf=malloc(max_nbd_request);
> 			if (!buf) 
> 				DEBUG("failed to allocate %d byte buffer\n", max_nbd_request);
> 		}
> #ifdef DODBG
> 		printf("%s from %d (%d) len %d, ", (request.type ? "WRITE" : "READ"),
> 		       (int) request.from, (int) request.from / 512, len);
> #endif
> 		memcpy(reply.handle, request.handle, sizeof(reply.handle));
> 		if (((request.from + len) > exportsize) ||
> 		    ((flags & F_READONLY) && request.type)) {
> 			DEBUG("[RANGE!]");
> 			ERROR;
> 			continue;
> 		}
> 		if (request.type) {	/* WRITE */
> 			DEBUG("wr: net->buf, ");
> 			readit(net, buf, len);
> 			DEBUG("buf->exp, ");
> 			if (expwrite(request.from, buf, len)) {
> 				DEBUG("Write failed: %m" );
> 				ERROR;
> 				continue;
> 			}
> 			lastpoint += len;
> 			SEND;
> 			continue;
> 		}
> 		/* READ */
> 
> 		DEBUG("exp->buf, ");
> 		if (expread(request.from, buf + sizeof(struct nbd_reply), len)) {
> 		 	lastpoint = -1;
> 			DEBUG("Read failed: %m");
> 			ERROR;
> 			continue;
> 		}
> 		lastpoint += len;
> 
> 		DEBUG("buf->net, ");
> 		memcpy(buf, &reply, sizeof(struct nbd_reply));
> 		writeit(net, buf, len + sizeof(struct nbd_reply));
> 		DEBUG("OK!\n");
> 	}
> }
> 
> char exportname2[1024];
> 
> void set_peername(int net)
> {
> 	struct sockaddr_in addrin;
> 	int addrinlen = sizeof( addrin );
> 	char *peername;
> 
> 	if (getpeername( net, (struct sockaddr *) &addrin, &addrinlen ) < 0)
> 		err("getsockname failed: %m");
> 	peername = inet_ntoa(addrin.sin_addr);
> 	sprintf(exportname2, exportname, peername);
> 
> 	syslog(LOG_INFO, "connect from %s, assigned file is %s", peername, exportname2);
> }
> 
> u64 size_autodetect(int export)
> {
> 	u64 es;
> 	DEBUG("looking for export size with lseek SEEK_END\n");
> 	if ((es = lseek64(export, 0, SEEK_END)) == MINUS_ONE_64 || es == 0) {
> 		struct stat stat_buf = { 0, } ;
> 		int error;
> 		DEBUG("looking for export size with fstat\n");
> 		if ((error = fstat(export, &stat_buf)) == -1 || stat_buf.st_size == 0 ) {
> 			DEBUG("looking for export size with ioctl BLKGETSIZE\n");
> #ifdef BLKGETSIZE
> 			if(ioctl(export, BLKGETSIZE, &es) || es == 0) {
> #else
> 			if(1){
> #endif
> 				err("Could not find size of exported block device: %m");
> 			} else {
> 				es *= 512; /* assume blocksize 512 */
> 			}
> 		} else {
> 			es = stat_buf.st_size;
> 		}
> 	}
> 	return es;
> }
> 
> int main(int argc, char *argv[])
> {
> 	int net;
> 	u64 i;
> 
> 	if (sizeof( struct nbd_request )!=28)
> 		err("Bad size of structure. Alignment problems?");
> 
> 	logging();
> 	cmdline(argc, argv);
> 	
> 	if (port)
> 		net = connectme(port);
> 	else
> 		net = 0;
> 	set_peername(net);
> 
> 	for (i=0; i<exportsize; i+=hunksize) {
> 		char exportname3[1024];
> 
> 		sprintf(exportname3, exportname2, i/hunksize);
> 		printf( "Opening %s\n", exportname3 );
> 		if ((export[i/hunksize] = open(exportname3, (flags & F_READONLY) ? O_RDONLY : O_RDWR)) == -1)
> 			err("Could not open exported file: %m");
> 	}
> 	
> 	if (exportsize == ~0) {
> 		exportsize = size_autodetect(export[0]);
> 	}
> 	if (exportsize > (~0UL >> 1))
> 		if ((exportsize >> 10) > (~0UL >> 1))
> 			syslog(LOG_INFO, "size of exported file/device is %luMB",
> 				       (unsigned long)(exportsize >> 20));
> 		else
> 			syslog(LOG_INFO, "size of exported file/device is %luKB",
> 			       (unsigned long)(exportsize >> 10));
> 	else
> 		syslog(LOG_INFO, "size of exported file/device is %lu",
> 		       (unsigned long)exportsize);
> 	setmysockopt(net);
> 
> 	mainloop(net);
> 	return 0;
> }
> ----
> 

> /* This header file is shared by client & server. They really have
>  * something to share...
>  * */
> 
> /* Client/server protocol is as follows:
>    Send INIT_PASSWD
>    Send 64-bit cliserv_magic
>    Send 64-bit size of exported device
>    Send 128 bytes of zeros (reserved for future use)
>  */
> 
> #include "config.h"
> #include <errno.h>
> #include <string.h>
> #include <netdb.h>
> 
> #if SIZEOF_UNSIGNED_SHORT_INT==4
> typedef unsigned short u32;
> #elif SIZEOF_UNSIGNED_INT==4
> typedef unsigned int u32;
> #elif SIZEOF_UNSIGNED_LONG_INT==4
> typedef unsigned long u32;
> #else
> #error I need at least some 32-bit type
> #endif
> 
> #if SIZEOF_UNSIGNED_INT==8
> typedef unsigned int u64;
> #define MINUS_ONE_64 (-1U)
> #elif SIZEOF_UNSIGNED_LONG_INT==8
> typedef unsigned long u64;
> #define MINUS_ONE_64 (-1UL)
> #elif SIZEOF_UNSIGNED_LONG_LONG_INT==8
> typedef unsigned long long u64;
> #define MINUS_ONE_64 (-1ULL)
> #else
> #error I need at least some 64-bit type
> #endif
> 
> #include "nbd.h"
> 
> u64 cliserv_magic = 0x00420281861253LL;
> #define INIT_PASSWD "NBDMAGIC"
> 
> #define INFO(a) do { } while(0)
> 
> void setmysockopt(int sock)
> {
> 	int size = 1;
> #if 0
> 	if (setsockopt(sock, SOL_SOCKET, SO_SNDBUF, &size, sizeof(int)) < 0)
> 		 INFO("(no sockopt/1: %m)");
> #endif
> 	size = 1;
> 	if (setsockopt(sock, SOL_TCP, TCP_NODELAY, &size, sizeof(int)) < 0)
> 		 INFO("(no sockopt/2: %m)");
> #if 0
> 	size = 1024;
> 	if (setsockopt(sock, SOL_TCP, TCP_MAXSEG, &size, sizeof(int)) < 0)
> 		 INFO("(no sockopt/3: %m)");
> #endif
> }
> 
> void err(const char *s)
> {
> 	const int maxlen = 150;
> 	char s1[maxlen], *s2;
> 	int n = 0;
> 
> 	strncpy(s1, s, maxlen);
> 	if (s2 = strstr(s, "%m")) {
> 		strcpy(s1 + (s2 - s), sys_errlist[errno]);
> 		s2 += 2;
> 		strcpy(s1 + strlen(s1), s2);
> 	}
> 	else if (s2 = strstr(s, "%h")) {
> 		strcpy(s1 + (s2 - s), hstrerror(h_errno));
> 		s2 += 2;
> 		strcpy(s1 + strlen(s1), s2);
> 	}
> 
> 	s1[maxlen-1] = '\0';
> #ifdef ISSERVER
> 	syslog(LOG_ERR, s1);
> #else
> 	fprintf(stderr, "Error: %s\n", s1);
> #endif
> 	exit(1);
> }
> 
> void logging(void)
> {
> #ifdef ISSERVER
> 	openlog(MY_NAME, LOG_PID, LOG_DAEMON);
> #endif
> 	setvbuf(stdout, NULL, _IONBF, 0);
> 	setvbuf(stderr, NULL, _IONBF, 0);
> }
> 
> #ifdef WORDS_BIGENDIAN
> u64 ntohll(u64 a)
> {
> 	return a;
> }
> #else
> u64 ntohll(u64 a)
> {
> 	u32 lo = a & 0xffffffff;
> 	u32 hi = a >> 32U;
> 	lo = ntohl(lo);
> 	hi = ntohl(hi);
> 	return ((u64) lo) << 32U | hi;
> }
> #endif
> #define htonll ntohll
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

