Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWBRKMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWBRKMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 05:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWBRKMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 05:12:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWBRKL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 05:11:59 -0500
Date: Sat, 18 Feb 2006 02:10:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dada1@cosmosbay.com
Subject: Re: [PATCH 2/2] fix file counting
Message-Id: <20060218021022.6b5fe1ba.akpm@osdl.org>
In-Reply-To: <20060218100629.GQ29846@in.ibm.com>
References: <20060217154147.GL29846@in.ibm.com>
	<20060217154337.GM29846@in.ibm.com>
	<20060217154626.GN29846@in.ibm.com>
	<20060218010414.1f8d6782.akpm@osdl.org>
	<20060218092517.GP29846@in.ibm.com>
	<20060218014529.5f160d39.akpm@osdl.org>
	<20060218100629.GQ29846@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
>  On Sat, Feb 18, 2006 at 01:45:29AM -0800, Andrew Morton wrote:
>  > Dipankar Sarma <dipankar@in.ibm.com> wrote:
>  > >
>  > > 
>  > >  Slight optimization -
>  > > 
>  > >  	if (get_nr_files() >= files_stat.max_files) {
>  > >  		if (capable(CAP_SYS_ADMIN)) {
>  > >  		/*
>  > >  		 * percpu_counters are inaccurate.  Do an expensive check before
>  > >  		 * we go and fail.
>  > >  		 */
>  > >  			if (percpu_counter_sum(&nr_files) >= 
>  > >  						files_stat.max_files)
>  > >  				goto over;
>  > >  		} else 
>  > >  			goto over;
>  > >  	}
>  > 
>  > That changes the behaviour for root.  Maybe you meant !capable(), but that
>  > still changes the behaviour.  I'm all confused.
> 
>  Hmm.. on second thoughts, there is no harm doing the expensive check
>  for both priviledged and non-priviledged user. It will correctly
>  allow non-priviledged users to create the new file provided
>  the fast-path percpu counter value returned was greater than the 
>  slow path per-cpu counter value.

Look closer ;)

	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
		/*
		 * percpu_counters are inaccurate.  Do an expensive check before
		 * we go and fail.
		 */
		if (percpu_counter_sum(&nr_files) >= files_stat.max_files)
			goto over;
	}

