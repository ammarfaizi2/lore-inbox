Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUKLGRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUKLGRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUKLGRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:17:46 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:26836 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262459AbUKLGQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:16:28 -0500
Date: Thu, 11 Nov 2004 22:16:27 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Willy Tarreau <willy@w.ods.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_PM_TIMER is slow
In-Reply-To: <20041112060413.GF783@alpha.home.local>
Message-ID: <Pine.LNX.4.61.0411112208180.24919@twinlark.arctic.org>
References: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org>
 <20041112060413.GF783@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Willy Tarreau wrote:

> On Thu, Nov 11, 2004 at 09:52:27PM -0800, dean gaudet wrote:
> > when using CONFIG_X86_PM_TIMER i'm finding that gettimeofday() calls take 
> > 2.8us on a p-m 1.4GHz box... which is an order of magnitude slower than 
> > TSC-based solutions.
> > 
> > on one workload i'm seeing a 7% perf improvement by booting "acpi=off" to 
> > force it to use tsc instead of the PM timer... (the workload calls 
> > gettimeofday too frequently, but i can't change that).
> 
> I did not test, this might be interesting.
> In fact, what would be very good would be sort of a new select/poll/epoll
> syscalls with an additional argument, which would point to a structure
> that the syscall would fill in return with the time of day. This would
> greatly reduce the number of calls to gettimeofday() in some programs,
> and make use of the time that was used by the syscall itself.
> 
> For example, if I could call it like this, it would be really cool :
> 
>    ret = select_absdate(&in, &out, &excp, &date_timeout, &return_date);

but the overhead isn't the syscall :)  it's the pm timer itself... the 
program below reads the pm timer the same way the kernel does and you can 
see it takes 2.5us to read it...

# cc -O2 -g -Wall readport.c -o readport
# grep PM-Timer /var/log/dmesg
ACPI: PM-Timer IO Port: 0xd808
# time ./readport 0xd808 1000000
./readport 0xd808 1000000  2.54s user 0.00s system 100% cpu 2.526 total

the gettimeofday overhead is dominated by this i/o...

-dean

/* readport.c */

#include <stdint.h>
#include <sys/io.h>
#include <stdio.h>
#include <stdlib.h>

uint32_t pmtmr_ioport;

#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */

static inline uint32_t read_pmtmr(void)
{
        uint32_t v1=0,v2=0,v3=0;
        /* It has been reported that because of various broken
         * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
         * source is not latched, so you must read it multiple
         * times to insure a safe value is read.
         */
        do {
                v1 = inl(pmtmr_ioport);
                v2 = inl(pmtmr_ioport);
                v3 = inl(pmtmr_ioport);
        } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
                        || (v3 > v1 && v3 < v2));

        /* mask the output to 24 bits */
        return v2 & ACPI_PM_MASK;
}


int main(int argc, char **argv)
{
	unsigned port;
	size_t count;
	size_t i;

	if (argc != 3) {
		fprintf(stderr, "usage: %s port_num count\n", argv[0]);
		exit(1);
	}

	pmtmr_ioport = port = strtoul(argv[1], 0, 0);
	count = strtoul(argv[2], 0, 0);

	if (iopl(3) != 0) {
		perror("iopl");
		exit(1);
	}

	for (i = 0; i < count; ++i) {
		read_pmtmr();
	}
	return 0;
}
