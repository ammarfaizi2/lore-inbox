Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbTHVOok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTHVOok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:44:40 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:20442 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263450AbTHVOoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:44:30 -0400
Date: Fri, 22 Aug 2003 15:43:40 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
       aj@suse.de
Subject: Re: Cpufreq for opteron
Message-ID: <20030822144340.GE3111@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
	aj@suse.de
References: <20030822135946.GA2194@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822135946.GA2194@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 03:59:46PM +0200, Pavel Machek wrote:

 > + *
 > + *  Based on the powernow-k7.c module written by Dave Jones.
 > + *  (C) 2003 Dave Jones <davej@suse.de>

Please change this to
"(C) 2003 Dave Jones <davej@codemonkey.org.uk> on behalf of SuSE Labs."
Whilst that email address is dead, it was SuSE who sponsered me to do
that work, so they should retain some credit.

 > +#include <linux/cpufreq.h>
 > +#include <linux/slab.h>
 > +#include <linux/string.h>
 > +#include <linux/cpufreq.h>

cpufreq.h included twice.
 
 > +#undef DEBUG
 > +#undef TRACE
 > +
 > +#define PFX "amd64-cpuf: "

Precedent on other cpufreq modules has been to use module name as PFX.
(Ie, "powernow-k8:")

 > +#define VERSION "version 1.00.06 - August 13, 2003"

minor nit: pre-driver VERSION strings go stale quickly once merged to the
kernel and people start adding small changes bypassing maintainer..

 > +#ifdef CONFIG_SMP
 > +#error cpufreq support is disabled for config_smp
 > +#endif

Why ? The core itself should be safe now, if you know of problems,
I'd like to know about them.  It's also extraneous given that you
do a runtime test for >1 CPU in check_supported_cpu() and abort in that case.

 > +#ifdef CONFIG_PREEMPT
 > +#warning noone tested this on preempt system, beware
 > +#endif

This is likely to be lots of 'fun'. The multiple stage state machine
that the opteron powernow uses could be preempted at any stage.
Might not be that big a deal for UP (except for any timing specific
routines, that need explicit disable/enable around them). But for SMP,
where you could wind up on a different CPU when you return to kernel
space, 'bad shit' will happen. Good luck!

 > +#ifdef LOG_CHANGES
 > +static char *vid_name(u32 vid);
 > +static char *fid_name(u32 fid);
 > +#endif
 > +
 > +static u32 convert_fid_to_vco_fid(u32 fid);
 > +static inline u32 find_freq_from_fid(u32 fid);
 > +static inline u32 find_fid_from_freq(u32 freq);
 > +static u32 find_closest_fid(u32 freq, int searchup);
 > +static inline void sort_pst(struct pst_s *ppst, u32 numpstates);
 > +static inline void count_off_vst(void);
 > +static inline void count_off_irt(void);
 > +static inline int transition_frequency(u32 * preq, u32 * pmin, u32 * pmax,
 > +				       u32 searchup);
 > +static int find_match(u32 * ptargfreq, u32 * pmin, u32 * pmax, int searchup,
 > +		      u32 * pfid, u32 * pvid);
 > +static inline int transition_fid_vid(u32 reqfid, u32 reqvid);
 > +static int decrease_vid_code_by_step(u32 reqvid, u32 step);
 > +static int write_new_fid(u32 fid);
 > +static int write_new_vid(u32 vid);
 > +static inline int pending_bit_stuck(void);
 > +static int query_current_values_with_pending_wait(void);
 > +static inline int core_voltage_pre_transition(u32 reqvid);
 > +static inline int core_voltage_post_transition(u32 reqvid);
 > +static inline int core_frequency_transition(u32 reqfid);
 > +static inline int find_psb_table(void);
 > +static inline int check_supported_cpu(void);
 > +static int drv_verify(struct cpufreq_policy *pol);
 > +static int drv_target(struct cpufreq_policy *pol, unsigned targfreq,
 > +		      unsigned relation);
 > +static int __init drv_cpu_init(struct cpufreq_policy *pol);
 > +static void __exit drv_exit(void);

Dump this lot in powernow-k8.h please, or better yet, remove them
where possible.

 > +static int onbattery = 1;	/* Set if running on battery, reset otherwise. */
 > +			   /* Of no relevance unless batterypstates <     */
 > +			   /* numpstates, as defined in the PSB/PST.      */

Where is this set ? My guess is you're going to need ACPI hooks
to do this, in which case it shouldn't be static.
 
 > +#define SEARCH_UP     1
 > +#define SEARCH_DOWN   0
 > +
 > +#ifdef LOG_CHANGES
 > +static char *pVIDs[] = {
 > +	"1.550V", "1.525V", "1.500V",
 > +	"1.475V", "1.450V", "1.425V", "1.400V",
 > +	"1.375V", "1.350V", "1.325V", "1.300V",
 > +	"1.275V", "1.250V", "1.225V", "1.200V",
 > +	"1.175V", "1.150V", "1.125V", "1.100V",
 > +	"1.075V", "1.050V", "1.025V", "1.000V",
 > +	"0.975V", "0.950V", "0.925V", "0.900V",
 > +	"0.875V", "0.850V", "0.825V", "0.800V",
 > +	"off",	"error - impossible vid"
 > +};

Passing these around as strings seems odd. See what powernow-k7 did.
You have to do all the extra division & multiplying, but it's less icky IMO.

 > +/* Sort the fid/vid frequency table into ascending order by fid. The spec */
 > +/* implies that it will be sorted by BIOS, but, it only implies it, and I */
 > +/* prefer not to trust when I can check.                                  */
 > +/* Yes, it is a simple bubble sort, but the PST is really small, so the   */
 > +/* choice of algorithm is pretty irrelevant.                              */
 > +static inline void
 > +sort_pst(struct pst_s *ppst, u32 numpstates)
 > +{
 > +	u32 i;
 > +	u8 tempfid;
 > +	u8 tempvid;
 > +	int swaps = 1;
 > +
 > +	while (swaps) {
 > +		swaps = 0;
 > +		for (i = 0; i < (numpstates - 1); i++) {
 > +			if (ppst[i].fid > ppst[i + 1].fid) {
 > +				swaps = 1;
 > +				tempfid = ppst[i].fid;
 > +				tempvid = ppst[i].vid;
 > +				ppst[i].fid = ppst[i + 1].fid;
 > +				ppst[i].vid = ppst[i + 1].vid;
 > +				ppst[i + 1].fid = tempfid;
 > +				ppst[i + 1].vid = tempvid;
 > +			}
 > +		}
 > +	}
 > +
 > +	return;
 > +}

Remind me why it needs to be sorted at all ? We just walk the table
linearly looking for a specific frequency iirc.

 > +#ifdef DEBUG
 > ... deletia 
 > +#endif

There's a *lot* of this in this driver. Does it really need that much
debugging info ? Additionally, the combination of dprintk, tprintk,
printk (KERN_DEBUG  is really messy, and kind of defeats the point
of having these macros. If they're not going to be consistent, don't
use them at all.

 > +	/* WARNING - the cpufreq calls end up doing nothing in a SMP kernel.       */
 > +	/* This code will not work too well in such a kernel. This module protects */
 > +	/* itself from being compiled ifdef CONFIG_SMP.                            */

Again, why ? Have you actually tried this ?
If you have any ideas whats wrong here, we'd like to get this fixed up.

 > +#ifdef LOG_CHANGES
 > +	printk(KERN_INFO PFX
 > +	       "cpu_init done, current fid 0x%x (%s), vid 0x%x (%s)\n", currfid,
 > +	       fid_name(currfid), currvid, vid_name(currvid));
 > +#else
 > +	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
 > +	       currfid, currvid);
 > +#endif
 > +	return 0;
 > +}

Just do the string and lose the ifdef.  Actually, if you change it not
to pass strings around, but integers, you get this for free without
needing any 'fid_name()' routines and such.

 > +/* Model Specific Registers for p-state transitions. MSRs are 64-bit. For     */
 > +/* writes (wrmsr - opcode 0f 30), the register number is placed in ecx, and   */
 > +/* the value to write is placed in edx:eax. For reads (rdmsr - opcode 0f 32), */
 > +/* the register number is placed in ecx, and the data is returned in edx:eax. */
 > +
 > +#define MSR_FIDVID_CTL      0xc0010041
 > +#define MSR_FIDVID_STATUS   0xc0010042
 > +
 > +/* Field definitions within the FID VID Low Control MSR : */
 > +#define MSR_C_LO_INIT_FID_VID     0x00010000
 > +#define MSR_C_LO_NEW_VID          0x00001f00
 > +#define MSR_C_LO_NEW_FID          0x0000002f
 > +#define MSR_C_LO_VID_SHIFT        8
 > +
 > +/* Field definitions within the FID VID High Control MSR : */
 > +#define MSR_C_HI_STP_GNT_TO       0x000fffff
 > +
 > +/* Field definitions within the FID VID Low Status MSR : */
 > +#define MSR_S_LO_CHANGE_PENDING   0x80000000	/* cleared when completed */
 > +#define MSR_S_LO_MAX_RAMP_VID     0x1f000000
 > +#define MSR_S_LO_MAX_FID          0x003f0000
 > +#define MSR_S_LO_START_FID        0x00003f00
 > +#define MSR_S_LO_CURRENT_FID      0x0000003f
 > +
 > +/* Field definitions within the FID VID High Status MSR : */
 > +#define MSR_S_HI_MAX_WORKING_VID  0x001f0000
 > +#define MSR_S_HI_START_VID        0x00001f00
 > +#define MSR_S_HI_CURRENT_VID      0x0000001f

Are you intending to use the i386 driver on x86-64 using the symlink
trick Andi did for some other parts of arch/i386/kernel/ ?
If not, move this lot to include/asm-[i386/x86_64]/msr.h
If so, it can stay to reduce duplication.


 > +#ifdef LOG_CHANGES
 > +#define lprintk(msg...) printk(msg)
 > +#else
 > +#define lprintk(msg...) do { } while(0)
 > +#endif
 > +
 > +#ifdef DEBUG
 > +#define dprintk(msg...) printk(msg)
 > +#else
 > +#define dprintk(msg...) do { } while(0)
 > +#endif
 > +
 > +#ifdef TRACE
 > +#define tprintk(msg...) printk(msg)
 > +#else
 > +#define tprintk(msg...) do { } while(0)
 > +#endif

See above, this lot seems to be adding more clutter than anything.
The fact most of users are already inside ifdef blocks themselves
doesn't help.

 > +/* Attempt to force the BIOS to enable power management in the chipset if 
 > + * it has not already done so. At least 1 BIOS is delaying the enablement 
 > + * until ACPI init, which never happens without an ACPI enabled Linux 
 > + * kernel. This can be regarded as a BIOS bug, but that is of little help 
 > + * when you are facing the situation. Do not enable this code unless you 
 > + * are sure as to what you are doing.                            */
 > +#ifdef CHIPSET_HACK
 > +#define chipset_force_pm() do {                                                          \
 > +        unsigned val;                                                                    \
 > +        unsigned port = 0x1010;                                                          \
 > +        val = inw( port );                                                               \
 > +        printk( KERN_INFO PFX "power management enable port 0x%x = 0x%x\n", port, val ); \
 > +        val |= 0x300;                                                                    \
 > +        outw( val, port );                                                               \
 > +        udelay( 200 );                                                                   \
 > +        val = inw( port );                                                               \
 > +        printk( KERN_INFO PFX "port 0x%x modified to 0x%x\n", port, val );               \
 > +        } while(0)
 > +#else
 > +#define chipset_force_pm() do { } while(0)
 > +#endif
 > +
 > +#ifdef TRACE
 > +#define chipset_force_pm() do {                                                          \
 > +        unsigned val;                                                                    \
 > +        unsigned port = 0x1010;                                                          \
 > +        val = inw( port );                                                               \
 > +        printk( KERN_INFO PFX "power management enable port 0x%x = 0x%x\n", port, val ); \
 > +        } while(0)
 > +#else
 > +#define chipset_force_pm() do { } while(0)
 > +#endif

This is gross. Get the DMI strings of the offending BIOS and add a quirk
that cpufreq can fix up when it starts. No more ifdefs, and it'll also
do the right thing on boxes with and without the bug.

Summary:
Mostly minor nits, but it does need some work to make it look like
a kernel driver.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
