Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316294AbSELBlQ>; Sat, 11 May 2002 21:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSELBlO>; Sat, 11 May 2002 21:41:14 -0400
Received: from elin.scali.no ([62.70.89.10]:43015 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S316294AbSELBlK>;
	Sat, 11 May 2002 21:41:10 -0400
Date: Sun, 12 May 2002 03:41:07 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Linux Kernel malinglist <linux-kernel@vger.kernel.org>
cc: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Strange problem with /proc/ksyms
In-Reply-To: <Pine.LNX.4.30.0205120313590.24933-100000@elin.scali.no>
Message-ID: <Pine.LNX.4.30.0205120336590.24933-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Steffen Persvold wrote:

> Hi guys,
>
> I've discovered this wierd problem with /proc/ksyms on RedHat's
> 2.4.18-4smp (i686 build) for 7.3. The thing is that with utilities like
> 'cat' and 'grep' it seems like the whole list isn't showing :
>
> [root@puma1 root]# uname -a
> Linux puma1.office.scali.no 2.4.18-4smp #1 SMP Thu May 2 18:32:34 EDT 2002 i686 unknown
>
> [root@puma1 root]# grep del_timer /proc/ksyms
> [root@puma1 root]# grep printk /proc/ksyms
> c011c870 printk_Rsmp_1b7d4074
>
> [root@puma1 root]# cat /proc/ksyms >cat_test
> [root@puma1 root]# ls -l cat_test
> -rw-r--r--    1 root     root        28519 May  4 02:48 cat_test
>
>
> But if I use 'dd', all of it is listed :
>
> [root@puma1 root]# dd if=/proc/ksyms of=dd_test
> 149+1 records in
> 149+1 records out
> [root@puma1 root]# ls -l dd_test
> -rw-r--r--    1 root     root        76683 May  4 02:49 dd_test
> [root@puma1 root]# grep printk dd_test
> c011c870 printk_Rsmp_1b7d4074
> c03d9488 tux_Dprintk_Rsmp_a12c9a12
> c03d9484 tux_TDprintk_Rsmp_c0ce7778
> [root@puma1 root]# grep del_timer dd_test
> c0124900 del_timer_Rsmp_fc62f16d
> c0124960 del_timer_sync_Rsmp_daff266a
>
>
> What could this be ? Buffering issues ? I haven't seen this on a stock
> 2.4.18 kernel.
>


Hmm, I've tested some more with 'dd' and different bs sizes, and I found
the following :

[root@puma2 root]# dd bs=1024 if=/proc/ksyms of=dd_test
70+1 records in
70+1 records out
[root@puma2 root]# ls -l dd_test
-rw-r--r--    1 root     root        72586 May  4 03:09 dd_test

[root@puma2 root]# dd bs=4095 if=/proc/ksyms of=dd_test
1+17 records in
1+17 records out
[root@puma2 root]# ls -l dd_test
-rw-r--r--    1 root     root        72586 May  4 03:10 dd_test

[root@puma2 root]# dd bs=4096 if=/proc/ksyms of=dd_test
0+6 records in
0+6 records out
[root@puma2 root]# ls -l dd_test
-rw-r--r--    1 root     root        24422 May  4 03:10 dd_test


So you can see, the moment I go to 4k (and above) of buffer space the
output gets truncated. Ideas ?

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

