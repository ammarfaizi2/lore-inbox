Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbUKQSNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbUKQSNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUKQSM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:12:27 -0500
Received: from hera.kernel.org ([63.209.29.2]:12240 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262434AbUKQSIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:08:46 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: AF_UNIX sockets: strange behaviour
Date: Wed, 17 Nov 2004 10:11:43 -0800
Organization: Open Source Development Lab
Message-ID: <20041117101143.6a3b7af6@zqx3.pdx.osdl.net>
References: <Pine.GSO.4.33.0411171618260.8987-100000@horus.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1100714922 25567 172.20.1.73 (17 Nov 2004 18:08:42 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 17 Nov 2004 18:08:42 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 16:29:14 +0100 (CET)
Catalin Drula <Catalin.Drula@imag.fr> wrote:

> Hi,
> 
> I have a small application that communicates over Bluetooth. I use
> connection-oriented UNIX domain sockets (AF_UNIX, SOCK_STREAM) to
> communicate between the applications's threads. When reading from
> one of these sockets, I get a strange behaviour: if I read all the
> bytes that are available (13, in this case) all at once, it's fine;
> however, if I try to read in two smaller batches (say, first time
> 6, and second time 7), the first read returns (with the 6 bytes), but
> the second read never returns.
> 
> As far as I know, this is not expected behaviour for SOCK_STREAM sockets.
> I tried looking into the problem so I instrumented net/unix/af_unix.c to
> see what is going on. More specifically, I was focusing on the function
> unix_stream_recvmsg. Here is what I noticed:
> 
>   - there is a skb in the sk_receive_queue with a len of 13
>   - 6 bytes are read from it
>   - a skb with the remaining 7 bytes is requeued in sk_receive_queue
>   - on the next call to unix_stream_recvmsg, the sk_receive_queue is
> empty (!)
> 
> Thus, this confirms the behaviour observed from userspace. Is this a bug?
> Who could be removing the skb from the receive_queue?
> 
> Thanks for any ideas/suggestions,
> 
> Catalin
>

See the following, it doesn't seem to be a problem (this is on 2.6.10-rc2)

/* Unix domain socket buffer test */
#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/un.h>

static void client(const char *path, const char *msg) {
	int s, len = strlen(msg);
	static struct sockaddr_un sun = { .sun_family = AF_UNIX };
	
	s = socket(AF_UNIX, SOCK_STREAM, 0);
	if (s < 0) { perror("socket"); return; }

	strncpy(sun.sun_path, path, sizeof(sun.sun_path));
	if (connect(s, (struct sockadr *)&sun, sizeof(sun)) < 0) {
		perror("connect");
		return;
	}
	
	if (write(s, msg, len) != len)
		perror("write");
	close(s);
}


static void server(int s) {
	struct sockaddr_un nsun;
	int len = sizeof(nsun);
	int ns = accept(s, (struct sockaddr *) &nsun, &len);
	int cc;
	char buf[3];

	if (ns < 0) {
		perror("accept");
		return;
	}

	while ((cc = read(ns, buf, sizeof(buf))) > 0) 
		write(1, buf, cc);

	putchar('\n');

	if (cc < 0)
		perror("read request");

	if (write(ns, "done", 4) != 4)
		perror("write response");
}

int main(int argc, char **argv) {
	int s;
	static struct sockaddr_un sun = { .sun_family = AF_UNIX };

	if (argc != 3) { fprintf(stderr, "Usage: udtest name message\n"); return 1; }
	
	s = socket(AF_UNIX, SOCK_STREAM, 0);
	if (s < 0) { perror("socket"); return 1; }

	strncpy(sun.sun_path, argv[1], sizeof(sun.sun_path));
	if (bind(s, (struct sockaddr *) &sun, sizeof(sun)) < 0) {
		perror("bind"); return 1;
	}

	listen(s, 1);

	if (fork() == 0) {
		close(s);
		client(sun.sun_path, argv[2]);
	} else {
		server(s);
		close(s);
		unlink(sun.sun_path);
	}
	return 0;
}

