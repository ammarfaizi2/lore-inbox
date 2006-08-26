Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422888AbWHZDqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWHZDqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 23:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWHZDqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 23:46:12 -0400
Received: from science.horizon.com ([192.35.100.1]:63047 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1422888AbWHZDqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 23:46:11 -0400
Date: 25 Aug 2006 23:46:10 -0400
Message-ID: <20060826034610.12928.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com, linux@horizon.com
Subject: Re: Linux time code
Cc: linux-kernel@vger.kernel.org, theotso@us.ibm.com, zippel@linux-m68k.org
In-Reply-To: <1156357786.5370.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anyone's interesting in the Very Sneaky option, here's a little
test program to judge its feasibility.

You can do an even nicer thing with timer 2, the speaker timer, since
it keeps counting mod-65536 when not in use, but coping with console
beeps or the PC speaker driver would be a nightmare.

On 4 machines (laptop, two desktops, and amd64), timer 1 is always
programmed for mode 2 (status = 0x94) with a cout of 18 (0x12).  This
does not divide any of the standard timer rate divisors (including the
AMD Elan versions).  However, collecting hitograms, I do see occasional
glitches:

Timer 1 status = 94
  1: 34
  3: 133
  4: 34
  6: 132
  7: 33
  9: 133
 10: 33
 12: 134
 13: 33
 15: 134
 16: 33
 18: 133
181: 1

(AMD64, nForce4 chipset - why it has a "refresh timer" when it doesn't
have any RAM attached is a mystery)

Also, it appears to take very nearly 3 us to latch the
count and read the timer, resulting in histograms like:

Timer 1 status = 94
  1: 167
  4: 167
  7: 166
 10: 166
 13: 167
 16: 167

Anyway, if anyone else would like to try, the following program should
be very conservative and not kill your machine.  Still, it disables
interrupts and does raw hardware accesses.  In fact, since nobody else
should be touching timer 1, the interrupt disabling is probably not
necessary, but I'd still be cuatious running it on an SMP system.

/*
 * This program figures out what timer 1 (the memory refresh timer) is
 * doing on yor computer.
 */
#include <stdio.h>
#include <sys/io.h>	/* For iopl(), inb(), outb() */
#include <asm/system.h>	/* For local_irq_disable(), local_irq_enable() */
#include <stdint.h>
#include <assert.h>

/* Timer registers at 0x40..0x43 */

static uint8_t
get_status(unsigned timer)
{
	uint8_t status;

	assert(timer < 3);

	local_irq_disable();
	outb(0xe0 + (2<<timer), 0x43);
	status = inb(0x40 + timer);
	local_irq_enable();

	return status;
}

/*
 * We collect a histogram of values to find out the highest counter
 * value and look for oddities like skipped values.
 */
static void
get_histogram(unsigned timer, unsigned counts[256], unsigned n)
{
	uint8_t const command = 0xd0 + (2<<timer);
	/* Alt: command = timer << 6 */
	uint16_t const port = 0x40 + timer;

	assert(timer < 3);
	assert(n);

	local_irq_disable();
	do {
		outb(command, 0x43);
		counts[inb(port)]++;
	} while (--n);
	local_irq_enable();
}

int
main(void)
{
	unsigned i;
	unsigned histogram[256];
	uint8_t status;

	if (iopl(3) < 0) {
		perror("iopl(3)");
		fputs("Are you running as root?\n", stderr);
		return 1;
	}

	status = get_status(1);

	printf("Timer 1 status = %02x\n", status);

	if (status & 0x40) {
		puts("Null count it set.  This is strange and interesting,\n"
		     "but means I don't know what's going on.  Aborting.");
		return 0;
	}
	if ((status & 0x30) != 0x10) {
		puts("Read mode is not lsbyte-only.  This is strange and interesting,\n"
		     "but means I don't know what's going on.  Aborting.");
		     return 0;
	}
	if ((status & 0xe) != 4) {
		printf("Timer mode is %u, not 2, which is unexpected.  Still,\n"
		       "data can be collected.  Please report!",
		       (status >> 1) & 7);
	}
	if (status & 1) {
		puts("Timer is in BCD mode.  Most peculiar.  Please report!");
		/* But we can collect a histogram */
	}

	for (i = 0; i < 256; i++)
		histogram[i] = 0;

	/* Break up collection into bursts to avoid long interrupt latency */
	for (i = 0; i < 10; i++)
		get_histogram(1, histogram, 100);

	for (i = 0; i < 256; i++)
		if (histogram[i])
			printf("%3u: %u\n", i, histogram[i]);

	puts("Thank you.");
	return 0;
}
