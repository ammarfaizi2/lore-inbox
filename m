Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318368AbSGRXwD>; Thu, 18 Jul 2002 19:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318396AbSGRXwD>; Thu, 18 Jul 2002 19:52:03 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60180 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318368AbSGRXwD>; Thu, 18 Jul 2002 19:52:03 -0400
Date: Thu, 18 Jul 2002 19:55:01 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hildo.Biersma@morganstanley.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value
Message-ID: <20020718195501.A21027@devserv.devel.redhat.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716.165241.123987278.davem@redhat.com> <1026869741.2119.112.camel@irongate.swansea.linux.org.uk> <20020716.172026.55847426.davem@redhat.com> <mailman.1026868201.10433.linux-kernel2news@redhat.com> <200207180001.g6I015f02681@devserv.devel.redhat.com> <15671.8335.526673.92376@axolotl.ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15671.8335.526673.92376@axolotl.ms.com>; from Hildo.Biersma@morganstanley.com on Thu, Jul 18, 2002 at 04:09:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 18 Jul 2002 16:09:51 -0400 (EDT)
> From: Hildo.Biersma@morganstanley.com

> Pete> The problem with errors from close() is that NOTHING SMART can be
> Pete> done by the application when it receives it. And application can:
> 
> Pete>  a) print a message "Your data are lost, have a nice day\n".
> Pete>  b) loop retrying close() until it works.
> Pete>  c) do (a) then (b).
> 
> I must disagree with you.  We run the Andrew File System (AFS), which
> has client-side caching with write-on-close semantics.  If an error
> occurs goes wrong at close() time, a well-written application can
> actually do something useful - such as sending an alert, or letting
> the user know the action failed.

The above is an example of an application covering up for
a filesystem that breaks the general expactions for the
operating environment. Remember your precursor with a broken
driver who received his beating a couple of months ago.
He also had an appliction which processed his errors from
close just fine. A workaround can be done in every specific
instance, but it does not make this practice any smarter.

What AFS designers should have done if they had a brain larger
than a pea was:

 1. Make close to block indefinitely, retrying writes.
    Allow overlapping writes, let clients to sort it out.
 2. Provide an ioctl to flush writes before close() or
    make fsync() work right. Your "smart" applications have had
    to use that, so that no ambiguity existed between tearing down
    the descriptor and writing out the data.

This way, naive applications such as cat and cc would
continue to work. There is no reason to penalize them just
because some application _could_ possibly post idiotic alerts
(Abort, Retry, Fail).

-- Pete
