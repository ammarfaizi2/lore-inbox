Return-Path: <linux-kernel-owner+w=401wt.eu-S1750847AbXAVITZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXAVITZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXAVITZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:19:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:10281 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbXAVITZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:19:25 -0500
Message-ID: <d4cf37a60701220019h7cae91f6nc33bd24761a54c67@mail.gmail.com>
Date: Mon, 22 Jan 2007 00:19:23 -0800
From: "Wink Saville" <wink@saville.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Asynchronous Messaging
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have implemented a technique which allows a kernel-space thread
or ISR to communicate with user-space or kernel-space threads
asynchronously and without having to copy data (zero copy).

The solution I came up with I call ACE, Atomic Code Execution. As the
name implies once code starts executing within the ACE environment,
that code is guaranteed to complete before any other code will run.

This is accomplished by allocating a page (or more) of memory which
is executable and mapped into every threads address space. Also, all
ISR entry points are modified to detect if the code that was interrupted
was executing within the ACE page. If it was then the ACE code is
allowed to complete before the ISR continues. This then provides
the guarantee of atomic execution.

Another way to look at it is that it gives user space programs the
capability to disable/enable interrupts thus allowing user space code
to execute the equivalent of spin_lock_irqsave() and
spin_unlock_irqrestore().

I then implemented asynchronous messaging with zero copy by implementing
link list operations within the ACE page, allocating the messages
and auxiliary memory globally using vmalloc and adding the notion of a
mproc (message processor) which encapsulates the a thread
and a queue.

I believe the ACE technique and the mproc idea could be used for several
purposes beyond my desire to write event driven applications. In particular
I could see it as a means of implementing device drivers written in user space
as well as a possible technique for communicating with virtual machines such
as Xen or KVM.

Currently, the proof of concept code runs on an Core 2 Duo. For those that
are interested the code is available as a patch against 2.6.19
at http://www.saville.com/linux/async.

I have been using asynchronous messaging for 4+ years and have found that
it provides very interesting properties, but is hindered because it is not
directly supported by operating systems. I am very interested in getting
feedback on the idea of including asynchronous messaging within the kernel.

Thank you,

Wink Saville
