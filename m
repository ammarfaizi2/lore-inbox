Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132111AbRCVRXh>; Thu, 22 Mar 2001 12:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132113AbRCVRX2>; Thu, 22 Mar 2001 12:23:28 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:61193 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S132111AbRCVRXS>; Thu, 22 Mar 2001 12:23:18 -0500
Reply-To: <frey@cxau.zko.dec.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 09:21:45 -0800
Message-ID: <007001c0b2f4$a4630110$90600410@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010322150752.27184@mailhost.mipsys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>> http://www.scs.ch/~frey/linux/kernelthreads.html

>Could you explain me a bit why you need the lock_kernel ? My probe
>thread is already protected by some atomic ops, but I'm considering
>changing them to semaphores. Is there any need for the bkl to be taken
>when calling daemonize or is this just for your own 
>syncronisation needs ?
>
The stuff done in daemonize() and the exit_files could need
the kernel lock. At least on some 2.2.x version it does,
I did not check whether it is still needed on 2.4.

On stop of the thread I need the big kernel lock to make
sure the kernel thread exited (everything really done
from my up() till the thread is in zombie state) before
I unload the module. The comment in the code should explain 
in.

Note that the threads itself do not run with the kernel lock
held. After setting everything up the make an unlock.

>I don't think you do more than what I currently do to prevent the
>zombie (except for the daemonize call, I don't see you 
>changing anything
>about the parent thread or whatever). 
>
No, changing the parent thread is done by daemonize().

>At first I though daemonize() would do the trick, but I still see
>zombies on my tests. I'm running UP now so I don't since my lack
>of lock_kernel() could explain it.
>
I needed the exit_files() on 2.2.x to prevent the zombies. On 2.4
daemonize() does that as well.

In the kill_thread() call I actually wait till the thread has
terminated. This is assured with the semaphore and the big kernel
lock. I did have problems when I just sent the termination signal
and unloaded the module, but since I really block there I did not
see zombies. I stress-tested the module for several days in a loop
- no zombies at all.

Regards,

Martin
