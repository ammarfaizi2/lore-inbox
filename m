Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131523AbQLJRWG>; Sun, 10 Dec 2000 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbQLJRV4>; Sun, 10 Dec 2000 12:21:56 -0500
Received: from 62-6-231-238.btconnect.com ([62.6.231.238]:43781 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131523AbQLJRVq>;
	Sun, 10 Dec 2000 12:21:46 -0500
Date: Sun, 10 Dec 2000 16:53:24 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.30.0012101803390.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012101646210.1350-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> user% ./fd-exhaustion   # e.g. while(1) open("/dev/null",...);
> root# cat /proc/sys/fs/file-nr
> cat: /proc/sys/fs/file-nr: Too many open files in system
> 
> The above happens even with increased NR_RESERVED_FILES to 96 [no
> wonder, get_empty_filp is broken].

no, it is not broken. But your experiment is broken. Don't do cat file-nr
but compile this C program
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
        int fd, len;
        static char buf[2048];

        fd = open("/proc/sys/fs/file-nr", O_RDONLY);
        if (fd == -1) {
                perror("open");
                exit(1);
        }
        while (1) {
                len = read(fd, buf, 1024);
                printf("len=%d %s", len, buf);
                lseek(fd, 0, SEEK_SET);
                sleep(1);
        }
        return 0;
}

and leave it running while doing experiments on the other console. You
will see that everything is fine -- there is no bug. No wonder you saw the
bug -- you ignored my 4 emails telling you otherwise :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
