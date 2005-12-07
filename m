Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVLGPch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVLGPch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLGPch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:32:37 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:43787 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751134AbVLGPcg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:32:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
X-OriginalArrivalTime: 07 Dec 2005 15:32:32.0759 (UTC) FILETIME=[7106F870:01C5FB43]
Content-class: urn:content-classes:message
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Date: Wed, 7 Dec 2005 10:32:25 -0500
Message-ID: <Pine.LNX.4.61.0512071015350.8843@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Thread-Index: AcX7Q3EQCOngPOIETIultE6Fx6F/og==
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Oliver Neukum" <oliver@neukum.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Eduardo Pereira Habkost" <ehabkost@mandriva.com>,
       "Greg KH" <gregkh@suse.de>,
       "Luiz Fernando Capitulino" <lcapitulino@mandriva.com.br>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Dec 2005, Alan Stern wrote:

> On Tue, 6 Dec 2005, Oliver Neukum wrote:
>
>> Am Dienstag, 6. Dezember 2005 21:13 schrieb Eduardo Pereira Habkost:
>>> Anyway, I don't see yet why the atomic_t would make the code slower on
>>> non-smp. Is atomic_add_unless(v, 1, 1) supposed to be slower than
>>> 'if (!v) v = 1;' ?
>>
>> spin_lock() can be dropped on UP. atomic_XXX must either use an operation
>> on main memory, meaning less efficient code generation, or must disable
>> interrupts even on UP.
>
> atomic_add_unless is sort of a special case.  It doesn't have a clean
> simple implementation, unlike most of the other atomic_t operations.  If
> an equivalent result could be obtained using, e.g., atomic_inc_and_test,
> that would be a better approach.
>
> On the other hand, Oliver needs to be careful about claiming too much.  In
> general atomic_t operations _are_ superior to the spinlock approach.  If
> they weren't, atomic_t wouldn't belong in the kernel at all.
>
> Alan Stern

You need to know what it is that you intend to do if the code
encounters a locked section.

For example, let's pretend that every operation is atomic so
that only the logic is investigated...

 	if(!critical_section_flag) {
             critical_section_flag = TRUE;
             do_something_in_critical_section();
         }
         else
             WTF?;


A spin-lock will prevent the current CPU from even getting to
or modifying data in the critical section because alternate paths
via interrupts are blocked. The only other way for data to be
modified is from another CPU. That CPU will spin until the current
CPU releases the lock.

Atomic operations on flags (semaphores) provide the opportunity
for another CPU to do something useful until the critical section
is released, the WTF above. However, if the other CPU can't
schedule you are caught between a rock and a hard-place because
you would need to spin anyway.

Basically, if you can schedule, it's much better to protect
a section with semaphores and do the down(&semi) / up(&semi) thing.
If you can't schedule, it's much cleaner to use a spin-lock
which, in fact, will prevent interference with the critical
section in most cases because, unless another CPU is idle,
it is unlikely to encounter the same thread of code.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
