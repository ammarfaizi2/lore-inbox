Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVBUUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVBUUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVBUUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:24:26 -0500
Received: from adsl-64-161-106-9.dsl.snfc21.pacbell.net ([64.161.106.9]:64464
	"EHLO eden.trestle.com") by vger.kernel.org with ESMTP
	id S262086AbVBUUX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:23:58 -0500
From: Scott Bronson <bronson@rinspin.com>
To: linux-kernel@vger.kernel.org
Subject: SIOCINQ/SIOCOUTQ and small socket buffers
Date: Mon, 21 Feb 2005 12:26:27 -0800
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zPkGCPO0R5elxza"
Message-Id: <200502211226.27769.bronson@rinspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zPkGCPO0R5elxza
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To try to figure out some buffering problems my network application is having, 
I wrote 2 tiny utilities
  - pwrite connects to a socket and floods it with data until it sleeps
  - pread accepts an incoming connection but never actually reads data.
    It just lets it pile up until the read buffer is full.

Therefore, pwrite will go to sleep once both its write buffer and pread's read 
buffer have filled up.

echo 4096 4096 4096 > /proc/sys/net/ipv4/tcp_rmem
echo 4096 4096 4096 > /proc/sys/net/ipv4/tcp_wmem

Now that I've established a  4K read buffer and a 4K write buffer, pwrite 
should go to go to sleep after writing 8K of data, right?  Except that it 
only manages to write 5K of data before sleeping!


Here is the output from running pread:

bronson@lea:~/linkanywhere/sockbuf/kernel$ ./pread 
waiting on port 1111...
Read buffer is 4096 bytes, with 0 bytes used.        (printed at startup)
Read buffer is 4096 bytes, with 3072 bytes used.   (printed on exit)


And simultaneously running pwrite with 1024-byte writes:

bronson@lea:~/kernel$ ./pwrite 1024
Allocating 1024 bytes for write buffer.
 0: SO_SNDBUF=  4096, SIOCOUTQ=     0:   4096 avail.  Wrote 1024 bytes, 1024 
total.
 1: SO_SNDBUF=  4096, SIOCOUTQ=     0:   4096 avail.  Wrote 1024 bytes, 2048 
total.
 2: SO_SNDBUF=  4096, SIOCOUTQ=  1024:   3072 avail.  Wrote 1024 bytes, 3072 
total.
 3: SO_SNDBUF=  4096, SIOCOUTQ=  2048:   2048 avail.  Wrote 1024 bytes, 4096 
total.
 4: SO_SNDBUF=  4096, SIOCOUTQ=  2048:   2048 avail.  Wrote 1024 bytes, 5120 
total.


Why on earth is it sleeping after only 5K?  According to the SIOC calls, the 
write buffer still had 2048 bytes available, and the read buffer 1024 bytes.  
The kernel claims that there's still 3K of space that can be filled.  So why 
isn't it?

Thanks,

    - Scott


--Boundary-00=_zPkGCPO0R5elxza
Content-Type: text/x-makefile;
  charset="us-ascii";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

COPTS+=-g -Wall -Werror

all: pread pwrite

pread: pread.c
	$(CC) $(COPTS) pread.c -o pread

pwrite: pwrite.c
	$(CC) $(COPTS) pwrite.c -o pwrite

clean:
	rm -f pread pwrite

--Boundary-00=_zPkGCPO0R5elxza
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="pwrite.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pwrite.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/ioctl.h>
#include <linux/sockios.h>


#define HOST "127.0.0.1"
#define PORT 1111


int main (int argc, char **argv)
{
	char *buf;
	int bufsiz;
	int sd, len, err;
	int sndbufsiz, used;
	int count = 0;
	int i;
	struct sockaddr_in sa;

	if(argc == 2) {
		bufsiz = atoi(argv[1]);
	} else {
		bufsiz = BUFSIZ;
	}
	printf("Allocating %d bytes for write buffer.\n", bufsiz);
	buf = malloc(bufsiz);
	if(!buf) {
		perror("malloc");
		exit(1);
	}

	sd = socket(AF_INET, SOCK_STREAM, 0);
	if(sd < 0) {
		perror("socket");
		exit(1);
	}

	memset(&sa, 0, sizeof(sa));
	sa.sin_family = AF_INET;
	sa.sin_addr.s_addr = htonl(INADDR_ANY);
	sa.sin_port = htons(0);

	err = bind(sd, (struct sockaddr*)&sa, sizeof(sa));
	if(err < 0) {
		perror("bind");
		exit(1);
	}

	memset(&sa, 0, sizeof(sa));
	sa.sin_family = AF_INET;
	sa.sin_port = htons(PORT);
	if(!inet_aton(HOST, &sa.sin_addr)) {
		printf("bad address\n");
		exit(1);
	}

	err = connect(sd, (struct sockaddr *)&sa, sizeof(sa));
	if(err < 0) {
		perror("connect");
		exit(1);
	}

	// give the read socket time to collect buffer sizes
	// start hitting it with data.
	sleep(1);

	for(i=0;;i++) {
		len = sizeof(sndbufsiz);
		err = getsockopt(sd, SOL_SOCKET, SO_SNDBUF, &sndbufsiz, &len);
		if(err < 0) {
			perror("getsockopt");
			exit(1);
		}

		err = ioctl(sd, SIOCOUTQ, &used);
		if(err < 0) {
			perror("ioctl SIOCOUTQ");
			exit(1);
		}

		len = write(sd, buf, bufsiz);
		if(len < 0) {
			perror("write");	
		}
		if(len <= 0) {
			exit(0);
		}

		count += len;
		printf("%2i: SO_SNDBUF=%6d, SIOCOUTQ=%6d: %6d avail.  Wrote %d bytes, %d total.\n",
				i, sndbufsiz, used, sndbufsiz - used, len, count);
	}
}


--Boundary-00=_zPkGCPO0R5elxza
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="pread.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pread.c"

/* This program accepts a single connection on PORT but it doesn't read
 * anything.  All the data piles up until the socket buffers are full.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <signal.h>
#include <sys/ioctl.h>
#include <linux/sockios.h>


#define PORT 1111


int rd;


void stats()
{
	int len, err;
	int rcvbufsiz, used;

	len = sizeof(rcvbufsiz);
	err = getsockopt(rd, SOL_SOCKET, SO_RCVBUF, &rcvbufsiz, &len);
	if(err < 0) {
		perror("getsockopt");
		exit(1);
	}

	err = ioctl(rd, SIOCINQ, &used);
	if(err < 0) {
		perror("ioctl SIOCINQ");
		exit(1);
	}

	printf("Read buffer is %d bytes, with %d bytes used.\n",
			rcvbufsiz, used);
}


void sigint()
{
	stats();
	exit(0);
}


int main(int argc, char **argv)
{
	int sd, err;
	struct sockaddr_in addr;

	sd = socket(AF_INET, SOCK_STREAM, 0);
	if(sd<0) {
		perror("socket");
		exit(1);
	}

	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port = htons(PORT);

	err = bind(sd, (struct sockaddr*)&addr, sizeof(addr));
	if(err < 0) {
		perror("bind");
		exit(1);
	}

	err = listen(sd, 5);
	if(err < 0) {
		perror("listen");
		exit(1);
	}

	while(1) {
		printf("waiting on port %d...\n", PORT);

		rd = accept(sd, NULL, NULL);
		if(rd < 0) {
			perror("accept");
			exit(1);
		}

		stats();
		signal(SIGINT, sigint);

		for(;;) {
			sleep(100);
		}
	}
}


--Boundary-00=_zPkGCPO0R5elxza--
