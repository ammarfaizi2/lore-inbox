Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269173AbTCBJZs>; Sun, 2 Mar 2003 04:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbTCBJZs>; Sun, 2 Mar 2003 04:25:48 -0500
Received: from mail.netone.com.tr ([193.192.100.127]:34279 "EHLO
	gtms01.netone.com.tr") by vger.kernel.org with ESMTP
	id <S269173AbTCBJZp>; Sun, 2 Mar 2003 04:25:45 -0500
Message-ID: <00a201c2e09f$0bab6900$0100a8c0@bora>
From: =?iso-8859-9?B?Qm9yYSDeYWhpbg==?= <borasah@netone.com.tr>
To: <linux-kernel@vger.kernel.org>
Subject: Q: parse_cmdline_early()
Date: Sun, 2 Mar 2003 11:35:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two problems with the parse_cmdline_early().

My first problem is related to mem options.
...
/*
* "mem=nopentium" disables the 4MB page tables.
* "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
* to <mem>, overriding the bios size.
* "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
* <start> to <start>+<mem>, overriding the bios size.
*/

I think this comment would be expressed better. Of the comments are
understood like
"start_at@mem_size". But actually "mem_size@start_at"

if (!memcmp(from, "mem=", 4)) {
    if (to != command_line)
        to--;
// ok
    if (!memcmp(from+4, "nopentium", 9)) {
        from += 9+4;
        clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);
    }
// ok
    else if (!memcmp(from+4, "exactmap", 8)) {
        from += 8+4;
        e820.nr_map = 0;
        userdef = 1;
    }
// This is the problem
    else {
        /* If the user specifies memory size, we
         * limit the BIOS-provided memory map to
         * that size. exactmap can be used to specify
         * the exact map. mem=number can be used to
         * trim the existing memory map.
        */
        unsigned long long start_at, mem_size;

        mem_size = memparse(from+4, &from);
        if (*from == '@') {
            start_at = memparse(from+1, &from);
            add_memory_region(start_at, mem_size, E820_RAM);
        }
        else {
            limit_regions(mem_size);
            userdef=1;
        }
    }
}
...

If I supply the parameter in a old fashion, that is, mem=xxx[kmg] It's OK,
limit_regions is called and It works as usual. But If I supply the parameter
in a new way, that is mem=128m@1m, the kernel hangs on. Only prints the
screen "uncompressing Linux... Ok, booting the kernel" msg. If I understand
the function correctly, there are two case:

1) mem=xx[kmg]. It works.

2) mem=exactmap and mem=xxx[kmg]@xxx[kmg] are supplied together because as
if function was configured having been thought this. For example this way
userdef is set. But If I supply the mem=exactmap and mem=x@x, Lilo complains
and refuse it: "Invalid number".
If I supply only mem=xxx[kmg]@xxx[kmg], kernel can be crashed.
Because (One of the reasons) I have got 256 Mb RAM and this will overlaps
the BIOS provided results. (sanitize function is not called after the
parse_cmdline_early()) But this isnt and as I said the above, It crashes
early-bootup phase.

These means, doesnt Lilo support mem=x@x? Version: 21.4-4 or are my
assumptions true?

My second problem is in fact trivial. According to the function, If an
option is omitted from command_line It seems It should be done a check.

*to = command_line
...
/* among mem options    */
if (to != command_line)
    to--;

This means an unnecessary space isnt added to 'to' variable. (If It is first
option in the command_line, then there is no extra space) But there is an
exception.

else if (!memcmp(from, "highmem=", 8))
    highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;

Here, highmem_pages is parsed and omitted but there is no check like the
above. This way, an extra space is added to 'to'. I think functions which
parse command_line later is prepared but It seems there are inconsistencies.

Kernel Version: 2.4.19

Thanks in advance...

Sory for my bad English...

Regards
Bora Sahin


