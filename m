Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265011AbUFGTRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265011AbUFGTRB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFGTRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:17:01 -0400
Received: from cptpc8.univ-mrs.fr ([139.124.7.122]:37133 "EHLO
	cptpc8.univ-mrs.fr") by vger.kernel.org with ESMTP id S265009AbUFGTOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:14:15 -0400
Message-ID: <40C4DACA.70001@cern.ch>
Date: Mon, 07 Jun 2004 21:14:50 +0000
From: Christian Hoelbling <christian.holbling@cern.ch>
Reply-To: Christian.Hoelbling@cpt.univ-mrs.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.5 speedstep on P4Ms
Content-Type: multipart/mixed;
 boundary="------------010809080502090400080307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809080502090400080307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  here is a small patch that should address the following issues for 
speedstep on P4M's

1.) detect all P4M's via the model_id string
2.) correctly register drivers on hyperthreading CPU's
3.) do P4-clockmod on top of speedstep on P4-Ms

 since this is my first attempt at kernel programming, it's probably an 
uglu hack. also there is a problem, that the powersave governor does not 
get the lowest frequency correctly. any suggestions/tips are very welcome.

chris

--------------010809080502090400080307
Content-Type: text/x-troff-man;
 name="patch-2.6.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.5"

diff --unified --recursive --new-file linux-2.6.5/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c linux-2.6.5.speedstep/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c
--- linux-2.6.5/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2004-06-07 20:49:36.000000000 +0000
+++ linux-2.6.5.speedstep/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2004-06-07 20:56:00.732209368 +0000
@@ -11,6 +11,9 @@
  *  for extensive testing.
  *
  *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
+ *
+ *  Added SMT and p4-clockmod support on P4-M's
+ *  Christian Hoelbling, 2004
  */
 
 
@@ -27,7 +30,6 @@
 
 #include "speedstep-lib.h"
 
-
 /* speedstep_chipset:
  *   It is necessary to know which chipset is used. As accesses to 
  * this device occur at various places in this module, we need a 
@@ -51,6 +53,44 @@
 	{0,			CPUFREQ_TABLE_END},
 };
 
+/*
+ * Duty Cycle (3bits) from p4-clockmod
+ * for each of the voltages
+ */
+enum {
+        DC_RESV, LO_DC_DFLT, LO_DC_25PT, LO_DC_38PT, LO_DC_50PT,
+	LO_DC_64PT, LO_DC_75PT, LO_DC_88PT, LO_DC_DISABLE,
+        HI_DC_DFLT, HI_DC_25PT, HI_DC_38PT, HI_DC_50PT,
+	HI_DC_64PT, HI_DC_75PT, HI_DC_88PT, HI_DC_DISABLE
+};
+
+/* 
+ * Extended speedstep + p4-clockmod table
+ * for P4-M's
+ * Values are in kHz for the time being.
+ */
+static struct cpufreq_frequency_table speedstep_p4_freqs[] = {
+	{DC_RESV, CPUFREQ_ENTRY_INVALID},
+	{LO_DC_DFLT, 0},
+	{LO_DC_25PT, 0},
+	{LO_DC_38PT, 0},
+	{LO_DC_50PT, 0},
+	{LO_DC_64PT, 0},
+	{LO_DC_75PT, 0},
+	{LO_DC_88PT, 0},
+	{LO_DC_DISABLE, 0},
+	{HI_DC_DFLT, 0},
+	{HI_DC_25PT, 0},
+	{HI_DC_38PT, 0},
+	{HI_DC_50PT, 0},
+	{HI_DC_64PT, 0},
+	{HI_DC_75PT, 0},
+	{HI_DC_88PT, 0},
+	{HI_DC_DISABLE, 0},
+	{DC_RESV, CPUFREQ_TABLE_END},
+};
+
+static unsigned int stock_freq[2];
 
 /* DEBUG
  *   Define it if you want verbose debug output, e.g. for bug reporting
@@ -63,7 +103,6 @@
 #define dprintk(msg...) do { } while(0)
 #endif
 
-
 /**
  * speedstep_set_state - set the SpeedStep state
  * @state: new processor frequency state (SPEEDSTEP_LOW or SPEEDSTEP_HIGH)
@@ -148,6 +187,251 @@
 	return;
 }
 
+/* This sets P4M's clockmod and speedstep settings.
+ * Note: clockmod only works reliably in the high speedstep
+ *       state. Therefore, the routine always switches to the
+ *       high speedstep state to do the clockmod, even if going
+ *       from one low voltage frequency to another.
+ */
+static int speedstep_p4_set_state(unsigned int cpu, unsigned int newstate, unsigned int notify)
+{
+	u32 l, h, pmbase;
+	u8 pm2_blk, value;
+	cpumask_t cpus_allowed, affected_cpu_map;
+	unsigned long flags;
+	struct cpufreq_freqs freqs;
+	int hyperthreading = 0;
+	int sibling = 0;
+	unsigned int dc_newstate,speedstep_newstate,oldstate,dc_oldstate,speedstep_oldstate;
+	unsigned int speedstep_trans,dc_trans;
+
+	if (!cpu_online(cpu) || (newstate > HI_DC_DISABLE) || 
+		(newstate == DC_RESV))
+		return -EINVAL;
+
+	/* disentangle speedstep and clockmod */
+	dc_newstate=((newstate-1) & 0x07)+1;
+	speedstep_newstate=(newstate>LO_DC_DISABLE);
+
+	/* switch to physical CPU where state is to be changed*/
+	cpus_allowed = current->cpus_allowed;
+
+	/* only run on CPU to be set, or on its sibling */
+       affected_cpu_map = cpumask_of_cpu(cpu);
+#ifdef CONFIG_X86_HT
+	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
+	if (hyperthreading) {
+		sibling = cpu_sibling_map[cpu];
+                cpu_set(sibling, affected_cpu_map);
+	}
+#endif
+	set_cpus_allowed(current, affected_cpu_map);
+        BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
+
+	/* get current clockmod state */
+	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+	if (l & 0x10) {
+		dc_oldstate = l >> 1;
+		dc_oldstate &= 0x7;
+	} else
+	        dc_oldstate = 0x08; /* dc disabled */
+
+	if (dc_oldstate == DC_RESV) {
+	        printk(KERN_ERR "cpufreq: BIG FAT WARNING: currently in invalid setting\n");
+	}
+	dc_trans=(dc_oldstate != dc_newstate);
+
+	/* get currect speedstep state */
+	speedstep_oldstate=(speedstep_get_processor_frequency(speedstep_processor)==speedstep_p4_freqs[HI_DC_DISABLE].frequency);
+	speedstep_trans=(speedstep_oldstate != speedstep_newstate);
+	oldstate  = ((dc_oldstate-1) + (speedstep_oldstate << 3)) + 1;
+
+	if (notify) {
+	        freqs.old = speedstep_p4_freqs[oldstate].frequency; /* relies on indices for all allowed states in frequency table being in sequential order starting from 1 */
+		freqs.cpu = cpu;
+		dprintk(KERN_DEBUG "cpufreq: os: 0x%x ns: 0x%x ssos: 0x%x ssns: 0x%x dcos: 0x%x dcns: 0x%x\n", oldstate,newstate,speedstep_oldstate,speedstep_newstate,dc_oldstate,dc_newstate);
+
+		/* notifiers */
+		freqs.new = speedstep_p4_freqs[newstate].frequency; /* relies on indices for all allowed states in frequency table being in sequential order starting from 1 */
+		dprintk(KERN_DEBUG "cpufreq: preparing transition on cpu %i from %i kHz to %ikHz \n",cpu ,freqs.old ,freqs.new);
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		if (hyperthreading) {
+		        freqs.cpu = sibling;
+			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		}
+	}
+
+	/* set speedstep to upper state if needed */
+	if ((speedstep_trans && (speedstep_newstate==0x1)) || 
+	    (dc_trans && (speedstep_oldstate==0x0))){
+
+	        /* get PMBASE */
+	        pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
+		if (!(pmbase & 0x01)) {
+		        printk(KERN_ERR "cpufreq: could not find speedstep register\n");
+			return 0;
+		}
+		
+		pmbase &= 0xFFFFFFFE;
+		if (!pmbase) {
+		       printk(KERN_ERR "cpufreq: could not find speedstep register\n");
+		       return 0;
+		}
+		
+		/* Disable IRQs */
+		local_irq_save(flags);
+
+		/* read state */
+		value = inb(pmbase + 0x50);
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
+
+		/* write new state */
+		value &= 0xFE;
+		
+		dprintk(KERN_DEBUG "cpufreq: writing 0x%x to pmbase 0x%x + 0x50\n", value, pmbase);
+
+		/* Disable bus master arbitration */
+		pm2_blk = inb(pmbase + 0x20);
+		pm2_blk |= 0x01;
+		outb(pm2_blk, (pmbase + 0x20));
+
+		/* Actual transition */
+		outb(value, (pmbase + 0x50));
+		
+		/* Restore bus master arbitration */
+		pm2_blk &= 0xfe;
+		outb(pm2_blk, (pmbase + 0x20));
+
+		/* check if transition was successful */
+		value = inb(pmbase + 0x50);
+
+		/* Enable IRQs */
+		local_irq_restore(flags);
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
+
+		if (~(value & 0x1)) {
+		        dprintk (KERN_INFO "cpufreq: change to %u kHz speedstep state succeeded\n", (speedstep_get_processor_frequency(speedstep_processor)));
+		} else {
+		        printk (KERN_ERR "cpufreq: change failed - I/O error\n");
+		}
+	}
+	
+	
+	/* clockmod transition */
+	if (dc_trans) {
+	        rdmsr(MSR_IA32_THERM_STATUS, l, h);
+#if 0
+		if (l & 0x01)
+		        dprintk(KERN_DEBUG "cpufreq: CPU#%d currently thermal throttled\n", cpu);
+#endif
+		rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+		if (dc_newstate == 0x08) {
+		        dprintk(KERN_INFO "cpufreq: CPU#%d disabling modulation\n", cpu); 
+		        dprintk(KERN_INFO "cpufreq: CPU#%d writing 0x%x to control reg.\n", cpu, (l | 0x0e)& ~(1<<4)); 
+			wrmsr(MSR_IA32_THERM_CONTROL, (l | 0x0e) & ~(1<<4), h);
+		} else {
+      		        dprintk(KERN_INFO "cpufreq: CPU#%d setting duty cycle to %d%%\n",
+		        cpu, ((125 * dc_newstate) / 10)); 
+	              /* bits 63 - 5	: reserved 
+		       * bit  4	: enable/disable
+		       * bits 3-1	: duty cycle
+		       * bit  0	: reserved
+		       */
+			l = (l & ~14);
+			l = l | (1<<4) | ((dc_newstate & 0x7)<<1);
+		        dprintk(KERN_INFO "cpufreq: CPU#%d writing 0x%x to control reg.\n", cpu, l); 
+			wrmsr(MSR_IA32_THERM_CONTROL, l, h);
+		}
+
+        /* get current clockmod state */
+	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+	dprintk(KERN_INFO "cpufreq: CPU#%d read 0x%x from control reg.\n", cpu, l); 
+	if (l & 0x10) {
+		l = l >> 1;
+		l &= 0x7;
+	} else
+	        l = 0x08; /* dc disabled */
+	dprintk(KERN_DEBUG "cpufreq: new dc state: 0x%x\n", l);
+
+
+
+	}
+
+	/* do speedstep to lower state transition if necessary*/
+	if ((speedstep_newstate==0x0) && (speedstep_trans || dc_trans)) {
+
+	        /* get PMBASE */
+	        pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
+		if (!(pmbase & 0x01)) {
+		        printk(KERN_ERR "cpufreq: could not find speedstep register\n");
+			return 0;
+		}
+		
+		pmbase &= 0xFFFFFFFE;
+		if (!pmbase) {
+		       printk(KERN_ERR "cpufreq: could not find speedstep register\n");
+		       return 0;
+		}
+		
+		/* Disable IRQs */
+		local_irq_save(flags);
+
+		/* read state */
+		value = inb(pmbase + 0x50);
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
+
+		/* write new state */
+		value &= 0xFE;
+		value |= 0x1;
+		
+		dprintk(KERN_DEBUG "cpufreq: writing 0x%x to pmbase 0x%x + 0x50\n", value, pmbase);
+
+		/* Disable bus master arbitration */
+		pm2_blk = inb(pmbase + 0x20);
+		pm2_blk |= 0x01;
+		outb(pm2_blk, (pmbase + 0x20));
+
+		/* Actual transition */
+		outb(value, (pmbase + 0x50));
+		
+		/* Restore bus master arbitration */
+		pm2_blk &= 0xfe;
+		outb(pm2_blk, (pmbase + 0x20));
+
+		/* check if transition was successful */
+		value = inb(pmbase + 0x50);
+
+		/* Enable IRQs */
+		local_irq_restore(flags);
+
+		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
+
+		if (value & 0x1) {
+		        dprintk (KERN_INFO "cpufreq: change to %u kHz speedstep state succeeded\n", (speedstep_get_processor_frequency(speedstep_processor)));
+		} else {
+		        printk (KERN_ERR "cpufreq: change failed - I/O error\n");
+		}
+	}
+
+	set_cpus_allowed(current, cpus_allowed);
+
+	if (notify) {
+	        /* notifiers */
+	        cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	        if (hyperthreading) {
+		        freqs.cpu = cpu;
+			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		}
+		dprintk(KERN_DEBUG "cpufreq: transition on cpu %i from %i kHz to %ikHz completed\n",cpu ,freqs.old ,freqs.new);
+		
+	}
+
+	return 0;
+}
+
 
 /**
  * speedstep_activate - activate SpeedStep control in the chipset
@@ -164,6 +448,7 @@
 
 	pci_read_config_word(speedstep_chipset_dev, 
 			     0x00A0, &value);
+	dprintk(KERN_DEBUG "cpufreq: speedstep registers: 0x%x \n",value);
 	if (!(value & 0x08)) {
 		value |= 0x08;
 		dprintk(KERN_DEBUG "cpufreq: activating SpeedStep (TM) registers\n");
@@ -258,6 +543,20 @@
 	return 0;
 }
 
+static int speedstep_p4_target (struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	unsigned int	newstate = DC_RESV;
+
+	if (cpufreq_frequency_table_target(policy, &speedstep_p4_freqs[0], target_freq, relation, &newstate))
+		return -EINVAL;
+
+	speedstep_p4_set_state(policy->cpu, speedstep_p4_freqs[newstate].index, 1);
+
+	return 0;
+}
+
 
 /**
  * speedstep_verify - verifies a new CPUFreq policy
@@ -271,6 +570,11 @@
 	return cpufreq_frequency_table_verify(policy, &speedstep_freqs[0]);
 }
 
+static int speedstep_p4_verify (struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, &speedstep_p4_freqs[0]);
+}
+
 
 static int speedstep_cpu_init(struct cpufreq_policy *policy)
 {
@@ -281,10 +585,10 @@
 	if (policy->cpu != 0)
 		return -ENODEV;
 
-	/* detect low and high frequency */
+	/* detect speedstep base frequencies */
 	result = speedstep_get_freqs(speedstep_processor,
-				     &speedstep_freqs[SPEEDSTEP_LOW].frequency,
-				     &speedstep_freqs[SPEEDSTEP_HIGH].frequency,
+				     &speedstep_p4_freqs[LO_DC_DISABLE].frequency,
+				     &speedstep_p4_freqs[HI_DC_DISABLE].frequency,
 				     &speedstep_set_state);
 	if (result)
 		return result;
@@ -312,6 +616,57 @@
 	return 0;
 }
 
+static int speedstep_P4_cpu_init(struct cpufreq_policy *policy)
+{
+	int		result = 0;
+	unsigned int    i,max,min,max_to_min_ratio,idx_lo;
+
+	/* detect low and high frequency */
+	result=speedstep_p4_set_state(policy->cpu, speedstep_p4_freqs[LO_DC_DISABLE].index, 0);
+	stock_freq[0]=speedstep_get_processor_frequency(speedstep_processor);
+	if (result)
+		return result;
+	result=speedstep_p4_set_state(policy->cpu, speedstep_p4_freqs[HI_DC_DISABLE].index, 0);
+	stock_freq[1]=speedstep_get_processor_frequency(speedstep_processor);
+	if (result)
+	        return result;
+
+	speedstep_p4_freqs[LO_DC_DISABLE].frequency=stock_freq[0];
+	speedstep_p4_freqs[HI_DC_DISABLE].frequency=stock_freq[1];
+
+	/* init low and high clockmod tables */
+	for (i=1; i<8; i++) {
+	        speedstep_p4_freqs[i].frequency = (speedstep_p4_freqs[LO_DC_DISABLE].frequency * i)/8;
+	        speedstep_p4_freqs[8+i].frequency = (speedstep_p4_freqs[HI_DC_DISABLE].frequency * i)/8;
+	}
+
+	/* check, if there are frequencies which are possible in both voltage states */
+	max=stock_freq[1];
+	min=stock_freq[0]/8;
+	max_to_min_ratio=max/min;
+	if ((min*max_to_min_ratio)==max) {
+	       dprintk(KERN_INFO "cpufreq: non-unique frequencies may appear\n");
+	       /* if yes, add 1 to higher voltage frequency - ugly but effective */
+	       for (i=1; i<9; i++) {
+		       idx_lo=(max*i)/(8*min);
+		       if ((idx_lo<=8) && (speedstep_p4_freqs[idx_lo].frequency == speedstep_p4_freqs[8+i].frequency)) 
+		               speedstep_p4_freqs[8+i].frequency++;
+	       }
+	}
+
+
+	dprintk(KERN_INFO "cpufreq: detected mobile P4 currently at %i MHz\n", 
+		(stock_freq[1] / 1000));
+
+        cpufreq_frequency_table_get_attr(speedstep_p4_freqs, policy->cpu);
+
+	/* cpuinfo and default policy values */
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL*2+1000000; /* assumed */
+	policy->cur = stock_freq[1];
+
+	return cpufreq_frequency_table_cpuinfo(policy, &speedstep_p4_freqs[0]);
+}
 
 static int speedstep_cpu_exit(struct cpufreq_policy *policy)
 {
@@ -336,6 +691,16 @@
 	.attr		= speedstep_attr,
 };
 
+static struct cpufreq_driver speedstep_P4_driver = {
+	.name		= "speedstep-ich",
+	.verify 	= speedstep_p4_verify,
+	.target 	= speedstep_p4_target,
+	.init		= speedstep_P4_cpu_init,
+	.exit		= speedstep_cpu_exit,    /* same as speedstep only */
+	.owner		= THIS_MODULE,
+	.attr		= speedstep_attr,        /* dummy - use same as speedstep only */
+};
+
 
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
@@ -361,7 +726,10 @@
 	if (speedstep_activate())
 		return -EINVAL;
 
-	return cpufreq_register_driver(&speedstep_driver);
+	if (speedstep_processor==SPEEDSTEP_PROCESSOR_P4M)
+	        return cpufreq_register_driver(&speedstep_P4_driver);
+	else
+	        return cpufreq_register_driver(&speedstep_driver);
 }
 
 
@@ -372,11 +740,14 @@
  */
 static void __exit speedstep_exit(void)
 {
-	cpufreq_unregister_driver(&speedstep_driver);
+	if (speedstep_processor==SPEEDSTEP_PROCESSOR_P4M)
+	        cpufreq_unregister_driver(&speedstep_P4_driver);
+	else
+	        cpufreq_unregister_driver(&speedstep_driver);
 }
 
 
-MODULE_AUTHOR ("Dave Jones <davej@codemonkey.org.uk>, Dominik Brodowski <linux@brodo.de>");
+MODULE_AUTHOR ("Dave Jones <davej@codemonkey.org.uk>, Dominik Brodowski <linux@brodo.de>, Christian Hoelbling <christian.holbling@cern.ch>");
 MODULE_DESCRIPTION ("Speedstep driver for Intel mobile processors on chipsets with ICH-M southbridges.");
 MODULE_LICENSE ("GPL");
 
diff --unified --recursive --new-file linux-2.6.5/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c linux-2.6.5.speedstep/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c
--- linux-2.6.5/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c	2004-06-07 20:49:36.000000000 +0000
+++ linux-2.6.5.speedstep/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c	2004-06-07 20:56:00.732209368 +0000
@@ -210,8 +210,17 @@
 		ebx = cpuid_ebx(0x00000001);
 		ebx &= 0x000000FF;
 
-		dprintk(KERN_INFO "ebx value is %x, x86_mask is %x\n", ebx, c->86_mask);
+		dprintk(KERN_INFO "ebx value is %x\n", ebx);
 
+		dprintk(KERN_INFO "model_id is %s\n", c->x86_model_id);
+		
+		/*
+		 * If the x86_model_id string contais "Mobile Intel(R) Pentium(R) 4"
+                 * omit all other checks and treat the CPU as a M-P4-M
+		 */
+		if (strstr(c->x86_model_id,"Mobile Intel(R) Pentium(R) 4") != NULL)
+		       return SPEEDSTEP_PROCESSOR_P4M;
+		
 		switch (c->x86_mask) {
 		case 4: 
 			/*
@@ -248,10 +257,11 @@
 			 * So, how to distinguish all those processors with
 			 * ebx=0xf? I don't know. Sort them out, and wait
 			 * for someone to complain.
+			 * also, M-P4M HTs actually have ebx=0x8, too
 			 */
-			if (ebx == 0x0e)
-				return SPEEDSTEP_PROCESSOR_P4M;
-			break;
+		         if (ebx == 0x0e)
+		                return SPEEDSTEP_PROCESSOR_P4M;
+			 break;
 		default:
 			break;
 		}

--------------010809080502090400080307--
