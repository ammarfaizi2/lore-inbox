Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTFUTqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 15:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTFUTqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 15:46:47 -0400
Received: from pl873.nas911.n-yokohama.nttpc.ne.jp ([210.139.42.105]:18629
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id S265287AbTFUTql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 15:46:41 -0400
Message-ID: <3EF4B98D.33A55CD1@yk.rim.or.jp>
Date: Sun, 22 Jun 2003 05:01:17 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Warning messages during compilation of 2.4.21. (5 files)
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I  patched my local kernel source to 2.4.21
and compiled it using gcc on my Debign GNU/Linux system.

I recorded the compile session found a few warning messages which caught
my
eyes.
(These are aside from the usual "defined but not used" warnings, 
and a host of warnings caused by the particular style of
assembly language source in boot setup.S.
They are harmless, I believe.) 

There are five files which produced the relevant warnings, which
I will explain below, in total. Considering the sheer number of
files in the kernel, this number is very small.
Thanks to all the contributors and Marcello to put such a
fine distribution. I hope my comment below reduces the warning
messages still further.

Environment.

Kernel 2.4.21 source.

GCC:  gcc --version
gcc (GCC) 3.3 (Debian)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

I will explain the five files and warning messages in turn.


---

[1] /usr/src/linux/drivers/char/agp/agpgart_be.c
;;;MODULE_AUTHOR("Jeff Hartmann <jhartmann@precisioninsight.com>");


agpgart_be.c: In function `agp_generic_create_gatt_table':
agpgart_be.c:580: warning: assignment from incompatible pointer type
agpgart_be.c: In function `amd_create_gatt_table':
agpgart_be.c:2453: warning: assignment from incompatible pointer type
agpgart_be.c:2454: warning: assignment from incompatible pointer type
agpgart_be.c: In function `amd_free_gatt_table':
agpgart_be.c:2480: warning: assignment from incompatible pointer type
agpgart_be.c:2481: warning: assignment from incompatible pointer type

There are three chunks. I will investigate this in turn.
(All of them seem to be fixed by (void *) cast on the Right-Hand-Side
of assignments.)

[]  agpgart_be.c:580: warning: assignment from incompatible pointer type

	char *table;
           ...
580 -->	agp_bridge.gatt_table_real = (unsigned long *) table;
	agp_gatt_table = (void *)table;

(It looks to me simply change the cast on the Right-Hand-Side into
           (void *) would disable the warning?)

The struct member gatt_table_real is declated as pointer to u32.
cd /usr/src/linux/drivers/char/agp/
grep -n  -e gatt_table_real *.h /dev/null
agp.h:88:	u32 *gatt_table_real;

Solution. Change the (unsigned long *) cast on the RHS to (void *).

[] agpgart_be.c:2453: warning: assignment from incompatible pointer type
   agpgart_be.c:2454: warning: assignment from incompatible pointer type

-->	agp_bridge.gatt_table_real = page_dir.real;
-->	agp_bridge.gatt_table = page_dir.remapped;
	agp_bridge.gatt_bus_addr = virt_to_bus(page_dir.real);

Solution.
put (void *) cast on RHS of the assignments.

[]
agpgart_be.c: In function `amd_free_gatt_table':
agpgart_be.c:2480: warning: assignment from incompatible pointer type
agpgart_be.c:2481: warning: assignment from incompatible pointer type


--->	page_dir.real = agp_bridge.gatt_table_real;
--->	page_dir.remapped = agp_bridge.gatt_table;

Solution.
put (void *) on the RHS.

---

The following files keyboard.c and vt.c 
produce warnings in a somewhat convinced manner in that
the warning is produced by explicit checking of
argument values: however as it stands, the 
checking always produce TRUE or FALSE, a compile-time
constant, so to speak.

[2] /usr/src/linux/drivers/char/keyboard.c

keyboard.c: In function `do_fn':
keyboard.c:644: warning: comparison is always true due to limited range
of data type

static void do_fn(unsigned char value, char up_flag)
{
	if (up_flag)
		return;
--->	if (value < SIZE(func_table)) {
		if (func_table[value])
			puts_queue(func_table[value]);
	} else
		printk(KERN_ERR "do_fn called with value=%d\n", value);
}

SIZE is a macro to return the size of an array.

The size of func_table is MAX_NR_FUNC.

cd /usr/src/linux/drivers/char/
grep -n	 -e func_table *.[ch] /dev/null
defkeymap.c:191:char *func_table[MAX_NR_FUNC] = {
		     ...


MAX_NR_FUNC is defined to be 256.
cd /usr/src/linux/include/linux/
grep -n	 -e NR_FUNC *.h /dev/null
kbd_kern.h:11:extern char *func_table[MAX_NR_FUNC];
keyboard.h:32:#define MAX_NR_FUNC	256	/* max nr of strings assigned to
keys */

So the confition inside if() is always TRUE as it stands.

Solution: see below for solution to [3].

[3] /usr/src/linux/drivers/char/vt.c

vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of
data type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of
data type

    #define i (tmp.kb_index)
    #define s (tmp.kb_table)
    #define v (tmp.kb_value)

166:
-->    	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
	    	return -EINVAL;	

283:
	if (tmp.kb_func >= MAX_NR_FUNC)
		return -EINVAL;

NR_KEYS is defined as 128.
keyboard.h:18:#define NR_KEYS		128
keyboard.h:28:extern unsigned short plain_map[NR_KEYS];

Solution :

I observe the desire to check the parameter value,
whic probably caused grief in the past.

Maybe cast the value to an integer value to
suppress the warning? It might be a little far-fetched
to do so just to suppress warning messages in
the compilation log, but I can see that for future
qaultiy-assurance of linux kernel efforts, such
hand-twisting may be necessary. 

(for example, the line 283 of vt.c could be re-written to
   int kludge_i; /* to shut up warning */

   if((kludge_i = tmp.kb_func) >= MAX_NR_FUNC)
       return -EINVAL;

OR
In this particular case, 
if we are very sure that MAX_NR_FUNC should not decrease 
from the current value (and is likely so), then
we can do away completely without the
checking that produced the warning messages.
(And to protect the future programmer from breaking
the assumption, we need to put put something like

  #if MAX_NR_FUNC < 256
  #error you lose : must be equal to or larger than 256. 
  #endif

in the keyboard.h)

---

[4] /usr/src/linux/drivers/scsi/sym53c8xx.c
    ;;; <groudier@free.fr>

sym53c8xx.c: In function `sym53c8xx_pci_init':
sym53c8xx.c:13172: warning: integer constant is too large for "long"
type

	/* Configure DMA attributes.  For DAC capable boards, we can encode
	** 32+8 bits for SCSI DMA data addresses with the extra bits used
	** in the size field.  We use normal 32-bit PCI addresses for
	** descriptors.
	*/
	if (chip && (chip->features & FE_DAC)) {
->		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
			chip->features &= ~FE_DAC_IN_USE;
		else
			chip->features |= FE_DAC_IN_USE;
	}

Maybe we should write the integer value using "ull" as
0xffFFffFFffull ? (note the "ull" suffix. This shuts up
the warning from GCC and all is well.)


I checked that the GCC certainly suprress the warning with "ull" suffix.
(I have no idea if other compilers follow suit, but
 who wants to compile this piece of code using non-GCC compiler?
 Maybe HP risc folks and pcc folks???)

The following file ymfpci.c puzzles me.
Looks to me that there is indeed a logic  bug or something.

[5] /usr/src/linux/drivers/sound/ymfpci.c
    ;;; zaitcev@yahoo.com ???

ymfpci.c: In function `ymf_ac97_init':
ymfpci.c:2463: warning: comparison is always false due to limited range
of data type

It certainly looks that  something is wrong with the code.
(Maybe some masking of the eid and the immediate value is missing?)

code in question

   u16 eid;
	...

   2462	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
-->2463	if (eid==0xFFFFFF) {
		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
		goto out_kfree;
	}


Solution: ???



----

This is all.
By fixing the above files (except ymfpci.c) in the above,
we can reduce the warning messages during the kernel compile.

I am not on linux-kernel mailing list and so prefer cc: ing if
someone responds to the message.
(I also intend to send a separate message to the module authors
as far as I could find them. I am not sure who are
responsible for vt.c and keyboard.c, though.)


 
Happy Hacking,


-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
