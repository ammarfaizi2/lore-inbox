Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936424AbWLAOEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936424AbWLAOEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936502AbWLAOEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:04:14 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:61966 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S936501AbWLAOEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:04:13 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       <schwab@suse.de>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Fri, 1 Dec 2006 06:03:26 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEEDABAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <jehcwflrv4.fsf@sykes.suse.de>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 01 Dec 2006 07:06:46 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 01 Dec 2006 07:06:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:
>
> > The problem is that '*(volatile unsigned int *)' results in a 'volatile
> > unsigned int'.
>
> No, it doesn't.  Values don't have qualifiers, only objects have.
> Qualifiers on rvalues are meaningless.

Yeah. That's the problem here. The 'volatile' has no object to qualify. You
are essentially lying to the compiler (telling it the pointer points to a
volatile object when it doesn't) and hoping it does the right thing.

Nothing in the standard requires any special behavior for accesses through
volatile-qualified pointers. It only requires special behavior for access to
objects that are in fact volatile.

I think the technically right solution is some mechanism to define an object
(which can be volatile-qualified) that exists at a particular address.
Accessing this object would be accessing a volatile object and you'd get all
the things the standard promises.

An adequate solution would probably be to make 'readl' return a
volatile-qualified unsigned integer. However, I'd have no complaints if GCC
provided stronger volatile guarantees than the C standard does, assuring
that even subsequent casts or other changes still assure the access takes
place where you expect it to. Just the guarantees in the standard get you
only signals and longjmp.

It comes down to just what those guarantees GCC provides actually are.

DS


