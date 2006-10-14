Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWJNPHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWJNPHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWJNPHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:07:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422664AbWJNPHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:07:10 -0400
Message-ID: <4530FD0F.4050305@redhat.com>
Date: Sat, 14 Oct 2006 11:06:55 -0400
From: Prarit Bhargava <prarit@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: Re: [PATCH]: disassociate tty locking fixups
References: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com> <1160830509.5732.26.camel@localhost.localdomain>
In-Reply-To: <1160830509.5732.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

 >Ugly but I don't think the patches are sufficient. Firstly you need to
 >hold the task lock if you are poking around some other users ->signal,
 >or that may itself change. (disassociate_ctty seems to have this wrong)

Ah -- okay.

So the locking order is (for example):

mutex_lock(&tty_mutex);
read_lock(&tasklist_lock);
task_lock(current);

Correct?

 >Secondly you appear to have lock ordering issues (you lock tty_mutex in
 >both orders relative to the task list lock) (you take tty_mutex first,
 >then the task lock which is correct, but then you drop and retake the
 >tty_mutex while holding the task lock, which may deadlock)

Fixed.

 >Can you also explain why the ctty change proposed is neccessary ?

disassociate_ctty can call tty_vhangup which calls do tty_hangup directly.
do_tty_hangup can then set p->signal->tty = NULL, and after returning to
disassociate_ctty, the value of tty will now contain a bad pointer.  (I can
reproduce this behaviour by running the gdb testsuite with slab debug on)

 >NAK the actual code, provisionally agree with the basic diagnosis of
 >insufficient locking.

Arjan wrote:

 >in addition, are you sure you don't need to revalidate anything after
 >retaking the lock?

The only place I need to revalidate data (AFAICT) is in 
disassociate_ctty where
I re-check to see if current->signal->tty is still valid.  Admittedly, I am
looking at a very specific failure path though.

I'll rework the patch and post later.

P.

