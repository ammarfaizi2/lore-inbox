Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265268AbSJaTzR>; Thu, 31 Oct 2002 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265289AbSJaTzR>; Thu, 31 Oct 2002 14:55:17 -0500
Received: from crack.them.org ([65.125.64.184]:19210 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265268AbSJaTyg>;
	Thu, 31 Oct 2002 14:54:36 -0500
Date: Thu, 31 Oct 2002 15:00:56 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: torvalds@transmeta.com, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: PATCH: ptrace support for fork/vfork/clone events [1/3]
Message-ID: <20021031200056.GA3764@nevyn.them.org>
Mail-Followup-To: torvalds@transmeta.com, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've answered everyone's concerns about these patches (again). 
Yet another Debian user asked me about their status last night, so I'm
going to submit them again.  I'm actively using the 2.4 backport, and I
find it invaluable when debugging multi-process problems.

These three patches provide an event-mask interface for ptrace clients to   
watch for events in debugged processes.  The supported events right now are
fork, vfork, clone, and execve.  This interface only triggers on the
requested events, which makes it a great deal more practical than using
PTRACE_SYSCALL.

Why is this necessary?  Without it, there are some things GDB can't do.  You
can't step over a call to fork(), because when you do, the child process 
will hit the parent's step breakpoint and exit with SIGTRAP.  You also can't
choose to debug the child instead of the parent, because GDB doesn't have a
chance to attach to it before it continues or exits.

There's no other viable way to do this without kernel support; using a
trampoline is racy (as well as exceedingly complicated from a lightweight
debugger standpoint).

The code is in three parts:
 1. Factor out some common ptrace code; implement PTRACE_O_TRACESYSGOOD
    and PTRACE_SETOPTIONS for every architecture.  This one will let me unify
    a great deal more of the architecture ptrace implementations later.      
 2. Add a new clone flag, CLONE_UNTRACED, and force it in all kernel_thread 
    implementations.  Needed by the next patch.  This one touches every
    architecture and some of them in assembly; I've tried to get them all   
    correct.
    [Why is this needed?  It's needed so that the debugger doesn't get
    triggered on, say, a kernel-started modprobe process or some other
    kernel thread.  That'd confuse the debugger, beyond the other possible  
    security/stability problems.]
 3. Add PTRACE_GETEVENTMSG and four new flags to PTRACE_SETOPTIONS, to allow
    tracing fork, vfork, clone, and exec events.

The patches have been tested on i386, and a 2.4 backport tested on SH, MIPS,
i386, PowerPC, and ARM; I have GDB using this mechanism and have run that
through more stress tests than I really want to remember right now.

Future plans for the unified ptrace handling include READDATA/WRITEDATA for
all architectures (someone else submitted code to do this just recently for
2.4, but mine's a little cleaner, I think) and page-protection based
watchpoints for targets which don't have available hardware watchpoints
(thanks to Klee at Apple for enlightening me on this concept :).
                                                                
The three patches are available at:
  http://crack.them.org/~drow/forks/

or from the BK tree at:
  bk://nevyn.them.org:5000

Here's #1.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.855   -> 1.856  
#	include/asm-i386/ptrace.h	1.2.1.1 -> 1.4    
#	arch/s390x/kernel/ptrace.c	1.7.1.1 -> 1.9    
#	include/linux/ptrace.h	1.3     -> 1.4    
#	arch/arm/kernel/ptrace.c	1.12.1.2 -> 1.14   
#	arch/sh/kernel/ptrace.c	1.7     -> 1.8    
#	arch/parisc/kernel/ptrace.c	1.4.1.1 -> 1.6    
#	include/asm-s390x/ptrace.h	1.3.1.1 -> 1.5    
#	arch/mips64/kernel/ptrace.c	1.6     -> 1.7    
#	arch/ppc/kernel/ptrace.c	1.10    -> 1.11   
#	arch/i386/kernel/ptrace.c	1.13.1.1 -> 1.15   
#	arch/x86_64/ia32/ptrace32.c	1.2.1.1 -> 1.4    
#	arch/ppc64/kernel/ptrace.c	1.3.1.1 -> 1.5    
#	arch/m68k/kernel/ptrace.c	1.7     -> 1.8    
#	include/asm-x86_64/ptrace.h	1.3.1.1 -> 1.5    
#	arch/x86_64/kernel/ptrace.c	1.3.1.1 -> 1.5    
#	arch/cris/kernel/ptrace.c	1.8     -> 1.9    
#	arch/ppc64/kernel/ptrace32.c	1.5.1.1 -> 1.7    
#	include/asm-arm/ptrace.h	1.2     -> 1.3    
#	include/asm-mips/ptrace.h	1.2     -> 1.3    
#	arch/ia64/ia32/sys_ia32.c	1.24    -> 1.25   
#	include/asm-ia64/ptrace.h	1.4     -> 1.5    
#	include/asm-s390/ptrace.h	1.5.1.1 -> 1.7    
#	include/asm-sh/ptrace.h	1.2     -> 1.3    
#	arch/alpha/kernel/ptrace.c	1.9     -> 1.10   
#	arch/s390/kernel/ptrace.c	1.8.1.1 -> 1.10   
#	include/asm-mips64/ptrace.h	1.1     -> 1.2    
#	arch/sparc64/kernel/ptrace.c	1.16    -> 1.17   
#	arch/ia64/kernel/ptrace.c	1.11.1.1 -> 1.13   
#	arch/sparc/kernel/ptrace.c	1.11    -> 1.12   
#	arch/mips/kernel/ptrace.c	1.8     -> 1.9    
#	     kernel/ptrace.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	drow@nevyn.them.org	1.856
# Merge nevyn.them.org:/nevyn/big/kernel/linux-2.5
# into nevyn.them.org:/nevyn/big/kernel/test/linux-2.5-trace1
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
--- a/arch/alpha/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/arch/alpha/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -383,7 +383,7 @@
 		goto out;
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		goto out;
 	}
  out:
@@ -400,7 +400,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
--- a/arch/arm/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/arm/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -692,16 +692,8 @@
 			ret = ptrace_setfpregs(child, (void *)data);
 			break;
 
-		case PTRACE_SETOPTIONS:
-			if (data & PTRACE_O_TRACESYSGOOD)
-				child->ptrace |= PT_TRACESYSGOOD;
-			else
-				child->ptrace &= ~PT_TRACESYSGOOD;
-			ret = 0;
-			break;
-
 		default:
-			ret = -EIO;
+			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
 
diff -Nru a/arch/cris/kernel/ptrace.c b/arch/cris/kernel/ptrace.c
--- a/arch/cris/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/cris/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -292,7 +292,7 @@
 		}
 
 		default:
-			ret = -EIO;
+			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
 out_tsk:
@@ -307,10 +307,8 @@
 	if ((current->ptrace & (PT_PTRACED | PT_TRACESYS)) !=
 	    (PT_PTRACED | PT_TRACESYS))
 		return;
-	/* TODO: make a way to distinguish between a syscall stop and SIGTRAP
-	 * delivery like in the i386 port ? 
-	 */
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/i386/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -416,17 +416,8 @@
 		break;
 	}
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-	}
-
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	Thu Oct 31 14:02:17 2002
+++ b/arch/ia64/ia32/sys_ia32.c	Thu Oct 31 14:02:17 2002
@@ -3076,7 +3076,7 @@
 		break;
 
 	      default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 
 	}
diff -Nru a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
--- a/arch/ia64/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/arch/ia64/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -1268,16 +1268,8 @@
 		ret = ptrace_setregs(child, (struct pt_all_user_regs*) data);
 		goto out_tsk;
 
-	      case PTRACE_SETOPTIONS:
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-
 	      default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		goto out_tsk;
 	}
   out_tsk:
diff -Nru a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
--- a/arch/m68k/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/m68k/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -355,7 +355,7 @@
 		}
 
 		default:
-			ret = -EIO;
+			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
 out_tsk:
@@ -370,7 +370,8 @@
 	if (!current->thread.work.delayed_trace &&
 	    !current->thread.work.syscall_trace)
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
--- a/arch/mips/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/arch/mips/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -304,16 +304,8 @@
 		res = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS:
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		res = 0;
-		break;
-
 	default:
-		res = -EIO;
+		res = ptrace_request(child, request, addr, data);
 		goto out;
 	}
 out_tsk:
diff -Nru a/arch/mips64/kernel/ptrace.c b/arch/mips64/kernel/ptrace.c
--- a/arch/mips64/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/mips64/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -275,17 +275,8 @@
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-	}
-
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 
@@ -535,17 +526,8 @@
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-	}
-
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 
diff -Nru a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
--- a/arch/parisc/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/parisc/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -385,7 +385,7 @@
 		goto out_tsk;
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		goto out_tsk;
 	}
 
@@ -409,7 +409,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/ppc/kernel/ptrace.c b/arch/ppc/kernel/ptrace.c
--- a/arch/ppc/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/ppc/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -339,7 +339,7 @@
 #endif
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
@@ -354,7 +354,8 @@
         if (!test_thread_flag(TIF_SYSCALL_TRACE)
 	    || !(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/ppc64/kernel/ptrace.c b/arch/ppc64/kernel/ptrace.c
--- a/arch/ppc64/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/ppc64/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -276,7 +276,7 @@
 	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
@@ -292,7 +292,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/ppc64/kernel/ptrace32.c b/arch/ppc64/kernel/ptrace32.c
--- a/arch/ppc64/kernel/ptrace32.c	Thu Oct 31 14:02:16 2002
+++ b/arch/ppc64/kernel/ptrace32.c	Thu Oct 31 14:02:16 2002
@@ -413,7 +413,7 @@
 
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
--- a/arch/s390/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/arch/s390/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -307,15 +307,8 @@
 			copied += sizeof(unsigned long);
 		}
 		return 0;
-
-	case PTRACE_SETOPTIONS:
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		return 0;
 	}
-	return -EIO;
+	return ptrace_request(child, request, addr, data);
 }
 
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
diff -Nru a/arch/s390x/kernel/ptrace.c b/arch/s390x/kernel/ptrace.c
--- a/arch/s390x/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/s390x/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -261,7 +261,7 @@
 		}
 		return 0;
 	}
-	return -EIO;
+	return ptrace_request(child, request, addr, data);
 }
 
 #ifdef CONFIG_S390_SUPPORT
@@ -469,7 +469,7 @@
 		}
 		return 0;
 	}
-	return -EIO;
+	return ptrace_request(child, request, addr, data);
 }
 #endif
 
@@ -538,12 +538,6 @@
 		/* detach a process that was attached. */
 		return ptrace_detach(child, data);
 
-	case PTRACE_SETOPTIONS:
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		return 0;
 	/* Do requests that differ for 31/64 bit */
 	default:
 #ifdef CONFIG_S390_SUPPORT
@@ -551,8 +545,8 @@
 			return do_ptrace_emu31(child, request, addr, data);
 #endif
 		return do_ptrace_normal(child, request, addr, data);
-		
 	}
+	/* Not reached.  */
 	return -EIO;
 }
 
diff -Nru a/arch/sh/kernel/ptrace.c b/arch/sh/kernel/ptrace.c
--- a/arch/sh/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/sh/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -356,17 +356,8 @@
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-	}
-
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
--- a/arch/sparc/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/arch/sparc/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -584,10 +584,15 @@
 
 	/* PTRACE_DUMPCORE unsupported... */
 
-	default:
-		pt_error_return(regs, EIO);
+	default: {
+		int err = ptrace_request(child, request, addr, data);
+		if (err)
+			pt_error_return(regs, -err);
+		else
+			pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
+	}
 out_tsk:
 	if (child)
 		put_task_struct(child);
@@ -604,7 +609,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	current->thread.flags ^= MAGIC_CONSTANT;
 	notify_parent(current, SIGCHLD);
diff -Nru a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
--- a/arch/sparc64/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/arch/sparc64/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -571,10 +571,15 @@
 
 	/* PTRACE_DUMPCORE unsupported... */
 
-	default:
-		pt_error_return(regs, EIO);
+	default: {
+		int err = ptrace_request(child, request, addr, data);
+		if (err)
+			pt_error_return(regs, -err);
+		else
+			pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
+	}
 flush_and_out:
 	{
 		unsigned long va;
@@ -612,7 +617,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/x86_64/ia32/ptrace32.c b/arch/x86_64/ia32/ptrace32.c
--- a/arch/x86_64/ia32/ptrace32.c	Thu Oct 31 14:02:16 2002
+++ b/arch/x86_64/ia32/ptrace32.c	Thu Oct 31 14:02:16 2002
@@ -185,17 +185,6 @@
 	__u32 val;
 
 	switch (request) { 
-	case PTRACE_TRACEME:
-	case PTRACE_ATTACH:
-	case PTRACE_SYSCALL:
-	case PTRACE_CONT:
-	case PTRACE_KILL:
-	case PTRACE_SINGLESTEP:
-	case PTRACE_DETACH:
-	case PTRACE_SETOPTIONS:
-		ret = sys_ptrace(request, pid, addr, data); 
-		return ret;
-
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
 	case PTRACE_POKEDATA:
@@ -211,7 +200,8 @@
 		break;
 		
 	default:
-		return -EIO;
+		ret = sys_ptrace(request, pid, addr, data); 
+		return ret;
 	} 
 
 	child = find_target(request, pid, &ret);
diff -Nru a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
--- a/arch/x86_64/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
+++ b/arch/x86_64/kernel/ptrace.c	Thu Oct 31 14:02:16 2002
@@ -405,17 +405,8 @@
 		break;
 	}
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
-		break;
-	}
-
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/include/asm-arm/ptrace.h b/include/asm-arm/ptrace.h
--- a/include/asm-arm/ptrace.h	Thu Oct 31 14:02:16 2002
+++ b/include/asm-arm/ptrace.h	Thu Oct 31 14:02:16 2002
@@ -6,10 +6,7 @@
 #define PTRACE_GETFPREGS	14
 #define PTRACE_SETFPREGS	15
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #include <asm/proc/ptrace.h>
 
diff -Nru a/include/asm-i386/ptrace.h b/include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	Thu Oct 31 14:02:16 2002
+++ b/include/asm-i386/ptrace.h	Thu Oct 31 14:02:16 2002
@@ -49,10 +49,7 @@
 #define PTRACE_GETFPXREGS         18
 #define PTRACE_SETFPXREGS         19
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
diff -Nru a/include/asm-ia64/ptrace.h b/include/asm-ia64/ptrace.h
--- a/include/asm-ia64/ptrace.h	Thu Oct 31 14:02:17 2002
+++ b/include/asm-ia64/ptrace.h	Thu Oct 31 14:02:17 2002
@@ -287,9 +287,6 @@
 #define PTRACE_GETREGS		18	/* get all registers (pt_all_user_regs) in one shot */
 #define PTRACE_SETREGS		19	/* set all registers (pt_all_user_regs) in one shot */
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #endif /* _ASM_IA64_PTRACE_H */
diff -Nru a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
--- a/include/asm-mips/ptrace.h	Thu Oct 31 14:02:16 2002
+++ b/include/asm-mips/ptrace.h	Thu Oct 31 14:02:16 2002
@@ -59,10 +59,7 @@
 /* #define PTRACE_GETFPXREGS		18 */
 /* #define PTRACE_SETFPXREGS		19 */
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #ifdef _LANGUAGE_ASSEMBLY
 #include <asm/offset.h>
diff -Nru a/include/asm-mips64/ptrace.h b/include/asm-mips64/ptrace.h
--- a/include/asm-mips64/ptrace.h	Thu Oct 31 14:02:17 2002
+++ b/include/asm-mips64/ptrace.h	Thu Oct 31 14:02:17 2002
@@ -64,10 +64,7 @@
 /* #define PTRACE_GETFPXREGS		18 */
 /* #define PTRACE_SETFPXREGS		19 */
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #ifdef _LANGUAGE_ASSEMBLY
 #include <asm/offset.h>
diff -Nru a/include/asm-s390/ptrace.h b/include/asm-s390/ptrace.h
--- a/include/asm-s390/ptrace.h	Thu Oct 31 14:02:17 2002
+++ b/include/asm-s390/ptrace.h	Thu Oct 31 14:02:17 2002
@@ -105,10 +105,7 @@
 
 #define STACK_FRAME_OVERHEAD	96	/* size of minimum stack frame */
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
diff -Nru a/include/asm-s390x/ptrace.h b/include/asm-s390x/ptrace.h
--- a/include/asm-s390x/ptrace.h	Thu Oct 31 14:02:16 2002
+++ b/include/asm-s390x/ptrace.h	Thu Oct 31 14:02:16 2002
@@ -85,10 +85,7 @@
 
 #define STACK_FRAME_OVERHEAD    160      /* size of minimum stack frame */
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
diff -Nru a/include/asm-sh/ptrace.h b/include/asm-sh/ptrace.h
--- a/include/asm-sh/ptrace.h	Thu Oct 31 14:02:17 2002
+++ b/include/asm-sh/ptrace.h	Thu Oct 31 14:02:17 2002
@@ -44,10 +44,7 @@
 #define REG_XDREG14	47
 #define REG_FPSCR	48
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 /*
  * This struct defines the way the registers are stored on the
diff -Nru a/include/asm-x86_64/ptrace.h b/include/asm-x86_64/ptrace.h
--- a/include/asm-x86_64/ptrace.h	Thu Oct 31 14:02:16 2002
+++ b/include/asm-x86_64/ptrace.h	Thu Oct 31 14:02:16 2002
@@ -32,10 +32,7 @@
 /* top of stack page */ 
 #define FRAME_SIZE 168
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 /* Dummy values for ptrace */ 
 #define FS 1000 
diff -Nru a/include/linux/ptrace.h b/include/linux/ptrace.h
--- a/include/linux/ptrace.h	Thu Oct 31 14:02:16 2002
+++ b/include/linux/ptrace.h	Thu Oct 31 14:02:16 2002
@@ -23,6 +23,12 @@
 
 #define PTRACE_SYSCALL		  24
 
+/* 0x4200-0x4300 are reserved for architecture-independent additions.  */
+#define PTRACE_SETOPTIONS	0x4200
+
+/* options set using PTRACE_SETOPTIONS */
+#define PTRACE_O_TRACESYSGOOD	0x00000001
+
 #include <asm/ptrace.h>
 #include <linux/sched.h>
 
@@ -32,6 +38,7 @@
 extern int ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
+extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
 extern void __ptrace_link(struct task_struct *child,
 				struct task_struct *new_parent);
 extern void __ptrace_unlink(struct task_struct *child);
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
+++ b/kernel/ptrace.c	Thu Oct 31 14:02:17 2002
@@ -248,3 +248,35 @@
 	}
 	return copied;
 }
+
+int ptrace_setoptions(struct task_struct *child, long data)
+{
+	if (data & PTRACE_O_TRACESYSGOOD)
+		child->ptrace |= PT_TRACESYSGOOD;
+	else
+		child->ptrace &= ~PT_TRACESYSGOOD;
+
+	if ((data & PTRACE_O_TRACESYSGOOD) != data)
+		return -EINVAL;
+
+	return 0;
+}
+
+int ptrace_request(struct task_struct *child, long request,
+		   long addr, long data)
+{
+	int ret = -EIO;
+
+	switch (request) {
+#ifdef PTRACE_OLDSETOPTIONS
+	case PTRACE_OLDSETOPTIONS:
+#endif
+	case PTRACE_SETOPTIONS:
+		ret = ptrace_setoptions(child, data);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
