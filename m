Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131214AbQK0O6t>; Mon, 27 Nov 2000 09:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131989AbQK0O6j>; Mon, 27 Nov 2000 09:58:39 -0500
Received: from ns.felk.cvut.cz ([147.32.80.9]:31750 "EHLO ns.felk.cvut.cz")
        by vger.kernel.org with ESMTP id <S131214AbQK0O6D>;
        Mon, 27 Nov 2000 09:58:03 -0500
Date: Mon, 27 Nov 2000 15:28:01 +0100 (CET)
From: "Pavel Pisa;research student" <pisa@waltz.felk.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <Pine.LNX.4.04.10011271457360.6145-100000@fu.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have used patch from GCC-PATCHES list
posted by Bernd Schmidt <bernds at redhat dot com>.
Because of high importance I am forwarding this patch to
Linux-Kernel. Patch seems to solve problem.

I have added warning print for case of problem,
to find which parts of Linux kernel could be affected by this GCC
bug. There are results:

linux-2.4.0-test10-pre?   compiled for K7
make[2]: Entering directory `/usr/src/linux-2.4.0-t9/fs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-t9/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe  -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -fno-strict-aliasing    -c -o block_dev.o block_dev.c
block_dev.c: In function `block_read':
block_dev.c:311: warning: possible original gcc 2.95.2 error c/877
make[2]: Entering directory `/usr/src/linux-2.4.0-t9/ipc'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-t9/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe  -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -fno-strict-aliasing    -c -o msg.o msg.c
msg.c: In function `sys_msgctl':
msg.c:576: warning: possible original gcc 2.95.2 error c/877
gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-t9/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe  -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -fno-strict-aliasing    -c -o sem.o sem.c

I have run same compilation for 2.2.15 kernel compiled for K6
make[2]: Entering directory `/usr/src/linux-2.2.15/fs'
block_dev.c: In function `block_read':
block_dev.c:304: warning: possible original gcc 2.95.2 error c/877

I hope that my mail is not only waste of your time.
These possible wrong compiled files could be sources of other
false kernel related bugs.

If you have interest I will to try to compile 2.2.x and 2.4.0-x kernels
for bare i586 to find more such problematic places.

Best wishes 
            Pavel Pisa

PS: For faster response CC any reply directly to my address, please.

-----------------------------------------------------------------------------
To: aeb at cwi dot nl 
Subject: Re: c/877: gcc 2.95.2 generates incorrect code on i386 
From: Bernd Schmidt <bernds at redhat dot com> 
Date: Fri, 24 Nov 2000 15:40:05 +0000 (GMT) 
cc: gcc-gnats at gcc dot gnu dot org, gcc-prs at gcc dot gnu dot org, gcc-bugs at gcc dot gnu dot org, gcc-patches at gcc dot gnu dot
    org 



On 24 Nov 2000 aeb@cwi.nl wrote:

> >Synopsis:       gcc 2.95.2 generates incorrect code on i386

> It seems that a variable length shift of a long long
> is miscompiled. This causes Linux kernel bugs.

This is (as usual) a bug in reload.  We have two insns:

(insn 69 67 70 (set (reg:QI 46)
        (subreg:QI (reg:SI 43) 0))

(insn 70 69 72 (set (reg:DI 44)
        (ashiftrt:DI (reg:DI 44)
            (reg:QI 46)))               (expr_list:REG_DEAD 46)

Neither reg 46 nor reg 44 gets a hard register.  While processing insn 70,
reload decides that it will need reg 2 (%cl) for reg 46, and reg 3/4
(%ebx/%esi) for reg 44.  It also notices that the value of reg 44 is
already available in reg 1/2 (%edx/%ecx), so it can avoid loading it from
the stack and instead use reg 1/2 as overriding input.  It then notices
that reg 46 dies in insn 70 and is set in insn 69, so it would be possible
simply to replace the destination of insn 69 with the reload reg (%cl).

The problem is that by changing insn 69 to store into %cl, the input
override for the other reload gets clobbered.  Oops.  The function
reload_reg_free_for_value_p doesn't test for this case.

I'm currently bootstrapping with the patch below; I'll check it in (along
with a testcase) once that finishes.  It won't apply cleanly to 2.95, but
it should be quite easy to figure out how to apply it.  This is an obvious
candidate should we decide to make a 2.95.3 release.

(As a side note, this bug has nothing to do with the fact that there's a
long long shift in this testcase, although I think I've noticed a bunch
of potential bugs related to multiword values in the reload inheritance
code while looking at this testcase...)


Bernd

        * reload1.c (conflicts_with_override): New function.
        (emit_input_reload_insns): Use it to tighten test for validity
        of substituting into output of previous insn.

Index: reload1.c
===================================================================
RCS file: /cvs/gcc/egcs/gcc/reload1.c,v
retrieving revision 1.241
diff -u -p -r1.241 reload1.c
--- reload1.c   2000/11/14 10:23:37     1.241
+++ reload1.c   2000/11/24 15:11:43
@@ -417,6 +417,7 @@ static int reload_reg_reaches_end_p PARA
                                                 enum reload_type));
 static int allocate_reload_reg         PARAMS ((struct insn_chain *, int,
                                                 int));
+static int conflicts_with_override     PARAMS ((rtx));
 static void failed_reload              PARAMS ((rtx, int));
 static int set_reload_reg              PARAMS ((int, int));
 static void choose_reload_regs_init    PARAMS ((struct insn_chain *, rtx *));
@@ -4882,6 +4883,21 @@ reload_reg_free_for_value_p (regno, opnu
   return 1;
 }
 
+/* Determine whether the reload reg X overlaps any rtx'es used for
+   overriding inheritance.  Return nonzero if so.  */
+
+static int
+conflicts_with_override (x)
+     rtx x;
+{
+  int i;
+  for (i = 0; i < n_reloads; i++)
+    if (reload_override_in[i]
+       && reg_overlap_mentioned_p (x, reload_override_in[i]))
+      return 1;
+  return 0;
+}
+
 /* Give an error message saying we failed to find a reload for INSN,
    and clear out reload R.  */
 static void
@@ -6215,6 +6231,7 @@ emit_input_reload_insns (chain, rl, old,
           && dead_or_set_p (insn, old)
           /* This is unsafe if some other reload
              uses the same reg first.  */
+          && ! conflicts_with_override (reloadreg)
           && reload_reg_free_for_value_p (REGNO (reloadreg),
                                           rl->opnum,
                                           rl->when_needed,




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
