Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSHFWZW>; Tue, 6 Aug 2002 18:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHFWZW>; Tue, 6 Aug 2002 18:25:22 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:28828 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316210AbSHFWZU>;
	Tue, 6 Aug 2002 18:25:20 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208062228.CAA25818@sex.inr.ac.ru>
Subject: Re: "new style" netdevice allocation patch for TUN driver
To: maxk@qualcomm.com (Maksim)
Date: Wed, 7 Aug 2002 02:28:44 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020806135501.09799218@mail1.qualcomm.com> from "Maksim" at Aug 6, 2 02:08:37 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Please explain to me why do we have to hold rtnl lock while sleeping in
> unregister_netdevice ?

... not "while sleeping", but just "while".

If the lock would be for the device, it would be local to the device,
rather than global. The semaphore blocks all the networking configuration
until caller will complete stuff related to unregistering.

Forward references from the unregistered device under cannot be invalidated
before the device is unregistered. All such work is done after unregistry
for "old style" or in dev->uninit/destructor hooks, which are used
by "new style" devices.


> 1 - Something is not releasing device

Let's find this something! It witnesses about really serious bug.

I cannot reproduce this too. Understand, please, we _can_ follow
your proposal, all 100% of old style devices do not need uninit in real
life. But then we never will find the bug. You cannot reproduce it,
I cannot too.


> 2 - We're sleeping with the rntl_lock held

Semaphores are used exaclty when we have to sleep while holding lock.


> fix it. If one thing is buggy it doesn't mean

It means exactly this. Kernel panic would be even better, if it was
possible to detect deadlock reliably.

Alexey
