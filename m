Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292444AbSCDQD4>; Mon, 4 Mar 2002 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292408AbSCDQDr>; Mon, 4 Mar 2002 11:03:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:29705 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S292429AbSCDQDh>; Mon, 4 Mar 2002 11:03:37 -0500
From: Vitaly Fertman <vitaly@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: bug report
Date: Mon, 4 Mar 2002 19:04:31 +0300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_JZHGH3TTY8CDL6XZDLCM"
Message-Id: <20020304160345Z292429-889+117297@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_JZHGH3TTY8CDL6XZDLCM
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit


Hi all,

a problem occured while testing our mkreiserfs utility with different
blocksizes. Now we have the following situation:

ioctl (fd, BLKGETSIZE, &size) returns 5735142 of 512-byte blocks.

1. mkreiserfs /dev/hdf8 --block-size 1024
no problem, block count == 2867571

2. mkreiserfs /dev/hdf8 --blocksize 2048(or 4096)
no problem, block count == 1433785 (or 716892)

3. mount /dev/hdf8, umount

4. mkreiserfs /dev/hdf8 --blocksize 1024(or 2048)
block count == 2867567 (or 1433783), it is a bit different!

ioctl (fd, BLKGETSIZE, &size) always returns the same result,
but we just cannot read the last 3k bytes. 

The small program (attached) shows interesting results also.

After 

1. mkreiserfs /dev/hdf8 --block-size 1024
2. mount/umount

lseek64 SEEK_END to 2936392704
lseek64 to 2936392704
read a byte
lseek64 to 2936392192
read a byte
lseek64 to 2936391680
read a byte
lseek64 to 2936391168
read a byte
lseek64 to 2936390656
read a byte
lseek64 to 2936390144
read a byte
lseek64 to 2936389632
read a byte
lseek64 to 2936389120
read a byte
lseek64 to 2936388608
read a byte
lseek64 to 2936388096
read a byte
lseek64 to 2936387584
read a byte
lseek64 to 2936387072
read a byte

After 

1. mkreiserfs /dev/hdf8 --block-size 2048/4096
2. mount/umount

lseek64 SEEK_END to 2936392704
lseek64 to 2936392704
read a byte
lseek64 to 2936392192
cannot read Input/output error
lseek64 to 2936391680
cannot read Input/output error
lseek64 to 2936391168
cannot read Input/output error
lseek64 to 2936390656
cannot read Input/output error
lseek64 to 2936390144
cannot read Input/output error
lseek64 to 2936389632
cannot read Input/output error
lseek64 to 2936389120
read a byte
lseek64 to 2936388608
read a byte
lseek64 to 2936388096
read a byte
lseek64 to 2936387584
read a byte
lseek64 to 2936387072
read a byte

kernels 2.5.3, 2.4.18.

-- 

Thanks,
Vitaly Fertman
--------------Boundary-00=_JZHGH3TTY8CDL6XZDLCM
Content-Type: text/plain;
  charset="koi8-r";
  name="read_last_bytes.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="read_last_bytes.c"

#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64

#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>

int main ()
{
    char ch;
    loff_t res;
    int fd;
    loff_t offset;
    int i;

    offset = (unsigned long)5735142 * 512;

    fd = open ("/dev/hdf8", O_RDONLY);

    res = lseek64 (fd, 0, SEEK_END);
    if (res < 0) {
        printf ("cannot lseek64 %m\n");
        return 1;
    } else {
        printf ("lseek64 SEEK_END to %Lu\n", res);
    }

    for (i = 0; i < 12; i++) {
        res = lseek64 (fd, offset, SEEK_SET);
        if (res < 0) {
            printf ("cannot lseek64 to %Lu", offset);
	    return 1;
        } else {
            printf ("lseek64 to %Lu\n", res);
        }

        if (read (fd, &ch, 1) < 0) {
            printf ("cannot read %m\n");
//            return 1;
        } else {
            printf ("read a byte\n");
        }

        offset -= 512;
    }

    return 0;
}

--------------Boundary-00=_JZHGH3TTY8CDL6XZDLCM--
