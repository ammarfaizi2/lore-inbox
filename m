Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSEONI1>; Wed, 15 May 2002 09:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSEONIW>; Wed, 15 May 2002 09:08:22 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:10706 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S312447AbSEONIS>; Wed, 15 May 2002 09:08:18 -0400
From: <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>
Cc: Neil Conway <nconway.list@ukaea.org.uk>,
        Anton Altaparmakov <aia21@cantab.net>,
        Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 61
Date: Wed, 15 May 2002 15:08:11 +0100
Message-Id: <20020515140811.15825@mailhost.mipsys.com>
In-Reply-To: <E177yXY-0001t9-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The problem is that with the busy flag on we are wasting quite
>> a significant amount of CPU time spinning around it for no good...
>
>Why spin on the busy flag. Instead you just let the person who clears
>the flag check the pending work and do it. 

Which is what happened in most cases, pending work could be resumed by
calling ide_do_request() (in the previous codebase).

I used/needed this feature when implementing machine sleep support on
PowerMac laptops. I basically got the lock, set busy flag on all interfaces
then release the lock (well, I did the proper wait for interface not to
be busy etc... but you get the point).

That way, I am sure that newly incoming requests would be queued and not
sent to HW while the controller is going to sleep (and then the entire
machine).

On wakeup, I do the opposite. After reviving the controller and the disk,
I clear the busy flag and call ide_do_request() to get things back.

I need to be able to do something similar with the new codebase, though
I beleive that should be part of the generic code for power management
when the controller gets a suspend request. In theory, it should issue
a device-specific suspend command (that is SLEEP for IDE disks, etc...)
and make sure the busy flag doesn't get cleared upon termination on this
command (thus blocking queues) until the machine gets woken up.

Ben.



