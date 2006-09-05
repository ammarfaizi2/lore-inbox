Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWIEAP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWIEAP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 20:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWIEAP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 20:15:56 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:14535 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751417AbWIEAPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 20:15:55 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andi Kleen <ak@suse.de>, Dmitry Torokhov <dtor@insightbb.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH-mm] i8042: activate panic blink only in X
Date: Tue, 05 Sep 2006 10:16:45 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <4pfpf2166o30bsqebumnceadbikea07n19@4ax.com>
References: <200609022320.36754.dtor@insightbb.com> <p738xkz65ly.fsf@verdi.suse.de> <ri9pf258l1q51kgsjs4u90sjp9581djjgs@4ax.com> <20060904230358.GC1614@rhlx01.fht-esslingen.de>
In-Reply-To: <20060904230358.GC1614@rhlx01.fht-esslingen.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006 01:03:58 +0200, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

>Hi,
>
>On Tue, Sep 05, 2006 at 08:29:09AM +1000, Grant Coady wrote:
>> If possible, kill the console blank timer too?  (dunno if you have).
>> 
>> Example: Oops screen on 2.4 recently I paged up to where the fault 
>> started, the screen blanker kicked in while I was hand copying info 
>> and wiped previous screens :(  Caused significant delay in working 
>> out what the issue was (slackware-10.2 2.4.33.1 glibc nptl boo-boo).
>> 
>> Is it safe / easy to do on oops/panic?
>
>It should be as easy as e.g. doing a
>
>int system_oopsed __read_mostly = 0;

Can't see where to set this one, from the kernel/panic.c notifier chain?

>if (!system_oopsed)
>    blank();

drivers/char/vt.c:
...
static void blank_screen_t(unsigned long dummy)
{
        if (unlikely(!keventd_up())) {
                mod_timer(&console_timer, jiffies + blankinterval);
                return;
        }
        blank_timer_expired = 1;
        schedule_work(&console_work);
}

Looks like the place to stop the screen blanker, that's as far as I'm game 
to travel.  

Hooking the panic notifier chain looks too scary for this little black duck ;)

Grant.
>
>in the timer handler as opposed to painfully deregistering the whole handler
>in the critical system state after an OOPS.
>A funny side effect is that this way even improves system stability
>after OOPS, since the blanking (which doesn't happen then)
>might bomb, too ;)
>
>Andreas Mohr

