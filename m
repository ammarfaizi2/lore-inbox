Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315830AbSETKM0>; Mon, 20 May 2002 06:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315808AbSETKMZ>; Mon, 20 May 2002 06:12:25 -0400
Received: from mail.zmailer.org ([62.240.94.4]:54687 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S315860AbSETKMX>;
	Mon, 20 May 2002 06:12:23 -0400
Date: Mon, 20 May 2002 13:12:22 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH]: adding counters to count bytes read/written
Message-ID: <20020520131222.K9955@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0205201506240.14394-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 03:09:36PM +0530, Manik Raina wrote:
> Hi Linus,
> 
> 	This patch adds 2 counters to the task_struct for
> 	counting how many bytes were read/written using
> 	the read()/write() system calls. 
> 
> 	These counters may be useful in determining how
> 	many IO requests are made by each process.

  These are defined as UINTegers, are you sure that is appropriate type ?
  What to do when they will overflow ?  For short term activity tracking 
  they may be ok (4GB/200 MB/sec = 20 sec to wrap around), but for accounting
  the overflow might not be liked thing..

  For short-term IO-activity tracking they may indeed make sense, but I
  would add another pair of counters to assist on that tracking.  Namely
  "values at the end of previous interval", which are maintained by the
  activity tracking code.

  Reading one byte at the time won't grow those counters very fast, but will
  cause massive amounts of syscalls, and context switches, so tracking data
  amount alone isn't good enough.

....
> diff -u -r ../temp/linux-2.5.12/include/linux/sched.h ./include/linux/sched.h
> --- ../temp/linux-2.5.12/include/linux/sched.h	Wed May  1 05:38:47 2002
> +++ ./include/linux/sched.h	Mon May 20 09:25:32 2002
> @@ -315,6 +315,7 @@
>  	int link_count, total_link_count;
>  	struct tty_struct *tty; /* NULL if no tty */
>  	unsigned int locks; /* How many file locks are being held */
> +	unsigned int bytes_written, bytes_read;
>  /* ipc stuff */
>  	struct sysv_sem sysvsem;
>  /* CPU-specific state of this task */

/Matti Aarnio
