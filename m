Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVAXUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVAXUpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVAXUnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:43:25 -0500
Received: from mail.inter-page.com ([207.42.84.180]:53516 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261644AbVAXUnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:43:01 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Ulrich Drepper'" <drepper@gmail.com>,
       "'Brent Casavant'" <bcasavan@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Pollable Semaphores
Date: Mon, 24 Jan 2005 12:42:39 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAANFFChaf6nUyxc8R7DAo09gEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <a36005b5050121194377026f39@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other obvious problem is that if there are contenders on the semaphore, the
semaphore may well not remain acquirable between the return from select and the call
to actually acquire the semaphore.

What I'd think you need is a "device" that you open, then attach a semaphore to (with
an ioctl()?), then you would write increment/decrement actions to the device file
descriptor and it would reply with the results.

By making the write and read actions be "normal" and "atomic" you end up with normal
produce/consume file operations and so normal interaction with poll/select.

I would imagine [off the top of my head] that each device node would have to have
some kind of tasklet-like (but blockable) context that could wait for the semaphore
in a non-blocking way.  (Actually I'd imagine a reverse hook in the semaphore itself
that would contain a linked-list of inactive tasklet references which would each be
activated on a suitable semaphore operation (increment).

The short version is that the "available" state must be atomic with the actual
decrement operation or you will probably end up blocking in the decrement after the
select() anyway.  Once you factor that in, all sorts of more-classic models suggest
themselves.

Rob White,
Casabyte, Inc.



