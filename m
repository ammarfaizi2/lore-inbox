Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbTCGHaY>; Fri, 7 Mar 2003 02:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbTCGHaX>; Fri, 7 Mar 2003 02:30:23 -0500
Received: from imap.gmx.net ([213.165.65.60]:12196 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261410AbTCGHaP>;
	Fri, 7 Mar 2003 02:30:15 -0500
Message-Id: <5.2.0.9.2.20030307075851.00cf5448@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 08:45:22 +0100
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Cc: rml@tech9.net, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20030306124257.4bf29c6c.akpm@digeo.com>
References: <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
 <20030228202555.4391bf87.akpm@digeo.com>
 <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_13943609==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_13943609==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 12:42 PM 3/6/2003 -0800, Andrew Morton wrote:
>Ingo's combo patch is better still - that is sched-2.5.64-a5 and your patch
>combined (yes?).  The slight mouse jerkiness is gone and even when doing
>really silly things I cannot make it misbehave at all.  I'd handwavingly
>describe both your patch and sched-2.5.64-a5 as 80% solutions, and the combo
>95%.

Weeeeell, FWIW my box (p3-500/128mb/rage128) disagrees.

I can still barely control the box when a make -j5 bzImage is running under 
X/KDE in one terminal and a vmstat (SCHED_RR) in another. I'm not swapping, 
though a bit of idle junk does page out.  IOW, I think I'm seeing serious 
cpu starvation.

For reference, I used to be able to easily control the same box under X 
while swapping moderately at make -j15 (during page aging vm days), and 
with a heavily twiddled VM at even -j30 (_way_ overloaded with X oinkers 
running).  At -j5, gui/icky was quite usable.

With the make -j30 bzImage, heavy load which does _hit_ VM saturation but 
not constantly, I see what I can only describe as starvation.  vmstat 
output for this load is definitely abby-normal, and there's no way 
/proc/vmstat should look like the attached.  It takes forever to build 
enough vm pressure that swap is touched (bad bad bad), and the volume 
reached is way low.  My hungry little cc1's are not sharing resources the 
way they should be (methinks).

With earlier versions of Ingo's patch, I was only able to get memory 
pressure up to where it should be by drastically reducing timeslice (at the 
expense of turning throughput to crud).  Take this with a giant economy 
sized grain of salt, but what I _think_ (no, I haven't instrumented it) is 
happening is that chunks of the total job are being rescheduled in front of 
the rest of the job such that they alloc/use/exit before the other guys can 
alloc.  (geez that's a nebulous WAG;)

         -Mike  (please torch me if I'm being stupid;) 
--=====================_13943609==_
Content-Type: text/plain; name="data.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="data.txt"

Ym94ID0gcDMvNTAwLzEyOE1CCmZyZXNoIGJvb3QKdGltZSBtYWtlIC1qMzAgYnpJbWFnZQpjYXQg
L3Byb2Mvdm1zdGF0CgogICAgICAgICAgICAgICAgICAyLjUuNjQtQjMgIDIuNS42NC12aXJnaW4K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCm5yX2RpcnR5ICAgICAg
ICAgICAgICAgICA2NCAgICAgICAgICAgMjQ0OApucl93cml0ZWJhY2sgICAgICAgICAgICAgIDAg
ICAgICAgICAgICAgIDAKbnJfcGFnZWNhY2hlICAgICAgICAgICA3NDMyICAgICAgICAgICA3NTYy
Cm5yX3BhZ2VfdGFibGVfcGFnZXMgICAgICA4NSAgICAgICAgICAgICA4NQpucl9yZXZlcnNlX21h
cHMgICAgICAgIDMzNDggICAgICAgICAgIDMxNzcKbnJfbWFwcGVkICAgICAgICAgICAgICAgNjM0
ICAgICAgICAgICAgNTc5Cm5yX3NsYWIgICAgICAgICAgICAgICAgMTIzOSAgICAgICAgICAgMTIz
NQpwZ3BnaW4gICAgICAgICAgICAgICAyODg1NjAgICAgICAgICA2OTI3MjUKcGdwZ291dCAgICAg
ICAgICAgICAgMjI4ODAzICAgICAgICAgNTg3NTcyCnBzd3BpbiAgICAgICAgICAgICAgICAzMDcz
NCAgICAgICAgIDExNjA5Nwpwc3dwb3V0ICAgICAgICAgICAgICAgNDczNDcgICAgICAgICAxMzg4
ODgKcGdhbGxvYyAgICAgICAgICAgICAgOTE4MDE2ICAgICAgICAxMDQ2MzY5CnBnZnJlZSAgICAg
ICAgICAgICAgIDk0MDc0NCAgICAgICAgMTA2ODk4MwpwZ2FjdGl2YXRlICAgICAgICAgICAgMjg1
NzcgICAgICAgICAgNDU1NjYKcGdkZWFjdGl2YXRlICAgICAgICAgIDU1MjY1ICAgICAgICAgMTcy
ODMzCnBnZmF1bHQgICAgICAgICAgICAgMTU3OTUxNyAgICAgICAgMTY4MjQ2NgpwZ21hamZhdWx0
ICAgICAgICAgICAgIDg0NjMgICAgICAgICAgMjgxMzcKcGdzY2FuICAgICAgICAgICAgICAgNTU2
MDQxICAgICAgICAxNjc4MzE1CnBncmVmaWxsICAgICAgICAgICAgIDIxMTU0MiAgICAgICAgIDY0
MzU2NApwZ3N0ZWFsICAgICAgICAgICAgICAgNzczMTEgICAgICAgICAxOTQyMTYKcGdpbm9kZXN0
ZWFsICAgICAgICAgICAgICAwICAgICAgICAgICAgICAwCmtzd2FwZF9zdGVhbCAgICAgICAgICA3
MzQ1NCAgICAgICAgIDE3MzM3OAprc3dhcGRfaW5vZGVzdGVhbCAgICAgMTEwNjkgICAgICAgICAg
MTEzMTcKcGFnZW91dHJ1biAgICAgICAgICAgICAgMjIyICAgICAgICAgICAgNTA5CmFsbG9jc3Rh
bGwgICAgICAgICAgICAgICA4NSAgICAgICAgICAgIDQ4MApwZ3JvdGF0ZWQgICAgICAgICAgICAg
NDk3OTggICAgICAgICAxNDA5NTYK
--=====================_13943609==_--

