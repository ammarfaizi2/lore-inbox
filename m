Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJ2JFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 04:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTJ2JFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 04:05:41 -0500
Received: from appana.dmz.aa.ap.titech.ac.jp ([131.112.71.130]:35592 "HELO
	guard.dmz.aa.ap.titech.ac.jp") by vger.kernel.org with SMTP
	id S261930AbTJ2JFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 04:05:05 -0500
Date: Wed, 29 Oct 2003 18:04:56 +0900
Subject: A bug in linux-2.4.22 about Swap Management for MPC860T
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: adachi@aa.ap.titech.ac.jp
To: linux-kernel@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCQi1OKUFvGyhC?= <adachi@aa.ap.titech.ac.jp>
Content-Transfer-Encoding: 7bit
Message-Id: <F775149E-09EE-11D8-83B0-003065E04568@aa.ap.titech.ac.jp>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Developers of Linux kernel,

    *BUG report 1/2*

Several months ago, I ported several recent versions of linux kernel
to a platform ``OpenBlockS 50'', which is a small box hardware
that is made by an Industorial Company ``PlatH'ome'' in Japan.
The CPU that is used in this hardware is Motorola's MPC860T,
which is an embedded version of PowerPC. This hardware has two
Ethernet ports to access network and one serial port to be used
for serial console. It has also an IDE bus interface
inside of it, which can be used to attach one harddisk and
one Compact Flash memory.

My port of recent linux kernels (version 2.4.21, 2.4.22) to this 
hardware
is based on anohter port of linux kernel (version 2.4.13),
which was done about one year ago by a Japanese, Mr. Katsunori Murase
(Home page in Japanese: http://homepage2.nifty.com/murase/).

While I was porting the linux kernel, I found a serious bug
in the linux kernel when it is compiled for MPC860T.
This serious bug is related with the swap management in the virtual
memory system. I also found a minor harmless problem
about the IDE device driver.

Maybe, it is better to report these two problems in separate emails
to help the maintainer to record different problems in different files.
So, I am now writing two emails to report these two problems.


This first email reports the former serious bug about the swap 
management
for MPC860T.


As I said, I ported the linux kernel (version 2.4.21, 2.4.22) to
the platform OpenBlockS 50, in which MPC860T is used as the CPU.
After I thought that everything that was needed for this port
had been done, I booted a Debian GNU/Linux system with the ported 
kernel.
Then, the login prompt appeared on the serial console
and I could login into the system.
However, after the system was used for a while,
the following message appeared on the serial console:

swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
swap_dup: Bad swap file entry 00002fe0
...
...

and the system hanged up completely. I could not do anything.

I started my investigation to fix this problem.
For example, I inserted many printk() statements into many source files
under the directory linux-2.4.xx/mm/ to build a test kernel
to see what causes the problem. Here, I will report only the result
of my investigation.

The above error message is printed from the function
swap_duplicate() in the source file mm/swapfile.c.
The code fragment that is related to this error is the following:

int swap_duplicate(swp_entry_t entry)
{
         struct swap_info_struct * p;
         unsigned long offset, type;
         int result = 0;

         type = SWP_TYPE(entry);
         if (type >= nr_swapfiles)
                 goto bad_file;

         ...

bad_file:
         printk(KERN_ERR "swap_dup: %s%08lx\n", Bad_file, entry.val);
         goto out;
}

The variable nr_swapfiles denotes the number of swap partitions and 
files
that are activated at the boot time or explicitly by the command 
swapon(8).
In my case, there is only one swap partition /dev/hda2, which is 
activated
at the boot time. Accordingly, the value of the variable nr_swapfiles
should be 1. Since the error message is printed, the actual value of
SWP_TYPE(entry) takes some value larger than or equal to 1.
Since the value of SWP_TYPE(entry) is designed to represent
the swap area index, which distinguishes the swap partition or file that
is used for the swap entry entry, the only one correct value in my case 
is 0.
This correct value seems not to be realized in actuality.

This consideration can be checked directly by investigating the value
of entry.val, which is reported to be equal to 0x00002fe0.
The variable val is of the type swp_entry_t, which is defined as

typedef struct {
         unsigned long val;
} swp_entry_t;

in the header file include/linux/shmem_fs.h. The macros
SWP_TYPE() and SWP_OFFSET() are defined for MPC8xx in the header file
include/asm-ppc/pgtable.h as follows:

#define SWP_TYPE(entry)                 ((entry).val & 0x3f)
#define SWP_OFFSET(entry)               ((entry).val >> 6)

Consequently, the least significant 6 bits of entry.val represent
the swap area index SWP_TYPE(entry). The rest of the bits of entry.val
represent the page slot index SWP_OFFSET(entry). Consequently, when
the value of entry.val is equal to 0x00002fe0, the swap area index
SWP_TYPE(entry) becomes 0x20, which is 32 in decimal.
This is an incorrect large value as is expected.
The correct value of SWP_TYPE}(entry) is 0.

Next, I investigated the sequence of the function calls that reaches 
finally
the above function swap_duplicate() by inserting many printk()
statements into source files under the directory mm.
The result that is obtained by this direct investigation is the 
following:

           handle_mm_fault()         in mm/memory.c
      ---> handle_pte_fault()        in mm/memory.c
      ---> do_swap_page()            in mm/memory.c          (*)
      ---> read_swap_cache_async()   in mm/swap_state.c
      ---> add_to_swap_cache()       in mm/swap_state.c
      ---> swap_duplicate()          in mm/swapfile.c

The function do_swap_page() that is marked by the symbol (*)
in the above sequence is coded as follows:

static int do_swap_page(struct mm_struct * mm,
         struct vm_area_struct * vma, unsigned long address,
         pte_t * page_table, pte_t orig_pte, int write_access)
{
         struct page *page;
         swp_entry_t entry = pte_to_swp_entry(orig_pte);          /* 
(**) */
         pte_t pte;
         int ret = 1;

         spin_unlock(&mm->page_table_lock);
         page = lookup_swap_cache(entry);
         if (!page) {
                 swapin_readahead(entry);
                 page = read_swap_cache_async(entry);
         ...
}


The arguemnt entry to the function swap_duplicate(swp_entry_t entry),
which happened to have the wrong value as was reported,
is originally calculated at the line marked by the symbol /* (**) */
in the above code and is transferred to the function
swap_duplicate() through the sequence of calling functions,
which is listed above. Thus the wrong value of the arguemnt entry to
the function swap_duplicate(swp_entry_t entry) comes from
some wrong value of the argument orig_pte of the function
do_swap_page(mm, vma, address, page_talble, orig_pte, write_access)
or the calulcalation from orig_pte to entry at the mark
/* (**) */ is wrong. This calculation is performed by the macro
pte_to_swp_entry(), which is defined in the header file
include/asm-ppc/pgtable.h as

#define pte_to_swp_entry(pte)           ((swp_entry_t) { pte_val(pte) 
 >> 2 })

The arguemnt of this macro pte should be of the type pte_t,
which is defined in the header file include/asm-ppc/page.h as

typedef struct { unsigned long pte; } pte_t;

In the same header file, the macro pte_val() is defined as

#define pte_val(x)      ((x).pte)

So, essentially, the type pte_t is just the unsigned long integer
and the macro pte_val() is redundant.

When the value of enttry.val that is calculated at
line marked by the symbol /* (**) */ takes the wrong value
0x00002fe0, which is reported before, the arguemnt orig_pte to
the macro pte_val() has the value equal to 0x0000bf80 according to
the defintion of the macro pte_val().

The value of the argument orig_pte that is passed to the function
do_swap_page(mm, vma, address, page_table, orig_pte, write_access)}
is first obtained in the function handle_mm_fault()
at the line marked by the symbol /* (***) */ in the list below;
the value is transferred to the function do_swap_page()
through the sequence of calling functions
handle_mm_fault() --> handle_pte_fault() --> do_swap_page().

int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
         unsigned long address, int write_access)
{
         pgd_t *pgd;
         pmd_t *pmd;

         current->state = TASK_RUNNING;
         pgd = pgd_offset(mm, address);

         /*
          * We need the page table lock to synchronize with kswapd
          * and the SMP-safe atomic PTE updates.
          */
         spin_lock(&mm->page_table_lock);
         pmd = pmd_alloc(mm, pgd, address);

         if (pmd) {
                 pte_t * pte = pte_alloc(mm, pmd, address);  /* (***) */
                 if (pte)
                         return handle_pte_fault(mm, vma, address, 
write_access, pte);
         ...

}

At this point,
I stopped my direct chase by inserting a lot of printk() statements
in the kernel source code to seek the origin that causes the wrong value
of the swap entry, since I thought that I had obtained enough 
information.

Anyway, the wrong value of the swap entry comes from the wrong value of
the corresponding Page Table Entry (PTE).

Furthermore, by inspecting the log that was printed by the many
printk() statements, I understood what is the rule how the correct 
value of
a swap entry is modified to the worng value for it.

I contiune using the same example, which I reported before.
In this example, the wrong value of a swap entry that is obtained from 
PTE
is 0x00002fe0; the correct value of this swap entry is 0x00002fc0.
Speaking in the corresponding value of PTE, the wrong value of the PTE
is 0x0000bf80 and the correct value of it is 0x0000bf00.
I observed in the log that (i) when a memory page is swapped out,
the PTE for the page is filled with the correct value 0x0000bf00
and (ii) when the PTE is read again, the value is changed to the wrong 
value
0x0000bf80. Namely, someone changed the value of the PTE while the page
is swapped out.

In this way, the wrong value of a PTE is obtained always by "or"ing
the coorect value and the constant 0x00000080.
This is the rule that I induced from the log.

Next, I looked around the source code to find out what the constant 
value
0x00000080 for a PTE means. I found that the following line
for PowerpC 8xx processors in the hader file include/asm-ppc/pgtable.h:

#define _PAGE_ACCESSED  0x0080  /* software: page referenced */

This suggests that someone turns on the flag _PAGE_ACCESSED
of a PTE, when it is accessed.

The next question is who is the "someone". I looked aournd the source 
code
again and found that three excpetion handlers actually turns on
the flag _PAGE_ACCESSED. These exception handlers are
InstructionTLBMiss, DataStoreTLBMiss and DataTLBError, which are coded
in the assmebler file arch/ppc/kernel/head_8xx.S. Among these handlers,
I think that DataStoreTLBMiss is innocent, since if DataStoreTLBMiss
were called, it would set not only the flag _PAGE_ACCESSED but also the 
flags
_PAGE_DIRTY and _PAGE_HWWRITE; however, I saw neither the flag 
_PAGE_DIRTY
nor _PAGE_HWWRITE was set in the log. Accordingly, the accused is/are
InstructionTLBMiss or/and DataStoreTLBMiss.

The exception handlers InstructionTLBMiss and DataStoreTLBMiss
are coded as follows:

InstructionTLBMiss:
...
         mtspr   MI_TWC, r21     /* Set page attributes */
#ifdef CONFIG_8xx_CPU6
         li      r3, 0x3b80
         stw     r3, 12(r0)
         lwz     r3, 12(r0)
#endif
         mtspr   MD_TWC, r21     /* Load pte table base address */
         mfspr   r21, MD_TWC     /* ....and get the pte address */
         lwz     r20, 0(r21)     /* Get the pte */

         ori     r20, r20, _PAGE_ACCESSED             /* Here !! */
         stw     r20, 0(r21)
...

DataStoreTLBMiss:
...
         mtspr   MD_TWC, r21     /* Load pte table base address */
         mfspr   r20, MD_TWC     /* ....and get the pte address */
         lwz     r20, 0(r20)     /* Get the pte */

         /* Insert the Guarded flag into the TWC from the Linux PTE.
          * It is bit 27 of both the Linux PTE and the TWC (at least
          * I got that right :-).  It will be better when we can put
          * this into the Linux pgd/pmd and load it in the operation
          * above.
          */
         rlwimi  r21, r20, 0, 27, 27
#ifdef CONFIG_8xx_CPU6
         li      r3, 0x3b80
         stw     r3, 12(r0)
         lwz     r3, 12(r0)
#endif
         mtspr   MD_TWC, r21

         mfspr   r21, MD_TWC     /* get the pte address again */
         ori     r20, r20, _PAGE_ACCESSED             /* Here !! */
         stw     r20, 0(r21)
...

Namely, when an exception InstructionTLBMiss or DataStoreTLBMiss occurs
for accessed page, the PTE corresponding to the memory page records that
the page is accessed in this way.

I have not yet investigated which routines in the linux kernel use
this flag _PAGE_ACCESSED for some purpose and what is the purpose.
Because this flag exists, it may have some purpose.

Nevertheless, the present way of usage of this flag _PAGE_ACCESSED
makes any swap partition or file be unable to be used at all for 
PowerPC 8xx
processors.

I know that a PowerPC 8xx processor is frequently used
without a swap partition and a swap file, since it is an embedded 
processor.
However, it is sometimes used with a swap partition or a swp file,
for example, as in the OpenBlockS 50. In the latter case,
the problem that I reported is fatal. Please fix this problem.

Finally, I report my somewhat phenomenologial fix of this problem.
I decided to turn off the flag _PAGE_ACCESSED in a PTE
when it is passed to the macro pte_to_swp_entry(pte).
Namely, I rewrote this macro as follows:

diff -rcP linux-2.4.22/include/asm-ppc/pgtable.h 
linux-2.4.22-obs-0.1/include/as
m-ppc/pgtable.h
*** linux-2.4.22/include/asm-ppc/pgtable.h      Mon Aug 25 20:44:44 2003
--- linux-2.4.22-obs-0.1/include/asm-ppc/pgtable.h      Mon Sep 29 
13:30:49 2003
***************
*** 565,571 ****
--- 565,575 ----
   #define SWP_TYPE(entry)                       ((entry).val & 0x3f)
   #define SWP_OFFSET(entry)             ((entry).val >> 6)
   #define SWP_ENTRY(type, offset)               ((swp_entry_t) { (type) 
| ((offs
et) << 6) })
+ #if defined(CONFIG_8xx)
+ #define pte_to_swp_entry(pte)         ((swp_entry_t) { (pte_val(pte) 
& ~_PAGE_
ACCESSED) >> 2 })
+ #else
   #define pte_to_swp_entry(pte)         ((swp_entry_t) { pte_val(pte) 
 >> 2 })
+ #endif
   #define swp_entry_to_pte(x)           ((pte_t) { (x).val << 2 })

   /* CONFIG_APUS */

I am not sure this is the most appropriate fix for this problem.
At least, I have confirmed that this fix removes completely
the problem that I have been reporting here.

Anyway, please fix this problem by some appropriate method
to make many users of OpenBlockS 50 in Japan be happy, please.

Sincerely yours,

Satoshi Adachi
adachi@aa.ap.titech.ac.jp

Tokyo Institute of Technology
Department of Condensed Matter Physics

P.S. The patch file for the source code of the official linux kernel
to make the kernel be usable on OpenBlockS 50 is stored at the following
address:

    ftp://ftp.aa.ap.titech.ac.jp/
       pub/adachi/OpenBlockS/linux/linux-2.4.22-obs-0.1.patch

This is a patch file for the official linux kernel (version 2.4.22).

