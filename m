Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbUKOX3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUKOX3j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKOX2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:28:47 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:44502 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261554AbUKOX0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:26:44 -0500
Message-ID: <41994983.9471C8A1@akamai.com>
Date: Mon, 15 Nov 2004 16:27:47 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davem@redhat.com
CC: linux-kernel@vger.kernel.org, devnet@oss.sgi.com, akpm@osdl.org
Subject: accept behaviour on EMFILE/ENFILE 
Content-Type: multipart/mixed;
 boundary="------------7894B69DEFF544A4C995CC20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7894B69DEFF544A4C995CC20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



    When accept returns EMFILE or ENFILE,
    it also drops a  pending connection.
    You may argue that is corner case, but still
    it can be avoided by code adjustment.

    The example program is attached.

--- linux-2.6.9/net/socket.c    Mon Oct 18 14:53:50 2004
+++ linux/net/socket.c          Mon Nov 15 16:09:37 2004
@@ -362,7 +362,7 @@
  *     but we take care of internal coherence yet.
  */

-int sock_map_fd(struct socket *sock)
+int sock_create_fd(struct socket *sock, struct file **filep)
 {
        int fd;
        struct qstr this;
@@ -372,6 +372,7 @@
         *      Find a file descriptor suitable for return to the user.
         */

+       *filep = NULL;
        fd = get_unused_fd();
        if (fd >= 0) {
                struct file *file = get_empty_filp();
@@ -404,13 +405,36 @@
                file->f_mode = FMODE_READ | FMODE_WRITE;
                file->f_flags = O_RDWR;
                file->f_pos = 0;
-               fd_install(fd, file);
+               *filep = file;
        }

 out:
        return fd;
 }

+static inline void sock_install_fd(struct sock *sock, int fd, struct
file *file)
+{
+       fd_install(fd, file);
+}
+
+static inline void sock_release_fd(struct sock *sock, int fd, struct
file *file)
+{
+       fput(file);
+       put_unused_fd(fd);
+}
+
+int sock_map_fd(struct sock *sock)
+{
+       int fd;
+       struct file *file;
+
+       fd = sock_create_fd(sock, &file);
+       if (fd >= 0)
+               sock_install_fd(sock, fd, file);
+
+       return fd;
+}
+
 /**
  *     sockfd_lookup   -       Go from a file number to its socket slot

  *     @fd: file handle
@@ -1349,6 +1373,8 @@
        struct socket *sock, *newsock;
        int err, len;
        char address[MAX_SOCK_ADDR];
+       int newfd;
+       struct file *newfile;

        sock = sockfd_lookup(fd, &err);
        if (!sock)
@@ -1371,24 +1397,29 @@
         */
        __module_get(newsock->ops->owner);

+       newfd = sock_create_fd(newsock, &newfile);
+       if (newfd < 0) {
+               err = newfd;
+               goto out_release;
+       }
+
        err = sock->ops->accept(sock, newsock, sock->file->f_flags);
        if (err < 0)
-               goto out_release;
+               goto out_fd;

        if (upeer_sockaddr) {
                if(newsock->ops->getname(newsock, (struct sockaddr
*)address, &len, 2)<0) {
                        err = -ECONNABORTED;
-                       goto out_release;
+                       goto out_fd;
                }
                err = move_addr_to_user(address, len, upeer_sockaddr,
upeer_addrlen);
                if (err < 0)
-                       goto out_release;
+                       goto out_fd;
        }

        /* File flags are not inherited via accept() unlike another
OSes. */

-       if ((err = sock_map_fd(newsock)) < 0)
-               goto out_release;
+       sock_install_fd(newsock, newfd, newfile);

        security_socket_post_accept(sock, newsock);

@@ -1396,6 +1427,8 @@
        sockfd_put(sock);
 out:
        return err;
+out_fd:
+       sock_release_fd(newsock, newfd, newfile);
 out_release:
        sock_release(newsock);
        goto out_put;

--------------7894B69DEFF544A4C995CC20
Content-Type: text/plain; charset=us-ascii;
 name="acceptonmaxfd.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acceptonmaxfd.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <errno.h>
#include <string.h>
#include <netinet/in.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <arpa/inet.h>
#include <unistd.h>
/* <pmeda@akamai.com> */

int *diskfds;
int maxdiskfd;
int curdiskfd;
int cfd, sfd, nfd;

void pexit(const char *msg)
{
	perror(msg);
	close(sfd);
	close(cfd);
	close(nfd);
	printf("TEST FAILED\n");
	exit(1);
}

int main(int argc, char *argv[])
{
	struct sockaddr_in myaddr, servaddr, cliaddr;
	int len = sizeof(struct sockaddr_in), yes = 1;
	unsigned short sport;
	int *olddiskfds;

	if (argc < 2) {
		printf("Usage:%s port\n", argv[0]);
		exit(1);
	}
	sport = atoi(argv[1]);

	/* Setup connection */
	cfd = socket(PF_INET, SOCK_STREAM, 0);
	sfd = socket(PF_INET, SOCK_STREAM, 0);
	if (cfd < 0 || sfd < 0)
		pexit("socket");
	memset((void *)&myaddr, sizeof(myaddr), 0);
	memset((void *)&servaddr, sizeof(myaddr), 0);
	memset((void *)&cliaddr, sizeof(myaddr), 0);
	myaddr.sin_port = servaddr.sin_port = htons(sport);
	myaddr.sin_family = servaddr.sin_family = AF_INET;
	myaddr.sin_addr.s_addr = INADDR_ANY; servaddr.sin_addr.s_addr = 0;

	if (bind(sfd, (struct sockaddr *)&myaddr, sizeof(myaddr)) < 0)
		pexit("bind");
	if (setsockopt(sfd, SOL_SOCKET,SO_REUSEADDR,&yes,sizeof(int)) < 0)
		perror("setsockopt");
	if (listen(sfd, 10) < 0)
		pexit("listen");
	if (fcntl(sfd, F_SETFL, O_NONBLOCK) < 0)
		perror("fnctl");
	if (connect(cfd, (struct sockaddr *)&servaddr, len) < 0)
		pexit("connect");
	printf("Client connected to server!\n");

	/* consume fds */
	while (1) {
		if (curdiskfd == maxdiskfd) {
			maxdiskfd = (!maxdiskfd)?1:(maxdiskfd<<1);
			olddiskfds = diskfds;
			if (!(diskfds = (int *)malloc(sizeof(int)*maxdiskfd)))
				pexit("malloc");
			memcpy(diskfds, olddiskfds, (maxdiskfd >> 1));
			free(olddiskfds);
		}
		if ((diskfds[curdiskfd] = open("/dev/null", O_RDONLY)) < 0) {
			printf("Server opened %d diks fds!\n", curdiskfd);
			break;
		}
		curdiskfd++;
	}

	nfd = accept(sfd, (struct sockaddr *)&cliaddr, &len);
	if (nfd < 0) {
		perror("1st accept");
		close(diskfds[--curdiskfd]);
		nfd = accept(sfd, (struct sockaddr *)&cliaddr, &len);
		if (nfd < 0) 
			pexit("2nd accept");
	}
	printf("Server got connection from %s:%d\n", inet_ntoa(cliaddr.sin_addr), cliaddr.sin_port);
	printf("TEST PASSED\n");
	return (0);	
}



--------------7894B69DEFF544A4C995CC20--

