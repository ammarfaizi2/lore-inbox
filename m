Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTDSU1H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTDSU1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:27:07 -0400
Received: from [12.47.58.203] ([12.47.58.203]:44497 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263459AbTDSU1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:27:04 -0400
Date: Sat, 19 Apr 2003 13:38:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030419133837.0118907b.akpm@digeo.com>
In-Reply-To: <20030419153923.6d63e22b.philippe.gramoulle@mmania.com>
References: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
	<20030418175116.75c8aa7b.akpm@digeo.com>
	<20030419153923.6d63e22b.philippe.gramoulle@mmania.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 19 Apr 2003 20:38:59.0433 (UTC) FILETIME=[B4898590:01C306B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé <philippe.gramoulle@mmania.com> wrote:
>
> [ SMP IRQ distribution ]
>
> Is this what you are looking for ? and are the values changes meaningful ?

Looks good to me.  But it didn't affect your machine at all, did it?

This stuff only counts when the machine is doing a lot of work.  The current
IRQ balancer works well under high interrupt frequencies, but does quite the
wrong thing if you're doing a lot of softirq work at low interrupt
frequencies (gige routing with NAPI).

My gut feel is that we'll never get this right with a single in-kernel IRQ
balancer.  So the proposal is to pull the IRQ balancer out altogether and to
then merge Arjan's userspace balancer into the main kernel tree.

It's a little radical to go placing userspace daemons into the kernel tree,
but I think it is appropriate - this thing is very tightly coupled to the
kernel.

The proposal has these advantages:

- No version skew problems: if the format of /proc/interrupts changes, we
  patch the irq balance daemon at the same time.

- Can build irqbalanced into the intial initramfs image as part of kernel
  build. (lacking klibc, we would need to statically link against glibc)

- Doing it in userspace means that we can do more things.

  - The balancer can "know about" the differences between NICs, disk
    controllers, etc.

  - The balancer can be controlled by config files: "I am a router"

  - The balancer can support non-x86 architectures


Anyway, that's the theory.  None of it has been done yet.
