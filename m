Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRBXPsi>; Sat, 24 Feb 2001 10:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129418AbRBXPs2>; Sat, 24 Feb 2001 10:48:28 -0500
Received: from s340-modem1815.dial.xs4all.nl ([194.109.167.23]:2432 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S129417AbRBXPsP>;
	Sat, 24 Feb 2001 10:48:15 -0500
Date: Sat, 24 Feb 2001 16:45:04 +0100 (CET)
From: Arjan Filius <iafilius@xs4all.nl>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, <mason@suse.com>
Subject: Re: reiserfs: still problems with tail conversion
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.30.0102241613140.1185-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried Erik's trigger-program.

After some test i thing it's memory related, and it seems to match the
other reports i saw on lkm.
With my 384M ram i was not able te reproduce it.
With "mem=32M" linux hang while starting a test oracle-db.
However i tried (not repeated tests, and after a fresh reboot):
ram=128M	; Triggered
ram=138M	; Triggered
ram=180M	; Triggered
ram=192M	; NOT Triggered
ram=250M	; NOT Triggered
ram=256M	; NOT Triggered

These results say that it memory dependent, and perhaps memory use
dependent.
With the mem=180M i did some additional tests:

reisertest	; triggered
free		; shows only 60M on cached data and 8192 files*8192
		  bytes=64M
/sbin/swapout 100M	; make sure enough cache to hold 64M data
reisertest	; NOT Triggered !!!!
While leaving the data, and executing reisertest in a new dir i'm
triggring it again!

So i think i can say, it's triggerable when the cache has no space to hold
all the data (64M), but i didn't extensive tests.



Running suse7.0+updates
kernel 2.4.2

Greatings,

On Fri, 23 Feb 2001, Erik Mouw wrote:

> Hi all,
>
> I am running linux-2.4.2-pre4 with Chris Mason's tailconversion bug fix
> applied, but I still have problems with null bytes in files. I wrote a
> little test program that clearly shows the problem:
>
>
> /* reisertest.c: test for tailconversion bug in reiserfs
>  *
>  * Compile with: gcc -O2 -o reisertest reisertest.c
>  */
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
>
> #define MAXBYTES	8192
>
> int main(int argc, char *argv[])
> {
> 	int fd;
> 	int i;
> 	char name[32];
> 	char buf[MAXBYTES];
> 	char check[MAXBYTES];
>
> 	memset(buf, 0x55, MAXBYTES);
>
> 	fprintf(stderr, "Creating %d files ... ", MAXBYTES);
>
> 	for(i = 0; i < MAXBYTES; i++) {
> 		sprintf(name, "reiser-%05d.test", i);
> 		fd = open(name, O_WRONLY | O_CREAT, 0644);
> 		write(fd, buf, i);
> 		close(fd);
> 	}
>
> 	fprintf(stderr, "done\n");
> 	fprintf(stderr, "Appending to the files ... ");
>
> 	for(i = 0; i < MAXBYTES; i++) {
> 		sprintf(name, "reiser-%05d.test", i);
> 		fd = open(name, O_WRONLY | O_APPEND);
> 		write(fd, buf, MAXBYTES - i);
> 		close(fd);
> 	}
>
> 	fprintf(stderr, "done\n");
> 	fprintf(stderr, "Checking files for null bytes ...\n");
>
> 	for(i = 0; i < MAXBYTES; i++) {
> 		sprintf(name, "reiser-%05d.test", i);
> 		fd = open(name, O_RDONLY);
> 		read(fd, check, MAXBYTES);
> 		if(memcmp(buf, check, MAXBYTES) != 0)
> 			fprintf(stderr, "  %s contains null bytes\n", name);
> 	}
>
> 	fprintf(stderr, "Checking done\n");
>
> 	return 0;
> }
>
>
> When I run this on a reiserfs partition, I get output like this:
>
>
> erik@arthur:~/reisertest/foo> ../reisertest
> Creating 8192 files ... done
> Appending to the files ... done
> Checking files for null bytes ...
>   reiser-00193.test contains null bytes
>   reiser-00220.test contains null bytes
>   reiser-00256.test contains null bytes
>   reiser-00289.test contains null bytes
>   reiser-00329.test contains null bytes
>   reiser-00338.test contains null bytes
>   reiser-00374.test contains null bytes
>   reiser-00407.test contains null bytes
>   reiser-00415.test contains null bytes
>   reiser-00430.test contains null bytes
>   reiser-00438.test contains null bytes
>   reiser-00445.test contains null bytes
>   reiser-00459.test contains null bytes
>   reiser-00481.test contains null bytes
>   reiser-00501.test contains null bytes
>   reiser-00508.test contains null bytes
>   reiser-00521.test contains null bytes
>   reiser-00534.test contains null bytes
>   reiser-00558.test contains null bytes
>   reiser-00577.test contains null bytes
>   reiser-00583.test contains null bytes
>   reiser-00600.test contains null bytes
>   reiser-00606.test contains null bytes
>   reiser-00612.test contains null bytes
>   reiser-00623.test contains null bytes
>   reiser-00634.test contains null bytes
>   reiser-00645.test contains null bytes
>   reiser-00665.test contains null bytes
>   reiser-00685.test contains null bytes
>   reiser-00730.test contains null bytes
>   reiser-00735.test contains null bytes
>   reiser-00740.test contains null bytes
>   reiser-00745.test contains null bytes
>   reiser-00750.test contains null bytes
>   reiser-00759.test contains null bytes
>   reiser-00764.test contains null bytes
>   reiser-00773.test contains null bytes
>   reiser-00778.test contains null bytes
>   reiser-00787.test contains null bytes
>   reiser-00796.test contains null bytes
>   reiser-00805.test contains null bytes
>   reiser-00814.test contains null bytes
>   reiser-00866.test contains null bytes
>   reiser-00915.test contains null bytes
>   reiser-00930.test contains null bytes
>   reiser-00934.test contains null bytes
>   reiser-00938.test contains null bytes
>   reiser-00942.test contains null bytes
>   reiser-00946.test contains null bytes
>   reiser-00950.test contains null bytes
>   reiser-00954.test contains null bytes
>   reiser-00958.test contains null bytes
>   reiser-00965.test contains null bytes
>   reiser-00969.test contains null bytes
>   reiser-00973.test contains null bytes
>   reiser-00977.test contains null bytes
>   reiser-00984.test contains null bytes
>   reiser-00988.test contains null bytes
>   reiser-00995.test contains null bytes
>   reiser-00999.test contains null bytes
>   reiser-01006.test contains null bytes
>   reiser-01010.test contains null bytes
>   reiser-01017.test contains null bytes
> Checking done
>
>
> Running the test a couple of times doesn't really show a pattern,
> sometimes the same files contains null bytes, sometimes others do. The
> files with null bytes seem to be with index < 1024.
>
> I did the same test with an ext2 filesystem, but didn't see any error.
> System is SuSE 7.0, compiler gcc-2.95.2.
>
>
> Erik
>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl


