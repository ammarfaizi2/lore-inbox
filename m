Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTBPGJ4>; Sun, 16 Feb 2003 01:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBPGJ4>; Sun, 16 Feb 2003 01:09:56 -0500
Received: from imap.gmx.net ([213.165.64.20]:16017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265890AbTBPGJy>;
	Sun, 16 Feb 2003 01:09:54 -0500
Message-Id: <5.1.1.6.2.20030216071717.00cc7818@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sun, 16 Feb 2003 07:24:27 +0100
To: Jens Axboe <axboe@suse.de>, Rik van Riel <riel@conectiva.com.br>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] CFQ scheduler, #2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030215163550.GO26738@suse.de>
References: <Pine.LNX.4.50L.0302150920510.16301-100000@imladris.surriel.com>
 <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
 <Pine.LNX.4.50L.0302150920510.16301-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_9453453==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_9453453==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 05:35 PM 2/15/2003 +0100, Jens Axboe wrote:
>On Sat, Feb 15 2003, Rik van Riel wrote:
> > On Sat, 15 Feb 2003, Mike Galbraith wrote:
> >
> > >I gave this a burn, and under hefty load it seems to provide a bit of
> > >anti-thrash benefit.
> >
> > Judging from your log, it ends up stalling kswapd and
> > dramatically increases the number of times that normal
> > processes need to go into the pageout code.
>
>With 30 odds processes, it doesn't take a whole lot for one process to
>have its share of requests eaten.
>
> > If this provides an anti-thrashing benefit, something's
> > wrong with the VM in 2.5 ;)
>
>It's not a vm problem. But it is a problem if kswapd + pdflush can
>consume the entire request pool, stalling real user processes.
>
>Mike, please retry the test with more requests available. CFQ does not
>rely on request queue length for fairness. Just changes:
>
>         (queue_nr_requests > 128)
>                 queue_nr_requests = 128;
>
>to
>
>         (queue_nr_requests > 512)
>                 queue_nr_requests = 512;
>
>in ll_rw_blk.c:blk_dev_init() and see how that runs.

Results attached.  512 comes out to be 240 on this box (128MB).  I also did 
a burn with it hardwired to 512 on GP.  Throughput numbers cut since 
there's all within expected jitter.

         -Mike
--=====================_9453453==_
Content-Type: text/plain; name="xx.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.txt"

L3Byb2Mvdm1zdGF0IDIuNS42MWNmcTIgICAyLjUuNjF2aXJnaW4gIGNmcTItNTEyKDI0MCkgICAg
Y2ZxMi01MTIKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KbnJfZGlydHkgICAgICAgICAgICAgMjAgICAgICAgICAgICAgMTMg
ICAgICAgICAgICAgOSAgICAgICAgICAgMTIKbnJfd3JpdGViYWNrICAgICAgICAgIDAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgMCAgICAgICAgICAgIDAKbnJfcGFnZWNhY2hlICAgICAgIDcz
MDggICAgICAgICAgIDc1OTMgICAgICAgICAgNzE3NiAgICAgICAgIDc3MzcKbnJfcGFnZV90YWJs
ZV9wYWdlcyAgODUgICAgICAgICAgICAgODUgICAgICAgICAgICA4NSAgICAgICAgICAgODUKbnJf
cmV2ZXJzZV9tYXBzICAgIDMyMjkgICAgICAgICAgIDMxOTggICAgICAgICAgMzI1NCAgICAgICAg
IDMxNTkKbnJfbWFwcGVkICAgICAgICAgICA1OTkgICAgICAgICAgICA1OTkgICAgICAgICAgIDYw
OCAgICAgICAgICA1ODMKbnJfc2xhYiAgICAgICAgICAgIDEyMDMgICAgICAgICAgIDExODQgICAg
ICAgICAgMTE2OSAgICAgICAgIDEyMzcKcGdwZ2luICAgICAgICAgIDE3Njc0MzIgICAgICAgIDE5
MTE2MTQgICAgICAgMTc1ODUwMSAgICAgIDE3NzU0MDIKcGdwZ291dCAgICAgICAgIDE2MDY3NDMg
ICAgICAgIDE3NDY0OTcgICAgICAgMTU5NTkyMCAgICAgIDE2NTQzNjYKcHN3cGluICAgICAgICAg
ICAzMTEyOTcgICAgICAgICAzMzg0MzYgICAgICAgIDMwNzgxMSAgICAgICAzMTE1MTUKcHN3cG91
dCAgICAgICAgICAzNzExNjEgICAgICAgICA0MDY2NzUgICAgICAgIDM2OTEzMiAgICAgICAzODMz
MDIKcGdhbGxvYyAgICAgICAgIDMwMzc5NjEgICAgICAgIDMwNzA4MTEgICAgICAgMzAzMDQ4MiAg
ICAgIDMwMjA5NjYKcGdmcmVlICAgICAgICAgIDMwNjA4MjUgICAgICAgIDMwOTM0MjAgICAgICAg
MzA1MzUyNCAgICAgIDMwNDMzNTUKcGdhY3RpdmF0ZSAgICAgICAxNDIzMjkgICAgICAgICAxMzU2
MTYgICAgICAgIDEzNDk2OCAgICAgICAxMzY2NTUKcGdkZWFjdGl2YXRlICAgICA1MTQ2NzIgICAg
ICAgICA1MDcwMjYgICAgICAgIDQ4MTE1NiAgICAgICA1MDExMTEKcGdmYXVsdCAgICAgICAgIDQ4
OTY4NzcgICAgICAgIDQ5Mjg1MzAgICAgICAgNDg5MTk4NyAgICAgIDQ5MTM1OTQKcGdtYWpmYXVs
dCAgICAgICAgNzQzNDIgICAgICAgICAgODQ0NzYgICAgICAgICA3NDA1OCAgICAgICAgODI4NTcK
cGdzY2FuICAgICAgICAgIDI3NTE5NTMgICAgICAgIDUzMjgyNjAgICAgICAgMzI1MDg4MCAgICAg
IDM3OTc5MTkKcGdyZWZpbGwgICAgICAgIDE4MjE1NjEgICAgICAgIDE5NzI3MTUgICAgICAgMTg5
NjExOSAgICAgIDIwNTc0NjEKcGdzdGVhbCAgICAgICAgICA1MjgwMTQgICAgICAgICA1NzUzMDEg
ICAgICAgIDUyODUxMyAgICAgICA1MjkwMTEKcGdpbm9kZXN0ZWFsICAgICAgICAgIDAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgMCAgICAgICAgICAgIDAKa3N3YXBkX3N0ZWFsICAgICAzODAy
ODIgICAgICAgICA1MjIxMjYgICAgICAgIDQwNTA3OCAgICAgICA0MTAzODIKa3N3YXBkX2lub2Rl
c3RlYWwgIDcwMTAgICAgICAgICAgIDcxMzIgICAgICAgICAgNjcwNCAgICAgICAgIDY4MjkKcGFn
ZW91dHJ1biAgICAgICAgIDExMDcgICAgICAgICAgIDE5NTYgICAgICAgICAgMTI2MyAgICAgICAg
IDEyNTkKYWxsb2NzdGFsbCAgICAgICAgIDM0NzIgICAgICAgICAgIDEyMzggICAgICAgICAgMjg2
NSAgICAgICAgIDI3ODIKcGdyb3RhdGVkICAgICAgICAzNTgyNDMgICAgICAgICA0MTM0NTAgICAg
ICAgIDM2NTkxNCAgICAgICAzODcyNzcKCg==
--=====================_9453453==_--

