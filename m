Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUC0ACF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUC0ACF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:02:05 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:46602 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261467AbUC0AB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:01:56 -0500
Date: Sat, 27 Mar 2004 11:01:46 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXT3/JBD] Periodic journal flush not enough?
Message-ID: <20040327000146.GB1017@gondor.apana.org.au>
References: <20040326231958.GA484@gondor.apana.org.au> <20040326154851.7a3ad417.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20040326154851.7a3ad417.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 26, 2004 at 03:48:51PM -0800, Andrew Morton wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > I've encountered a problem with the journal flush timer.  The problem
> > is that when a filesystem is short on space, relying on a timer-based
> > flushing mechanism is no longer adequate.  For example, on my P4 2GHz
> > I can trigger an ENOSPC error by doing
> > 
> > while :; do echo test > a; [ -s a ] || break; rm a; done; echo Out of space
> > 
> > on an ext3 file system with 12Mb of free space using the usual 5s
> > journal flush timer.
> 
> I cannot reproduce this.  Please send more details.  Journalling mode,
> kernel version, etc.

OK.  I can reproduce this under both 2.4.25 and 2.6.4.

To prepare for the test, you need to arrange for an ext3 file system
which is short on space.  In the following example, I'm using one with
around 12Mb of free space.

You'll also need a way to write/delete files quickly.  The above shell
fragment probably doesn't in bash since it's very slow.

So I've attached a C program which does a similar thing.

I've also attached the script output of it running in my VMware machine
running 2.6.4.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--BOKacYhQ+x31HxR3
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="b.c"

#include <unistd.h>
#include <stdio.h>
#include <strings.h>
#include <pwd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
	int fd;
	int cnt = 0;

	while (1) {
		char c = 'x';
		fd = open("a", O_WRONLY|O_CREAT|O_EXCL);
		if (fd < 0) {
			perror("open");
			break;
		}
		if (write(fd, &c, 1) != 1) {
			perror("write");
			break;
		}
		close(fd);
		unlink("a");
		cnt++;
	}
	printf("%d\n", cnt);
	return 0;
}

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=c

Script started on Sun Feb 22 22:08:38 2004
angband:~# df .
Filesystem           1K-blocks      Used Available Use% Mounted on
/devfs/mapper/ren-root
                        253871    241542     12329  96% /
angband:~# /tmp/b
write: No space left on device
21603
angband:~# exit

Script done on Sun Feb 22 22:08:51 2004

--BOKacYhQ+x31HxR3--
