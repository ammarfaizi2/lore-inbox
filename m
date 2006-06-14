Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWFNAkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWFNAkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWFNAkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:40:05 -0400
Received: from relay01.pair.com ([209.68.5.15]:32013 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S964833AbWFNAkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:40:02 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 02/11] Task watchers:  Register process events task watcher
Date: Tue, 13 Jun 2006 19:39:38 -0500
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain> <1150242874.21787.142.camel@stark>
In-Reply-To: <1150242874.21787.142.camel@stark>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131940.00539.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 18:54, Matt Helsley wrote:

> +static int cn_proc_watch_task(struct notifier_block *nb, unsigned long
> val, +			      void *t)
> +{
> +	struct task_struct *task = t;

Why the copy?

> +	int rc = NOTIFY_OK;
> +
> +	switch (get_watch_event(val)) {
> +	case WATCH_TASK_CLONE:
> +		proc_fork_connector(task);
> +		break;
> +	case WATCH_TASK_EXEC:
> +		proc_exec_connector(task);
> +		break;
> +	case WATCH_TASK_UID:
> +		proc_id_connector(task, PROC_EVENT_UID);
> +		break;
> +	case WATCH_TASK_GID:
> +		proc_id_connector(task, PROC_EVENT_GID);
> +		break;
> +	case WATCH_TASK_EXIT:
> +		proc_exit_connector(task);
> +		break;
> +	default: /* we don't care about WATCH_TASK_INIT|FREE because we
> +		    don't keep per-task info */
> +		rc = NOTIFY_DONE; /* ignore all other notifications */
> +		break;
> +	}
> +	return rc;
> +}
> +

>  /*
>   * cn_proc_init - initialization entry point
>   *
>   * Adds the connector callback to the connector driver.
>   */
> @@ -219,11 +259,16 @@ static int __init cn_proc_init(void)
>  	int err;
>
>  	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
>  	 			   &cn_proc_mcast_ctl))) {
>  		printk(KERN_WARNING "cn_proc failed to register\n");
> -		return err;
> +		goto out;
>  	}
> -	return 0;
> +
> +	err = register_task_watcher(&cn_proc_nb);
> +	if (err != 0)

if (err)

Thanks,
Chase
