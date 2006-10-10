Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWJJFOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWJJFOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWJJFOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:14:11 -0400
Received: from ozlabs.org ([203.10.76.45]:53154 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964980AbWJJFOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:14:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17707.11292.661824.337474@cargo.ozlabs.ibm.com>
Date: Tue, 10 Oct 2006 15:14:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Why is device_create_file __must_check?
In-Reply-To: <20061009214936.a2788702.akpm@osdl.org>
References: <17707.8801.395100.35054@cargo.ozlabs.ibm.com>
	<20061009214936.a2788702.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> There are no super-strong reasons here, but if device_create_file() fails
> then the required control files aren't there and the subsystem isn't
> working as intended.  If it's in a module then we should fail the modprobe. 
> If it's a bootup thing then best we can do is to panic.  Or at least log
> the event.

In the case of the windfarm driver, the sysfs files are reporting
things like cpu voltage, current, temperature etc. which can be
interesting to know about, but the sysfs files are not essential to
the operation of the driver.  So just some cheesy printk would do in
that sort of situation, I guess.

> The most common cause of this is a programming error: we tried to create
> the same entry twice.   We want to know about that.

In that case a WARN_ON inside device_create_file when the duplicate is
detected would be better - less code, and only one place where the
check needs to be done.  The WARN_ON will give us a backtrace so we
can see where the second creation attempt happened.

> Because it can fail.  We need to take _some_ action if the setup failed - at
> least report it so the user (and the kernel developers) know that something
> is going wrong.

So we have to add printks in all sorts of places where the
device_create_file has never failed before.  If you're that concerned,
why not add a WARN_ON(error) in device_create_file() ?

Paul.
