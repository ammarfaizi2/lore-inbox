Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVGLKN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVGLKN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVGLKN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:13:56 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:18615 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261282AbVGLKNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:13:55 -0400
Date: Tue, 12 Jul 2005 12:10:34 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050712121034.3f0e84c8@localhost>
In-Reply-To: <20050712103811.0087a7e3@localhost>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
	<20050712103811.0087a7e3@localhost>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__12_Jul_2005_12_10_34_+0200_/wqGGXCRzc93jbxu"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Tue__12_Jul_2005_12_10_34_+0200_/wqGGXCRzc93jbxu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 12 Jul 2005 10:38:11 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> The particular case you analized (blocking connect interrupted by a
> SA_RESTART signal) is interesting... and since SUSV3 says
> 	"but the connection request shall not be aborted, and the
> 	connection shall be established asynchronously" (with select()
> 	or poll()...)
> both for EINPROGRESS and EINTR, I think it's quite stupit to
> automatically restart it and then return EALREADY.
> 
> The logically correct behaviur with blocking connect interrupted and
> then restarted should be to continue the blocking wait... IHMO.

it seems that Linux is doing the Right Thing... see the attached
program...

$ make
gcc -O2 -Wall -o conntest connect_test.c


FROM ANOTHER CONSOLE: this is needed to block connect()...
# iptables -A OUTPUT -p tcp --dport 3500 -m state --state NEW -j DROP


$ ./conntest WITHOUT_SA_RESTART
connect(): errno = 4		# EINTR, as expected
Cannot setup client!


$ ./conntest	# connect is restarted after SIGALRM, and then it blocks again


FROM ANOTHER CONSOLE:
# iptables -D OUTPUT -p tcp --dport 3500 -m state --state NEW -j DROP


and then "conntest" (thanks to TCP protocol retries) will terminate.



:-)

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64

--Multipart_Tue__12_Jul_2005_12_10_34_+0200_/wqGGXCRzc93jbxu
Content-Type: text/x-csrc; name=connect_test.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=connect_test.c

#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netinet/tcp.h>
#include <signal.h>
#include <unistd.h> 

void sighandler(int sig)
{
	/* nothing :) */
}

int setup_alarm_handler(int flags)
{
	struct sigaction sa = {
		.sa_handler = &sighandler,
		.sa_flags = flags
	};
	return sigaction(SIGALRM, &sa, NULL);
}

int setup_server(int port)
{
	int sock;
	struct sockaddr_in sa = {
		.sin_family = AF_INET,
		.sin_port = htons(port),
		.sin_addr.s_addr = htonl(INADDR_ANY)
	};

	if ((sock=socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
		goto error;
	if (bind(sock, (struct sockaddr*)&sa, sizeof(sa)) < 0)
		goto error_clean;
	if (listen(sock, 16) < 0)
		goto error_clean;
	return sock;

 error_clean:
	close(sock);
 error:
	return -1;
}

int setup_client(const char *server, int port)
{
	int sock;
	struct sockaddr_in sa = {
		.sin_family = AF_INET,
		.sin_port = htons(port),
		.sin_addr.s_addr = inet_addr(server)
	};

	if ((sock=socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
		goto error;
	if (connect(sock, (struct sockaddr*)&sa, sizeof(sa)) < 0) {
		printf("connect(): errno = %d\n", errno);
		goto error_clean;
	}
	return sock;

 error_clean:
	close(sock);
 error:
	return -1;
}

int main(int argc, char *argv[])
{
	int server, client;
	int flags = SA_RESTART;

	if (argc > 1)
		flags = 0;

	if (setup_alarm_handler(flags))
		return 1;
	
	server = setup_server(3500);
	if (server < 0) {
		printf("Cannot setup server!\n");
		return 1;
	}
	alarm(1);
	client = setup_client("127.0.0.1", 3500);
	if (client < 0) {
		printf("Cannot setup client!\n");
		return 1;
	}
	printf("Ok!\n");
	return 0;
}

--Multipart_Tue__12_Jul_2005_12_10_34_+0200_/wqGGXCRzc93jbxu
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=Makefile

Y29ubnRlc3Q6IGNvbm5lY3RfdGVzdC5jCglnY2MgLU8yIC1XYWxsIC1vICRAICQ8Cg==

--Multipart_Tue__12_Jul_2005_12_10_34_+0200_/wqGGXCRzc93jbxu--
