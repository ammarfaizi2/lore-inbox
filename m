Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTDWQil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTDWQil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:38:41 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60176
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264125AbTDWQii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:38:38 -0400
Subject: Re: 2.5.68-mm2
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20030423095926.GJ8931@holomorphy.com>
References: <20030423012046.0535e4fd.akpm@digeo.com>
	 <20030423095926.GJ8931@holomorphy.com>
Content-Type: text/plain
Message-Id: <1051116646.2756.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 23 Apr 2003 12:50:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 05:59, William Lee Irwin III wrote:

> rml and I coordinated to put together a small patch (combining both
> our own) for properly locking the static variables in out_of_memory().
> There's not any evidence things are going wrong here now, but it at
> least addresses the visible lack of locking in out_of_memory().

Thank you for posting this, wli.

> -	first = now;
> +	/*
> +	 * We dropped the lock above, so check to be sure the variable
> +	 * first only ever increases to prevent false OOM's.
> +	 */
> +	if (time_after(now, first))
> +		first = now;

Just thinking... this little bit is actually a bug even on UP sans
kernel preemption, too, since oom_kill() can sleep.  If it sleeps, and
another process enters out_of_memory(), 'now' and 'first' will be out of
sync.

So I think this patch is a Good Thing in more ways than the obvious SMP
or kernel preemption issue.

	Robert Love


