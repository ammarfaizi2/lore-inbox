Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVDYRmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVDYRmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDYRlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:41:44 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:65510 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262691AbVDYRkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:40:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l1GpVL/2nbTWBYM0b/W3eeH9+JgR7FE00K/gYDqYoBWBMC3t1AY4srvo/WdSksRaXzBj3t2bJ5bKBx0Cb1rsk41OsENE7Ly+3l5/arGV96MCA0Meh7DbSpcP5+Max0QM53sDeAi7HSTZBKBqGW4ShMWh25LLcVpZrEpFVJPe2r4=
Message-ID: <29495f1d05042510403b262909@mail.gmail.com>
Date: Mon, 25 Apr 2005 10:40:16 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 1a/7] dlm: core locking
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050425165705.GA11938@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425165705.GA11938@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, David Teigland <teigland@redhat.com> wrote:
> [Apologies, patch 1 was too large on its own.]
> 
> The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
> Creates lockspaces which give applications separate contexts/namespaces in
> which to do their locking.  Manages locks on resources' grant/convert/wait
> queues.  Sends and receives high level locking operations between nodes.
> Delivers completion and blocking callbacks (ast's) to lock holders.
> Manages the distributed directory that tracks the current master node for
> each resource.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>

<snip>

> --- a/drivers/dlm/lockspace.c   1970-01-01 07:30:00.000000000 +0730
> +++ b/drivers/dlm/lockspace.c   2005-04-25 22:52:03.956816760 +0800

<snip>

> +int dlm_scand(void *data)
> +{
> +       struct dlm_ls *ls;
> +
> +       while (!kthread_should_stop()) {
> +               list_for_each_entry(ls, &lslist, ls_list)
> +                       dlm_scan_rsbs(ls);
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(DLM_SCAN_SECS * HZ);
> +       }
> +       return 0;
> +}

<snip>

> +static void remove_lockspace(struct dlm_ls *ls)
> +{
> +       for (;;) {
> +               spin_lock(&lslist_lock);
> +               if (ls->ls_count == 0) {
> +                       list_del(&ls->ls_list);
> +                       spin_unlock(&lslist_lock);
> +                       return;
> +               }
> +               spin_unlock(&lslist_lock);
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(HZ);
> +       }
> +}

<snip>

These can both be msleep_interruptible() calls?

Thanks,
Nish
