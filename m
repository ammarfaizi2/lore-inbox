Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWDCJSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWDCJSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWDCJSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:18:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50315 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751689AbWDCJSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:18:20 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mitchell Blank Jr <mitch@sfgoth.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1 core_sys_select incompatible pointer types 
In-reply-to: Your message of "Mon, 03 Apr 2006 02:09:16 MST."
             <20060403020916.57c9eaec.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Apr 2006 19:18:12 +1000
Message-ID: <26766.1144055892@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Mon, 3 Apr 2006 02:09:16 -0700) wrote:
>Mitchell Blank Jr <mitch@sfgoth.com> wrote:
>>  I posted a patch to fix this and another problem with the recent select
>>  changes a couple days ago.
>> 
>>  Original version, with description:
>>    http://lkml.org/lkml/2006/3/31/308
>>  Slightly updated:
>>    http://lkml.org/lkml/2006/3/31/316
>> 
>>  I'm hoping that Andrew picked it up.
>
>Nope.  I queued up the below.  If anything additional is needed, please
>resend.
>
>
>diff -puN fs/select.c~select-warning-fixes fs/select.c
>--- devel/fs/select.c~select-warning-fixes	2006-04-01 22:27:14.000000000 -0800
>+++ devel-akpm/fs/select.c	2006-04-01 22:28:50.000000000 -0800
>@@ -310,7 +310,7 @@ static int core_sys_select(int n, fd_set
> 			   fd_set __user *exp, s64 *timeout)
> {
> 	fd_set_bits fds;
>-	char *bits;
>+	void *bits;
> 	int ret, size, max_fdset;
> 	struct fdtable *fdt;
> 	/* Allocate small arguments on the stack to save memory and be faster */
>@@ -341,12 +341,12 @@ static int core_sys_select(int n, fd_set
> 		bits = kmalloc(6 * size, GFP_KERNEL);
> 	if (!bits)
> 		goto out_nofds;
>-	fds.in      = (unsigned long *)  bits;
>-	fds.out     = (unsigned long *) (bits +   size);
>-	fds.ex      = (unsigned long *) (bits + 2*size);
>-	fds.res_in  = (unsigned long *) (bits + 3*size);
>-	fds.res_out = (unsigned long *) (bits + 4*size);
>-	fds.res_ex  = (unsigned long *) (bits + 5*size);
>+	fds.in      = bits;
>+	fds.out     = bits +   size;
>+	fds.ex      = bits + 2*size;
>+	fds.res_in  = bits + 3*size;
>+	fds.res_out = bits + 4*size;
>+	fds.res_ex  = bits + 5*size;
> 
> 	if ((ret = get_fd_set(n, inp, fds.in)) ||
> 	    (ret = get_fd_set(n, outp, fds.out)) ||

When did arithmetic on void pointers become acceptable?  I know that it
is a gcc extension but AFAIK its use is discouraged.  Or am I in the
wrong parallel universe again?

