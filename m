Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131129AbQKTGMI>; Mon, 20 Nov 2000 01:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131268AbQKTGL6>; Mon, 20 Nov 2000 01:11:58 -0500
Received: from alanke.lnk.telstra.net ([139.130.140.14]:20036 "EHLO
	dog.topology.org") by vger.kernel.org with ESMTP id <S131129AbQKTGLy>;
	Mon, 20 Nov 2000 01:11:54 -0500
Date: Mon, 20 Nov 2000 16:06:38 +1030
From: Alan Kennington <akenning@dog.topology.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Alan Kennington <akenning@dog.topology.org>
Subject: easy-to-fix bug in /dev/null driver
Message-ID: <20001120160638.A14325@dog.topology.org>
Reply-To: akenning@dog.topology.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Homepage: http://www.topology.org
X-PGP-Key: http://www.topology.org/key_ak2.asc
X-PGP-Key-Fingerprint: 8A7B 7A8E 1C02 8298 579F 1860 7D56 121B D363 329E
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that this code in linux/drivers/char/mem.c
is a bug:

===================================================
static ssize_t write_null(struct file * file, const char * buf,
                          size_t count, loff_t *ppos)
{
        return count;
}
===================================================

To activate the bug try this little program:

---------------------------------------------------
#include <stdio.h>
#include <errno.h>
#include <sys/fcntl.h>

main() {
    char buf[1];
    int fd = open("/dev/null", O_RDWR);
    int i;
    printf("fd = %d\n", fd);
    for (i = 1; i <= 10; ++i) {
        int ret = write(fd, buf, -i);
        if (ret < 0) {
            fprintf(stderr, "i = %d, errno = %d\n", i, errno);
            perror("write");
            }
        }
    } 
---------------------------------------------------

On my legacy 2.4.0-test1-ac21 system, I get this:

---------------------------------------------------
fd = 3
i = 1, errno = 1
write: Operation not permitted
i = 2, errno = 2
write: No such file or directory
i = 3, errno = 3
write: No such process
i = 4, errno = 4
write: Interrupted system call
i = 5, errno = 5
write: Input/output error
i = 6, errno = 6
write: Device not configured
i = 7, errno = 7
write: Argument list too long
i = 8, errno = 8
write: Exec format error
i = 9, errno = 9
write: Bad file descriptor
i = 10, errno = 10
write: No child processes
---------------------------------------------------

You could argue that user-space users shouldn't do such stupid
things, but in some contexts, the bug might be hard to find,
and having wrong error messages just makes such bugs hard to find.
Arguably, write() should not be defined to return the count of
written bytes when this is impossible for very large writes.
I.e. it is the definition of the user-space write() function which
is meaningless for large counts - so why bother to permit this
if a negative error code is returned when this is attempted?

Perhaps more correct code for the write_null function would be:

===================================================
static ssize_t write_null(struct file * file, const char * buf,
                          size_t count, loff_t *ppos)
{
	if ((ssize_t)count >= 0)
		return (ssize_t)count;
	else
        	return 0x7fffffff;
}
===================================================

....with preferably a symbol instead of 0x7fffffff.

Cheers,
Alan Kennington.

--------------------------------------------------------------------
    name: Dr. Alan Kennington
  e-mail: akenning@dog.topology.org
 website: http://topology.org/
    city: Adelaide, South Australia
  coords: 34.88051 S, 138.59334 E
timezone: UTC+1030 http://topology.org/timezone.html
 pgp-key: http://topology.org/key_ak2.asc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
