Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154065-16160>; Sun, 20 Sep 1998 00:44:47 -0400
Received: from diala061.ppp.lrz-muenchen.de ([129.187.24.61]:1226 "HELO fred.muc.de" ident: "TIMEDOUT2") by vger.rutgers.edu with SMTP id <153970-16160>; Sun, 20 Sep 1998 00:44:12 -0400
Message-ID: <19980920101801.A1794@kali.lrz-muenchen.de>
Date: Sun, 20 Sep 1998 10:18:01 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.rutgers.edu, ak@muc.de
Subject: Performance counters and Re: [PATCH] *_user fixes for ptrace on i386
References: <19980920011930.A1474@kali.lrz-muenchen.de> <Pine.LNX.3.96.980919222619.25789A-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.3.96.980919222619.25789A-100000@penguin.transmeta.com>; from Linus Torvalds on Sun, Sep 20, 1998 at 07:27:49AM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, Sep 20, 1998 at 07:27:49AM +0200, Linus Torvalds wrote:
> 
> 
> On Sun, 20 Sep 1998, Andi Kleen wrote:
> > 
> > I didn't consider these functions as speed critical, thus I chosed the
> > alternative that generates more compact code. If you think they're critical
> > I can move the access_ok calls out of the loops again - the main point
> > was to add the check for the return value of the actual data transfer.
> 
> I'm just nervous that you're removing __put_user()/__get_user() calls
> because you dislike them, not for any technical reasons. I like the "more
> compact code" argument, I just didn't get that when I got the patch.
> 
> I'll think about it some more - in the meantime the patch is gone, but I
> could maybe see it be re-applied.

Ok,I appended the patch again. Please tell me if you want me to change it.

Now another issue. I intend to implement support for the p5+
performance counters into Linux. This is a 2.3 project of course, I just
want to hear general opinions from you and the list on the API I chosed.

I think the right place for it is in ptrace. If a process wants to measure
itself it can just do ptrace(..., getpid(), ..). Because of the security
implications all reading and writing to the registers should be done from
kernel space - the counters will stop ticking as soon as supervisor mode
is entered anyways (when the OS flag is set in PervEvtSel), and in most
cases the profiler will be an external process anyways.

The kernel shall save and restore the counters and settings on context 
switch. The check for that can be merged with the check for debugging
registers that is already in __switch_to so there will be no slowdown for
the non-debugging case (BTW I think changing it to 
"if (!next->tss.debugreg[7]) return;" will safe one taken branch in this
critical function)

I added a few new ptrace requests:

struct perf_reg {
	int	p_num;			/* 0,1 for PervCtr0,1 on Intel */
	int	p_event;		/* Type of event to count for */
	__u64	p_value;		/* value to be read/writen */	
};

One problem is that p_event varies greatly between architectures and CPUs.
I propose to define some well-known events that are mapped by the kernel
to the CPU specific events, and reserve a range for CPU specific counters.
Problem is that the kernel has to contain a potentially large table then,
but I see no better way.

int ptrace(PTRACE_SETPERF, pid, struct perf_reg *reg, int flags);

Write reg->p_value into the performance register defined by reg and set it
up to count that event. Does not start the counter yet.
Return error if the CPU does not support that event or register.

flags: 

None defined yet.

int ptrace(PTRACE_GETPERF, pid, struct perf_reg *reg, int flags);

Get the current value and selected event for performance register reg->p_num.
Return error if the CPU does not support that register.

flags:

PERF_COUNTER_MAX	Read the overflow value instead, when the counter
			will overflow and may cause a SIGPROF if requested.
			On Intel that is always 2^40-1

int ptrace(PTRACE_PERFCTL_SET, pid, struct perf_reg *reg, int flags)

Control the performace counting for register reg.

flags:

PERF_COUNTER_ON		If set counter runs, otherwise it is turned off.
PERF_OVERFLOW_SIG	Send SIGPROF if counter overflows (if the CPU
			supports it)
PERF_OVERFLOW_OCCURED	Overflow occured. Only be set by the kernel.
			The kernel counts overflows in the p_value bits above
			PERF_COUNTER_MAX. If PERF_COUNTER_MAX is not a power
			of 2 the behaviour is undefined.

int ptrace(PTRACE_PERFCTL_GET, pid, struct perf_reg *reg, int flags)

Return current active flags for register reg.

This interface should map to the performance monitors of Intel P5 and PPro/PII,
PPC604e. The 21164 does not seem to provide a way to cause a interrupt on
overflow thus PERF_OVERFLOW_SIG won't work, but the rest does.

How would it map to other architectures e.g. MIPS or UltraSparc?

It might be a good idea to provide a read-only sysctl for the number of 
performance registers available.

-Andi


--- ../linus/linux/arch/i386/kernel/ptrace.c	Sat Sep 19 12:03:02 1998
+++ linux/arch/i386/kernel/ptrace.c	Sun Sep 20 00:48:08 1998
@@ -564,7 +564,7 @@
 			child->p_pptr = child->p_opptr;
 			SET_LINKS(child);
 			write_unlock_irqrestore(&tasklist_lock, flags);
-	/* make sure the single step bit is not set. */
+			/* make sure the single step bit is not set. */
 			tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 			put_stack_long(child, EFL_OFFSET, tmp);
 			wake_up_process(child);
@@ -573,89 +573,66 @@
 		}
 
 		case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-		  	if (!access_ok(VERIFY_WRITE, (unsigned *)data,
-				       17*sizeof(long)))
-			  {
-			    ret = -EIO;
-			    goto out;
-			  }
-			for ( i = 0; i < 17*sizeof(long); i += sizeof(long) )
-			  {
-			    __put_user(getreg(child, i),(unsigned long *) data);
+			for (i = 0; i < 17*sizeof(long); i += sizeof(long)) {
+			    ret = put_user(getreg(child, i),(unsigned long *) data);
+			    if (ret) break;
 			    data += sizeof(long);
-			  }
-			ret = 0;
+			}
 			goto out;
-		  };
+		}
 
 		case PTRACE_SETREGS: { /* Set all gp regs in the child. */
 			unsigned long tmp;
-		  	if (!access_ok(VERIFY_READ, (unsigned *)data,
-				       17*sizeof(long)))
-			  {
-			    ret = -EIO;
-			    goto out;
-			  }
-			for ( i = 0; i < 17*sizeof(long); i += sizeof(long) )
-			  {
-			    __get_user(tmp, (unsigned long *) data);
+			for (i = 0; i < 17*sizeof(long); i += sizeof(long)) {
+			    ret = get_user(tmp, (unsigned long *) data);
+			    if (ret) break;
 			    putreg(child, i, tmp);
 			    data += sizeof(long);
-			  }
-			ret = 0;
+			}
 			goto out;
-		  };
+		}
 
 		case PTRACE_GETFPREGS: { /* Get the child FPU state. */
-			if (!access_ok(VERIFY_WRITE, (unsigned *)data,
-				       sizeof(struct user_i387_struct)))
-			  {
-			    ret = -EIO;
-			    goto out;
-			  }
 			ret = 0;
-			if ( !child->used_math ) {
-			  /* Simulate an empty FPU. */
-			  child->tss.i387.hard.cwd = 0xffff037f;
-			  child->tss.i387.hard.swd = 0xffff0000;
-			  child->tss.i387.hard.twd = 0xffffffff;
+			if (!child->used_math) {
+				/* Simulate an empty FPU. */
+				child->tss.i387.hard.cwd = 0xffff037f;
+				child->tss.i387.hard.swd = 0xffff0000;
+				child->tss.i387.hard.twd = 0xffffffff;
 			}
 #ifdef CONFIG_MATH_EMULATION
 			if ( boot_cpu_data.hard_math ) {
 #endif
-				__copy_to_user((void *)data, &child->tss.i387.hard,
-						sizeof(struct user_i387_struct));
+				ret = copy_to_user((void *)data, 
+						   &child->tss.i387.hard,
+						   sizeof(struct user_i387_struct)) 
+					? -EFAULT : 0 ;
 #ifdef CONFIG_MATH_EMULATION
 			} else {
-			  save_i387_soft(&child->tss.i387.soft,
-					 (struct _fpstate *)data);
+				save_i387_soft(&child->tss.i387.soft,
+					       (struct _fpstate *)data);
 			}
 #endif
 			goto out;
 		  };
 
 		case PTRACE_SETFPREGS: { /* Set the child FPU state. */
-			if (!access_ok(VERIFY_READ, (unsigned *)data,
-				       sizeof(struct user_i387_struct)))
-			  {
-			    ret = -EIO;
-			    goto out;
-			  }
+			ret = 0; 
 			child->used_math = 1;
 #ifdef CONFIG_MATH_EMULATION
 			if ( boot_cpu_data.hard_math ) {
 #endif
-			  __copy_from_user(&child->tss.i387.hard, (void *)data,
-					   sizeof(struct user_i387_struct));
-			  child->flags &= ~PF_USEDFPU;
-			  stts();
+				ret = copy_from_user(&child->tss.i387.hard, (void *)data,
+					   sizeof(struct user_i387_struct))
+				  ? -EFAULT : 0;
+				child->flags &= ~PF_USEDFPU;
+				stts();
 #ifdef CONFIG_MATH_EMULATION
 			} else {
-			  restore_i387_soft(&child->tss.i387.soft,
-					    (struct _fpstate *)data);
+				restore_i387_soft(&child->tss.i387.soft,
+						  (struct _fpstate *)data);
 			}
 #endif
-			ret = 0;
 			goto out;
 		  };
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
