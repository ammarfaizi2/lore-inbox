Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbRE1Xlg>; Mon, 28 May 2001 19:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbRE1Xl1>; Mon, 28 May 2001 19:41:27 -0400
Received: from [209.226.175.26] ([209.226.175.26]:30391 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261771AbRE1XlK>; Mon, 28 May 2001 19:41:10 -0400
To: John Lenton <jlenton@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to crash 2.4.4 w/SBLive
In-Reply-To: <20010524063754.5547.qmail@web11607.mail.yahoo.com> <m23d9ux3dk.fsf@sympatico.ca>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 28 May 2001 19:38:59 -0400
In-Reply-To: Bill Pringlemeir's message of "24 May 2001 09:50:31 -0400"
Message-ID: <m27kz111t8.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "John" == John Lenton <jlenton@yahoo.com> writes:
 John> I found to my dismay that it's extremely easy to crash 2.4.4 if
 John> it has a Live! in it. I have no way of getting at the oops, but
 John> somebody out there probably has both this soundcard and a
 John> serial console (or somethin').  I present it in the form of a
 John> script, but you'll probably have no problem realizing where the
 John> problem is. The number of "writers" never gets past 64. I guess
 John> the 65th should probably get the same as the 2nd writer does on
 John> other cards...

I have retried this Oops with 2.4.4-ac17.  I have the ksymoops'ed file.
The error is happening in "linux/drivers/sound/emu10k1/timer.c".  The
function `emu10k1_timer_uninstall' has the following code,

          list_del(&timer->list);

Which are the generic kernel list manipulation functions.  The `next'
element is NULL and when the statement `next->prev = prev;' is
executed, the processor tries to access 4(NULL) in kernel mode.  My
guess is that some sort of race condition is happening and `next' is
NULL when it shouldn't be; but what do I know...

Here is an objdump --disassemble --source --line...

     174:   fa                      cli
    /usr/src/linux-2.4.4/include/linux/list.h:82
     * the prev/next entries already!
     */
    static __inline__ void __list_del(struct list_head * prev,
                                      struct list_head * next)
    {
     175:   8b 52 04                movl   0x4(%edx),%edx
     178:   89 54 24 10             movl   %edx,0x10(%esp,1)
     17c:   8b 54 24 1c             movl   0x1c(%esp,1),%edx
     180:   8b 02                   movl   (%edx),%eax
    /usr/src/linux-2.4.4/include/linux/list.h:83
            next->prev = prev;
     182:   8b 54 24 10             movl   0x10(%esp,1),%edx
     186:   89 50 04                movl   %edx,0x4(%eax)

***** Oops is here ^^^^^^^^^^

    /usr/src/linux-2.4.4/include/linux/list.h:84
            prev->next = next;
     189:   89 02                   movl   %eax,(%edx)
    /usr/src/linux-2.4.4/drivers/sound/emu10k1/timer.c:121

            list_del(&timer->list);

            list_for_each(entry, &card->timers) {
     18b:   8b 97 70 40 00 00       movl   0x4070(%edi),%edx
     191:   8d b7 70 40 00 00       leal   0x4070(%edi),%esi

I looked in list.h for a `safe' list delete, where next is checked for
NULL.  Should the driver check this before calling `list_delete'?

Here is the opps again,

 Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip: c01caa92
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[emu10k1_timer_uninstall+50/236]
 EFLAGS: 00010097
 eax: 00000000   ebx: ffffffff   ecx: c3a9350c   edx: 00000000
 esi: c11d8000   edi: c11d8000   ebp: 00000097   esp: c3909f38
 ds: 0018   es: 0018   ss: 0018
 Process cat (pid: 872, stackpage=c3909000)
 Stack: c3a93400 c11d8000 c2089ba0 00000000 00000000 c01c7957 c11d8000 c3a93478
        c2089ba0 c3a93400 c11d8000 c01c78fa c2089ba0 00000246 c3a93400 00001000
        c01c400a c2089ba0 ffffffea c15d6200 00001000 00000000 00001000 c3908000
 Call Trace: [emu10k1_waveout_close+27/60]
             [emu10k1_waveout_open+102/168]
             [emu10k1_audio_write+190/456]
             [sys_write+142/196]
             [system_call+51/64]

 Code: 89 50 04 89 02 8b 97 70 40 00 00 8d b7 70 40 00 00 89 54 24

And the script,

     #!/bin/sh

     setup () {
             dd bs=1M count=10 </dev/urandom >/tmp/noise 2> /dev/null
     }

     noise () {
             cat /tmp/noise > /dev/dsp &
     }

     setup
     i=0
     while (noise); do
             i=$(( $i+1 ))
             echo $i
     done

thanks,
Bill

ps, There is no FAQ entry on how to generate a single object with `-g'.  I
ended up recompiling my whole tree!




