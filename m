Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129738AbQK3Nik>; Thu, 30 Nov 2000 08:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129776AbQK3NiV>; Thu, 30 Nov 2000 08:38:21 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:8466 "EHLO
        finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
        id <S129738AbQK3NiM>; Thu, 30 Nov 2000 08:38:12 -0500
From: "John Meikle" <linux@procom.demon.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Using map_user_kiobuf()
Date: Thu, 30 Nov 2000 13:07:37 -0000
Message-ID: <NEBBIIEABDPEIPKIJFDOEEAMDGAA.linux@procom.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experimenting with a module that returns data to either a user
space programme or another module.  A memory area is passed in, and the data
is written to it.  Because the memory may be allocated either by a module or
a user programme, a kiobuf seemed a good way of representing it.  A layer
converts user memory to a kiobuf using map_user_kiobuf().

To test if it would work, I wrote a short test that passed 1,000,000 bytes
of memory to a module that wrote a pattern into the memory.  The pattern was
checked in the user programme to ensure it worked.

The test does work in so much as the pattern checks okay, but kernel memory
appears to be corrupted.  Trying to run gcc dies with a segmentation
violation, and the output of "ps" has the command names replaced with time
strings ("00:00:00" or "00:00:05").  X won't shut down properly, and
Ctrl-Alt-Del fails to reboot.

The code in the module (without validation and error checking) is:

int test_kiobuf(char* buf)
{
    struct kiobuf *iobuf;
    int i;

    alloc_kiovec(1, &iobuf);
    map_user_kiobuf(WRITE, iobuf, buf, TEST_SIZE);

    for (i = 0 ; i < iobuf->length; i++)
    {
        int off = iobuf->offset + i;
        int page = off / 4096;
        unsigned char* buf = page_address(iobuf->maplist[page]);
        buf[off % 4096] = (i & 0xFF);
    }

    unmap_kiobuf(iobuf);
    free_kiovec(1, &iobuf);
    return 0;
}

The user space programme is:

#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>

#define TEST_SIZE 1000000

int main(int argc, char *argv[])
{
    int fh;
    int i;
    unsigned char * buf;

    buf = (unsigned char *)malloc(TEST_SIZE);

    fh = open("/tmp/test", O_CREAT);

    if (ioctl(fh, 99, buf) != 0)
        perror("ioctl failed");
    else
    {
        for (i = 0; i < TEST_SIZE; i++)
        {
            if (buf[i] != (i & 0xFF))
                printf("%8.8X: %2.2X %2.2X\n", i, i & 0xFF, buf[i]);
        }
    }

    close(fh);
    free(buf);

    return 0;
}

If I change the user programme to initialise the memory to zero everything
works okay.  It also works if I use copy_to_user() to write a single byte in
each page at the beginning of the module code.

This is using kernel 2.4.0-test9.

Does anyone know what I am doing wrong?


John Meikle.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
