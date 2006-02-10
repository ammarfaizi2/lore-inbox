Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWBJLqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWBJLqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBJLqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:46:17 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:59099 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1751080AbWBJLqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:46:16 -0500
To: linux-kernel@vger.kernel.org
Subject: [IPv6 since 2.6.12] connect() without bind() can't time out.
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Message-Id: <200602102045.HEI44709.SGNtSLVOtOFMJFPYM@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.50]
X-Accept-Language: ja,en
Date: Fri, 10 Feb 2006 20:45:55 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I think timer check for TCP's "connect() without bind()" for IPv6
doesn't work when no local port is available.

I can run the following program for 2.4.30, 2.4.31, 2.4.32 and 2.6.11.
But I can't run it for 2.6.12 and later (including 2.6.16-rc2).

The stream socket enters to SYN_SENT state. But when there is no free
port in the range defined by /proc/sys/net/ipv4/ip_local_port_range,
the connect() call sleeps forever; even after some ports became free.

Other operations such as TCP's "bind() with port = 0",
UDP's "bind() with port = 0", UDP's "connect() without bind()",
UDP's "sendto() without bind()" return immediately
when no free port is available.

---- Start of code. -----
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <signal.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

static void Test(unsigned short int port) {
	int i = 0;
	for (i = 0; ; i++) {
		const int fd = socket(AF_INET6, SOCK_STREAM, 0);
		struct sockaddr_in6 addr;
		socklen_t size = sizeof(addr);
		memset(&addr, 0, sizeof(addr));
		addr.sin6_family = AF_INET6;
		addr.sin6_addr = in6addr_loopback;
		addr.sin6_port = htons(port);
		printf("i=%d\n", i); fflush(stdout);
		if (connect(fd, (struct sockaddr *) &addr, sizeof(addr))) break;
		if (getsockname(fd, (struct sockaddr *) &addr, &size)) {
			printf("getsockname() failed.\n"); break;
		}
	}
	printf("IPv6/TCP connect port exhausted at %d\n", i); fflush(stdout);
}
	
int main(int argc, char *argv[]) {
	FILE *fp = fopen("/proc/sys/net/ipv4/ip_local_port_range", "r");
	int original_range[2], narrow_range[2] = { 32768, 32768 + 100 };
	if (!fp || fscanf(fp, "%u %u", &original_range[0], &original_range[1]) != 2) {
		fprintf(stderr, "Can't open /proc/sys/net/ipv4/ip_local_port_range .\n");
		exit(1);
	}
	fclose(fp);
	if ((fp = fopen("/proc/sys/net/ipv4/ip_local_port_range", "w")) == NULL) {
		fprintf(stderr, "Can't open /proc/sys/net/ipv4/ip_local_port_range .\n");
		exit(1);
	}
	fprintf(fp, "%d %d\n", narrow_range[0], narrow_range[1]);
	fclose(fp);
	{
		struct sockaddr_in6 addr;
		socklen_t size = sizeof(addr);
		pid_t pid;
		const int listener = socket(AF_INET6, SOCK_STREAM, 0);
		unsigned short int port;
		memset(&addr, 0, sizeof(addr));
		addr.sin6_family = AF_INET6;
		addr.sin6_addr = in6addr_any;
		addr.sin6_port = htons(0);
		bind(listener, (struct sockaddr *) &addr, sizeof(addr));
		getsockname(listener, (struct sockaddr *) &addr, &size);
		port = ntohs(addr.sin6_port);
		listen(listener, 512);
		if ((pid = fork()) == 0) {
			while (1) {
				size_t size = sizeof(addr);
				const int fd = accept(listener, (struct sockaddr *) &addr, &size);
				fprintf(stderr, "accept=%d\n", fd);
			}
		}
		close(listener);
		Test(port);
		kill(pid, SIGHUP);
	}
	if ((fp = fopen("/proc/sys/net/ipv4/ip_local_port_range", "w")) == NULL) {
		fprintf(stderr, "Can't open /proc/sys/net/ipv4/ip_local_port_range .\n");
		exit(1);
	}
	fprintf(fp, "%d %d\n", original_range[0], original_range[1]);
	fclose(fp);
	printf("Done.\n");
	return 0;
}
---- End of code. -----

Regards.
