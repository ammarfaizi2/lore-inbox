Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTDVIDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTDVIDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:03:50 -0400
Received: from [213.69.58.83] ([213.69.58.83]:49162 "EHLO invsv002.invision.de")
	by vger.kernel.org with ESMTP id S262985AbTDVIDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:03:48 -0400
Subject: inconsistent usage of 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
From: Heiko.Rabe@InVision.de
Date: Tue, 22 Apr 2003 10:11:11 +0200
X-MIMETrack: Serialize by Router on invsv002/InVision/DE(Release 5.0.8 |June 18, 2001) at
 04/22/2003 10:11:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found inconsistent behavoir between SMP oand none SMP kernels using spin
locks inside driver programming
As first an simple example:

static spinlock_t        qtlock               = SPIN_LOCK_UNLOCKED;

void foo()
{
     unsigned long  local_flags;
     spin_lock_irqsave (&qtlock, local_flags);
     spin_lock_irqsave (&qtlock, local_flags);
}

Calling the function foo() works proper in none SMP kernels. I assume, the
spinlocks internaly will be initialized as
recursive semaphore as default. So it is possible to aquire it more than
once by the same thread.

If foo() has been called using a SMP kernel, it freezes the kernel. I
assume that the semaphore object will be initialized as
default to be none recursive. So the semaphore can't aquired a second time
from the same thread.

I found it during investigation of open source ISDN USB external Box
drivers, that is well working in none SMP kernels
but freeze at SMP kernels. Course i have an SMP kernel, i run into the
freeze problem shown above.
The example is only the simple structure about, it's not coded in that way
inside the driver but results in this scenario.
I have fixed the problem at driver to work well at SMP kernels too, but it
seems to be a general issue.

I think, semaphores should be have the same behavoir (default
initialization) at SMP and none SMP kernels. Some code
problems running software at SMP kernels that freeze could be avoided, if
we had a consistent default behavoir of semaphores.

Is the there any reason for this difference i doesn't know ?
Could this be handled in cosistent behavoir handling ?

regards

Heiko Rabe
Senior Developer
InVision Software AG
Tel.: +49-(0)341/497208-12
Fax: +49-(0)2102/728-111
mailto:heiko.rabe@invision.de

