Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291970AbSBYVIr>; Mon, 25 Feb 2002 16:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292178AbSBYVIj>; Mon, 25 Feb 2002 16:08:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9107 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291970AbSBYVIZ>;
	Mon, 25 Feb 2002 16:08:25 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Mon, 25 Feb 2002 22:08:06 +0100
Message-ID: <2871.1014671286@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I run:

	Linux nice 2.4.18-pre7 #1 SMP Mon Jan 28 23:12:48 MET 2002 i686 unknown

I noticed that whenever I do:

	setsockopt(fd, SOL_SOCKET, SO_SNDBUF....)

followed by

	getsockopt(fd, SOL_SOCKET, SO_SNDBUF....)

to verify what the kernel has set, I read TWICE as much the amount used
for the set.  That is, if I set 8192, I read 16384.  Therefore, to set
the correct size, I need to half the parameter first.

Is this a known bug?  Is it setsockopt or getsockopt which returns the
wrong size?

Here's sample code demonstrating the problem:

--------------------------
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

static void set_send_buf(int fd, int size)
{
	int new_len;
	int arglen = sizeof(new_len);

	if (-1 == setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &size, sizeof(size)))
		perror("setsockopt");

	if (-1 == getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &new_len, &arglen))
		perror("getsockopt");

	printf("size was %d, but set %d\n", size, new_len);
}

main()
{
	int fd = socket(AF_INET, SOCK_STREAM, 0);

	set_send_buf(fd, 8192);
	set_send_buf(fd, 16384);
}
--------------------------

When run, it displays:

	size was 8192, but set 16384
	size was 16384, but set 32768

Raphael
