Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTJOAMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 20:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTJOAMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 20:12:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:11699 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262066AbTJOAMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 20:12:18 -0400
Date: Tue, 14 Oct 2003 17:12:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: OK to set PF_MEMDIE on cleanup tasks?
Message-Id: <20031014171227.014f0d2f.akpm@osdl.org>
In-Reply-To: <20031014151759.GA2188@us.ibm.com>
References: <20031014151759.GA2188@us.ibm.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> Hello!
> 
> We have tasks that actively return memory to the system, which we
> would like to exempt from the OOM killer, as killing such tasks under
> low-memory conditions would indeed be counterproductive.  It looks like
> the "official" way to do this is to catch/ignore signal 15, which results
> in PF_MEMDIE being set (in the 2.6 kernel), thus preventing the OOM killer
> from killing the task again.  I don't see where PF_MEMDIE is cleared,
> though there are a number of subtle ways one might do this that I would
> have missed.

The PF_MEMDIE flag is there so the oom killer doesn't just sit there
hitting the same task over and over again.

We leave PF_MEMDIE set because we expect the task to exit, or to not want
any more oomkiller attention.

The SIGTERM behaviour is there because the CAP_SYS_RAWIO process may need
to release critical resources.

So as long as your process has CAP_SYS_RAWIO, everything happens to work as
you want it.  I don't think it was really designed that way though.

> So...  Is it considered legit to simply set PF_MEMDIE when creating
> the cleanup task?  Or is there some reason that one should deal with
> signal 15?

Well it's all very unconventional.  Catching SIGTERM seems like a suitable
way to do what you want to do.

Possibly your special process should also run as PF_MEMALLOC.  I've seen
that done before, with success.  There is no existing API with which this
can be set.

