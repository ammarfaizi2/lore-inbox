Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUHRI66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUHRI66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUHRI66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:58:58 -0400
Received: from holomorphy.com ([207.189.100.168]:43957 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265161AbUHRI6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:58:55 -0400
Date: Wed, 18 Aug 2004 01:58:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: DervishD <disposable1@telefonica.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: setproctitle
Message-ID: <20040818085850.GW11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	DervishD <disposable1@telefonica.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040818082851.GA32519@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818082851.GA32519@DervishD>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 10:28:51AM +0200, DervishD wrote:
>     Is there any special reason not to implement setproctitle in the
> kernel? In user space is a bit difficult to implement since 'argv[0]'
> cannot grow beyond the initially allocated space, better said, it can
> grow but only changing the pointer to another place or eating the
> space occupied by the other arguments.
>     proftpd has a not-very-polite set_proc_title that misses the
> final NULL, and a couple of other programs out there uses it, too.
> Applications should be free to change theirs proc titles to some
> pretty if they want, shouldn't they?
>     In proc/base.c you can read about 'setproctitle(3)', that is, in
> library space (user space), not kernel space, but AFAIK only FreeBSD
> has setproctitle :?

Observe the following, from fs/proc/base.c:

static int proc_pid_cmdline(struct task_struct *task, char * buffer)
{
	int res = 0;
	unsigned int len;
	struct mm_struct *mm = get_task_mm(task);
	if (!mm)
		goto out;
	if (!mm->arg_end)
		goto out;	/* Shh! No looking before we're done */

 	len = mm->arg_end - mm->arg_start;
 
	if (len > PAGE_SIZE)
		len = PAGE_SIZE;
 
	res = access_process_vm(task, mm->arg_start, buffer, len, 0);

	// If the nul at the end of args has been overwritten, then
	// assume application is using setproctitle(3).
	if (res > 0 && buffer[res-1] != '\0') {
		len = strnlen(buffer, res);
		if (len < res) {
		    res = len;
		} else {
			len = mm->env_end - mm->env_start;
			if (len > PAGE_SIZE - res)
				len = PAGE_SIZE - res;
			res += access_process_vm(task, mm->env_start, buffer+res, len, 0);
			res = strnlen(buffer, res);
		}
	}
	mmput(mm);

out:
	return res;
}

The command-line arguments are being fetched from the process address
space, i.e. simply editing argv[] in userspace will have the desired
effect. Though this code is butt ugly.


-- wli
