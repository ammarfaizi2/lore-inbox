Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRCANlM>; Thu, 1 Mar 2001 08:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRCANkx>; Thu, 1 Mar 2001 08:40:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129584AbRCANkk>; Thu, 1 Mar 2001 08:40:40 -0500
Date: Thu, 1 Mar 2001 08:39:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ivan Stepnikov <iv@spylog.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv>
Message-ID: <Pine.LNX.3.95.1010301082536.9591A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Ivan Stepnikov wrote:

>             Hello!
> 
> I tried to test linux memory allocation. For experiment I used i386
> architecture with Pentium III processor, 512M RAM and 8G swap space. For
> memory allocation libhoard was tried. Linux kernel 2.4.2 with patch
> per-process-3.5G-IA32-no-PAE-1, at
> /pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre5/ on
> ftp.kernel.org (This patch should force memory allocation for one process up
> to 3.5G approximately).
> 
> When I try large blocks (about 256K - 1M) everything was ok. More then 3G
> memory was successfully allocated.
> 
> On small blocks result was significantly worse. About 2.3 - 2.4G was
> allocated and system hanged. But it was possible to switch between  local
> consoles, and to receive ping replay by network. Actually it's only one sign
> of life (hard disk didn't work and it was impossible to reboot the machine
> by correct methods). At /var/log/messages was
> 
> Feb 28 17:08:55 zetta kernel: <ed.
> Feb 28 17:08:55 zetta kernel: __alloc_pages: 0-order allocation failed.
> Feb 28 17:09:05 zetta last message repeated 363 times
> 
> 
> 
> Test program looks like this:
> 
> 
> 
> block = 1024;
> 
> for (i=1; ; ++i ){
> 
>                 if(p==malloc(block)){
> 
>                         perror("failed");
> 
>                         fprintf(stderr,"Error! Size total:%uM pass:
> %u\n",size/1024/1024,i);
> 
>                         return 0;
> 
>                 }
> 
>                 size += block;
> 
>                 printf("Size total:%uM pass: %u\n",size/1024/1024,i);
> 
> }
> 
> 

This program does not allocate memory. It only tests to see if the
value returned from malloc() was equal to whatever is in variable "p".

No assignment was made. Further, for allocation to occur, an allocated
memory area has to be accessed. In some memory management systems,
the allocated area has to be actually written (demand zero paging).

If you execute from a user account, not root, with ulimits enabled,
you should be able to do:

        char *p;

	for(;;)
        {
            if((p = (char *) malloc(WHATEVER)) == NULL)
            {
                 puts("Out of memory");
                 exit(1);
            }
            *p = (char) 0x01;    /* Write to memory */
        }

      ... without hanging the system.

If you insist upon running without ulimits, from the root account,
you get what you asked for.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


