Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272953AbRIPWyd>; Sun, 16 Sep 2001 18:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272966AbRIPWyX>; Sun, 16 Sep 2001 18:54:23 -0400
Received: from u-10-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.10]:39301
	"EHLO dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S272953AbRIPWyM>; Sun, 16 Sep 2001 18:54:12 -0400
Date: Mon, 17 Sep 2001 00:52:24 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Matt <matt@bluefishwireless.com>
Cc: linux-kernel@vger.kernel.org, procps-bugs@redhat.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: struct_task->start_time, jiffies or hz_to_std(jiffies)
Message-ID: <20010917005224.B23335@dea.linux-mips.net>
In-Reply-To: <20010913154855.B628@bluefishwireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913154855.B628@bluefishwireless.com>; from matt@bluefishwireless.com on Thu, Sep 13, 2001 at 03:48:55PM +1000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 03:48:55PM +1000, Matt wrote:

> 2.4.9-ac10 linux/kernel/fork.c:658
>         p->start_time = jiffies;
> 
> is this
> 
> 2.4.9-ac10 linux/fs/proc/array.c
>                 task->start_time,
> 
> correct? or should it be
> 		hz_to_std(task->start_time),
> 
> ??
> 
> i know this will affect libproc, however libproc appears to be broken
> anyway; i changed HZ and CLOCKS_PER_SEC to 1024 in include/asm/param.h
> on x86 and top / ps etc are giving me very whacked out numbers.. the
> machine itself is stable however and appears to be working just fine.

Antirely correct; I'll make a patch and send it to Alan in case he doesn't
have this one yet.

A quick grep also shows that kernel accounting also seems to have it's
issues with time granularity.  Bad, accounting date should be portable
between architectures.

Alan, real patch below in case this isn't yet in -ac please apply.

  Ralf

Index: fs/proc/array.c
===================================================================
RCS file: /home/pub/cvs/linux/fs/proc/array.c,v
retrieving revision 1.48
diff -u -r1.48 array.c
--- fs/proc/array.c 2001/08/24 03:38:51 1.48  
+++ fs/proc/array.c 2001/09/16 22:48:28   
@@ -365,7 +365,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		task->start_time,
+		hz_to_std(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
