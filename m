Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVHOHfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVHOHfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVHOHfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:35:55 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:23570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932112AbVHOHfz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:35:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ehlvwbez+2QWFPeKDQCqNQQJeFWER6KII7lOVREsCXtFKm2CLGiTkkHjW9PKFVeqrKkAjOH22qU8NHBsYF8xLnBfCZyHB7mUXuoUAAvzTwSLELHdY2uKuPiVlSPGBCpUaL8lccZqJAtw+9ccpwMYAhvpqa5/3ddaWbrY4bPDTCA=
Message-ID: <398d69300508150035246230af@mail.gmail.com>
Date: Mon, 15 Aug 2005 15:35:49 +0800
From: Xuekun Hu <xuekun.hu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lockmeter: fix lock counter roll over issue
Cc: raybry@sgi.com, akpm@osdl.org
In-Reply-To: <398d69300508132100327e3712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <398d69300508132100327e3712@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have inputs?

On 8/14/05, Xuekun Hu <xuekun.hu@gmail.com> wrote:
> When I collected lockmeter data for a longer duration, sometimes the
> locks counter could roll over. I'm sure someone else maybe meet the
> same situation. So I wrote the below patch, could you have a look?
> 
> diff -Nraup linux/include/linux/lockmeter.h
> linux.lockmeter/include/linux/lockmeter.h
> --- linux/include/linux/lockmeter.h     2005-08-09 10:46:53.302083832 +0800
> +++ linux.lockmeter/include/linux/lockmeter.h   2005-08-05
> 17:22:37.000000000 +0800
> @@ -150,7 +150,7 @@ typedef struct {
>        uint32_t    max_wait_ww_ticks;  /* max wait time writer vs writer  */
>                                        /* prev 2 only used for write locks*/
>        uint32_t    acquire_time;       /* time lock acquired this CPU     */
> -       uint32_t    count[LSTAT_ACT_MAX_VALUES];
> +       uint64_t    count[LSTAT_ACT_MAX_VALUES];
>  } lstat_lock_counts_t;
> 
>  typedef lstat_lock_counts_t    lstat_cpu_counts_t[LSTAT_MAX_STAT_INDEX];
> @@ -167,7 +167,7 @@ typedef lstat_lock_counts_t lstat_cpu_co
>  #define LSTAT_MAX_READ_LOCK_INDEX 1000
>  typedef struct {
>        POINTER     lock_ptr;            /* address of lock for output stats */
> -       uint32_t    read_lock_count;
> +       uint64_t    read_lock_count;
>        int64_t     cum_hold_ticks;       /* sum of read lock hold times over */
>                                          /* all callers. ....................*/
>        uint32_t    write_index;          /* last write lock hash table index */
> 
> I also modified lockstat to compliant with this modification against
> lockstat 1.4.11 version.
> 
> diff -Nraup lockstat/include/linux/lockmeter.h
> lockstat.fix/include/linux/lockmeter.h
> --- lockstat/include/linux/lockmeter.h  2004-09-14 07:02:05.000000000 +0800
> +++ lockstat.fix/include/linux/lockmeter.h      2005-08-05 17:38:46.000000000 +0800
> @@ -150,7 +150,7 @@ typedef struct {
>        uint32_t    max_wait_ww_ticks;  /* max wait time writer vs writer  */
>                                        /* prev 2 only used for write locks*/
>        uint32_t    acquire_time;       /* time lock acquired this CPU     */
> -       uint32_t    count[LSTAT_ACT_MAX_VALUES];
> +       uint64_t    count[LSTAT_ACT_MAX_VALUES];
>  } lstat_lock_counts_t;
> 
>  typedef lstat_lock_counts_t    lstat_cpu_counts_t[LSTAT_MAX_STAT_INDEX];
> @@ -167,7 +167,7 @@ typedef lstat_lock_counts_t lstat_cpu_co
>  #define LSTAT_MAX_READ_LOCK_INDEX 1000
>  typedef struct {
>        POINTER     lock_ptr;            /* address of lock for output stats */
> -       uint32_t    read_lock_count;
> +       uint64_t    read_lock_count;
>        int64_t     cum_hold_ticks;       /* sum of read lock hold times over */
>                                          /* all callers. ....................*/
>        uint32_t    write_index;          /* last write lock hash table index */
> diff -Nraup lockstat/lockstat.c lockstat.fix/lockstat.c
> --- lockstat/lockstat.c 2004-09-14 07:01:41.000000000 +0800
> +++ lockstat.fix/lockstat.c     2005-08-09 10:35:18.305356776 +0800
> @@ -36,7 +36,7 @@ static char lockstat_version[]  = "1.4.1
>  #include <stdlib.h>
>  #include <string.h>
>  #include <errno.h>
> -#include <sys/time.h>
> +#include <time.h>
>  #include <linux/lockmeter.h>
> 
>  extern void    closeFiles(void);
> @@ -267,7 +267,7 @@ typedef enum        {Null_Entry, Spin_Entry, RL
> 
>  typedef struct {
>        lstat_lock_counts_t  counts;
> -       uint32_t        total;
> +       uint64_t        total;
>        double          contention;
>        double          persec;
>        double          utilization;
> @@ -999,7 +999,8 @@ add_counts(lock_summary_t *sump, lstat_l
>  int
>  sum_counts(lock_summary_t *sump, entry_type_enum entry_type)
>  {
> -       int             total, i, j;
> +       int             i, j;
> +       uint64_t        total;
>        double  contention;
>        double  utilization;
> 
> @@ -1171,7 +1172,7 @@ print_lock(char *name, lock_summary_t *s
>        float mean_hold_time, max_hold_time;
>        float wait_time, mean_wait_time, max_wait_time, mean_wait_ww_time,
> max_wait_ww_time;
>        double temp_time;
> -       uint32_t total_spin_count = 0;
> +       uint64_t total_spin_count = 0;
> 
>        print_header();
> 
> @@ -1317,7 +1318,7 @@ print_lock(char *name, lock_summary_t *s
>        }
> 
>        /* following done for ALL types of locks, except as indicated */
> -       printf(" %9d", sump->total);
> +       printf(" %20ld", sump->total);
>        print_percentage('
> ',100.0*(double)sump->counts.count[LSTAT_ACT_NO_WAIT]/(double)sump->total,0);
>        print_percentage('
> ',100.0*(double)sump->counts.count[LSTAT_ACT_SPIN]/(double)sump->total,0);
>        if (entry_type == WLspin_Entry) {
> @@ -1325,7 +1326,7 @@ print_lock(char *name, lock_summary_t *s
>                                 ')');
>        }
>  #ifdef notyet
> -       printf("%9d", sump->counts.count[LSTAT_ACT_SLEPT]);
> +       printf("%20ld", sump->counts.count[LSTAT_ACT_SLEPT]);
>  #endif
>        if (entry_type == Spin_Entry) {
>                /* We only see these for spinlock_t, and even then it's rare. */
> 
> Any comments?
>
