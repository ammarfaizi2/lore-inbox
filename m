Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbSI2Tw5>; Sun, 29 Sep 2002 15:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbSI2Tw5>; Sun, 29 Sep 2002 15:52:57 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:21266 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S261765AbSI2TvZ>; Sun, 29 Sep 2002 15:51:25 -0400
Date: Sun, 29 Sep 2002 15:56:48 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Dominik Brodowski <linux@brodo.de>
Cc: Gerald Britton <gbritton@alum.mit.edu>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929155648.A20308@light-brigade.mit.edu>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020928134739.A11797@light-brigade.mit.edu> <20020929111603.F1250@brodo.de> <20020929121018.A811@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020929121018.A811@brodo.de>; from linux@brodo.de on Sun, Sep 29, 2002 at 12:10:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 12:10:18PM +0200, Dominik Brodowski wrote:
> I think I found the problem: it should be GFP_ATOMIC and not GFP_KERNEL in
> the allocation of struct cpufreq_driver. Will be fixed in the next release.

Nope.  That should be fine, it's in a process context and not holding any
locks, so GFP_KERNEL should be fine.  I found the bug though:
 
-driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
+driver->policy = (struct cpufreq_policy *) (driver + 1);
 
Remember your pointer arithmetic.
 
I was also thinking about the quirkyness with the init process and safety with
other code.  I'm currently running with a modified version adding a "notify"
argument to speedstep_set_state() so that notifiers which is 0 during init so
that the notifiers do not get run.  We're going to be flapping the speed here
without notifying anything, so i disabled interrupts for the entire detection
process.  It appears to be working reasonably well.  Patch below (also includes
some cleaned up irq locking and the timer.c fix).

Also, the notifier in timer.c is wrong.  it updates the per-cpu loops_per_jiffy
with the global loops_per_jiffy value (which may have already been scaled).

Also.. these adjusted values have rounding errors...

cpu MHz		: 1132.403
cpu MHz		: 732.731
cpu MHz		: 1132.402
cpu MHz		: 732.730
cpu MHz		: 1132.400
cpu MHz		: 732.729
cpu MHz		: 1132.399

There probably isn't a lot that can be done about these unfortunately, but
they won't necessarily converge to a stable value so things may eventually
start to fail.

				-- Gerald

--- linux/arch/i386/kernel/speedstep.c.old	Thu Sep 26 18:35:29 2002
+++ linux/arch/i386/kernel/speedstep.c	Sun Sep 29 15:21:33 2002
@@ -91,6 +91,7 @@
  */
 static int speedstep_get_state (unsigned int *state)
 {
+	unsigned long   flags;
 	u32             pmbase;
 	u8              value;
 
@@ -110,9 +111,9 @@
 			return -EIO;
 
 		/* read state */
-		local_irq_disable();
+		local_irq_save(flags);
 		value = inb(pmbase + 0x50);
-		local_irq_enable();
+		local_irq_restore(flags);
 
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
@@ -132,7 +133,7 @@
  *
  *   Tries to change the SpeedStep state. 
  */
-static void speedstep_set_state (unsigned int state)
+static void speedstep_set_state (unsigned int state, int notify)
 {
 	u32                     pmbase;
 	u8	                pm2_blk;
@@ -154,7 +155,8 @@
 	freqs.new = (state == SPEEDSTEP_HIGH) ? speedstep_high_freq : speedstep_low_freq;
 	freqs.cpu = CPUFREQ_ALL_CPUS; /* speedstep.c is UP only driver */
 	
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	if (notify)
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
@@ -173,10 +175,11 @@
 			return;
 		}
 
+		/* Disable IRQs */
+		local_irq_save(flags);
+
 		/* read state */
-		local_irq_disable();
 		value = inb(pmbase + 0x50);
-		local_irq_enable();
 
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
@@ -186,10 +189,6 @@
 
 		dprintk(KERN_DEBUG "cpufreq: writing 0x%x to pmbase 0x%x + 0x50\n", value, pmbase);
 
-		/* Disable IRQs */
-		local_irq_save(flags);
-		local_irq_disable();
-
 		/* Disable bus master arbitration */
 		pm2_blk = inb(pmbase + 0x20);
 		pm2_blk |= 0x01;
@@ -202,14 +201,11 @@
 		pm2_blk &= 0xfe;
 		outb(pm2_blk, (pmbase + 0x20));
 
-		/* Enable IRQs */
-		local_irq_enable();
-		local_irq_restore(flags);
-
 		/* check if transition was sucessful */
-		local_irq_disable();
 		value = inb(pmbase + 0x50);
-		local_irq_enable();
+
+		/* Enable IRQs */
+		local_irq_restore(flags);
 
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
@@ -223,7 +219,8 @@
 		printk (KERN_ERR "cpufreq: setting CPU frequency on this chipset unsupported.\n");
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	if (notify)
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return;
 }
@@ -291,7 +288,6 @@
 	if (speedstep_chipset_dev)
 		return SPEEDSTEP_CHIPSET_ICH2M;
 
-
 	return 0;
 }
 
@@ -503,9 +499,13 @@
  */
 static int speedstep_detect_speeds (void)
 {
+	unsigned long   flags;
 	unsigned int    state;
 	int             i, result;
-    
+
+	/* Disable irqs for entire detection process */
+	local_irq_save(flags);
+
 	for (i=0; i<2; i++) {
 		/* read the current state */
 		result = speedstep_get_state(&state);
@@ -522,7 +522,7 @@
 			case SPEEDSTEP_PROCESSOR_P4M:
 				speedstep_low_freq = pentium4_get_frequency();
 			}
-			speedstep_set_state(SPEEDSTEP_HIGH);
+			speedstep_set_state(SPEEDSTEP_HIGH, 0);
 		} else {
 			switch (speedstep_processor) {
 			case SPEEDSTEP_PROCESSOR_PIII_C:
@@ -532,14 +532,16 @@
 			case SPEEDSTEP_PROCESSOR_P4M:
 				speedstep_high_freq = pentium4_get_frequency();
 			}
-			speedstep_set_state(SPEEDSTEP_LOW);
+			speedstep_set_state(SPEEDSTEP_LOW, 0);
 		}
-
-		if (!speedstep_low_freq || !speedstep_high_freq || 
-		    (speedstep_low_freq == speedstep_high_freq))
-			return -EIO;
 	}
 
+	local_irq_restore(flags);
+
+	if (!speedstep_low_freq || !speedstep_high_freq || 
+	    (speedstep_low_freq == speedstep_high_freq))
+		return -EIO;
+
 	return 0;
 }
 
@@ -556,16 +558,16 @@
 		return;
 
 	if (policy->min > speedstep_low_freq) 
-		speedstep_set_state(SPEEDSTEP_HIGH);
+		speedstep_set_state(SPEEDSTEP_HIGH, 1);
 	else {
 		if (policy->max < speedstep_high_freq)
-			speedstep_set_state(SPEEDSTEP_LOW);
+			speedstep_set_state(SPEEDSTEP_LOW, 1);
 		else {
 			/* both frequency states are allowed */
 			if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-				speedstep_set_state(SPEEDSTEP_LOW);
+				speedstep_set_state(SPEEDSTEP_LOW, 1);
 			else
-				speedstep_set_state(SPEEDSTEP_HIGH);
+				speedstep_set_state(SPEEDSTEP_HIGH, 1);
 		}
 	}
 }
@@ -653,8 +655,8 @@
 	if (!driver)
 		return -ENOMEM;
 
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
-	
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	driver->cpu_min_freq    = speedstep_low_freq;
 	driver->cpu_cur_freq[0] = speed;
--- linux/arch/i386/kernel/time.c.old	Thu Sep 26 18:35:01 2002
+++ linux/arch/i386/kernel/time.c	Sun Sep 29 15:10:10 2002
@@ -659,7 +659,7 @@
 		}
 		for (i=0; i<NR_CPUS; i++)
 			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(loops_per_jiffy, freq->old, freq->new);
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
 		break;
 
 	case CPUFREQ_POSTCHANGE:
@@ -670,7 +670,7 @@
 		}
 		for (i=0; i<NR_CPUS; i++)
 			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(loops_per_jiffy, freq->old, freq->new);
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
 		break;
 	}
 
