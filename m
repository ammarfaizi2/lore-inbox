Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVHYJF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVHYJF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVHYJF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:05:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23204 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964888AbVHYJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:05:57 -0400
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
	atomic_t
From: Arjan van de Ven <arjan@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <430D8518.8020502@cosmosbay.com>
References: <20050824214610.GA3675@localhost.localdomain>
	 <1124956563.3222.8.camel@laptopd505.fenrus.org>
	 <430D8518.8020502@cosmosbay.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 11:05:44 +0200
Message-Id: <1124960744.3222.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 10:45 +0200, Eric Dumazet wrote:
> This patch removes filp_count_lock spinlock, used to protect files_stat.nr_files.
> 
> Just use atomic_t type and atomic_inc()/atomic_dec() operations.
> 
> This patch assumes that atomic_read() is a plain {return v->counter;} on all 
> architectures. (keywords : sysctl, /proc/sys/fs/file-nr, proc_dointvec)
> 

this patch adds atomic ops where there were none before
>  static inline void file_free(struct file *f)
> @@ -70,7 +62,7 @@
>  	/*
>  	 * Privileged users can go above max_files
>  	 */
> -	if (files_stat.nr_files >= files_stat.max_files &&
> +	if (atomic_read(&files_stat.nr_files) >= files_stat.max_files &&
>  				!capable(CAP_SYS_ADMIN))
>  		goto over;
>  

here 

> @@ -94,10 +86,10 @@
>  
>  over:
>  	/* Ran out of filps - report that */
> -	if (files_stat.nr_files > old_max) {
> +	if (atomic_read(&files_stat.nr_files) > old_max) {
>  		printk(KERN_INFO "VFS: file-max limit %d reached\n",
>  					files_stat.max_files);
> -		old_max = files_stat.nr_files;
> +		old_max = atomic_read(&files_stat.nr_files);
>  	}
>  	goto fail;

and here

for those architectures that need atomics for read (parisc? arm?)

however.. wouldn't it be better to make this a per cpu variable for
write, and for read iterate or do something smart otherwise?


