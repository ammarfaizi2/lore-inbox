Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130288AbRBSNgn>; Mon, 19 Feb 2001 08:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRBSNge>; Mon, 19 Feb 2001 08:36:34 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:13380 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130288AbRBSNg3>; Mon, 19 Feb 2001 08:36:29 -0500
Date: Mon, 19 Feb 2001 07:36:04 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: <30512.982588558@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.96.1010219073235.16489I-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Keith Owens wrote:
> On Mon, 19 Feb 2001 06:15:22 -0600 (CST), 
> Philipp Rumpf <prumpf@mandrakesoft.com> wrote:
> No need for a callin routine, you can get this for free as part of
> normal scheduling.  The sequence goes :-
> 
> if (use_count == 0) {
>   module_unregister();
>   wait_for_at_least_one_schedule_on_every_cpu();
>   if (use_count != 0) {
>     module_register();	/* lost the unregister race */
>   }
>   else {
>     /* nobody can enter the module now */
>     module_release_resources();
>     unlink_module_from_list();
>     wait_for_at_least_one_schedule_on_every_cpu();
>     free_module_storage();
>   }
> }
> 
> wait_for_at_least_one_schedule_on_every_cpu() prevents the next

wait_for_at_least_one_schedule_on_every_cpu() *is* callin_other_cpus().
I agree the name isn't optimal.  (and yes, you could implement it by
hacking sched.c directly, but I don't think that's necessary).

> The beauty of this approach is that the rest of the cpus can do normal
> work.  No need to bring everything to a dead stop.

Which nicely avoids potential deadlocks in modules that need to initialize
on all CPUs.

