Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSCOPRd>; Fri, 15 Mar 2002 10:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292815AbSCOPRZ>; Fri, 15 Mar 2002 10:17:25 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:39697 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S292730AbSCOPRJ>; Fri, 15 Mar 2002 10:17:09 -0500
To: frankeh@watson.ibm.com
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] get_pid() performance fix
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
	<20020314231733.638C03FE06@smtp.linux.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 16 Mar 2002 00:16:48 +0900
In-Reply-To: <20020314231733.638C03FE06@smtp.linux.ibm.com>
Message-ID: <87663xlv33.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops! I'm sorry. previous email was the middle of writing.

Hubertus Franke <frankeh@watson.ibm.com> writes:

> +	if (i == PID_MAP_SIZE) { 
> +		if (again) {
> +			/* we didn't find any pid , sweep and try again */
> +			again = 0;
> +			memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
> +			last_pid = RESERVED_PIDS;
> +			goto repeat;
> +		}
> +		next_safe = RESERVED_PIDS;
> +		return 0; 

Probably, the bug is here.

the following is test case: ./getpid1 -r300 -c3

	case 3:
		populate_all(0, 1);
		pid = get_pid(0);
		printf("new pid: %d\n", pid);
		tsk = find_task_by_pid(400);
		del_task(tsk);
		pid = get_pid(0);
		printf("new pid: %d\n", pid);

		break;

result,
	new pid: 0
	new pid: 1

> +	}
> +
> +	fpos = ffz(mask);
> +	i &= (PID_MAX-1);
> +	last_pid = (i << SHIFT_PER_LONG) + fpos;
> +
> +	/* find next save pid */
> +	mask &= ~((1 << fpos) - 1);
> +
> +	while ((mask == 0) && (++i < PID_MAP_SIZE)) 
> +		mask = pid_map[i];
> +
> +	if (i==PID_MAP_SIZE) 
> +		next_safe = PID_MAX;
> +	else 
> +		next_safe = (i << SHIFT_PER_LONG) + ffs(mask) - 1;
> +	return last_pid;
> +}
> +
>  static int get_pid(unsigned long flags)
>  {
> -	static int next_safe = PID_MAX;
>  	struct task_struct *p;
> -	int pid;
> +	int pid,beginpid;
>  
>  	if (flags & CLONE_PID)
>  		return current->pid;
>  
>  	spin_lock(&lastpid_lock);
> +	beginpid = last_pid;
>  	if((++last_pid) & 0xffff8000) {
> -		last_pid = 300;		/* Skip daemons etc. */
> +		last_pid = RESERVED_PIDS;		/* Skip daemons etc. */
>  		goto inside;
>  	}
>  	if(last_pid >= next_safe) {
>  inside:
>  		next_safe = PID_MAX;
>  		read_lock(&tasklist_lock);
> +		if (nr_threads > GETPID_THRESHOLD) {
> +			last_pid = get_pid_by_map(last_pid);
> +		} else {
>  	repeat:
>  		for_each_task(p) {
>  			if(p->pid == last_pid	||
> @@ -151,9 +228,11 @@
>  			   p->session == last_pid) {
>  				if(++last_pid >= next_safe) {
>  					if(last_pid & 0xffff8000)
> -						last_pid = 300;
> +							last_pid = RESERVED_PIDS;
>  					next_safe = PID_MAX;
>  				}
> +					if(unlikely(last_pid == beginpid))
> +						goto nomorepids;
>  				goto repeat;
>  			}
>  			if(p->pid > last_pid && next_safe > p->pid)
> @@ -162,6 +241,9 @@
>  				next_safe = p->pgrp;
>  			if(p->session > last_pid && next_safe > p->session)
>  				next_safe = p->session;
> +				if(p->tgid > last_pid && next_safe > p->tgid)
> +					next_safe = p->tgid;
> +			}
>  		}
>  		read_unlock(&tasklist_lock);
>  	}
> @@ -169,6 +251,10 @@
>  	spin_unlock(&lastpid_lock);
>  
>  	return pid;
> +nomorepids:

Probably, the following line are required, here.

  +	next_safe = RESERVED_PIDS;	/* or 0 */

> +	read_unlock(&tasklist_lock);
> +	spin_unlock(&lastpid_lock);
> +	return 0;
>  }


Basically nice, I think.

BTW, How about using the __set_bit(), find_next_zero_bit(), and
find_next_bit() in get_pid_by_map().

Thanks for nice work.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
