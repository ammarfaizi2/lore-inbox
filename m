Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWA3Jmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWA3Jmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWA3Jmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:42:44 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:19360 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932167AbWA3Jmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:42:43 -0500
Message-ID: <43DDF19B.AF498BBD@tv-sign.ru>
Date: Mon, 30 Jan 2006 13:59:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Don't hash pid 0.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -148,6 +148,9 @@ int fastcall attach_pid(task_t *task, en
>  {
>  	struct pid *pid, *task_pid;
>  
> +	if (!nr)
> +		goto out;
> +
>  	task_pid = &task->pids[type];
>  	pid = find_pid(type, nr);
>  	task_pid->nr = nr;

If nr == 0 then task_pid->nr is uninitialized, so

> @@ -169,6 +172,9 @@ static fastcall int __detach_pid(task_t 
>  	int nr = 0;
>  
>  	pid = &task->pids[type];
> +	if (!pid->nr)
> +		goto out;

this is unsafe.

Yes, INIT_TASK() sets pids[...].nr == 0, but this is fragile and at
least needs a comment.

Eric, Andrew, I think I have a better patch, will post in a minute.

Oleg.
