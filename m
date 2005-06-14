Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVFNAa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFNAa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFNA2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:28:05 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:7904 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261494AbVFNAYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:24:08 -0400
Message-ID: <000b01c5707e$c189c930$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC]  exit_thread() speedups in x86 process.c
Date: Mon, 13 Jun 2005 21:16:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current exit_thread() implementation, it appears including the I/O
port map tear down code within the exit_thread() generates enough autovar
data that the compiler needs to spill 4 registers to the stack resulting in
(4) PUSH on entry and (4) POP on exit.

When I tried extracting the map teardown into a seperate function, the
situation changed dramatically to where NO REGISTERS were being
pushed/popped in the normal path entry/exit.

Below is the original generated code, code my proposal generated, and an
#ifdef'd change that produced this elimination of the PUSH/POP's.

Unless I'm on drugs, this looks like a solid winner in a fairly important
code path :)

--------- Original exit_thread() -------
 615               .globl exit_thread
 616               .type exit_thread,@function
 617               exit_thread:
 618 02cc 55        pushl %ebp
 619 02cd 57        pushl %edi
 620 02ce 56        pushl %esi
 621 02cf 53        pushl %ebx
 622 02d0 B800E0FF  movl $-8192,%eax

    blah, blah...

 629 02e5 85C0      testl %eax,%eax
 630 02e7 7507      jne .L1675
 631               .L1657:
 632 02e9 5B        popl %ebx
 633 02ea 5E        popl %esi
 634 02eb 5F        popl %edi
 635 02ec 5D        popl %ebp
 636 02ed C3        ret
 637 02ee 89F6      .p2align 2
 638               .L1675:
 639 02f0 50        pushl %eax
 640 02f1 E8FCFFFF  call kfree


    ...Lots of stuff here to tear down port maps...

--------- Proposed exit_thread() -------

 655               .globl exit_thread
 656               .type exit_thread,@function
 657               exit_thread:
///////////////////////////////////////
// Note how all PUSH/POP's are
// gone from the mainline code now
///////////////////////////////////////
 658 0340 B800E0FF  movl $-8192,%eax
 658      FF
 659
 660 0345 21E0      andl %esp,%eax
 661
 662 0347 8B00      movl (%eax),%eax
 663 0349 05C00100  addl $448,%eax
 663      00
 664 034e 8B907C02  movl 636(%eax),%edx
 664      0000
 665 0354 85D2      testl %edx,%edx
 666 0356 7504      jne .L1676
 667 0358 C3        ret
 668 0359 8D7600    .p2align 2
 669               .L1676:
 670 035c 50        pushl %eax
 671 035d E86AFFFF  call NukePortMap
 671      FF
 672 0362 58        popl %eax
 673 0363 C3        ret

---- This is the change that eliminates the PUSH/POP's ---

#ifdef __TONYI__
static void NukePortMap(struct thread_struct *t)
{
 int cpu = get_cpu();
 struct tss_struct *tss = &per_cpu(init_tss, cpu);

 kfree(t->io_bitmap_ptr);
 t->io_bitmap_ptr = NULL;
 /*
  * Careful, clear this in the TSS too:
  */
 memset(tss->io_bitmap, 0xff, tss->io_bitmap_max);
 t->io_bitmap_max = 0;
 tss->io_bitmap_owner = NULL;
 tss->io_bitmap_max = 0;
 tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 put_cpu();
}
#endif

/*
 * Free current thread data structures etc..
 */
void exit_thread(void)
{
 struct task_struct *tsk = current;
 struct thread_struct *t = &tsk->thread;

 /* The process may have allocated an io port bitmap... nuke it. */
 if (unlikely(NULL != t->io_bitmap_ptr)) {
#ifdef __TONYI__
  NukePortMap(t);
#else
  int cpu = get_cpu();
  struct tss_struct *tss = &per_cpu(init_tss, cpu);

  kfree(t->io_bitmap_ptr);
  t->io_bitmap_ptr = NULL;
  /*
   * Careful, clear this in the TSS too:
   */
  memset(tss->io_bitmap, 0xff, tss->io_bitmap_max);
  t->io_bitmap_max = 0;
  tss->io_bitmap_owner = NULL;
  tss->io_bitmap_max = 0;
  tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
  put_cpu();
#endif
 }
}

