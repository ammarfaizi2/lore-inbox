Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTK0L5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTK0L5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:57:25 -0500
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:44965 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S264488AbTK0L5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:57:21 -0500
From: Akinobu Mita <mita@miraclelinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [BUG 2.4] NFS unlocking operation accesses invalid file struct
Date: Thu, 27 Nov 2003 20:54:22 +0900
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200311252000.32094.mita@miraclelinux.com> <shs1xrwvudw.fsf@charged.uio.no>
In-Reply-To: <shs1xrwvudw.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311272054.22316.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Trond.

but, your patch causes memory leak.


# gcc leak.c -o leak -lpthread
# find /usr -type f -exec ./leak {} \; &
# while true; do sleep 1; grep file_lock_cache /proc/slabinfo;done

-- leak.c --
#include <strings.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>

int process_B(void *arg)
{
        int i, ret;
	struct stat stat;
	int fd = *(int *)arg;
        struct flock lck;

	if ((ret = fstat(fd, &stat)) < 0) {
		perror("fstat");
		return ret;
	}
	for (i = 0; i < stat.st_size/2; i++) {
		lck.l_type = F_RDLCK;
		lck.l_whence = 0;
		lck.l_start = 2*i;
		lck.l_len = 1;
		if ((ret = fcntl(fd, F_SETLK, &lck)) < 0) {
			perror("fcntl");
			return ret;
		}
	}
	return 0;
}

int main(int argc, char **argv)
{
        int p, ret;
        pthread_t tid;

        p = open(argv[1], O_RDWR);
        if (p < 0) {
                perror("open");
                exit(1);
        }
        pthread_create(&tid, NULL, process_B, &p);
	pthread_join(tid, NULL);
        if ((ret = close(p)) < 0)
                perror("close");
        exit(0);
}
----

it seems that your another patch could not avoid the race completely.

Cheers,
--
Akinobu Mita



On Wednesday 26 November 2003 09:35, Trond Myklebust wrote:
> >>>>> " " == Akinobu Mita <mita@miraclelinux.com> writes:
>      > Does anyone have a idea of how to fix it ?
>
> Yes. I posted a patch about a week or 2 ago. The original patch can be
> found on
>
>  
> http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1/linux-2.4.23-01-p
>osix_race.dif
>
> However, I now believe the real problem here is that
> locks_remove_posix() should also be checking the pid (as is done in
> all the other POSIX locking checks by calling locks_same_owner()).
>
> It is wrong for locks_remove_posix() to be deleting locks that don't
> belong to this pid... Note: this bug exists in 2.6.x. too, although
> there it does not cause an Oops...
>
> Cheers,
>   Trond
>
> --- linux-2.4.23-rc1/fs/locks.c.orig	2003-11-16 19:30:53.000000000 -0500
> +++ linux-2.4.23-rc1/fs/locks.c	2003-11-25 19:34:02.000000000 -0500
> @@ -1746,7 +1746,8 @@
>  	lock_kernel();
>  	before = &inode->i_flock;
>  	while ((fl = *before) != NULL) {
> -		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
> +		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner &&
> +				fl->fl_pid == current->pid) {
>  			locks_unlock_delete(before);
>  			before = &inode->i_flock;
>  			continue;

