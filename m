Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133033AbQLJVNx>; Sun, 10 Dec 2000 16:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbQLJVNo>; Sun, 10 Dec 2000 16:13:44 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:7182 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132820AbQLJVNf>; Sun, 10 Dec 2000 16:13:35 -0500
Date: Sun, 10 Dec 2000 22:55:52 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.21.0012101646210.1350-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0012102227070.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2000, Tigran Aivazian wrote:

> > user% ./fd-exhaustion   # e.g. while(1) open("/dev/null",...);
> > root# cat /proc/sys/fs/file-nr
> > cat: /proc/sys/fs/file-nr: Too many open files in system
> >
> > The above happens even with increased NR_RESERVED_FILES to 96 [no
> > wonder, get_empty_filp is broken].
>
> no, it is not broken. But your experiment is broken. Don't do cat file-nr
> but compile this C program

Ok, now I understand why you can't see the problem ;) You lookup the
values in user space but I did it [additionally] in kernel space [also
I think I understand what happens ;)]. I guess with the code below you
claim I shouldn't see values like this when file struct allocations
started by user apps,
1024 0 1024

Or 0 shouldn't be between 0 and NR_RESERVED_FILES. Right? Wrong. I saw
it happens, you can reproduce it if you lookup the nr_free_files
value, allocate that much by root, don't release them and
immediately after this start to allocate fd's by user app. Note, if
you already hit nr_files = max_files you won't ever be able to
reproduce the above - but this is a half solution, kernel 2.0 was
fine, get_empty_filp was broke somewhere between 2.0 and 2.1 and it's
still broken. With the patch the functionality is back and also works
the way what the authors of the book mentioned believe ;)

It's quite funny, because before I was also told this is broken but I
couldn't believe it, so I look the code and tested it, the report was
right ...

Still disagree? ;)

	Szaka

> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> int main(int argc, char *argv[])
> {
>         int fd, len;
>         static char buf[2048];
>
>         fd = open("/proc/sys/fs/file-nr", O_RDONLY);
>         if (fd == -1) {
>                 perror("open");
>                 exit(1);
>         }
>         while (1) {
>                 len = read(fd, buf, 1024);
>                 printf("len=%d %s", len, buf);
>                 lseek(fd, 0, SEEK_SET);
>                 sleep(1);
>         }
>         return 0;
> }
>
> and leave it running while doing experiments on the other console. You
> will see that everything is fine -- there is no bug. No wonder you saw the
> bug -- you ignored my 4 emails telling you otherwise :)
>
> Regards,
> Tigran
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
