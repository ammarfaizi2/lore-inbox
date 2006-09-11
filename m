Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWIKPsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWIKPsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWIKPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:48:42 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:45754 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751160AbWIKPsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:48:42 -0400
Date: Mon, 11 Sep 2006 19:48:33 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
Message-ID: <20060911154833.GB82@oleg>
References: <45019CC3.2030709@fr.ibm.com> <m18xktkbli.fsf@ebiederm.dsl.xmission.com> <450537B6.1020509@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450537B6.1020509@fr.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Cedric Le Goater wrote:
>
> Eric W. Biederman wrote:
> > Cedric Le Goater <clg@fr.ibm.com> writes:
> > 
> >> message queues can signal a process waiting for a message.
> >>
> >> this patch replaces the pid_t value with a struct pid to avoid pid wrap
> >> around problems.
> >>
> >> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> >> Cc: Eric Biederman <ebiederm@xmission.com>
> >> Cc: Andrew Morton <akpm@osdl.org>
> >> Cc: containers@lists.osdl.org
> > 
> > Signed-off-by: Eric Biederman <ebiederm@xmission.com>
> > 
> > I was just about to send out this patch in a couple more hours.
> 
> Well, you did the same with the usb/devio.c and friends :)
> 
> > So expect the fact we wrote the same code is a good sign :)
> 
> How does oleg feel about it ? I've seen some long thread on possible race
> conditions with put_pid() and solutions with rcu. I didn't quite get all of
> it ... it will need another run for me.

I assume you are talking about this patch:
	http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115773820415171

I think it's ok, info->notify_owner is always used under info->lock.

This is simple. If, for example, mqueue_read_file() didn't take info->lock,
then we have a problem: pid_nr() may read a freed memory in case when
__do_notify()->put_pid() happens at the same time.

In this context info->notify_owner is a usual refcounted object, no special
attention is needed.

Oleg.

