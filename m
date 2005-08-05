Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVHEIpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVHEIpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVHEIpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:45:33 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:26349 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262923AbVHEIpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:45:31 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 5 Aug 2005 10:44:02 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, george@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve() any more
Message-ID: <20050805084401.GA12145@bytesex>
References: <42F28707.7060806@mvista.com> <20050804213416.1EA56180980@magilla.sf.frob.com> <20050804150251.5f4acb0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804150251.5f4acb0a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 03:02:51PM -0700, Andrew Morton wrote:
> Roland McGrath <roland@redhat.com> wrote:
> >
> > That's wrong.  It has to be done only by the last thread in the group to go.
> > Just revert Ingo's change.
> > 
> 
> OK..
> 
> +++ 25-akpm/kernel/exit.c	Thu Aug  4 15:01:06 2005
> @@ -829,8 +829,10 @@ fastcall NORET_TYPE void do_exit(long co
> -	if (group_dead)
> +	if (group_dead) {
> + 		del_timer_sync(&tsk->signal->real_timer);
>  		acct_process(code);
> +	}
> +++ 25-akpm/kernel/posix-timers.c	Thu Aug  4 15:01:06 2005
> @@ -1166,7 +1166,6 @@ void exit_itimers(struct signal_struct *
> -	del_timer_sync(&sig->real_timer);

That one fixes it for me.

  Gerd

-- 
panic("it works"); /* avoid being flooded with debug messages */
