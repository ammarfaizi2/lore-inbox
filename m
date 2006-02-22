Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWBVRqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWBVRqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWBVRqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:46:04 -0500
Received: from spirit.analogic.com ([204.178.40.4]:62471 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751380AbWBVRqC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:46:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <60bb95410602220900n440564d7xb459d47c8ca30997@mail.gmail.com>
x-originalarrivaltime: 22 Feb 2006 17:46:01.0622 (UTC) FILETIME=[D87D3B60:01C637D7]
Content-class: urn:content-classes:message
Subject: Re: Kernel thread removal
Date: Wed, 22 Feb 2006 12:45:55 -0500
Message-ID: <Pine.LNX.4.61.0602221229280.10931@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel thread removal
Thread-Index: AcY319iEnmxPpv7yQIyh1zA55HHn3g==
References: <60bb95410602220900n440564d7xb459d47c8ca30997@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "James Yu" <cyu021@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Feb 2006, James Yu wrote:

> How do I remove a kernel thread in kernel mode ?
> I write a C-function in one of the Linux source files and create a
> kernel thread by invoking kernel_thread() to run the function, like:
> "kernel_thread(a1, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);"
> Function a1 simply invokes printk() to output some message on console.
> I invoke do_exit(0); at the end of a1, but a1's task_struct still
> exists in in task_struct list after its execution.
> How do I remove it a1's task_struct upon its completion? I thought
> explicitly invoke do_exit() ensures the removal of task_struct?
> -

This is becoming a FAQ. In the main loop that your kernel thread
executes, you do:

 		if(signal_pending(current))
                     complete_and_exit(&struct_completion, status_value);


In the module exit code, or wherever you want to shut down the
kernel thread, you do:

 		kill_proc(thread_pid, some_unblocked_signal, 1);
 		wait_for_completion(&struct_completion);

Remember to do init_completion(&struct_completion) in the startup
code, and to unblock the signal the kernel thread is supposed to
receive, SIGTERM is a good one.

The secret of success is that the kernel thread needs to
exit in the context of the kernel thread, and somebody needs to
pick up its status. Re-parenting to `init` will not always
work for reaping child status because `init` needs to get the
CPU at the time that you, in the module-remove routine, may
have the CPU. This might deadlock. The solution is above.

A final word, both complete_and_exit() and wait_for_completion()
need to be free of any spin-locks.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
