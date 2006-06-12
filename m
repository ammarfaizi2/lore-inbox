Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWFLWi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWFLWi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWFLWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:38:27 -0400
Received: from web50103.mail.yahoo.com ([206.190.38.31]:899 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932626AbWFLWi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=leKPo2KCIM3/tVtLTsyM+o1ByivpJlblbVWw1BY/N3qNZI+MoUvAmA9JgBbzCWdcc+uAJgcJrZM/rZklOmvq8vn/c7ixYsDtYQ3GtjwhFK3EeuqPzNIE6c6xEb+ntHAUlUxw+SuwcJA9OiGFohB+hb6Xsh5iKC8mPp6XkZ1Rbak=  ;
Message-ID: <20060612223827.33255.qmail@web50103.mail.yahoo.com>
Date: Mon, 12 Jun 2006 15:38:27 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [BUG] safe_smp_process_id() uses apicid which exceeds NR_CPUs in array
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


with 2.6.15 kernel running on a Tyan S4881 quad processor board (with factory BIOS)
using Opterons 254s, I received the following MCEs:

CPU 18: Machine Check Exception:                4 Bank 0: b601a00000000833
TSC 9c3799943459 ADDR 4eee07800

CPU 18: Machine Check Exception:                4 Bank 2: d000400000000863
TSC 9c3799943d01

CPU 18: Machine Check Exception:                4 Bank 4: d42dc00100000813
TSC 9c379994422d ADDR 4eee05708


It was later determined to be a bad memory stick, but the problem was 
'CPU 18'.  Running the same hardware with 2.6.17-rc6 produced MCEs with:

'CPU 2' messages instead

as the output. Thought problem fixed, BUT.....

looking at 2.6.17-rc6 safe_smp_processor_id()  in arch/x86_64/kernel/smp.c (This
function is called by the MCE handler code):

int safe_smp_processor_id(void)
{
        int apicid, i;

        if (disable_apic)
                return 0;

        apicid = hard_smp_processor_id();

----->  if (x86_cpu_to_apicid[apicid] == apicid)
                return apicid;

        for (i = 0; i < NR_CPUS; ++i) {
                if (x86_cpu_to_apicid[i] == apicid)
                        return i;
        }

        /* No entries in x86_cpu_to_apicid?  Either no MPS|ACPI,
         * or called too early.  Either way, we must be CPU 0. */
        if (x86_cpu_to_apicid[0] == BAD_APICID)
                return 0;

        return 0; /* Should not happen */
}

I noticed the:   if (x86_cpu_to_apicid[apicid] == apicid)
above.

NR_CPUS was 4 and apicid could be:  16, 17 18, or 19

definitely an out-of-bounds reference.

doug thompson

portion of boot.mesg follows:

SRAT: PXM 0 -> APIC 16 -> Node 0
SRAT: PXM 1 -> APIC 17 -> Node 1
SRAT: PXM 2 -> APIC 18 -> Node 2
SRAT: PXM 3 -> APIC 19 -> Node 3
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-d0000000
SRAT: Node 0 PXM 0 0-230000000
SRAT: Node 1 PXM 1 230000000-430000000
SRAT: Node 2 PXM 2 430000000-630000000
SRAT: Node 3 PXM 3 630000000-830000000
NUMA: Using 28 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000230000000
Bootmem setup node 1 0000000230000000-0000000430000000
Bootmem setup node 2 0000000430000000-0000000630000000
Bootmem setup node 3 0000000630000000-0000000830000000
On node 0 totalpages: 2063996
  DMA zone: 2596 pages, LIFO batch:0
  DMA32 zone: 833240 pages, LIFO batch:31
  Normal zone: 1228160 pages, LIFO batch:31
On node 1 totalpages: 2068480
  Normal zone: 2068480 pages, LIFO batch:31
On node 2 totalpages: 2068480
  Normal zone: 2068480 pages, LIFO batch:31
On node 3 totalpages: 2068480
  Normal zone: 2068480 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x10] enabled)
Processor #16 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x11] enabled)
Processor #17 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x12] enabled)
Processor #18 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x13] enabled)
Processor #19 15:5 APIC version 16

