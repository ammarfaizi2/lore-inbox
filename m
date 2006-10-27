Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946411AbWJ0LSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946411AbWJ0LSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946410AbWJ0LSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:18:13 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:18892 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946408AbWJ0LSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:18:12 -0400
Date: Fri, 27 Oct 2006 13:18:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061027111809.GD27468@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/appldata/appldata_base.c |    1 +
 arch/s390/kernel/compat_linux.c    |    4 +++-
 arch/s390/kernel/compat_signal.c   |   12 ++++++------
 arch/s390/kernel/compat_wrapper.S  |    2 +-
 arch/s390/kernel/signal.c          |   12 ++++++------
 arch/s390/kernel/traps.c           |   20 +++++++++++++-------
 drivers/s390/cio/css.c             |    7 +++----
 drivers/s390/cio/device.c          |    3 +--
 drivers/s390/cio/device.h          |    1 -
 drivers/s390/crypto/ap_bus.c       |    7 ++++++-
 10 files changed, 40 insertions(+), 29 deletions(-)

Cornelia Huck:
      [S390] cio: css_probe_device() must be called enabled.
      [S390] cio: Make ccw_device_register() static.

Gerald Schaefer:
      [S390] Initialize interval value to 0.

Heiko Carstens:
      [S390] uaccess error handling.

Paul Mundt:
      [S390] sys_getcpu compat wrapper.

Ralph Wuerthner:
      [S390] Improve AP bus device removal.

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 45c9fa7..af1e8fc 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -310,6 +310,7 @@ appldata_interval_handler(ctl_table *ctl
 	if (copy_from_user(buf, buffer, len > sizeof(buf) ? sizeof(buf) : len)) {
 		return -EFAULT;
 	}
+	interval = 0;
 	sscanf(buf, "%i", &interval);
 	if (interval <= 0) {
 		P_ERROR("Timer CPU interval has to be > 0!\n");
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 2001767..5b33f82 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -757,7 +757,9 @@ asmlinkage long sys32_sysctl(struct __sy
 			    put_user(oldlen, (u32 __user *)compat_ptr(tmp.oldlenp)))
 				error = -EFAULT;
 		}
-		copy_to_user(args->__unused, tmp.__unused, sizeof(tmp.__unused));
+		if (copy_to_user(args->__unused, tmp.__unused,
+				 sizeof(tmp.__unused)))
+			error = -EFAULT;
 	}
 	return error;
 }
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index d49b876..861888a 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -169,12 +169,12 @@ sys32_sigaction(int sig, const struct ol
 		compat_old_sigset_t mask;
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(sa_handler, &act->sa_handler) ||
-		    __get_user(sa_restorer, &act->sa_restorer))
+		    __get_user(sa_restorer, &act->sa_restorer) ||
+		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
+		    __get_user(mask, &act->sa_mask))
 			return -EFAULT;
 		new_ka.sa.sa_handler = (__sighandler_t) sa_handler;
 		new_ka.sa.sa_restorer = (void (*)(void)) sa_restorer;
-		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
-		__get_user(mask, &act->sa_mask);
 		siginitset(&new_ka.sa.sa_mask, mask);
         }
 
@@ -185,10 +185,10 @@ sys32_sigaction(int sig, const struct ol
 		sa_restorer = (unsigned long) old_ka.sa.sa_restorer;
 		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(sa_handler, &oact->sa_handler) ||
-		    __put_user(sa_restorer, &oact->sa_restorer))
+		    __put_user(sa_restorer, &oact->sa_restorer) ||
+		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
+		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
 			return -EFAULT;
-		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
-		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
         }
 
 	return ret;
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index cb0efae..71e54ef 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1664,4 +1664,4 @@ sys_getcpu_wrapper:
 	llgtr	%r2,%r2			# unsigned *
 	llgtr	%r3,%r3			# unsigned *
 	llgtr	%r4,%r4			# struct getcpu_cache *
-	jg	sys_tee
+	jg	sys_getcpu
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 4392a77..4c8a795 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -80,10 +80,10 @@ sys_sigaction(int sig, const struct old_
 		old_sigset_t mask;
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
-		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
+		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
+		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
+		    __get_user(mask, &act->sa_mask))
 			return -EFAULT;
-		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
-		__get_user(mask, &act->sa_mask);
 		siginitset(&new_ka.sa.sa_mask, mask);
 	}
 
@@ -92,10 +92,10 @@ sys_sigaction(int sig, const struct old_
 	if (!ret && oact) {
 		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
-		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
+		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
+		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
+		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
 			return -EFAULT;
-		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
-		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
 	}
 
 	return ret;
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 66375a5..92ecffb 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -462,7 +462,8 @@ asmlinkage void illegal_op(struct pt_reg
 		local_irq_enable();
 
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
-		get_user(*((__u16 *) opcode), (__u16 __user *) location);
+		if (get_user(*((__u16 *) opcode), (__u16 __user *) location))
+			return;
 		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
 			if (current->ptrace & PT_PTRACED)
 				force_sig(SIGTRAP, current);
@@ -470,20 +471,25 @@ asmlinkage void illegal_op(struct pt_reg
 				signal = SIGILL;
 #ifdef CONFIG_MATHEMU
 		} else if (opcode[0] == 0xb3) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_b3(opcode, regs);
                 } else if (opcode[0] == 0xed) {
-			get_user(*((__u32 *) (opcode+2)),
-				 (__u32 __user *)(location+1));
+			if (get_user(*((__u32 *) (opcode+2)),
+				     (__u32 __user *)(location+1)))
+				return;
 			signal = math_emu_ed(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb299) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_srnm(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb29c) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_stfpc(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb29d) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_lfpc(opcode, regs);
 #endif
 		} else
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index a2dee5b..ad7f7e1 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -271,10 +271,6 @@ static int css_evaluate_known_subchannel
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
 		cio_modify(sch);
-
-		/* Probe if necessary. */
-		if (action == UNREGISTER_PROBE)
-			ret = css_probe_device(sch->schid);
 		break;
 	case REPROBE:
 		device_trigger_reprobe(sch);
@@ -283,6 +279,9 @@ static int css_evaluate_known_subchannel
 		break;
 	}
 	spin_unlock_irqrestore(&sch->lock, flags);
+	/* Probe if necessary. */
+	if (action == UNREGISTER_PROBE)
+		ret = css_probe_device(sch->schid);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 94bdd4d..39c98f9 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -532,8 +532,7 @@ device_remove_files(struct device *dev)
 
 /* this is a simple abstraction for device_register that sets the
  * correct bus type and adds the bus specific files */
-int
-ccw_device_register(struct ccw_device *cdev)
+static int ccw_device_register(struct ccw_device *cdev)
 {
 	struct device *dev = &cdev->dev;
 	int ret;
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index c6140cc..9233b5c 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -78,7 +78,6 @@ void io_subchannel_recog_done(struct ccw
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);
 
-int ccw_device_register(struct ccw_device *);
 void ccw_device_do_unreg_rereg(void *);
 void ccw_device_call_sch_unregister(void *);
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index c5ccd20..79d89c3 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -739,11 +739,16 @@ static void ap_scan_bus(void *data)
 		dev = bus_find_device(&ap_bus_type, NULL,
 				      (void *)(unsigned long)qid,
 				      __ap_scan_bus);
+		rc = ap_query_queue(qid, &queue_depth, &device_type);
+		if (dev && rc) {
+			put_device(dev);
+			device_unregister(dev);
+			continue;
+		}
 		if (dev) {
 			put_device(dev);
 			continue;
 		}
-		rc = ap_query_queue(qid, &queue_depth, &device_type);
 		if (rc)
 			continue;
 		rc = ap_init_queue(qid);
