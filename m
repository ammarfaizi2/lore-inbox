Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSK1Qhh>; Thu, 28 Nov 2002 11:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSK1Qhh>; Thu, 28 Nov 2002 11:37:37 -0500
Received: from pc-62-31-66-70-ed.blueyonder.co.uk ([62.31.66.70]:36739 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S265675AbSK1Qhf>; Thu, 28 Nov 2002 11:37:35 -0500
Date: Thu, 28 Nov 2002 16:44:39 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021128164439.E2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no> <1038387522.31021.188.camel@ixodes.goop.org> <20021127150053.A2948@redhat.com> <15845.10815.450247.316196@charged.uio.no> <20021127205554.J2948@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021127205554.J2948@redhat.com>; from sct@redhat.com on Wed, Nov 27, 2002 at 08:55:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Nov 27, 2002 at 08:55:54PM +0000, Stephen C. Tweedie wrote:
 
> Having said that, the server is clearly in error in sending a
> duplicate cookie in the first place, and if it did so we'd never get
> into such a state.

And it's ext3's fault.  Reproducer below.  Run the attached readdir
against an htree directory and you get something like:

[root@host1 htest]# ~sct/test/fs/readdir 
getdents at f_pos 0000000000000000 returned 4084.
getdents at f_pos 0X0000000B753BE7 returned 4080.
getdents at f_pos 0X000000158C4C61 returned 4080.
getdents at f_pos 0X00000021E86BDC returned 4080.
getdents at f_pos 0X0000002D60F25D returned 4080.
getdents at f_pos 0X00000037BC95D7 returned 4096.
getdents at f_pos 0X000000434E2AA3 returned 4080.
getdents at f_pos 0X0000004EF11AE6 returned 4080.
getdents at f_pos 0X000000596EBC2F returned 4080.
getdents at f_pos 0X00000065A76668 returned 4080.
getdents at f_pos 0X0000007060CF8B returned 4080.
getdents at f_pos 0X0000007B9213FA returned 1464.
getdents at f_pos 0X0000007B9213FA returned 0.
Final f_pos is 0X0000007B9213FA.
[root@host1 htest]# 

The problem is that the htree readdir code is not updating f_pos after
returning the very last chunk of data to the caller.  That doesn't
hurt most callers because the location is cached in the filp->private
data, but it really upsets NFS.

--Stephen

--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="readdir.c"

#define _LARGEFILE64_SOURCE
#include <assert.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <sys/fcntl.h>
#include <sys/stat.h>
#include <sys/vfs.h>
#include <sys/resource.h>

#include <linux/types.h>
#include <linux/unistd.h>
#include <linux/dirent.h>
_syscall3(int, getdents, uint, fd, struct dirent *, dirp, uint, count);
 
void try(const char *what, int err)
{
	if (!err)
		return;
	fprintf (stderr, "Unexpected result %d.  %s: %s\n",
		 err, what, strerror(errno));
	exit(1);
}

int test_readdir(int fd)
{
	loff_t offset;
	char dirbuf[4096];
	int res;

	offset = lseek64(fd, 0, SEEK_CUR);
	res = getdents(fd, (struct dirent *)dirbuf, sizeof(dirbuf));
	printf("getdents at f_pos %#016llX returned %d.\n", offset, res);
	return res;
}

int main()
{
	int fd;
	int res;
	loff_t offset;
	
	fd = open64(".", O_RDONLY, 0);
	try ("open \".\"", fd < 0);

	do {
		res = test_readdir(fd);
	} while (res > 0);

	offset = lseek64(fd, 0, SEEK_CUR);
	printf("Final f_pos is %#016llX.\n", offset);
	return 0;
}

--24zk1gE8NUlDmwG9--
