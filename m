Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKVLxM>; Wed, 22 Nov 2000 06:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131240AbQKVLxC>; Wed, 22 Nov 2000 06:53:02 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:46481 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129091AbQKVLwo>; Wed, 22 Nov 2000 06:52:44 -0500
Message-ID: <3A1BAC59.B0F124AF@uow.edu.au>
Date: Wed, 22 Nov 2000 22:22:01 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Johannes Erdfelt <johannes@erdfelt.com>,
        Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c
In-Reply-To: <20001121142616.L7764@sventech.com>,
		<20001121142616.L7764@sventech.com>  <20001121095626.F3431@valinux.com> <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk> <4627.974890115@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> johannes@erdfelt.com said:
> >  Multiple seconds in the worst case.
> 
> Well, I think the PCMCIA socket drivers would be happy with that. Depends
> what akpm also added to the list of tasks,

Nothing which sleeps for very long - mainly serial drivers which queue
a call to tty_hangup(), which immediately queues _another_ tq_scheduler
call to do_tty_hangup (Why?  Heaven knows).

> and whether Linus actually puts
> that patch into test12.

tq_scheduler is a bug.  You can't sleep, you can't call copy_*_user,
you can't call kmalloc non-atomically.  But we do do these things.
Really the only reason for using tq_scheduler is so you can acquire
the tasklist_lock or the files_lock. schedule_task() is fine for that.

tq_scheduler must die.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
