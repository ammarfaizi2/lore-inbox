Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129226AbQK2EjV>; Tue, 28 Nov 2000 23:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129267AbQK2EjL>; Tue, 28 Nov 2000 23:39:11 -0500
Received: from hera.cwi.nl ([192.16.191.1]:9138 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129226AbQK2EjC>;
        Tue, 28 Nov 2000 23:39:02 -0500
Date: Wed, 29 Nov 2000 05:08:57 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011290408.FAA151004.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: corruption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did again a large test comparing two identical trees.
Found again corruption, and, upon inspection, the disk
files did not differ - this is in-core corruption only.

A few days ago:

diff -r /c2/linux/linux-2.4.0-test10/linux/include/asm-sparc/ecc.h /g1/linux/li\
nux-2.4.0-test10/linux/include/asm-sparc/ecc.h
80,83c80,95
< #define ECC_FADDR0_CACHE     0x00000800
< #define ECC_FADDR0_SIZE      0x00000700
< #define ECC_FADDR0_TYPE      0x000000f0
< #define ECC_FADDR0_PADDR     0x0000000f
---
> #define ECC_FADDR0_Ccount << RATIO_SCALE_LOG;
>           if (db->bytes_out != 0)
>             {
>               new_ratio /= db->bytes_out;
>             }
>
>           if (new_ratio < db->ratio || new_ratio < 1 * RATIO_SCALE)
>             {
>               bsd_clear (db);
>               return 1;
>             }
>           db->ratio = new_ratio;
>         }
>       }
>     return 0;
> }

Here the corruption starts precisely 3072 bytes into the file
(which lives on a filesystem with 1024-byte blocks).

But the tail is a fragment of drivers/isdn/isdn_bsdcomp.c
starting at an offset of 7168 bytes.

The former lives on blocks 6373895 6373896 6373897 6373898 6373899,
the other on blocks 2475568...2475579,2475616...2475628.

Today:

diff -r /g1/linux/linux-2.4.0-test11vanilla/linux/net/sched/sch_cbq.c /c2/linux\
/linux-2.4.0-test11vanilla/linux/net/sched/sch_cbq.c
2000c2000,2115
<               cbq_destr\201XM^@\202XM^@^@^@^@^@^@^@^@^@^@^@...

(lots of nulls)

with corruption starting at an offset of 47104=46*1024 bytes.
Don't know where the corruption part is from.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
