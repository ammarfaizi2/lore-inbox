Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVH2N3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVH2N3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVH2N3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 09:29:52 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:65065 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751057AbVH2N3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 09:29:51 -0400
Date: Mon, 29 Aug 2005 15:29:47 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20050829132947.GA21255@harddisk-recovery.com>
References: <002501c5ac93$6ef754c0$106215ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501c5ac93$6ef754c0$106215ac@realtek.com.tw>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 08:15:43PM +0800, colin wrote:
> I wrote a simple program to test direct io, and found that there are some
> strange behaviors of it on "ext3".
> My simple program is below. Assume that the executable file name is
> "directio". If I do the following:
>     1. cp directio aaa
>     2. ./directio directio aaa
> 
> The size of aaa is about the same with directio. This is wrong.

No, it's right, but it's not what you expected.

> It should be 3 times the size of directio because there are 2 write
> operations and one lseek to the file end.

I suggest to strace() your program to see what happens.

> If the second file is not opened with "O_DIRECT", the result is correct.
> 
> What's the problem of direct io? I found that if I remove the instruction of
> lseek, the result is correct.

There are four prerequisites for direct IO:
- the file needs to be opened with O_DIRECT
- the buffer needs to be page aligned (hint: use getpagesize() instead
  of assuming that a page is 4k
- reads and writes need to happen *in* multiples of the soft block size
- reads and writes need to happen *at* multiples of the soft block size

> Is there any problem of lseek when doing direct io on ext3?
> My platform is 2.6.11.

There is no problem.

> Regards,
> Colin
> 
> #define _GNU_SOURCE
> 
> #include <stdio.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <stdlib.h>

Compile your program with -Wall, you're missing quite some include
files over here.

> int main(int argc, char **argv) {
> 
> int fd1, fd2, count;
> char *ptr1, *ptr2;
> 
> if(argc == 3) {
>   fd1 = open(argv[1], O_RDONLY | O_DIRECT, S_IRWXU);
>   fd2 = open(argv[2], O_RDWR | O_CREAT | O_DIRECT);
> } else {
>   printf("Error syntax\n");
>   exit(1);
> }
> printf("%d\n", lseek(fd2, 0, SEEK_END));

Make that lseek(fd2, 4 * 4096, SEEK_SET);

> ptr1 = malloc(4096 + 4096-1);
> ptr2 = (void*)((int)ptr1 - (int)ptr1 % 4096 + 4096);

Use memalign() or posix_memalign().

> do {
>   count = read(fd1, ptr2, 4096);
>   if(!count)
>     break;

And what happens when count < 0 ?

>   write(fd2, ptr2, 4096);
>   write(fd2, ptr2, 4096);

Check return values.

> } while(count > 0);
> 
> free(ptr1);
> close(fd1);
> close(fd2);

return 0;

> }

With the changes, the result is:

erik@arthur:/tmp > ls -l directio aaa
-rwxr-xr-x  1 erik erik 49152 2005-08-29 15:26 aaa*
-rwxr-xr-x  1 erik erik 12628 2005-08-29 15:26 directio*


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
