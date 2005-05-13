Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVEMBTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVEMBTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVEMBTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:19:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36795 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262221AbVEMBLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 21:11:03 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, ericvh@gmail.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
References: <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
	 <a4e6962a0505120623645c0947@mail.gmail.com>
	 <20050512151631.GA16310@mail.shareable.org>
	 <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1115946620.6248.299.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 May 2005 18:10:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 11:51, Miklos Szeredi wrote:
> > > I'm not sure passing directory file descriptors is the right semantic
> > > we want - but at least it provides a point of explicit control (in
> > > much the same way as a bind).  Are you sure the clone + open("/") +
> > > pass-to-parent scenario you allows the parent to traverse the child's
> > > private name space through that fd?
> > 
> > Pretty sure.
> 
> Yup.  Attached a little program that can be used to try this out.  It
> creates a new namespace in the child, does a bind mount (so the
> namespaces can be differentiated), then sends the file descriptor of
> "/" to the parent.  The parent does fchdir(fd), then starts a shell.


> So the result is that CWD is under the child namespace, while root is
> under the initial namespace.
> 

r u sure, this program works? Sorry if I am saying something dumb here.
Correct me.  When a file descriptor is sent from one process to other,
arn't they referring to different files in each of the processes.
fd=5 may be pointing to file 'xyz' in parent process, 
where as fd=5 will be pointing to 'abc' in the child process.  

This program did not work for me, and I was wondering if adding
CLONE_FILES in clone() would help. Because that would make sure
 that both
the processes share the same file descriptor. It did not work too.

What am I understanding wrong?

In any case my opinion is if this program works than the hole should
be closed instead of exploting it to access different namespace. I 
know Jamie is going to pounce at me. ;)

RP



> I also tried bind mounting from the child's namespace to the parent's,
> and that works too.  But the new mount's mnt_namespace is copied from
> the old, which makes the mount un-removable.  This is most likely not
> intentional, IOW a bug.
> 
> Miklos
> 
> === newns.c =========================================================
> #define _GNU_SOURCE
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <sched.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/un.h>
> #include <sys/socket.h>
> 
> static int socks[2];
> 
> static int send_fd(int sock_fd, int fd)
> {
>     int retval;
>     struct msghdr msg;
>     struct cmsghdr *p_cmsg;
>     struct iovec vec;
>     char cmsgbuf[CMSG_SPACE(sizeof(fd))];
>     int *p_fds;
>     char sendchar = 0;
> 
>     msg.msg_control = cmsgbuf;
>     msg.msg_controllen = sizeof(cmsgbuf);
>     p_cmsg = CMSG_FIRSTHDR(&msg);
>     p_cmsg->cmsg_level = SOL_SOCKET;
>     p_cmsg->cmsg_type = SCM_RIGHTS;
>     p_cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
>     p_fds = (int *) CMSG_DATA(p_cmsg);
>     *p_fds = fd;
>     msg.msg_controllen = p_cmsg->cmsg_len;
>     msg.msg_name = NULL;
>     msg.msg_namelen = 0;
>     msg.msg_iov = &vec;
>     msg.msg_iovlen = 1;
>     msg.msg_flags = 0;
>     /* "To pass file descriptors or credentials you need to send/read at
>      * least one byte" (man 7 unix) */
>     vec.iov_base = &sendchar;
>     vec.iov_len = sizeof(sendchar);
>     while ((retval = sendmsg(sock_fd, &msg, 0)) == -1 && errno == EINTR);
>     if (retval != 1) {
>         perror("sending file descriptor");
>         return -1;
>     }
>     return 0;
> }
> 
> static int receive_fd(int fd)
> {
>     struct msghdr msg;
>     struct iovec iov;
>     char buf[1];
>     int rv;
>     int connfd = -1;
>     char ccmsg[CMSG_SPACE(sizeof(connfd))];
>     struct cmsghdr *cmsg;
> 
>     iov.iov_base = buf;
>     iov.iov_len = 1;
> 
>     msg.msg_name = 0;
>     msg.msg_namelen = 0;
>     msg.msg_iov = &iov;
>     msg.msg_iovlen = 1;
>     /* old BSD implementations should use msg_accrights instead of
>      * msg_control; the interface is different. */
>     msg.msg_control = ccmsg;
>     msg.msg_controllen = sizeof(ccmsg);
> 
>     while(((rv = recvmsg(fd, &msg, 0)) == -1) && errno == EINTR);
>     if (rv == -1) {
>         perror("recvmsg");
>         return -1;
>     }
>     if(!rv) {
>         /* EOF */
>         return -1;
>     }
> 
>     cmsg = CMSG_FIRSTHDR(&msg);
>     if (!cmsg->cmsg_type == SCM_RIGHTS) {
>         fprintf(stderr, "got control message of unknown type %d\n",
>                 cmsg->cmsg_type);
>         return -1;
>     }
>     return *(int*)CMSG_DATA(cmsg);
> }
> 
> int childfn(void *p)
> {
>     int fd;
> 
>     (void) p;
>     mkdir("/tmp/clonetest", 755);
>     mkdir("/tmp/clonetest/dir1", 755);
>     mkdir("/tmp/clonetest/dir1/subdir1", 755);
>     mkdir("/tmp/clonetest/mnt", 755);
>     system("mount --bind /tmp/clonetest/dir1 /tmp/clonetest/mnt");
>     fd = open("/", O_RDONLY | O_DIRECTORY);
>     send_fd(socks[0], fd);
>     sleep(1000);
>     return 1;
> }
> 
> int main()
> {
>     char buf[10000];
>     pid_t pid;
>     int res;
>     int childfd;
> 
>     res = socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
>     if (res == -1) {
>         perror("socketpair");
>         return 1;
>     }
> 
>     pid = clone(childfn, buf+5000, CLONE_NEWNS | SIGCHLD, NULL);
>     if ((int) pid == -1) {
>         perror("clone");
>         exit(1);
>     }
> 
>     childfd = receive_fd(socks[1]);
>     res = fchdir(childfd);
>     if (res == -1) {
>         perror("fchdir");
>         return 1;
>     }
>     execl("/bin/bash", "/bin/bash", NULL);
>     
>     return 0;
> }

