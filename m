Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTILOAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTILOAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:00:19 -0400
Received: from [139.30.44.2] ([139.30.44.2]:19418 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261696AbTILOAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:00:12 -0400
Date: Fri, 12 Sep 2003 16:00:05 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tabris <tabris@tabris.net>
cc: lkml <linux-kernel@vger.kernel.org>, <bero@arklinux.org>,
       <saint@arklinux.org>, Alan Cox <alan@redhat.com>
Subject: Re: Jiffies_64 for 2.4.22-ac
In-Reply-To: <200309120035.28720.tabris@tabris.net>
Message-ID: <Pine.LNX.4.33.0309121541180.21331-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Tabris wrote:

> I took Tim Schmielau's jiffies_64 patch, and ported it to -ac
>
> currently running on my machine here.
> comments? did i screw up horribly?

see my comments below:


> +#define get_uidle_64()     get_64bits(&(init_tasks[0]->times.tms_utime),\
> +                                      &uidle_msb_flips)
> +#define get_sidle_64()     get_64bits(&(init_tasks[0]->times.tms_stime),\
> +                                      &sidle_msb_flips)

for -ac this needs to be

+#define get_uidle_64()     get_64bits(&(init_task.times.tms_utime),\
+                                      &uidle_msb_flips)
+#define get_sidle_64()     get_64bits(&(init_task.times.tms_stime),\
+                                      &sidle_msb_flips)


> +	check_one(init_tasks[0]->times.tms_utime, &uidle_msb_flips);
> +	check_one(init_tasks[0]->times.tms_stime, &sidle_msb_flips);

ditto


+#define get_uidle_64()     (init_tasks[0]->times.tms_utime)
+#define get_sidle_64()     (init_tasks[0]->times.tms_stime)

ditto


> -	unsigned long uptime;
> -	unsigned long idle;
> +	u64 uptime, idle;
>  	int len;

the declaration
	unsigned long uptime_remainder, idle_remainder;
is missing


>  #if HZ!=100
>  	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -		uptime / HZ,
> -		(((uptime % HZ) * 100) / HZ) % 100,
> -		idle / HZ,
> -		(((idle % HZ) * 100) / HZ) % 100);
> +		(unsigned long) uptime,
> +		uptime_remainder,
> +		(unsigned long) idle / HZ,
> +		idle_remainder);

since we're in the HZ!=100 branch, this needs to be

+               (uptime_remainder * 100) / HZ,
+               (unsigned long) idle,
+               (idle_remainder * 100) / HZ);



I wonder it actually compiled, but otherwise it looks good.

Tim

