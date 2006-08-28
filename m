Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWH1CzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWH1CzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWH1CzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:55:19 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:57145 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932365AbWH1CzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:55:17 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Is stopmachine() preempt safe? 
In-reply-to: Your message of "Mon, 28 Aug 2006 09:38:55 +1000."
             <1156721935.10467.1.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Aug 2006 12:55:18 +1000
Message-ID: <16193.1156733718@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell (on Mon, 28 Aug 2006 09:38:55 +1000) wrote:
>On Sun, 2006-08-27 at 19:42 +1000, Keith Owens wrote:
>> I cannot convince myself that stopmachine() is preempt safe.  What
>> prevents this race with CONFIG_PREEMPT=y?
>
>Nothing.  Read side is preempt_disable.  Write side is stopmachine.

That is very worrying.  The whole point of stopmachine is to get all
cpus to a known state with no locally cached global data, so the caller
of stopmachine can safely fiddle with some global data (like updating
the module lists).  But CONFIG_PREEMPT defeats this and turns any code
that relies on stopmachine into a race.

What we need is either a scheduler flag or a new task state to be
assigned to the kstopmachine threads.  That indicator says

  If the current state is not preempt active then schedule me.

  If the current state is preempt active then put me back in the active
  queue.

  While the runqueue contains at least one task with this flag then
  ignore reschedule on irq and prempt_enable.

That will ensure that the kstopmachine threads get scheduled as soon as
possible but only when all the preempted tasks have got to a clean stop
point, e.g. sleep or yield.  At which point they have no locally cached
global data, making stopmachine race safe again.

