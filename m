Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKTOyG>; Mon, 20 Nov 2000 09:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKTOx6>; Mon, 20 Nov 2000 09:53:58 -0500
Received: from alanke.lnk.telstra.net ([139.130.140.14]:23624 "EHLO
	dog.topology.org") by vger.kernel.org with ESMTP id <S129171AbQKTOxm>;
	Mon, 20 Nov 2000 09:53:42 -0500
Date: Tue, 21 Nov 2000 00:53:04 +1030
From: Alan Kennington <akenning@dog.topology.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Alan Kennington <akenning@dog.topology.org>
Subject: Re: easy-to-fix bug in /dev/null driver
Message-ID: <20001121005304.A15760@dog.topology.org>
Reply-To: akenning@dog.topology.org
In-Reply-To: <20001120160638.A14325@dog.topology.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001120160638.A14325@dog.topology.org>; from akenning@dog.topology.org on Mon, Nov 20, 2000 at 04:06:38PM +1030
X-Homepage: http://www.topology.org
X-PGP-Key: http://www.topology.org/key_ak2.asc
X-PGP-Key-Fingerprint: 8A7B 7A8E 1C02 8298 579F 1860 7D56 121B D363 329E
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, okay, I didn't really make my point persuasively enough.
The file linux/drivers/char/mem.c contains this:

===================================================
static ssize_t write_null(struct file * file, const char * buf,
                          size_t count, loff_t *ppos)
{
        return count;
}
===================================================

Now try this little program:

---------------------------------------------------
#include <stdio.h>
#include <errno.h>
#include <sys/fcntl.h>

main() {
    char buf[1];
    int fd = open("/dev/null", O_RDWR);
    int i;
    for (i = 1; i <= 10; ++i) {
        int ret = write(fd, buf, 429496729 * i);
        if (ret < 0) {
            fprintf(stderr, "i = %d, errno = %d\n", i, errno);
            perror("write");
            }
        }
    } 
---------------------------------------------------

Result is this:

---------------------------------------------------
i = 6, errno = 0
write: Success
i = 7, errno = 0
write: Success
i = 8, errno = 0
write: Success
i = 9, errno = 0
write: Success
i = 10, errno = 6
write: Device not configured 
---------------------------------------------------

To me, it's pretty clear that an error has occurred here.
The error "Device not configured" has _not_ occurred.
So it is an error for the kernel to say that it has!

The cause is obviously that fact that the people who worked out
the input/output types for write(2) didn't allow for the
possibility that someone might really be able to
write 2 GBytes or more at a time.
But this is now becoming credible in some people's computers (not mine).

I.e. whenever anyone tries to write 2 GBytes or more to a device,
they're going to get a negative return value and possibly a positive
errno value - _if_ the device permits such a big chunk to
be written at once, which /dev/null does.
The device might be a 622 Mbit/sec ATM card or something.
That's only about 25 seconds of transmission time.
So it's not unrealistic.

Questions:
Should device drivers in general be written to truncate the
user-space request down to 2 GByte - 1 (2^31 - 1) or less?

Or should the device driver flag such excessive write-calls as erroneous?

I still think that write_null() should be rewritten as:

===================================================
static ssize_t write_null(struct file * file, const char * buf,
                          size_t count, loff_t *ppos)
{
        return (count <= 2147483647) ? count : 2147483647;
}
=================================================== 

This would fix the problem without introducing any new errors.
(Unless someone change the definitions of ssize_t and size_t!!)

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
