Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbTIMUSs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTIMUSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:18:48 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14603
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262184AbTIMUSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:18:44 -0400
Date: Sat, 13 Sep 2003 13:01:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <Pine.LNX.4.10.10309131111360.16744-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10309131209520.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SYMBOL in question "dequeue_signal"

*************************************

pwd :: /usr/src/linux-2.4.18-27/kernel/signal.c

/*
 * Dequeue a signal and return the element to the caller, which is
 * expected to free it.
 *
 * All callers must be holding current->sigmask_lock.
 */

int
dequeue_signal(sigset_t *mask, siginfo_t *info)
{
        int sig = 0;

#if DEBUG_SIG
printk("SIG dequeue (%s:%d): %d ", current->comm, current->pid,
        signal_pending(current));
#endif

        sig = next_signal(current, mask);
        if (sig) {
                if (current->notifier) {
                        if (sigismember(current->notifier_mask, sig)) {
                                if (!(current->notifier)(current->notifier_data)) {
                                        current->sigpending = 0;
                                        return 0;
                                }
                        }
                }

                if (!collect_signal(sig, &current->pending, info))
                        sig = 0;

                /* XXX: Once POSIX.1b timers are in, if si_code == SI_TIMER,
                   we need to xchg out the timer overrun values.  */
        }
        recalc_sigpending(current);

#if DEBUG_SIG
printk(" %d -> %d\n", signal_pending(current), sig);
#endif

        return sig;
}

EXPORT_SYMBOL(dequeue_signal);
EXPORT_SYMBOL(flush_signals);

*************************************

pwd :: /usr/src/linux-2.4.20-18.9/kernel/signal.c

static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
                        siginfo_t *info)
{
        int sig = 0;

        sig = next_signal(pending, mask);
        if (sig) {
                if (current->notifier) {
                        if (sigismember(current->notifier_mask, sig)) {
                                if (!(current->notifier)(current->notifier_data)) {
                                        current->sigpending = 0;
                                        return 0;
                                }
                        }
                }

                if (!collect_signal(sig, pending, info))
                        sig = 0;

                /* XXX: Once POSIX.1b timers are in, if si_code == SI_TIMER,
                   we need to xchg out the timer overrun values.  */
        }
        recalc_sigpending();

        return sig;
}

/*
 * Dequeue a signal and return the element to the caller, which is
 * expected to free it.
 *
 * All callers have to hold the siglock.
 */
int dequeue_signal(sigset_t *mask, siginfo_t *info)
{
        int signr = __dequeue_signal(&current->pending, mask, info);
        if (!signr)
                signr = __dequeue_signal(&current->signal->shared_pending,
                                         mask, info);
        return signr;
}


EXPORT_SYMBOL(recalc_sigpending);
EXPORT_SYMBOL_GPL(dequeue_signal);
EXPORT_SYMBOL(flush_signals);

*************************************


Now it is totally clear this is an attempt to strip and remove
functionality of the API, period.

But this is to obvious to miss.

Regards,

Andre Hedrick
LAD Storage Consulting Group



