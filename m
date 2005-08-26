Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVHZPZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVHZPZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVHZPZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:25:56 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:23668 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965076AbVHZPZz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bNZW8ZAn/3bFyLtCtvSUaBY6kyCzKwE3wrAuUPDnxisuOe20ZuUDZeIUffCJwrMjXrgOgxc8z3ycQ6RfsWdJKnq8H70LhZGiunkiEHKn4hiYhJ6VTqS32uGm8a0nVd5GUzlNmwTogQ49LSq+/Frl27/lTOCUbNKdGKPxq8R0EwM=
Message-ID: <54315475050826082547323146@mail.gmail.com>
Date: Fri, 26 Aug 2005 17:25:48 +0200
From: Gereon Steffens <gereon.steffens@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: poll() returns EINVAL
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

under what appears to me as weird circumstances, poll() returns EINVAL
where I belive it shouldn't. Here's an example program that
demonstrates the problem both on kernel 2.4 and 2.6 machines:

#include <sys/poll.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX 1025
#define MOD 250

int main(int argc, char**argv)
{
    struct pollfd pfd[MAX] = { { 0 } };

    int i, rc;

    for (i=0; i<MAX; ++i)
    {
        int fd;

        fd = dup(1);

        pfd[i].fd = fd;
        pfd[i].events = POLLOUT;
        pfd[i].revents = 0;
        printf("%d fd: %d\n", i, fd);

        if (i % MOD == 0)
        {
            /* put same fd into set with a check for reading */
            ++i;
            pfd[i].fd = fd;
            pfd[i].events = POLLIN;
            pfd[i].revents = 0;
            printf("%d fd: %d\n", i, fd);
        }

    }

    rc = poll(pfd, MAX, 0);
    printf("poll rc %d errno %d %s\n", rc, errno, strerror(errno));

    return 0;
}

Run this program after the number for file descriptors per process has
been increased to more than 1024, e.g. using "ulimit -n 2000".

Even more weird is the fact than when MAX is defined as 1024 or less,
the failure never happens. If MOD is changed so that less than 4
"duplicate"
fds are in the set, poll() works fine also.

Am I doing something wrong? Why does poll choke on such duplicate fd
to be checked, and why does it do this only when the fd list is longer
than 1024 entries?

Thanks for any insights,

Gereon
