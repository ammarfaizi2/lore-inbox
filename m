Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSGSL2y>; Fri, 19 Jul 2002 07:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318457AbSGSL2y>; Fri, 19 Jul 2002 07:28:54 -0400
Received: from pivsbh1-x0.ms.com ([199.89.64.101]:32646 "EHLO pivsbh1.ms.com")
	by vger.kernel.org with ESMTP id <S318294AbSGSL2x>;
	Fri, 19 Jul 2002 07:28:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15671.63658.675586.540958@axolotl.ms.com>
Date: Fri, 19 Jul 2002 07:31:54 -0400 (EDT)
From: Hildo.Biersma@morganstanley.com
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <20020718195501.A21027@devserv.devel.redhat.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
	<20020716.165241.123987278.davem@redhat.com>
	<1026869741.2119.112.camel@irongate.swansea.linux.org.uk>
	<20020716.172026.55847426.davem@redhat.com>
	<mailman.1026868201.10433.linux-kernel2news@redhat.com>
	<200207180001.g6I015f02681@devserv.devel.redhat.com>
	<15671.8335.526673.92376@axolotl.ms.com>
	<20020718195501.A21027@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:

>> Date: Thu, 18 Jul 2002 16:09:51 -0400 (EDT)
>> From: Hildo.Biersma@morganstanley.com

Pete> The problem with errors from close() is that NOTHING SMART can be
Pete> done by the application when it receives it. And application can:
>> 
Pete> a) print a message "Your data are lost, have a nice day\n".
Pete> b) loop retrying close() until it works.
Pete> c) do (a) then (b).
>> 
>> I must disagree with you.  We run the Andrew File System (AFS), which
>> has client-side caching with write-on-close semantics.  If an error
>> occurs goes wrong at close() time, a well-written application can
>> actually do something useful - such as sending an alert, or letting
>> the user know the action failed.

Pete> The above is an example of an application covering up for
Pete> a filesystem that breaks the general expactions for the
Pete> operating environment. Remember your precursor with a broken
Pete> driver who received his beating a couple of months ago.
Pete> He also had an appliction which processed his errors from
Pete> close just fine. A workaround can be done in every specific
Pete> instance, but it does not make this practice any smarter.

I agree in general, but you should realize that there are valid
reasons why Unix filesystem semantics are sometimes violated.

We have slightly over 8,000 Unix hosts using the same networked
filesystem against the same set of file-servers.  This is only
feasible if you minimize the number of client<->server interactions.

This is done in two ways:
- persistent (disk-based) client-side caching, where the server will
  let a client know if a file is updated and needs to be evicted from
  the client's cache
- close-on-write semantics for files

Pete> What AFS designers should have done if they had a brain larger
Pete> than a pea was:

Pete>  1. Make close to block indefinitely, retrying writes.
Pete>     Allow overlapping writes, let clients to sort it out.

None of these things work, as security may be denied, a volume may be
taken off-line, or hvaing overlppaing writes from clients increases
the amount of client<->server interaction.

Pete>  2. Provide an ioctl to flush writes before close() or
Pete>     make fsync() work right. Your "smart" applications have had
Pete>     to use that, so that no ambiguity existed between tearing down
Pete>     the descriptor and writing out the data.

This is provided - sync, fsync, msync all work.

Pete> This way, naive applications such as cat and cc would
Pete> continue to work. There is no reason to penalize them just
Pete> because some application _could_ possibly post idiotic alerts
Pete> (Abort, Retry, Fail).

That's work the trade-offs come in.  The AFS designers found that
relaxing the Unix filesystem semantics vastly improves scalability.

Many of the high-performance filesystems (not XFS, the _really_
high-performance filesystems) that you run on supercomputers also
vioilate Unix semantics in various ways.  Yes, that breaks na\"ive
apps, but that trade-off is generally accepted.
