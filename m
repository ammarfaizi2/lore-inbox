Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRB1SuM>; Wed, 28 Feb 2001 13:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRB1SuB>; Wed, 28 Feb 2001 13:50:01 -0500
Received: from gateway.sequent.com ([192.148.1.10]:866 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129161AbRB1Stu>; Wed, 28 Feb 2001 13:49:50 -0500
Date: Wed, 28 Feb 2001 10:49:45 -0800
From: "Martin J. Bligh" <mbligh@mail.com>
Reply-To: "Martin J. Bligh" <mbligh@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Confused by local APIC addressing in setup_IO_APIC_irqs()
Message-ID: <4104841651.983357385@W-MBLIG.svc.sequent.com>
X-Mailer: Mulberry/2.0.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that we're stuffing a 32 bit bitmask into an
8 bit register ... which seems very odd. Either I don't understand
this properly (probable ;-)) or something's wrong ... can anyone
shed some light on this for me?

It looks like we do this in arch/i386/kernel/io_apic.c (2.4.x):

-----------------------------------------

#define TARGET_CPUS cpu_online_map

void __init setup_IO_APIC_irqs(void)
{
        struct IO_APIC_route_entry entry;
....
entry.dest.logical.logical_dest = TARGET_CPUS;
....
                io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
                io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));

---------------------------------------------

But ....

struct IO_APIC_route_entry {
...
    union {
....
            struct { __u32
                    __reserved_1    : 24,
                    logical_dest    :  8;
            } logical;
    } dest;

---------------------------------------------

But cpu_online map seems to be a 32 bit bitmask of which
CPUs are online .... are we stuffing this directly into an 8-bit
logical desitination register?

Ironically, if I'm understanding this right, it kind of works anyway
for most systems - the low nibble of the logical ID is a bitmask
anyway, so it works normally for up to 4 way. For 8 way or more,
the high nibble will be set to 1111, which is the broadcast cluster ID,
so it'll direct interrupts anywhere .... but I can't believe that was
intentional ;-) For a start, a 7 way system would send to some
non-existant cluster ID ....

Any insights would be much appreciated,

Thanks,

Martin.




