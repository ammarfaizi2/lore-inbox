Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUDLOSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUDLOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:18:22 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:24552 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262909AbUDLOSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:18:17 -0400
Message-ID: <407AA51F.5020205@myrealbox.com>
Date: Mon, 12 Apr 2004 07:18:07 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
CC: Andrew Morton <akpm@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fix must_not_trace_exec() test
References: <20040410200551.31866667.akpm@osdl.org> <878yh1y1gs.fsf@goat.bogus.local>
In-Reply-To: <878yh1y1gs.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> 
> Although, I'd rather not lump together unrelated tests without
> renaming must_not_trace_exec(). Btw, can someone enlighten me what
> this atomic_read() test is all about.

Oops... your fix is obviously correct.

I assumed that the test was to check if the caller is a thread, but that sounds 
odd -- wouldn't it stop being a thread after the exec anyway?  Maybe that part 
happens after compute_creds, so this prevents a race?  Although I don't see how 
it could be triggered if the thread never entered usermode before getting a new 
fs/files/sighand.

Anyone?

> 
> Regards, Olaf.
> 
> diff -urN a/security/commoncap.c b/security/commoncap.c
> --- a/security/commoncap.c	Mon Apr 12 10:38:17 2004
> +++ b/security/commoncap.c	Mon Apr 12 11:10:38 2004
> @@ -118,9 +118,9 @@
>  static inline int must_not_trace_exec (struct task_struct *p)
>  {
>  	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
> -		|| atomic_read(&current->fs->count) > 1
> -		|| atomic_read(&current->files->count) > 1
> -		|| atomic_read(&current->sighand->count) > 1;
> +		|| atomic_read(&p->fs->count) > 1
> +		|| atomic_read(&p->files->count) > 1
> +		|| atomic_read(&p->sighand->count) > 1;
>  }
>  [...]

--Andy
