Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSBWMui>; Sat, 23 Feb 2002 07:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSBWMuQ>; Sat, 23 Feb 2002 07:50:16 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57317 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293131AbSBWMuM>; Sat, 23 Feb 2002 07:50:12 -0500
Date: Sat, 23 Feb 2002 07:50:02 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223075002.A23666@devserv.devel.redhat.com>
In-Reply-To: <200202231011.g1NABaU10984@devserv.devel.redhat.com> <25097.1014467212@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <25097.1014467212@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Feb 23, 2002 at 11:26:52PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Keith Owens <kaos@ocs.com.au>
> Date: Sat, 23 Feb 2002 23:26:52 +1100

> Kernel code already has exception tables to handle invalid addresses,
> invalid opcodes etc.  See copy_to_user and wrmsr_eio for examples.

I think you confuse hardware interrupts or exceptions with
language exceptions (which are the topic of current discussion).
Language exceptions constitute a fancy equivalent of return
code checking. Every time you see the following code, an exception
is handled:

int foo () {
   int rc;
   bar_t *x;

   if ((x = do_bar()) == NULL) { rc = -ENOMEM; goto out_nobar; }
   if ((rc = quux()) != 0) goto out_noquux;
   more_stuff();
   return 0;

 out_noquux;
   undo_bar(x);
 out_nobar:
   return rc;
}

> The kernel model is "get it right the first time, so we don't need
> exception handlers".  You have not given any reason why the existing
> mechanisms are failing.

If you understand that we are not talking about oopses here,
you will see that we emulate quite a bit of stuff with gotos.
The problem with current practice is that it takes a fair bit
of discipline to prevent it from growing into spaghetti [*].

Personally, I have no problem handling current practices.
But I may see the point of the guy with the try/catch patch.
Do not make me to defend him though. I am trying to learn
is those exceptions are actually helpful. BTW, we all know
where they come from (all of Cutler's NT is written that way),
but let it not cloud our judgement.

[*] List of subtlietes in the example, that a number of driver
monkeys get wrong:
1. rc must always be set right. Sometimes it's extracted from ERR_PTR,
   sometimes other ways.
2. You must have the Russian Doll commit-uncommit order. If you
   cannot fall into this rigid scheme, you must use more functions.
3. Names for labels correspond to what fails, not what has to be undone
   (or else you cannot move stuff around).

-- Pete
