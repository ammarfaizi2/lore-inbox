Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132081AbQLVUEr>; Fri, 22 Dec 2000 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQLVUEh>; Fri, 22 Dec 2000 15:04:37 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:16134 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S132256AbQLVUE0>; Fri, 22 Dec 2000 15:04:26 -0500
Date: Fri, 22 Dec 2000 21:33:58 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
Message-ID: <20001222213358.A5829@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 22, 2000 at 12:52:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 12:52:32AM +0000, Alan Cox wrote:
> 
> 2.2.19pre3
> o	Fix e820 handling				(Andrea Arcangeli)


arch/i386/kernel/setup.c:

                /* compare results from other methods and take the greater */
                if (ALT_MEM_K < EXT_MEM_K) {
                        mem_size = EXT_MEM_K;
                        who = "BIOS-88";
                } else {
                        mem_size = ALT_MEM_K;
                        who = "BIOS-e801";
                }
 
                e820.nr_map = 0;
-               add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-               add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+               add_memory_region(0, i386_endbase, E820_RAM);
+               add_memory_region(HIGH_MEMORY, (mem_size << 10)-HIGH_MEMORY,
+                                E820_RAM);

I think in case of BIOS-88 it now sees 1 Meg less than should. int 15, ah=88
gives the amount of extended memory above 1 Meg and it gets copied to
EXT_MEM_K. So HIGH_MEMORY should not be subtracted from it. (On the other
hand in case of BIOS-e801 ALT_MEM_K includes lower memory. I guess the
direct comparison of memory sizes ALT_MEM_K and EXT_MEM_K is not ok.)

linux-2.2.19pre3 on my 486 with 49152 k of RAM:

BIOS-provided physical RAM map:
 BIOS-88: 000a0000 @ 00000000 (usable)
 BIOS-88: 02e00000 @ 00100000 (usable)
Memory: 46128k/48128k available

linux-2.2.18 or linux-2.2.19pre2 :

Memory: 47144k/49152k available
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
