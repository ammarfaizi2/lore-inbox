Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWFPMPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWFPMPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWFPMPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:15:16 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25748 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751373AbWFPMPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 08:15:15 -0400
Date: Fri, 16 Jun 2006 21:15:55 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before
 crashing
Message-Id: <20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 00:28:08 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Please give a concrete example of a failure mode where this allows
> you to meet your timing constraint.
> 
> I have yet to be convinced that this actually solves a real world
> problem.
> 
> What is the cost of the notifier you wish to implement?
> What is your guarantee that the system won't have wasted seconds
> detecting it can't allocate memory or other cases?
> 
> If we go this route the notifier should not be exported to modules.
> Only the most scrutinized of code paths should ever set this,
> and code like that should never be a module.
> 
> The patchset that adds the notifier call needs to include the notifier
> so people can look and see how sane this is.
> 
> So far what I have seen are hand waving arguments that failures
> that can never happen must be detected and reported within
> milliseconds to another machine in an unspecified manner.  Your kernel
> startup times are asserted to be to large to do this from the next
> kernel, but the code to do so is sufficiently complicated you can't do
> this in the kexec code stub that runs before it starts your next
> kernel.
> 
> I am sympathetic but this interface seems to set expectations that
> we can the impossible, and it still appears unnecessary to me.

As I mentioned many times, this notifier is very effective in the
clustering system. Actually the Red Hat's kernel has a notifier
at the same point like this patch. I know a real system that failover
of DB server is immediately done by using this notifier.
It takes much cost to keep consistency of transaction processing
on DB system. Therefore, to shorten down time, it is very important
to immediately know that the system dies. In a mission critical system,
millisecond order or less is demanded.
The processing of the notifier is to make a SCSI adaptor power off to
stop writing in the shared disk completely and then notify to standby-node.
But as you think, it is sure not to necessarily become this scenario.
For instance, if the kernel hangs, the failure can be detected only
by heart-beat. In this case the detection time becomes longer.

Anyway this notifier is very effective and important in the actual world. 
Another example is as follows:

http://lists.osdl.org/pipermail/fastboot/2006-June/003028.html

Thanks,

Akiyama, Nobuyuki

