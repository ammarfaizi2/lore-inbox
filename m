Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVF2SPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVF2SPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVF2SPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:15:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262388AbVF2SPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:15:44 -0400
Date: Wed, 29 Jun 2005 11:15:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gernot Payer <gpayer@suse.de>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: Patch to disarm timers after an exec syscall
Message-Id: <20050629111500.61095514.akpm@osdl.org>
In-Reply-To: <200506291455.45468.gpayer@suse.de>
References: <200506291455.45468.gpayer@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gernot Payer <gpayer@suse.de> wrote:
>
> while running the openposix testsuite I saw testcase timer_create/9-1.c 
>  failing. This testcase tests whether timers are disarmed when a process calls 
>  exec, as described in e.g. 
>  http://www.opengroup.org/onlinepubs/009695399/functions/timer_create.html.
> 
>  The attached one-liner patch (+ one line comment) fixes this issue. I did the 
>  diff against 2.6.12.1, but the fix is pretty much the same for every other 
>  2.6.x kernel I had a look at.
> 
>  I don't think this patch breaks anything, as relying on this (undocumented) 
>  behaviour would imho be bad style.
> 
>  So tell me what you think, and if you have some pointers to interesting 
>  discussions about Linux and POSIX compliance then I would like to read that 
>  as well.
> 
>  --- linux-2.6.12.1-orig/fs/exec.c	2005-06-29 14:29:31.069738264 +0200
>  +++ linux-2.6.12.1/fs/exec.c	2005-06-29 14:34:46.034856288 +0200
>  @@ -1200,6 +1200,10 @@
>   		acct_update_integrals(current);
>   		update_mem_hiwater(current);
>   		kfree(bprm);
>  +
>  +		/* delete old itimers */
>  +		exit_itimers(current->signal);
>  +		
>   		return retval;
>   	}

Ouch.  What does 2.4.x do?

It wouldn't surprise me if fixing this breaks _something_ out there.  We
might have to remain non-POSIX-compliant for the rest of time.

