Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132356AbRA2S3C>; Mon, 29 Jan 2001 13:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132376AbRA2S2m>; Mon, 29 Jan 2001 13:28:42 -0500
Received: from www.wen-online.de ([212.223.88.39]:54544 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132356AbRA2S2c>;
	Mon, 29 Jan 2001 13:28:32 -0500
Date: Mon, 29 Jan 2001 19:27:51 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: Chris Evans <chris@scary.beasts.org>, Tony.Young@ir.com, slug@slug.org.au,
        csa@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Disk Performance/File IO per process
In-Reply-To: <Pine.LNX.4.30.0101291723290.27571-100000@fs131-224.f-secure.com>
Message-ID: <Pine.Linu.4.10.10101291845590.1410-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Szabolcs Szakacsits wrote:

> On Mon, 29 Jan 2001, Chris Evans wrote:
> 
> > Stephen Tweedie has a rather funky i/o stats enhancement patch which
> > should provide what you need. It comes with RedHat7.0 and gives decent
> > disk statistics in /proc/partitions.
> 
> Monitoring via /proc [not just IO but close to anything] has the
> features:
>  - slow, not atomic, not scalable
>  - if kernel decides explicitely or due to a "bug" to refuse doing
>    IO, you get something like this [even using a mlocked, RT monitor],
>    procs                    memory    swap          io     system         cpu
>  r  b  w   swpd  free  buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  1  1  27116  1048   736 152832 128 1972 2544   869   44  1812   2  43  55
>  5  0  2  27768  1048   744 153372  52 1308 2668   777   43  1772   2  61  37
>  0  2  1  28360  1048   752 153900 332 564  2311   955   49  2081   1  68  31
> <frozen>
>  1  7  2  28356  1048   752 153708 3936  0  2175 29091  494 27348   0   1  99
>  1  0  2  28356  1048   792 153656 172   0  7166     0  144   838   4  17  80
> 
> In short, monitoring via /proc is unreliable.

Not really unreliable, but definitely with _serious_ latency issues :)
due to taking the mmap_sem.  Acquiring the mmap_sem semaphore can take
a really long time under load.. and sys_brk downs this semaphore first
thing, as does task_mem() and proc_pid_stat()...  If someone has the
mmap_sem you want, and is pushing disk I/O when that disk is saturated,
you are in for a long wait.  This I think is what you see with your
mlocked RT monitor (pretty similar to my mlocked RT monitor I suspect)

In fact, that darn monitor can have a decidedly negative impact on system
performance because it can take an arbitrary task's mana connection and
then fault while throttling it... I think ;-)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
