Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031177AbWI0Ws4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031177AbWI0Ws4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031176AbWI0Ws4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:48:56 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:21991 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1031174AbWI0Wsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:48:54 -0400
Date: Wed, 27 Sep 2006 15:48:32 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-ID: <20060927224832.GA17883@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060926143420.GF14550@frankl.hpl.hp.com> <20060926220951.39bd344f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926220951.39bd344f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is the summary of the various point raised by your review and the current
status. I am hoping to close all points by next release.

[ak] : use add_timer()/del_timer() instead of hook into smp_local_timer_interrupt() set timeout based set 
	- started looking into this, not confident it could be done and be sa simple as what we have today

[ak] : put set_intr_gate() all in one place for each arch()
	- done

[ak] : suggest use upcoming exit_thread/copy_thread notifiers instead of hooks
	- abandonned

[ak] : separate patch for _TIF_WORK_CTXSW
	- I think I submitted a TIF patch for x86-64, but unlike i386 it is not yet in mainline

[ak] : clarify pfm_handle_work(), use TIF flags to trigger call
	- trigger by TIF_PERFMON_WORK now. Optimization as it is called only for tasks 
	  that have it set, not all tasks with TIF_PERFMON_CTXSW

[ak] : x86-64 FIRST_SYSTEM_VECTOR does not need to be adjusted
	- done

[ak] : CONFIG_PERFMON* not on by default
	- done

[ak] : rename *_AMD64 to *_K8
	- done

[ak] : rename EM64T to P4
	- done

[ak] : explain what PEBS does
	- done

[ak] : merge 64-bit and 32-bit PEBS code
	- done

[ak] : what about UUID for sampling format?
	- could try to replace UUID with plain old string. work-in-progress

[ak] : check alignment of shared struct for 32-it and 64-bit ABIs
	- done. structures shared with user have no padding

[ak] : had comment about lazy save/restore strategy
	- not yet done

[ak] : may have to add __kprobes to some functions
	- started doing this on some functions. Need better understanding on when to use this

[ak] : use sched_clock() to get timing
	- done

[ak] : explain context locking
	- not yet done

[ak] : explain statistics gathering
	- done. This is mostly for debugging purposes

[ak] : justify why multiple sampling formats are needed, instead of just hardcoding
	- done. Just think of Intel PEBS support without it

[ak] : i386 should have wrmsrl()
	- modified the code to avoid having a #define

[ak] : cleaner integration with NMI watchdog
	- integration done on AMD K8. Issues on P4, P6, due to PMU design

[ak] : drop cr4.pce management, will be one by default with PERFCTR0 as a replacement or TSC
	- done

[ak] : add exit_idle/enter_idle to smp_pmu_interrupt()
	- done

[ak] : what is the difference between masking/unmasking monitoring and start/stop
	- need to provide explanation. In short: on Itanium start/stop may be controlled
	  from userland, kernel need another way to guarantee monitoring is stopped

[ak] : check that CPUID instruction is supported before using it
	- done

[ak] : fix helper function to module autoloader to better check for architectural PMU on Intel
	- done

[ak] : add synthetic flag to cpufeature to simplify detection of architectural PMU and features
	- done. Added PEB. May be able to do more. Andi added ARCH_PERFMON in 2.6.18

[ak] : simplify model/vendor/family detection in PMU description modules 
	- done

[ak] : ignore registers if find more than what is supported by generic architectural PMU description module
	- done

[ak] : removed duplicate APIC enable detction
	- done

[ak] : add a force module option on P4 (just too many variations)
	- done

[ak] : may need some apic workaround for older i386 CPU (pfm_arch_resend_irq())
	- not yet investigated

[ak] : pfm_serialize() : should this be sync_core() on x86?
	- not yet investigated

[ak] : over-abstraction in pfm_arch_read_pmd()
	- not yet done

[ak] : security fix in syscall with vector argument (overflow)
	- done


[akpm]: lots of poking into task lifetime internals
	- simplified by using ptrace_check_attach(). Need to check if more can be done

[akpm]: checks running atomic in some of the task checks
	- yes

[akpm]: fix return value for pfm_get_args() 
	- done

[akpm]: use fget_light() in some place instead of fget()
	- not sure understand when to use one versus the other

[akpm]: check integer multiply overflow in syscall with vector arguments
	- done

[akpm] : add ptr_to_free to syscall with vector arguments to make logic more explicit
	- done

[akpm] : make sure we do not leak kernel information through copy_to_user() when returning with errors
	- done

[akpm]: documentation for syscall? Is there an API specification?
	- answered. In short, there exists a specification but it needs to be updated

[akpm]: check structure shared between kernel and user do not have padding inserted by compiler (leak)
	- done

[akpm]: move pfm_sysfs_add_pmu() declaration to header file if necessary
	- not yet done

[akpm: change return value for sysfs debug_store()  function to return sz
	- done

[akpm]: use goto instead of multiple 'return ret;'
	- done

[akpm]: does this code support CPU HOTPLUG?
	- yes, as of 2.6.18 perfmon2 supoprts CPU hotplug. This affects system-wide measurements
	  and /sysfs stuff.

[akpm]: what use UUID for sampling formats?
	- switch to clear text string, not yet done

[akpm]: pfm_sysfs_remove_fmt(), pfm_sysfs_add_fmt() add comments to explain goal
	- not yet done

[akpm]: pfm_sysfs_remove_pmu(), pfm_sysfs_add_pmu() add comments to explain goal
	- not yet done

[akpm]: sysfs uses one file = one value, fix for register mapping view
	- done, register mapping files use one file per value, 2.6.18 introduces a new subtree in /sys/kernel/perfmon/pmu_desc

[akpm]: is pfm_smpl_fmt_lock really needed?
	- I think so

[akpm]: check and handle sysfs errors
	- done

[akpm]: get_cpu() not needed in pfm_interrupt_handler()
	- done
[akpm]: SLAB_ATOMIC is unreliable, use SLAB_KERNEL if possible?
	- started looking into this, not completely solved

[akpm]: use kmem_cache_zalloc()
	- done

[akpm]: careful vmalloc() sleeps
	- yes, I think I switched to kmalloc()

[akpm]: pfm_view_map_pagefault() test should use >=
	- done

[akpm]: justify perfmon_kapi.c
	- removed for now

[akpm]: replace PFM_LAST_CPU() with actual code, this is less confusing
	- done

[akpm]: __pfmk_read() check return value from wait_completion_interruptible()
	- due to removal of kapi, this problem is gone

[akpm]: use EXPORT_SYMBOL_GPL() 
	- not yet done.

[akpm]: extraenous white space  in __pfm_read()
	- done

[akpm]: simplify __pfm_read() using a while loop
	- not yet done

[akpm]: pfm_poll() test on filp is useless as it can never be true
	- not yet done

[akpm]: pfm_poll() is context locking needed?
	- not yet investigated

[akpm]: explain why cannot use relayfs instead of buffer remapping scheme
	- need to exlain. In short, for per-thread monitoring, the buffer is managed
	   per thread and follows the thrad as it migrates from one CPU to another.

[akpm]: explicit licensing
	- done

[akpm]: add comment to show which structure are shared with users
	- not yet done

[akpm]: alignment of structures shared with users
	- done

[akpm]: don't use type for pfm_flags_t
	- not yet done
[akpm]: maybe use packed on structures shared with user
	- may cause unaligned problems

[akpm]: reserved for future is useless unless there is version info somewhere
	- yes there is a version in /sys/kernel/perfmon/version

[akpm]: reserved for future fields must be guaranteed zero when kernel provides them
	- need to check this
[akpm]: does kernel check reserved fields are zero?
	- no, need to be done
[akpm]: why microseconds for set timeout, nanoseconds is typical
	- could be nanoseconf to be uniform. No real compatiblity issue. The point
	  was that the timeout granularity is limited by timer tick granularity, which is
	  more in the order of micro-seconds than nanoseconds. We can still make the change.

[akpm]: what about the volatile in pfm_set_view
	- pfm_set_view is a structure shared with user via remapping.

[akpm]: convert pfm_arch_context() to inline 
	- not yet done

[akpm]: pfm_modview*() need locking and comments
	- set_view may be shared with user via remapping. This can ONLY happen when
	  self-monitoring. There is no concurrency possible with another thread and
	  interrupts are masked when kernel modifies fields.

[akpm]: protoypes need argument identifiers
	- not yet done

[akpm]: carta_random32() should be in another header file
	- yes, I know. Should I create a specific header file? I don't think random.h
	  is meant for this.

[akpm]: replace pfm_put_ctx() wrapper with explicit call
	- not yet done

[akpm]: add bitmap operation for bv_set, bv_isset() to bitmap.h
	- not yet done
	
[akpm]: fix bitmap.h shortcomings with data types
	- not sure how to solve this? Force to u64, use void *

[akpm]: change the way we manage the ringbuffer for messages
	- not yet done

[akpm]: pfm_setup_smpl_fmt() check for duplicate tests
	- need to investigate this

[akpm]: get CONFIG_IA64_PERFMON_COMPAT out of perfmon.c using helper functions
	- good idea. Will do in next release

[akpm]: avoid unreliable SLAB_ATOMIC
	- need to verify locking issue if switch to other SLAB mode

[akpm]: pfm_smpl_buffer_alloc() add newline to if()
	- not yet done

[akpm]: avoid multiple consecutive empty lines
	- not yet done

[akpm]: remove unneeded braces in pfm_reset_pmds()
	- not yet done

[akpm]: use assert_spin_locked() in pfm_resume_after_ovfl()
	- not yet done

[akpm]: remove reference to IA-64 code in comments to pfm_handle_work()
	- done

[akpm]: pfm_handle_work() unpleasing handling of local_irq
	- not sure how to deal with this in a better way

[akpm]: switch() statement indent
	- not yet done

[akpm]: __pfm_init() may leak cachep for context
	- kmem_cache_create is done only once. Need to check if we can add destroy call

[akpm]: add comments in pfm_bad_permissions()
	- not yet done

[akpm]: pfm_task_incompatible() task state in task_struct.exit_state, not task->state
	- not yet done

[akpm]: pfm_get_task() what is it doing exactly?
	- need to add comment

[akpm]: extra braces in pfm_get_task()
	- not yet done

[akpm]: pfm_check_task_exist()  braces, and expensive
	- not yet done

[akpm]: set_view locking
	- explained above

[akpm]: check locking for functions using smp_processor_id() (preemption)
	- need more investigation

On Tue, Sep 26, 2006 at 10:09:51PM -0700, Andrew Morton wrote:
> On Tue, 26 Sep 2006 07:34:20 -0700
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> 
> > I have released another version of the perfmon new code base package.
> > This version of the kernel patch is relative to 2.6.18. This longer
> > than usual delay between releases comes from the large amount of changes
> > than went into this new release following the feedback I got on LKML. As
> > a result, the code has improved.
> 
> Thanks for doing that.
> 
> Would it be possible to get an accounting of the disposition of the various
> review comments?  Of the "yes I did that" or "OK, but I'll do it later" or
> "no, you're an idiot" form?
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list

-- 

-Stephane
