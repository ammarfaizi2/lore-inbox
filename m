Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293301AbSCFOJz>; Wed, 6 Mar 2002 09:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293527AbSCFOJp>; Wed, 6 Mar 2002 09:09:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25729 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293301AbSCFOJY>; Wed, 6 Mar 2002 09:09:24 -0500
Date: Wed, 6 Mar 2002 09:08:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Subject: Re: execve() fails to report errors
In-Reply-To: <20020305233437.GA130@elf.ucw.cz>
Message-ID: <Pine.LNX.3.95.1020306090414.31541A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Pavel Machek wrote:

> Hi!
> 
> Take this trivial .c program. Obviously correct.
> 
> 
> struct foo {
>         char fill[1*1024*1024*1024];
> };
> 
> struct foo a;
> 
> void
> main(void)
> {
> }
> 
> Compile. Run. Segfault.
> 
> Whose fault? Kernels; it fails to corectly report not enough address
> space.

I think the bug has to be found earlier on up the food chain.
If you do:


char a[1*1024*1024*1024] = {0,};


int main(void);
int main()
{
    return 0;
}


The linker will run forever, un-killable...

      gcc -o xxx xxx.c 
     0     0 31478 31466   9   0    752   280 wait4       S    1  0:00
      /usr/local/lib/gcc-lib/i686-pc-linux-gnu/egcs-2.91.66/collect2
      -m elf_i386 -dynamic-linke
     0     0 31479 31478  14   0 1050176 255184 lock_page   D    1  0:23
      /usr/local/i686-pc-linux-gnu/bin/ld -m elf_i386 -dynamic-linker
      /lib/ld-linux.so.2 -o xxx

I can kill the top-level, but the task in lock_page runs forever, paging
to swap-file like crazy.

The output file grew to 1 gb, then stopped.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

