Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTKXHhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 02:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKXHhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 02:37:36 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:24276 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263612AbTKXHhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 02:37:33 -0500
Message-ID: <3FC1B539.50204@softhome.net>
Date: Mon, 24 Nov 2003 08:37:29 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wuertele <dave-gnus@bfnet.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Do I need kswapd if I don't have swap?
References: <URy0.Sx.3@gated-at.bofh.it>
In-Reply-To: <URy0.Sx.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Can you try 2.6?

   AFAIK 2.4 has no callpath to return ENOMEM to user space. (probably 
in couple of months I will reach this issue on my systems and test it 
completely).

   kswapd is universal process to write-out information to disk - and in 
Linux pages has no any difference as kswapd concerned. It just dumbly 
write them out. If you will disable kswapd - files modified by mean of 
mmap() most likely will never be written back to disk. (Here I am (most 
likely) wrong - probably some of the vm gurus can correct me). That's 
actually why Linux has problems with disk cache and disk cache can 
easily swap the task doing i/o.

   If you want to work-around this situation - enable OOM. it will just 
kill your process instead.


David Wuertele wrote:
> Using 2.4.18 on my 32MB RAM embedded MIPS system, malloc() goes
> bye-bye:
> 
>   /* Malloc as much as possible, then return */
>   #include <stdio.h>
>   #define UNIT 1024		/* one kilobyte */
>   int main ()
>   {
>     unsigned int j, totalmalloc=0, totalwrote=0, totalread=0;
>     while (1) {
>       unsigned char *buf = (unsigned char *) malloc (UNIT);
>       if (!buf) return 0;
>       totalmalloc += UNIT; fprintf (stderr, "%u ", totalmalloc);
>       for (j=0; j<UNIT; j++) buf[j] = j % 256;
>       totalwrote += UNIT; fprintf (stderr, "%u ", totalwrote);
>       for (j=0; j<UNIT; j++) if (buf[j] != (j % 256)) return -1;
>       totalread += UNIT; fprintf (stderr, "%u\n", totalread);
>     }
>   }
> 
> I expected this program to malloc most of my embedded MIPS's 32MB of
> system RAM, then eventually return with a -1 or a -2.  Unfortunately,
> it hangs having finally printed:
> 
>   M26916864
>   W26916864
>   R26916864
> 
> The malloc call isn't even returning.  What could explain that?
> 
> I don't have swap space configured, and I notice several kernel
> threads that I figure might be assuming I have swap.  For example:
> 
>       3 root     S    [ksoftirqd_CPU0]
>       4 root     S    [kswapd]
>       5 root     S    [bdflush]
>       6 root     S    [kupdated]
>       7 root     S    [mtdblockd]
> 
> Do I need any of these if I don't have swap?  Are there any special
> kernel configs I should be doing if I don't have swap?
> 


