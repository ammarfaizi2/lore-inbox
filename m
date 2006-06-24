Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933001AbWFXJYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbWFXJYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933366AbWFXJYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:24:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:51688 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933001AbWFXJYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=feOQixIyZPfZp9sCfJSqCzydcLyxuqO/G+dFW+j5ujWKsaSQ+pOps5m+7AdcKXadXyTjvHs7+WmVUe1qK7icZJwfdW4AMzQ2HCewvkOoC6gGSvO/SJj89vWr8zxTlrquBxoWz0UGOaLFTaGKOlr81J5aJAMIDHkx6Hh+ZvX/Uxo=
Message-ID: <615cd8d10606240224m2a0dece7t3bdb41df0dae71f2@mail.gmail.com>
Date: Sat, 24 Jun 2006 09:24:51 +0000
From: "=?BIG5?B?s1yspbuo?=" <brianhsu.hsu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: A question about behavior of SCHED_FIFO: Only one process in run queue at any time.
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_98711_17762204.1151141091190"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_98711_17762204.1151141091190
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry for my poor English, I will try to explain clearly at my best.

The main question I have is that why even I have lots of SCHED_FIFO
process with same
priority, it still have time sharing behavior? And at any time point,
there is always only one
process in the runqueue?

Following is the full story:

I have to do a homework that tearcher asks us impelement an EDF
real-time process
scheduling policy in Linux, so I am trying to understanding how Linux
real-time process
scheduling work, and do the homework baed on this.

I have read some textbook about OS and Linux kernel, according to these books,
SCHED_FIFO is a real-time scheduling policy, and when a process is a SCHED_FIFO
process, it will be preempted only when follwing case happend:

1.There are some process with higher priority.
2.The process is in blocking opreation.
3.The process is dead.
4.sched_yield()

Man page of sched_setscheduler even says:"SCHED_FIFO is a  simple
scheduling  algorithm  without  time slicing."

Then I worte an user space program (in the attachment),
which fork an SCHED_FIFO child process, it does nothing expect an infinite loop
and print something on screen.

Beside this, I also modify kernel/sched.c and add the following code
after line of
"next = list_entry(queue->next, task_t, run_list);"

====== Code Start =======
        /* Print all element in the real-time task runqueue */
        if ( idx < 100 ) {

            struct task_struct * i;

            printk ( "RT-Queue[%d]:", idx );

            list_for_each_entry ( i, queue, run_list ) {
                printk ( "P[%d] ->", i->pid );
            }

            printk ( "\n" );
        }
====== Code  End =======

As I mentioned, after these modify, no matter how many SCHED_FIFO process I
am running, there are always only one process in the runqueue, why?

Here is the dmesg result, it is clearly these process is in the same
queue, and there
is only one process in the queue at any time point.

RT-Queue[1]:P[9822] ->
RT-Queue[1]:P[9822] ->
RT-Queue[1]:P[9810] ->
RT-Queue[1]:P[9810] ->
RT-Queue[1]:P[9816] ->
RT-Queue[1]:P[9816] ->
RT-Queue[1]:P[9822] ->
RT-Queue[1]:P[9822] ->

Did I misunderstand about SCHED_FIFO policy?

------=_Part_98711_17762204.1151141091190
Content-Type: text/x-csrc; name="test.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test.c"
X-Attachment-Id: f_eou8t6go

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxhc20vdW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJu
by5oPgojaW5jbHVkZSA8c2NoZWQuaD4KCl9zeXNjYWxsMSAoIGludCwgZm9ya19ydF9wcm9jZXNz
LCBpbnQgLCBkZWFkbGluZSApOwoKaW50IG1haW4gKCBpbnQgYXJnYywgY2hhciAqIGFyZ3ZbXSAp
CnsKICAgIGludCBwaWQgPSAtMTsKICAgIGxvbmcgZGVhZGxpbmUgPSAwOwogICAgc3RydWN0IHNj
aGVkX3BhcmFtIHRtcDsKICAgIHRtcC5zY2hlZF9wcmlvcml0eSA9IDk4OwoKICAgIGlmICggYXJn
YyAhPSAyICkgewogICAgICAgIHByaW50ZiAoICJVU0U6JXMgZGVhZGxpbmVcbiIsIGFyZ3ZbMF0g
KTsgCiAgICAgICAgcmV0dXJuOwogICAgfQoKICAgIGRlYWRsaW5lID0gdGltZShOVUxMKSArIGF0
b2kgKCBhcmd2WzFdICk7CgogICAgcGlkID0gZm9yayAoKTsKCiAgICBpZiAoIHBpZCA9PSAwICkg
ewogICAgICAgIGludCBpID0gMDsKCiAgICAgICAgaW50IGNvZGUgPSBzY2hlZF9zZXRzY2hlZHVs
ZXIgKCBnZXRwaWQoKSwgU0NIRURfRklGTywgJnRtcCApOwoKICAgICAgICB3aGlsZSAoIDEgKSB7
CiAgICAgICAgICAgIHByaW50ZiAoICJOZXcgUElEOiVkOiVkXG4iLCBnZXRwaWQoKSxpICk7CiAg
ICAgICAgICAgIGkrKzsKCiAgICAgICAgICAgIGlmICggKGxvbmcpIHRpbWUoTlVMTCkgPiBkZWFk
bGluZSApCiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICB9CgogICAgICAgIHByaW50ZiAo
ICJFbmQgb2YgUElEOiVkLCVkXG4iLCBnZXRwaWQoKSxjb2RlICk7CiAgICB9IGVsc2UgewogICAg
ICAgIHdhaXQoKTsKICAgIH0KfQo=
------=_Part_98711_17762204.1151141091190--
