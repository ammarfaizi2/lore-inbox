Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVE0WcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVE0WcG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVE0WcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:32:06 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:30981 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262503AbVE0Wbk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:31:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SmyyFuhhHczu8R96bSxbUIWyWKYDHKR4KUZcsfQwVygKLmO2v9DDsz/9JYi9CAa5lnL9C/1Ivojm38zkB9pcWdWVXO3La4oxY+7pK1/zFA4hphChgag6u3e5zKu1TveLg+Jq/7pcP8TUTcaSHYUe1oAjqVRmdu/ANSasyFaZKmM=
Message-ID: <934f64a205052715315c21d722@mail.gmail.com>
Date: Fri, 27 May 2005 17:31:38 -0500
From: David Nicol <davidnicol@gmail.com>
Reply-To: David Nicol <davidnicol@gmail.com>
To: john cooper <john.cooper@timesys.com>
Subject: spinaphore conceptual draft (was discussion of RT patch)
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/05, john cooper <john.cooper@timesys.com> wrote:

> given design.  Clearly we aren't buying anything to trade off
> a spinlock protecting the update of a single pointer with a
> blocking lock and associated context switching.

thinking out loud here, doubting I'm covering any new ground.

Just curious, are there any statistics about how often spinlocks
are spinning?  A spinlock only has to wait when there is actual
contention for the resource, right?  If that is a very rare thing, the
performance difference is divided by the chance of the resource
being in contention, right?  So if the normal, uncontended case,
in a SMP system, is, check something visible to all CPUs, set that
thing, do the protected thing, unset the visible thing, continue on, and
the setting/unsetting is the same speed, there would be no difference
in performance, except when there is actual contention?

If there were fifty CPUs, and two hundred threads, all occasionally needing the
same resource protected by the locking scheme, even if that resource is
something very small, if the section of the program that is going to use the
resource uses it a dozen times, locking and unlocking each time, it seems like
computer science queueing theory could be applied to determine the factors 
that would optimize for minimum amount of lock contention. 

On contention, and only on contention, we are faced with the question of what
to do.  Do we wait, or do we go away and come back later?  What information is
available to us to base the decision on?  We can't gather any more information, 
because that would take longer than spin-waiting.  If the "spinaphore" told us,
on acquisition failure, how many other threads were asking for it, we
could implement
a tunable lock, that surrenders context when there are more than N
threads waiting for
the resource, and that otherwise waits its turn, or its chance,  as a compromise
and synthesis.

Of course we'd then have to spin while waiting our turn to increment
(and decrement,
when we gave up) the spinaphore, unless we have machine code to do that
without frying the memory bus too severely, which we probably do, in any machine
architecture that is designed to support SMP, so that should not be a
problem.  So,
one cache fault to check a global lock state, that we can't avoid --
or does the hardware
take care of writing back? I bet it does -- so, presuming no
contention, we breeze through
and hit the memory bus twice at lock and unlock, in any lock scheme.

The spinaphore would work something like this:

int try_and_obtain (spinaphore_t *S,  void **EntryPoint)

  returns zero on obtaination or an integer in which the low bits
indicate the number of
  threads waiting for it, including you, and the high bits indicate
which wait slot your
  non-null EntryPoint is registered in.

void abandon(spinaphore_t *S, int slot)

  to notify the spinaphore that you are no longer wish to receive a notification
  when it is your turn for the resource

int try_and_obtain_or_abandon (spinaphore_t *S)

  doesn't register anything with S if we can't get it

void release(spinaphore_t *S)

  to only be called on spinaphores you hold, causes selection of the
  next registered EntryPoint and a message sent to that CPU -- an interrupt of
  some kind -- to resume at the right place in the context that was waiting for
  the resource.  (This needs to retry until the message, if any, gets through)

void requeue(spinaphore_t, entry_point)

  when a CPU receives an interrupt concerning an available spinaphore that
had been requested by a process with affinity to that CPU, it might do this
 to the spinaphore instead of giving control back to the thread.  this
would entail
putting the entry_point at the back of the line for the resource and sending 
the resource_available message to a process on a different CPU.  This might best
work as a response -- "NOT NOW" -- to a resource-available message instead of
as something more involved that the receiving CPU would have to do, leaving the
CPU that is trying to release the spinaphore to try to release it to
someone else,
which might again turn into spinning, but spinning through the other
CPUs instead
of retesting a bit.





So, some code would attempt try_and_obtain_or_abandon a few times,
then would register itself with the spinaphore, and yield its CPU.  When the
message comes from the spinaphore that it is now this code's turn, the CPU
would either requeue the entry point if it is really busy --
interrupting an interrupt
or something like that -- or switch context back to whatever had registered with
the spinaphore.



Questions:  Just how many CPUs, and how busy of a resource, do you have
to have for this kind of thing to work better than spinning, and what kind of
resource would it be protecting?  How important is affinity?



Looking at the linux/spinlock.h file from 2.6.11, there are a lot of
flavors of lock to
choose between already.  What's one or two or ten more?
