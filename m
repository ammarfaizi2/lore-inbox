Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154693-17165>; Sun, 6 Dec 1998 06:24:36 -0500
Received: from noc.nyx.net ([206.124.29.3]:3619 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <156435-17165>; Sat, 5 Dec 1998 23:48:08 -0500
Date: Sun, 6 Dec 1998 00:22:33 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199812060722.AAA19494@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sun Dec  6 00:22:33 1998, Sender=colin, Recipient=, Valsender=colin@localhost
To: alan@lxorguk.ukuu.org.uk
Subject: Re: Linux timekeeping plans
Cc: ak@muc.de, linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox wrote:
> Andi Kleen wrote:
>> Colin Plumb wrote:
>>> 	volatile master_lock = 1, slave_lock = 0;
>>> 
>>> master:
>>> 	tell_slave_to_start_calibration();
>>> 
>>> 	for (i = 0; i < 100; i++) {
>>> 		/* Send to slave */
>>> 		while (slave_lock)	/* Wait for slave to start spinning */
>>> 			;
>>> 		nop();	/* Wait a moment for slave to really start spinning */
>>> 		master_time[2*i] = rdtsc();
>>> 		master_lock = 1;
>>> 
>>> 		/* Receive from slave */
>>> 		master_lock = 0;	/* Announce that we're spinning */
>>> 		while (!slave_lock)
>>> 			;
 
>> I think you need mb() after the setting of master/slave_lock to make sure
>> that the other CPU sees it as early as possible.

> Also you will need to allow for the cross CPU migration of cache lines and
> the store ordering. That will throw your estimate out wildly.

Um, the code thee is buggy, so it's not worth defending, but I'd still
like to understand the comments.

I think I understand the mb() comment.  I've been seeing much higher
run times on P6 systems, and after reading some of the manuals, I think
that's the write combining buffer which needs flushing.

But I don't understand the cross-CPU migration issue.

My current code looks like this:

/*
 * Variables for interprocessor communications. 
 * Padded to make sure thre is no cache line interference.
 */
static volatile int pad0[16];
static volatile int receive_ready;
static volatile int pad1[15];
static volatile int signal_sent;
static volatile int pad2[15];

#define rdtsc(hi,lo) asm volatile("rdtsc" : "=a" (lo), "=d" (hi))

/* Send a signal, returning the TSC just before it is sent. */
static unsigned
send(void)
{
	unsigned hi, lo;

	/* Send to slave */
	signal_sent = 0;
	while (!receive_ready)
		;
	rdtsc(hi,lo);	/* Waste time */
	receive_ready = 0;
	rdtsc(hi,lo);
	signal_sent = 1;

	return lo;
}

/* Receive a signal, returning the TSC just after it is received. */
static unsigned
receive(void)
{
	unsigned hi, lo;

	while (signal_sent)
		;
	receive_ready = 1;
	while (!signal_sent)
		;
	rdtsc(hi,lo);
	return lo;
}

Now, I think that after an iteration or two, this will settle into a steady
state.  The sequence of memory operations will be:

- signal_sent = 1, shared in both caches.  receive_ready = 0, exclusive in the
  receiver's cache.
- Sender broadcasts invalidate and gets signal_sent exclusively to write to 0.
- Receiver reads, sender intercepts the read and writes the data out.
  We end up back in a shared state with signal_sent = 0.

- Before the receiver is through mucking with that, the sender has advanced
  to reading receive_ready.  This causes a bus operation which is intercepted
  by the receiver and the current value(0) forwarded.

- Then the receiver sets receive_ready to 1 and falls into a spin loop
  checking signal_sent.  Which is already shared, so there is no bus traffic.
- This causes the same invalidate steps as before.

- The sender sees receive_ready and then clears it (obtaining exclusive
  access to it in the process) and otherwise wastes time to ensure that
  the receiver is happily in the spin loop with branch prediction operating
  to give it the fastest possible loop time.

- The sender now reads the tsc.  Timing starts now.
  One point of concern I realize now that I'm stepping through this is that
  the receive_ready update probably isn't finished yet.

- Then the sender writes signal_sent.  This causes the same invalidate
  cascade as before, ending up with signal_sent = 1 shared in both caches
  (the initial condition)

- The receiver's poll of signal_sent completes and the receiver reads
  the tsc.

It seems that the steps that take place between the sender reading the
tsc and the receiver reading it are pretty well defined.  How will this
not work?

Here's a revised version I'm considering:

/* Send a signal, returning the TSC just before it is sent. */
static unsigned
send(void)
{
	unsigned hi, lo;

	/* Send to slave */
	while (!receive_ready)
		;
	receive_ready = 0;	/* Waste some time */
	mb();			/* Finish bus protocol */
	rdtsc(hi,lo);
	signal_sent = 1;
	mb();

	return lo;
}

/* Receive a signal, returning the TSC just after it is received. */
static unsigned
receive(void)
{
	unsigned hi, lo;

	signal_sent = 0;
	mb();
	receive_ready = 1;
	mb();
	while (!signal_sent)
		;
	rdtsc(hi,lo);
	return lo;
}

This removes the need to spin waiting for signal_sent to be cleared,
since it's subsumed by the receive_ready spin.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
