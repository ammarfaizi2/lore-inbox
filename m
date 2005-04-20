Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVDTI1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVDTI1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDTI1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:27:18 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:33492 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261469AbVDTI1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:27:02 -0400
X-ORBL: [67.124.119.21]
Date: Wed, 20 Apr 2005 01:26:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050420082655.GA2756@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org> <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org> <42660B6B.6040600@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <42660B6B.6040600@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2005 at 04:57:31PM +0900, Takashi Ikebe wrote:

> hmm.. most internet base services will use TCPv4 TCPv6 SCTP...
> AF_UNIX can not use as inter-nodes communication.

You can send file descriptors (the actually file descriptors
themselves, not their contents) to another process over a socket.

A nearly ten-year old example is attached (ie. this isn't new or
magical or specific to Linux).


--XsQoSWH+UP9D9v3l
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sendfd.c"

/* sendfd.c - v. crude example of passing fds */

/*
 * I tested this on HPUX10 using gcc -D_XOPEN_SOURCE_EXTENDED sendfd.c -lxnet
 *
 * Expected output is "hello world"
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>

/* Note: msg_control may be msg_accrights, etc. */

int sendfd(int conn, int fd)
{
    size_t len = sizeof(struct cmsghdr) + sizeof(int);
    struct cmsghdr *hdr = (struct cmsghdr *)malloc(len);
    struct msghdr msg;
    int rc;

    hdr->cmsg_len = len;
    hdr->cmsg_level = SOL_SOCKET;
    hdr->cmsg_type = SCM_RIGHTS;
    *(int *)CMSG_DATA(hdr) = fd;

    msg.msg_name = NULL;
    msg.msg_namelen = 0;
    msg.msg_iov = NULL;
    msg.msg_iovlen = 0;
    msg.msg_control = hdr;
    msg.msg_controllen = len;

    rc = sendmsg(conn, &msg, 0);
    free(hdr);
    return rc;
}

int recvfd(int conn)
{
    size_t len = sizeof(struct cmsghdr) + sizeof(int);
    struct cmsghdr *hdr = (struct cmsghdr *)malloc(len);
    struct msghdr msg;
    int rc;

    msg.msg_iov = NULL;
    msg.msg_iovlen = 0;
    msg.msg_control = hdr;
    msg.msg_controllen = len;

    rc = recvmsg(conn, &msg, 0);

    if (rc >= 0 
	&& hdr->cmsg_len == len 
	&& hdr->cmsg_level == SOL_SOCKET 
	&& hdr->cmsg_type == SCM_RIGHTS)
    {
	int fd = *(int *)CMSG_DATA(hdr);
	free(hdr);
	return fd;
    }

    free(hdr);
    return -1;
}

int main()
{
    int fds[2];
    int fd = -1;
    int rc = socketpair(AF_UNIX, SOCK_STREAM, 0, fds);
    pid_t pid;

    if (rc)
    {
	perror("socketpair");
	return 1;
    }

    /* punt */
    system("echo hello world >testfile");

    switch (pid = fork())
    {
    case 0:
	// open this in the child proc
	fd = open("testfile",O_RDONLY);
	if (fd < 0)
	    perror("open(testfile)");
	rc = sendfd(fds[1], fd);
	if (rc)
	    perror("sendfd");
	_exit(0);
    case -1:
	perror("fork");
	return 1;
    default:
	waitpid(pid,NULL,0);
    }

    fd = recvfd(fds[0]);

    if (fd < 0)
    {
	perror("recvfd");
	return 1;
    }

    close(fds[0]);
    close(fds[1]);

    dup2(fd,0);
    close(fd);
    execl("/bin/cat","cat",NULL);
}

--XsQoSWH+UP9D9v3l--
