Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUCBXb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUCBXb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:31:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261692AbUCBXbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:31:21 -0500
Date: Tue, 2 Mar 2004 18:32:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <4045106D.8060902@tmr.com>
Message-ID: <Pine.LNX.4.53.0403021817050.9351@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
 <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it>
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it>
 <4045106D.8060902@tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-133161302-1078270355=:9351"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-133161302-1078270355=:9351
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 2 Mar 2004, Bill Davidsen wrote:

> Roland Dreier wrote:
>
> > I don't know why I continue this, but.... can you point out the line
> > in the kernel 2.4 source for __pollwait() where it sleeps?
> >
> > Or think about it.  Suppose a user called poll() with two fds, each of
> > which belonged to a different driver.  Suppose each driver slept in
> > its poll method.  If the first driver never became ready (and stayed
> > asleep), how would poll() return to user space if the second driver
> > became ready?
> >
> > What actually happens is that each driver registers with the kernel
> > the wait queues that it will wake up when it becomes ready.  But the
> > core kernel is responsible for sleeping, outside of the driver code.
>
> Could you maybe go back to the initial report, which is that after
> poll() gets wrong status? It's nice to argue about where the process
> waits, but the issue is if it gets the same status with 2.4 and 2.6, and
> if not which one should be fixed.
>
> Richard: can you show this with a small demo program? I assume you
> didn't find this just by reading code ;-)

Yes. The code I attached earlier shows that the poll() in a driver
gets called (correctly), then it calls poll_wait(). Unfortunately
the call to poll_wait() returns immediately so that the return
value from the driver's poll() is whatever it was before some
event occurred that the driver was going to signal with
wake_up_interruptible().

The attached code clearly demonstrates this. It doesn't even contain
any code to execute wake_up_interruptible(). When an event occurs
in the driver that would have set the poll_flag to POLLIN, and
executed wake_up_interruptible, the old status, the stuff that
was returned when poll_wait() returned immediately instead of
waiting for the wake up, gets returned to the user-mode program.

Now, if the user-mode program calls poll() again, which is likely,
it gets the status that was returned from the previous event so
it "seems" to work. However, it is always one event behind so
you need two events to recognize the first one.

I attached the module and demo program again. It clearly shows
that poll_wait() gets called and then immediately returns without
waiting...

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-133161302-1078270355=:9351
Content-Type: APPLICATION/octet-stream; name="modules.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0403021832350.9351@chaos>
Content-Description: 
Content-Disposition: attachment; filename="modules.tar.gz"

H4sIAEPzREAAA+0Ya2/bNjBfo19x8NJO8uxYfsVoUg8IHHfz6tqDm3Qb1kFQ
JMrWIlEeRaXNhv73HUlJlh03xoC4XTddgYa6F+94Dx4dRm4SkLhxsEeAjtnr
duEABJgbf9OPpmm2ms1es9M1AT+6zd4BdPdpVAZJzG0GcMCiiD/Et4v+hUKY
xv+VfUM8PyD72ANje9LpfDz+3ZN2Hv9mu4Xxb7Xa3QMw92HMJvzP46+9Gc7g
tA9HerwgQQAJtUMCdWZor85/mM6gD81nz0DTRpNBv5HErBEzpxH4NHlfP9JR
1mj41AkSl2iDATLPHQfqP9moqD5tQf3Csl4OZ5Ph2LLw49X04mo8FAuh2prM
+ke6XBpC+Js+1EdHOm5kaBpqOD085Aufzu+OI+Ak5oTB5fejyXealqFPMwZH
Ozw80gcDA+q4PbLnchldUxqETrmQIgVj8y2E2TmLJjfMhVCEhVD3UjsOD8Mb
GrnqCxx5UKamOQGx6WnOW0UzBMfLVK2mfe6Qr0FW/9lJ7WOPHfXf6XVaWf2b
7XZH1n+vWdb/pwDtq7R+4bms6sYNYZQEx4tv71FUqmyj+NTn2/BxYF9vwxPG
aLRVUbSM2FZVyyjYMMqOQ+S/j0tsxyFxLAgYWu474EQ05uAsMM4uuRUN7tff
+pWx0AuXMu8rZxoys8ThIC5BK1oShqIoB160jJH6zva59UdCEmItiO1aHJYC
JeXkJrH/JxFYtFMvqIKqt6xBihBEi9vXuEOKqQolhvaXJgphyXzKb3TRMa3R
5MW08iSGU6XRAAf7FHHf0kotc8I4U1JCqVCji52eSrNqIPWe7VbLCE8w4NsU
KxKYZ9qH3EvUBH7k8NxHHzsgOumvnFx5ndDYn6NuKeWEbgETRHQONptnrq8T
lvacxMqI+J3PnYWO0ob8VuyOHRMwT7VsgpACeP1Y1pxwy2OEWBKlmzUwU3cE
+J6+TLiVxITpkqEG+vrWVUNYZeQShYOoD1+cX40vV9quGbFv1KdLPDsJ+Mqi
XGY0eXM+Vkwf7h1r4VQx5ejuQ83OC69SjOXAuno9tAbTq8nlvZCB1qjW+4/x
r9oo2ukEUUz+maEXw09maKOqQRX1j7Aj+XaANYkzAAHVusCmbr4z5gKQW8Lu
5M0HfgzRjX13rMRniskGSubo+S0BbFkRqzvCXRSkERecDU2ciGWJ/gfiP0tt
pGfeCzIjMWaGcjskYUy4/lQ0FczM9ybmp2gckacLlJGmqlQlKnjVcHRV2CmD
YD6O3lEcWADTHueL15aargp0WaeSLldFScw1kBSxKhAYweEFS6uvwlygiHah
RMQqNdPTdeUdohmZ+2K+sZwFwz6iZzNe3lWwNykf4TnWZKGYYbNJDWajS9Wk
Bjb9mueqZQu3HbFCnb5DAJvDAipvV2oqof17xIAm4TVyPVlrazXIbCp0hCwf
ilH68EDb9LPEktcDXi3hMiCc7Gifj5/hAzFlJstidvsUbSZLW91cGDaGNoTR
rR2oXL2NfBccJbc9UXkxriKoCd0Z1u3xLB7e+Xg4W4vnSitshAv0J66xPWY1
YV8hcOp404DBAxFLT0cexb177pFD829U9fD8l83/8hGzpxkTWg+//4u//7R6
PTH/t1vtA2jvyZ41eKz5H71om72Vc18I5O+/9M27jz12/f5z0lzFv3mifv/p
tMv336eAwuMp5u7mewpRgb/xhEsotm53Hec5lG88z+K7uCHnjvvo7C2nyfEp
tH26dg95bjr6rx5NngvLDC1uJ/xWs4tekY0Le/rUml1MJ+NfPnIfyflNrwiZ
SuEWIe/x3TT8eXRpvTgfja9mQ2NtBPDcY7lVtrdA4NBIuXhs/Dgdj0eTFYHl
FPMM8qcZDm4evnyaNag31ycDNUl7rryGPncelFBCCSWUUEIJJZRQQgkllFBC
Cf9d+BufzvGTACgAAA==

--1678434306-133161302-1078270355=:9351--
