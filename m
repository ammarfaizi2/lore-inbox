Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVDLXxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVDLXxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVDLXqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:46:00 -0400
Received: from fmr17.intel.com ([134.134.136.16]:25793 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S263036AbVDLXJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:09:42 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FUSYN and RT
Date: Tue, 12 Apr 2005 16:09:04 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FD4731@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FUSYN and RT
Thread-Index: AcU/r7T+C9DGC4GJQVipfBCDdoPlPQAAF8ew
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>
Cc: "Esben Nielsen" <simlo@phys.au.dk>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>
X-OriginalArrivalTime: 12 Apr 2005 23:09:06.0507 (UTC) FILETIME=[A03EF1B0:01C53FB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>On Tue, 2005-04-12 at 15:26, Perez-Gonzalez, Inaky wrote:
>
>> You should not need any of this if your user space mutexes are a
>> wrapper over the kernel space ones. The kernel handles everything
>> the same and there is no need to take care of any special cases or
>> variations [other than the ones imposed by the wrapping].
>
>The problem situation that I'm thinking of is when a task gets priority
>boosted by Fusyn , then gets priority boosted by an RT Mutex. In that
>situation, when the RT mutex demotes back to task->static_prio it will
>be lower than the priority that Fusyn has given the task (potentially).
>I don't think that's handled in the kernel anyplace, is it?

There would be conflicts, for sure [I haven't been able
to grok all the details of rt-mutex, so if I say something
really gross, please speak up]:

- rt saves the new owner's original prio in the mutex
- fusyn uses the mutex owned list and recalculates
  everytime the dyn prio changes based on that (so
  if we change the prio of the owner while owning
  there are no side effects).

- rt saves the pi-waiters in a per-task list, the rest
  in another list
- fusyn associates all the waiters in a per-mutex list, 
  and the PI or not is not a per-waiter attribute, is 
  is a per-mutex attribute--this simplifies the bubbling
  up of the boosting priority

In general the methods are similar, but the implementations
are too different. Yielding to the fact that I haven't looked
too deep at rt-mutex [to be far, I get lost :)], I think we'd
have a hard time getting them to interoperate with regards
to PI and PP.

Are you *really* considering to have them coexisting? I lack
the braveness :) It'd be easier to zap one in favour of the
other and crosspolinate.

<biased opinion>
if we take out all the user space crap from fusyn (vlocator.c,
ufu* and merge in or remove the hooks it requires), it seems 
to me to be simpler than rt-mutex in the PI handling section.
However, that is possibly because I wrote it.
</biased opinion>

<long explanation copied from somewhere else> 

fusyn uses (for transitivity and stacking purposes) the
priority of the 'fulock_olist' ownership list in the task 
struct as the priority the task needs to be boosted to
and calls __prio_boost() [which sets task->boost_prio] with
that prio.

Thus, whenever you acquire a mutex, it is added to that list
in the right position:

 - non PI or PP mutexes have priority BOTTOM_PRIO, so they 
   are always lower than any possible priority you can get
   and won't affect your dynamic prio.

- PI mutexes inherit their prio from the highest prio 
  (task->prio) of the tasks waiting in its waiters list.

- PP mutexes get a prio assigned by a sort of ioctl

</long explanation copied from somewhere else>

-- Inaky
