Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136282AbRD1AgI>; Fri, 27 Apr 2001 20:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136283AbRD1Af6>; Fri, 27 Apr 2001 20:35:58 -0400
Received: from elin.scali.no ([195.139.250.10]:785 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S136282AbRD1Afo>;
	Fri, 27 Apr 2001 20:35:44 -0400
Message-ID: <3AEA11F5.3D54828@scali.no>
Date: Fri, 27 Apr 2001 19:42:29 -0500
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17-16enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Question regarding kernel threads and userlevel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-kernel,

I have a question regarding kernel threads : Are kernel threads treated equally
in terms of scheduling as normal userlevel processes ??

In my test case I have a driver for a PCI card from which I want to control
access to it's memory (prefetchable PCI space). Userlevel processes can mmap
this PCI memory and write directly to it (via the nopage technique). This is
also possible from the kernel thread, but to avoid trashing and short bursts on
the PCI bus, I protect every access to the memory space with a spin lock (a
mmapped kernel memory page which the driver initializes). That means if you
have a SMP system and two userlevel processes wants to write to this memory,
one will have to wait for the other before doing the memcpy (yep I'm using what
you can call PIO). This works great for two userlevel processes.

Now the reason for my question is; if also I have a kernel thread wanting to
write to this memory space it will also have to wait for the same lock (though
not mmapped since we are already in kernel space and can access the lock page
directly). What happens, is that if a userlevel process holds this lock and the
kernel thread gets scheduled and tries to get the same lock it will deadlock
because the userlevel process never gets back control and releases the lock
(kinda like when you spinlock in interrupt level on a lock wich is locked
without spinlock_irq). Is this because the kernel thread has higher priority
than the user level process (it has a nice level of -20) ?

Best regards,
-- 
 Steffen Persvold                        Systems Engineer
 Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
 Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
          Fax  : (+47) 2262 8951         N-0621 Oslo, Norway

 USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
                                         Houston, Texas 77042, USA
