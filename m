Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVDYQoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVDYQoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDYQni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:43:38 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:824 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262679AbVDYQm1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:42:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=huPM+QlccrlKLos6TJP1fSFFMxesqZOCid4DcGesOYUR6iUc7NXHvYpb4wPgwkvHlX9G/dy7jZyqFcioKrkcYjoeurUOm5HMNq7EyI7yD68FBchVo3Wbfs0vBD3wVH5sSt/yevdCHy6xDMyUCGyBP3F1191k84JtoZL9BtYXBZs=
Message-ID: <29495f1d05042509426681c4a0@mail.gmail.com>
Date: Mon, 25 Apr 2005 09:42:21 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 3/7] dlm: recovery
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050425151239.GD6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425151239.GD6826@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, David Teigland <teigland@redhat.com> wrote:
> 
> When a node is removed from a lockspace, recovery is required for that
> lockspace on all the remaining lockspace members.  Recovery involves: a
> full rebuild of the distributed resource directory, selecting a new master
> node for locks/resources previously mastered on the removed node, and
> rebuilding master-copy locks on newly selected masters.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>

<snip>

> +int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls))
> +{
> +       int error = 0;
> +
> +       for (;;) {
> +               wait_event_interruptible_timeout(ls->ls_wait_general,
> +                                       testfn(ls) ||
> +                                       test_bit(LSFL_LS_STOP, &ls->ls_flags),

Shouldn't this be
     dlm_recover_stopped(ls) and not test_bit()?
?

> +                                       (dlm_config.recover_timer * HZ));
> +               if (testfn(ls))
> +                       break;
> +               if (dlm_recovery_stopped(ls)) {
> +                       error = -1;
> +                       break;
> +               }
> +       }
> +
> +       return error;
> +}

Rather than wrap an infinite loop in an infinite loop, since all you
really want the second loop for is a periodic gurantee of
recover_timer seconds, wouldn't it be easier to have a sof-timer set
up to go off in that amount of time, and have it's callback do an
unconditional wake-up on the local wait-queue then mod_timer the timer
back in? Or might there be other tasks sleeping on the same
wait-queue? At that point, since your code does not seem to care about
signals (uses interruptible version, but doesn't check for
signal_pending() return value from wait_event), you probably could
just use the stock version of wait_event(). The conditions would be
checked in wait_event() on the desired periodic basis, just as they
are now, but maybe slightly more efficiently (and cleaner code, IMO :)
). If you do *need* interruptible, please put in a comment as to why.

Maybe we need yet another interface? :)

<snip>

> +int dlm_wait_status_all(struct dlm_ls *ls, unsigned int wait_status)
> +{
> +       struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
> +       struct dlm_member *memb;
> +       int error = 0;
> +
> +       list_for_each_entry(memb, &ls->ls_nodes, list) {
> +               for (;;) {
> +                       error = dlm_recovery_stopped(ls);
> +                       if (error)
> +                               goto out;
> +
> +                       error = dlm_rcom_status(ls, memb->nodeid);
> +                       if (error)
> +                               goto out;
> +
> +                       if (rc->rc_result & wait_status)
> +                               break;
> +                       else {
> +                               set_current_state(TASK_INTERRUPTIBLE);
> +                               schedule_timeout(HZ >> 1);

<snip>

> +int dlm_wait_status_low(struct dlm_ls *ls, unsigned int wait_status)
> +{
> +       struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
> +       int error = 0, nodeid = ls->ls_low_nodeid;
> +
> +       for (;;) {
> +               error = dlm_recovery_stopped(ls);
> +               if (error)
> +                       goto out;
> +
> +               error = dlm_rcom_status(ls, nodeid);
> +               if (error)
> +                       break;
> +
> +               if (rc->rc_result & wait_status)
> +                       break;
> +               else {
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +                       schedule_timeout(HZ >> 1);

500 ms is a long time! What's the justification? No comments?
Especially considering you will wake up on *every* signal. It's
unlikely you'll actually sleep for 500 ms. Also, please use
msleep_interruptible(), unless you expect to be woken by  wait-queues
(I didn't have enough time to trace all the possible code paths :) )
-- in which case, make it explicit with comments, please.

Thanks,
Nish
