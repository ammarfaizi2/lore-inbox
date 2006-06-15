Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031416AbWFOVSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031416AbWFOVSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031418AbWFOVSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 17:18:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50634 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031416AbWFOVSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 17:18:44 -0400
Subject: Re: [PATCH] fs: sys_poll with timeout -1 bug fix
From: Matt Helsley <matthltc@us.ibm.com>
To: frode isaksen <frode.isaksen@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <383D1CA3-E74C-4530-A8C8-D0B9608A1970@gmail.com>
References: <383D1CA3-E74C-4530-A8C8-D0B9608A1970@gmail.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 14:13:29 -0700
Message-Id: <1150406009.21787.375.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 17:33 +0200, frode isaksen wrote:
> From: Frode Isaksen <frode.isaksen@gmail.com>
> 
> If you do a poll() call with timeout -1, the wait will be a big  
> number (depending on HZ)  instead of infinite wait, since -1 is  
> passed to the msecs_to_jiffies function.
> 
> Signed-off-by: Frode Isaksen <frode.isaksen@gmail.com>
> 
> ---
> --- linux-2.6.16.20/fs/select.c.orig.c	2006-06-05 19:18:23.000000000  
> +0200
> +++ linux-2.6.16.20/fs/select.c	2006-06-15 14:20:47.000000000 +0200
> @@ -699,9 +699,9 @@ out_fds:
>   asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int  
> nfds,
>   			long timeout_msecs)
>   {
> -	s64 timeout_jiffies = 0;
> +	s64 timeout_jiffies;
> 
> -	if (timeout_msecs) {
> +	if (timeout_msecs > 0) {
>   #if HZ > 1000
>   		/* We can only overflow if HZ > 1000 */
>   		if (timeout_msecs / 1000 > (s64)0x7fffffffffffffffULL / (s64)HZ)
> @@ -709,6 +709,9 @@ asmlinkage long sys_poll(struct pollfd _
>   		else
>   #endif
>   			timeout_jiffies = msecs_to_jiffies(timeout_msecs);
> +	} else {
> +		/* Infinite (-1) or no (0) timeout */
> +		timeout_jiffies = timeout_msecs;

nit: The comment isn't quite right according to the poll manpage. Any
negative number represents an infinite timeout. I think you want:

+ 		/* Infinite (< 0) or no (0) timeout */

>   	}
> 
>   	return do_sys_poll(ufds, nfds, &timeout_jiffies);


