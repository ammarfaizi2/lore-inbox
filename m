Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWBURIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWBURIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBURIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:08:32 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:33167 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932326AbWBURIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:08:32 -0500
Message-ID: <43FB5B15.F88FF5A8@tv-sign.ru>
Date: Tue, 21 Feb 2006 21:25:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] introduce sig_needs_tasklist() helper
References: <43F76374.EDA3ED9D@tv-sign.ru> <20060221021302.GR1480@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Sat, Feb 18, 2006 at 09:12:04PM +0300, Oleg Nesterov wrote:
> > +#define sig_needs_tasklist(sig) \
> > +             (((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK | M(SIGCONT)))
> > +
> 
> Seems to me to be an improvement, but why not also encapsulate the
> lock acquisition, something like:
> 
>         static inline int sig_tasklist_lock(int sig)
>         {
>                 if (unlikely(sig_needs_tasklist(sig)) {
>                         read_lock(&tasklist_lock);
>                         return 1;
>                 }
>                 return 0;
>         }
> 
>         static inline void sig_tasklist_unlock(int acquired_tasklist_lock)
>         {
>                 if (acquired_tasklist_lock)
>                         read_unlock(&tasklist_lock);
>         }

I hope we will have

	#define sig_needs_tasklist(sig)	  (sig == SIGCONT)

really soon (I planned to submit the final bits today, but
for some stupid reasons I can't do anything till weekend),
so I think it's better to kill 'acquired_tasklist_lock' and
just do:

	void sig_tasklist_lock(sig)
	{
		if (sig_needs_tasklist(sig))
			read_lock(&tasklist_lock);
	}

	void sig_tasklist_unlock(sig)
	{
		if (sig_needs_tasklist(sig));
			read_unlock(&tasklist_lock);
	}

Oleg.
