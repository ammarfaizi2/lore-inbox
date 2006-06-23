Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932882AbWFWGeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbWFWGeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbWFWGeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:34:24 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:35558 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932882AbWFWGeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:34:23 -0400
Date: Thu, 22 Jun 2006 23:34:20 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 17/25] x86_64 irq: Remove the msi assumption that irq ==
 vector
Message-ID: <Pine.LNX.4.61.0606222331090.1213@osa.unixfolk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric and I had a brief side discussion, which we thought should
be shared with the other folks interested in this issue.

On Thu, 22 Jun 2006, Eric W. Biederman wrote:
| > Will there any (exported) way for a driver to find out the actual vector
| > corresponding
| > to it's irq?
|
| Not in a good way.  The vector changes at runtime, when the irq
| is migrated between cpus.

Since this has to be handled for MSI in general, it should be possible
to handle it for HyperTransport as well.

Our InfiniPath HT chip has an additional constraint that it needs a callback if
the vector changes, because a register past the config space also
has to change.

Or we have to have a way to disable migration from the driver (probably
not a bad idea anyway, for performance sensitive drivers), or both.

| > If not, this will break the infinipath HTX driver, which needs to
| > program the vector into the HT config space of our chip (something the
| > MSI infrastructure does for PCI and PCI-e, but which doesn't exist for
| > HT, so I do it myself).
|
| Right we need a cousin of msi layer to implement generic HT interrupt
| support.  Otherwise whatever we implement will be prone to break.
|
| The good news is this should be much easier to implement now than
| it was earlier.
|
| > Before the MSI support changed what request_irq() returned, I either
| > had to do some heuristics to figure out the vector, or hack a way into
| > the kernel so I could get the vector.
|
| So far I see what your driver is doing as a hack, who's only excuse

Agreed.

| is that there isn't generic code to do better.  However now that
| this code isn't scheduled to go in before 2.6.19 I expect we can
| have a generic HT layer before this code reaches a stable kernel.
|
| Looking at the ipath_ht400.c driver your code appears to have the side
| effect of always binding to cpu 0, and always in fix physical mode.
| Ok on small systems but probably not what you want on systems with
| multiple instances of this chip.

Definitely not what's wanted for multiple instances on large systems in
all cases (from a cache perspective, multiple adapters interrupting on
the same processor isn't necessarily bad, but beyond 2 per cpu is
a real problem with openib, in terms of available cpu cycles).

| I was thinking earlier because of the on the wire similarities I could
| share msi_ops between the implementations.  But the HT code really
| implements this quite differently much more like an io_apic in it's
| register layout so I guess a ht_ops is needed.

Probably.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave

