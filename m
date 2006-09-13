Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWIMTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWIMTdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIMTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:33:55 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:35598 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S1751139AbWIMTdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:33:54 -0400
Date: Wed, 13 Sep 2006 14:33:49 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: odd cpu_khz behavior (doubling)
Message-ID: <20060913193349.GA21182@dbz.icequake.net>
Reply-To: nemesis@icequake.net
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


OK, I realize cpu_khz should not be constant.  I wrote a cpufreq driver
for Toshiba laptops that has two CPU speeds (1/2 and full) and that is
managed via SMM.  Can anyone tell me why cpu_khz occasionally doubles
itself while the driver is in use?  It starts at ~120000, then doubles
to ~240000, then to ~480000, etc.  However, this is over ~15 loads and
unloads of the cpufreq target driver.  Small cpu_khz variations would
not bother anything wrt the cpufreq driver, but this is just plain
incorrect for things like /proc/cpuinfo which also use cpu_khz.

Is this a TSC issue (maybe related to SMM) or am I just doing something
in the wrong place in the driver?

Attached is the cpufreq part of the code, just a testing version.

-- 
Ryan Underwood, <nemesis@icequake.net>

--ibTvN161/egqYuK8
Content-Type: text/x-csrc; charset=iso-8859-1
Content-Disposition: attachment; filename="toshiba_freq.c"

/*
 *	toshiba_freq.c: cpufreq driver for Toshiba SCI (non-Speedstep) laptops
 *
 *	Copyright (C) 2006 Ryan Underwood <nemesis@icequake.net>
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 *
 *	Based on sc520_freq.c
 *
 *	2006-09-11: - initial revision
 */

/* NOTE: currently this should drag in toshiba.ko which checks for the
 * appropriate hardware in its init function. Things will be different when
 * ACPI instead of the SMM driver is used as the SCI access method. */

/* XXX, error handling on all tosh_scihci calls!! And graceful exit! */
/* FIXME: Fan and LCD brightness are variable on some systems */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>

#include <linux/cpufreq.h>
#include <linux/toshiba.h>

#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, "toshiba_freq", msg)

static u32 original_cpustate;
static u32 original_cache;
static u32 original_brightness;
static u32 original_fan;

/* Store this locally to avoid a SMM round trip to obtain it */
static u32 current_cpustate;

static int control_cpucache = 1;
static int control_fan = 1;
static int control_lcd;

module_param_named(cpucache, control_cpucache, int, 1);
MODULE_PARM_DESC(fn, "Allow CPUFreq to enable/disable CPU cache");
module_param_named(fan, control_fan, int, 1);
MODULE_PARM_DESC(fn, "Allow CPUFreq to control the system fan");
module_param_named(lcd, control_lcd, int, 0);
MODULE_PARM_DESC(fn, "Allow CPUFreq to control LCD brightness");

/* Index corresponds to the SCI CPU speed state (0 or 1) */
static struct cpufreq_frequency_table toshiba_freq_table[] = {
	{0,	0},  /* slow (low) */
	{1,	0},  /* fast (high) */
	{0,	CPUFREQ_TABLE_END},
};

static unsigned int toshiba_freq_get_cpu_frequency(unsigned int cpu)
{
#if 0
	unsigned int val;
	tosh_scihci_get(0, SCI_PROCESSING, &val);
	return val;
#else
	return toshiba_freq_table[current_cpustate].frequency;
#endif
}

static void toshiba_freq_set_cpu_state (unsigned int state)
{
	struct cpufreq_freqs	freqs;

	freqs.old = toshiba_freq_get_cpu_frequency(0);
	freqs.new = toshiba_freq_table[state].frequency;
	freqs.cpu = 0;

	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

	dprintk("attempting to set frequency to %i kHz\n",
			toshiba_freq_table[state].frequency);

	if (state == 0) { /* slow */
		if (control_fan)
			tosh_scihci_set(HCI_SET, HCI_FAN, HCI_DISABLE);
		if (control_lcd)
			tosh_scihci_set(0, SCI_LCD_BRIGHTNESS, SCI_SEMI_BRIGHT);
		if (control_cpucache)
			tosh_scihci_set(0, SCI_CPU_CACHE, SCI_OFF);
		tosh_scihci_set(0, SCI_PROCESSING, SCI_LOW);
	}
	else { /* fast */
		if (control_fan)
			tosh_scihci_set(HCI_SET, HCI_FAN, HCI_ENABLE);
		if (control_lcd)
			tosh_scihci_set(0, SCI_LCD_BRIGHTNESS, SCI_BRIGHT);
		if (control_cpucache)
			tosh_scihci_set(0, SCI_CPU_CACHE, SCI_ON);
		tosh_scihci_set(0, SCI_PROCESSING, SCI_HIGH);
	}

	current_cpustate = toshiba_freq_table[state].index;

	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
};

static int toshiba_freq_verify (struct cpufreq_policy *policy)
{
	return cpufreq_frequency_table_verify(policy, &toshiba_freq_table[0]);
}

static int toshiba_freq_target (struct cpufreq_policy *policy,
			    unsigned int target_freq,
			    unsigned int relation)
{
	unsigned int newstate = 0;

	if (cpufreq_frequency_table_target(policy, toshiba_freq_table, target_freq, relation, &newstate))
		return -EINVAL;

	toshiba_freq_set_cpu_state(newstate);

	return 0;
}


/*
 *	Module init and exit code
 */

static int toshiba_freq_cpu_init(struct cpufreq_policy *policy)
{
	int result;

	/* Fill out the frequency table
	 * Toshiba SCI has two modes, "slow" and "fast" where "fast" is
	 * the nominal CPU speed, and "slow" is half speed */

	/* Prevent userspace from using /dev/toshiba to frob the CPU speed */
	tosh_cpufreq_in_control = 1;

	/* It would be nice if we could obtain the CPU nominal MHz rating from
	 * the firmware somehow.  Oh well.  We use cpu_khz instead since it is
	 * close enough for our needs. */

	/* FIXME why is cpu_khz doubling? */
	toshiba_freq_table[0].frequency = cpu_khz / 2;
	toshiba_freq_table[1].frequency = cpu_khz;

	/* cpuinfo and default policy values */
	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
	policy->cpuinfo.transition_latency = 5000000; /* 5ms, estimated max SMI/SMM latency */
	policy->cur = toshiba_freq_get_cpu_frequency(0);

	result = cpufreq_frequency_table_cpuinfo(policy, toshiba_freq_table);
	if (result)
		return (result);

	cpufreq_frequency_table_get_attr(toshiba_freq_table, policy->cpu);

	return 0;
}


static int toshiba_freq_cpu_exit(struct cpufreq_policy *policy)
{
	cpufreq_frequency_table_put_attr(policy->cpu);
	
	/* Restore the old configuration */
	if (control_fan)
		tosh_scihci_set(HCI_SET, HCI_FAN, original_fan);

	if (control_lcd)
		tosh_scihci_set(0, SCI_LCD_BRIGHTNESS, original_brightness);

	if (control_cpucache)
		tosh_scihci_set(0, SCI_CPU_CACHE, original_cache);

	tosh_scihci_set(0, SCI_PROCESSING, original_cpustate);

	/* Allow userspace to control CPU via SCI again */
	tosh_cpufreq_in_control = 0;

	return 0;
}


static struct freq_attr* toshiba_freq_attr[] = {
	&cpufreq_freq_attr_scaling_available_freqs,
	NULL,
};


static struct cpufreq_driver toshiba_freq_driver = {
	.get	= toshiba_freq_get_cpu_frequency,
	.verify	= toshiba_freq_verify,
	.target	= toshiba_freq_target,
	.init	= toshiba_freq_cpu_init,
	.exit	= toshiba_freq_cpu_exit,
	.name	= "toshiba_freq",
	.owner	= THIS_MODULE,
	.attr	= toshiba_freq_attr,
};

static int __init toshiba_freq_init(void)
{
	/* Note: At least some ACPI machines do not allow the SMM driver to
	 * modify the CPU frequency.  Here, we will read all the settings we
	 * are interested in and attempt to set their values, as a test that we
	 * are actually in control of the hardware. */

	char buf[100];

	/* CPU speed state */
	if (tosh_scihci_get(0, SCI_PROCESSING, &original_cpustate) ||
			tosh_scihci_set(0, SCI_PROCESSING, original_cpustate))
		return -ENODEV;

	sprintf(buf, "toshiba_freq.c: Managing CPU");

	/* CPU cache */
	if (control_cpucache) {
		if (tosh_scihci_get(0, SCI_CPU_CACHE, &original_cache) ||
				tosh_scihci_set(0, SCI_CPU_CACHE, original_cache))
			return -ENODEV;
		strcat(buf, ", L2 cache");
	}

	/* Fan */
	if (control_fan) {
		if (tosh_scihci_get(HCI_GET, HCI_FAN, &original_fan) ||
				tosh_scihci_set(HCI_SET, HCI_FAN, original_fan))
			return -ENODEV;
		strcat(buf, ", system fan");
	}

	/* Display brightness */
	if (control_lcd) {
		if (tosh_scihci_get(0, SCI_LCD_BRIGHTNESS, &original_brightness) ||
				tosh_scihci_set(0, SCI_LCD_BRIGHTNESS, original_brightness))
			return -ENODEV;
		strcat(buf, ", LCD");
	}

	printk("%s\n", buf);

	current_cpustate = original_cpustate;

	return cpufreq_register_driver(&toshiba_freq_driver);
}


static void __exit toshiba_freq_exit(void)
{
	cpufreq_unregister_driver(&toshiba_freq_driver);
}


MODULE_LICENSE("GPL");
MODULE_AUTHOR("Ryan Underwood <nemesis@icequake.net>");
MODULE_DESCRIPTION("cpufreq driver for Toshiba SCI (non-Speedstep) laptops");

module_init(toshiba_freq_init);
module_exit(toshiba_freq_exit);


--ibTvN161/egqYuK8--
