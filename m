Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVLGQIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVLGQIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVLGQIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:08:43 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:11997 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751158AbVLGQIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:08:42 -0500
Date: Wed, 7 Dec 2005 11:08:39 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Oliver Neukum <oliver@neukum.org>, <linux-usb-devel@lists.sourceforge.net>,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
 spin lock to atomic_t.
In-Reply-To: <Pine.LNX.4.61.0512071015350.8843@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L0.0512071104110.21143-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, linux-os (Dick Johnson) wrote:

> You need to know what it is that you intend to do if the code
> encounters a locked section.
> 
> For example, let's pretend that every operation is atomic so
> that only the logic is investigated...
> 
>  	if(!critical_section_flag) {
>              critical_section_flag = TRUE;
>              do_something_in_critical_section();
>          }
>          else
>              WTF?;
> 
> 
> A spin-lock will prevent the current CPU from even getting to
> or modifying data in the critical section because alternate paths
> via interrupts are blocked. The only other way for data to be
> modified is from another CPU. That CPU will spin until the current
> CPU releases the lock.
> 
> Atomic operations on flags (semaphores) provide the opportunity
> for another CPU to do something useful until the critical section
> is released, the WTF above. However, if the other CPU can't
> schedule you are caught between a rock and a hard-place because
> you would need to spin anyway.
> 
> Basically, if you can schedule, it's much better to protect
> a section with semaphores and do the down(&semi) / up(&semi) thing.
> If you can't schedule, it's much cleaner to use a spin-lock
> which, in fact, will prevent interference with the critical
> section in most cases because, unless another CPU is idle,
> it is unlikely to encounter the same thread of code.

That's true as far as it goes.  But it ignores the possibility that, for
example, the critical section is extremely short (like incrementing an
integer variable).  In such situations, spinning is better than
scheduling.  And even better than spinning is for the CPU to wait while
another CPU carries out a locked bus cycle (which is what atomic_t
operations do on x86).  As well as being more efficient, it may even be
"cleaner" -- depending on one's personal taste.  :-)

Alan Stern

