Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWDDGtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWDDGtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWDDGtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:49:46 -0400
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:27824 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751464AbWDDGtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:49:45 -0400
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>,
       "Andrew Morton" <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Fri, 24 Mar 2006 09:31:46 +0800."
             <3ACA40606221794F80A5670F0AF15F840B469696@pdsmsx403> 
X-Mailer: MH-E 7.93; nmh 1.1; GNU Emacs 21.4.1
Date: Tue, 04 Apr 2006 02:49:32 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FQfM4-0001Ui-J1@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d47848d7ba2f7fbb8675f517642b1cae6dc3a063b90c4356b0a3350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some light at the end of a long tunnel of debugging, so the end of this
email has a patch for review.  This was done with lots of help from
Luming Yu.  The discussions that went off list for a while are on the
bugzilla page [kernel bugzilla #5989].

When ec_intr=1 became the default, my TP 600X started hanging on S3
sleep (in _PTS()).  With a minimal kernel config, just a few acpi
modules built, it would hang on the first sleep...only if the thermal
module was loaded.  But that was with a hacked DSDT, so perhaps the bug
was due to the DSDT hacks.

With the vanilla (latest BIOS, v1.11) DSDT, it wouldn't hang in the
minimal configuration at all.  But with my regular, production
configuration it would hang on the 2nd sleep, so my DSDT hacks probably
helped expose, but not create the problem.  (Some of the modifications
were to fix thermal polling.)

So I hacked thermal so that it would load only a specified thermal zone
(one of THM{0,2,6,7}) -- given as a module parameter -- and also would
stop partway through setting up the thermal zone, with how far to get
specified by another thermal parameter.  Experiments with this modified
module showed that the bug appeared even when THM0 was the only zone,
and disappeared if no TMP method was called.

Perhaps there is more than one bug, but THM0 has at least one, so I did
most of the remaining testing with just THM0.  With just THM0 and a
kernel that returned 27 C for any temperature -- without calling ACPI
methods -- the system wouldn't hang.  Bisecting within the THM0 method
in the DSDT eventually showed that the trouble came in the _TMP method:

            Method (_TMP, 0, NotSerialized)
            {
                \_SB.PCI0.ISA0.EC0.UPDT ()
                Store (\_SB.PCI0.ISA0.EC0.TMP0, Local0)
                If (LGreater (Local0, 0x0AAC))
                {
                    Return (Local0)
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

Further bisection showed that commenting out the EC0.UPDT() stopped the
hangs.  By the way, only THM0._TMP does an EC0.UPDT(); THM{2,6,7} just
load the temperatures from the EC (so with thermal polling only on, say,
THM2, the system won't notice when temperatures get too high -- you have
to turn it on for THM0 -- and the DSDT hack mentioned above worked
around this bug).  But back to bisecting BIOS-supplied DSDT.

EC0.UPDT() is this:

                    Method (UPDT, 0, NotSerialized)
                    {
                        If (IGNR)
                        {
                            Decrement (IGNR)
                        }
                        Else
                        {
                            If (H8DR)
                            {
                                If (Acquire (I2CM, 0x0064)) {}
                                Else
                                {
                                    Store (I2RB (Zero, 0x01, 0x04), Local7)
                                    If (Local7)
                                    {
                                        Fatal (0x01, 0x80000003, Local7)
                                    }
                                    Else
                                    {
                                        Store (HBS0, TMP0)
                                        Store (HBS2, TMP2)
                                        Store (HBS6, TMP6)
                                        Store (HBS7, TMP7)
                                    }

                                    Release (I2CM)
                                }
                            }
                        }
                    }

Bisecting within it showed that 

  Store (I2RB (Zero, 0x01, 0x04), Local7)

caused problems.  It looks like:

                    Method (I2RB, 3, NotSerialized)
                    {
                        Store (Arg0, HCSL)
                        Store (ShiftLeft (Arg1, 0x01), HMAD)
                        Store (Arg2, HMCM)
                        Store (0x0B, HMPR)
                        Return (CHKS ())
                    }

For hacking, I made an I2RBcopy() method and an UPDTcopy() for
THM0._TMP() to call, which would call I2RBcopy() instead of IR2B().  By
the way, the actual method names had to be four characters or the iasl
compiler got unhappy, but I'll use the longer forms for clarity.

This debugging version of I2RBcopy was useful:

                    Method (I2RBcopy, 3, NotSerialized)
                    {
                        Store (Arg0, HCSL)
                        Store (ShiftLeft (Arg1, 0x01), HMAD)
                        Store (Arg2, HMCM)
                        Store (0x0B, HMPR)
			Store(local0, Debug)
                        Return (local0)
                        Return (CHKS ())
                    }

It showed -- once I found the right debug_level/debug_layer combination
(layer=0x90, level=0x1F) -- that I2RBcopy was called during wakeup in a
strange spot.  You'd expect it to be called after a THM0._TMP(), but it
would be called during the _SST() method; see comment #43 at bug 5989
and the dmesgs attached there, of which the relevant extract is:

Execute Method: [\_WAK] (Node e3f8aa48)
Execute Method: [\_TZ_.THM0._PSV] (Node e3f8bdc8)
Execute Method: [\_TZ_.THM0._TC1] (Node e3f8bd48)
Execute Method: [\_TZ_.THM0._TC2] (Node e3f8bd08)
Execute Method: [\_TZ_.THM0._TSP] (Node e3f8bcc8)
Execute Method: [\_TZ_.THM0._AC0] (Node e3f8bec8)
Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf08)
Execute Method: [\_SI_._SST] (Node e3f8a848)
# why does the Debug line show up here, and not right after the THM0._TMP line?
[ACPI Debug]  Integer: 0x00000000
Execute Method: [\_SB_.LID0._PSW] (Node c1574808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1574708)

So the next step was to try the acpi_serialize boot option to make the
method calls more like how Windows interprets ACPI code (presumably well
tested when the BIOS was made).  The system still hung on the 2nd sleep.

One explanation was that kacpid was jumping the gun and the wakeup
methods were not running in the right order.  So after several hacks and
tests of them, the changes converged to the following (see the diff for
the full details):

- Create an exported symbol: int acpi_in_suspend;

- In acpi_pm_prepare(), set acpi_in_suspend just before preparing to
  sleep. 

- In acpi_pm_finish, unset acpi_in_suspend after leaving sleep state.

- If acpi_in_suspend is true:
  -- Don't do anything in acpi_os_queue_for_execution()
  -- or in acpi_thermal_run()
  -- or in acpi_thermal_check()
  -- or in acpi_thermal_notify()

By itself, and returning to the vanilla DSDT, this change seemed to fix
the problem: The system lasted through two sleep/wake cycles, which was
encouraging.  Alas, it hung on the 4th sleep.

But there's good news.  I used that patch with

   acpi_os_name="Microsoft Windows" acpi_serialize

and I haven't been able to hang it (again, now with the vanilla DSDT).
[Thanks to Len Brown for the recent ACPI changes that document
acpi_os_name.]  

I did 14 sleep/wake cycles with no problem.  The first eight cycles were
with debug_{level,layer}=0x10, which was the combination that hung more
easily than layer=0x90,level=0x1F.  To check whether the debug params
matters, I did the last six cycles with layer=0x90,level=0x1F -- also
fine.

To further flush out any bug, I turned on thermal polling: every 1
second for each of the four thermal zones (starting them 0.25 seconds
apart to maximize the chance that a thermal poll happens at a dangerous
time during the suspend or wake).  Six further cycles worked fine.  Then
I unloaded and loaded the thermal module, which often helps produce
hangs on the next suspend, and that was fine for six more cycles.  I
haven't been able to hang it at all.

To summarize:

1. hangs on 4th S3 : patch in #63.
2. hangs on 2nd S3 : vanilla + acpi_os_name="Microsoft Windows"
3. hangs on 2nd S3 : vanilla + acpi_os_name="Microsoft Windows" acpi_serialize
4. doesn't hang    :   patch + acpi_os_name="Microsoft Windows"

Probably the patch + acpi_serialize will hang too, but I'm not sure.
The unclean version of the patch (i.e. with debugging printk's) did
hang with just acpi_serialize.

The slight problems: the fan state and polling frequencies are garbled
on resume.  By fan state being garbled, I mean that it is sometime on
even though the temps are all below the trip points, and acpi -t
reports that the fan is off.  So the system doesn't have the right fan
state.  Similarly with the thermal polling: It reports 1 second for
each zone, but it's not polling at all (no TMP methods reported in the
dmesgs).  If I set the polling intervals to 1 second, then it starts
polling again.

Also, I need to wake it up using the power switch instead of the Fn
key.  Using the power switch produces a couple sharp clicks on the
speaker.

Here's the diff.  It needs review.  For example, are these changes
solving the real problem, or do they just smother it under a bunch of
hacks?  If the basic idea of acpi_in_suspend is sound, are there other
areas that need to check for it?  For example, should EC UPDT() be
disabled during sleep/wake?

Is the change something that other machines should use by default, or
should use if sleep hangs, or should avoid?  My suspicion is that it
solves a real problem, which will be triggered on some machines in some
circumstances, although whether it's the whole problem I'm not sure.  I
had one (unreproducible) S3 hang with a vanilla kernel even though
thermal was being unloaded every time by that sleep script (the other
hangs discussed above had thermal loaded).  So the _TMP story isn't the
whole one.

On the other hand, the patch is at least part of the story.  For
example, bug 5037 <http://bugzilla.kernel.org/show_bug.cgi?id=5037#c17>,
where pre-emptible kernels would often hang going to sleep, is probably
related to this problem of methods running out of order.  [Although I
haven't tried recompiling with all preemption turned on to see whether
that problem goes away.]



diff -r ac486e270597 -r abd89292c539 drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/osl.c	Thu Mar 30 10:59:57 2006 -0500
@@ -634,6 +634,8 @@ static void acpi_os_execute_deferred(voi
 	return_VOID;
 }
 
+extern int acpi_in_suspend;
+
 acpi_status
 acpi_os_queue_for_execution(u32 priority,
 			    acpi_osd_exec_callback function, void *context)
@@ -643,6 +645,8 @@ acpi_os_queue_for_execution(u32 priority
 	struct work_struct *task;
 
 	ACPI_FUNCTION_TRACE("os_queue_for_execution");
+	if (acpi_in_suspend)	/* in case kacpid is causing the queue */
+		return_ACPI_STATUS(AE_OK);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
diff -r ac486e270597 -r abd89292c539 drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/sleep/main.c	Thu Mar 30 10:59:57 2006 -0500
@@ -19,6 +19,12 @@
 #include <acpi/acpi_drivers.h>
 #include "sleep.h"
 
+/* for functions putting machine to sleep to know that we're
+   suspending, so that they can careful about what AML methods they
+   invoke (to avoid trying untested BIOS code paths) */
+int acpi_in_suspend;
+EXPORT_SYMBOL(acpi_in_suspend);
+
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
@@ -55,6 +61,8 @@ static int acpi_pm_prepare(suspend_state
 		printk("acpi_pm_prepare does not support %d \n", pm_state);
 		return -EPERM;
 	}
+	acpi_os_wait_events_complete(NULL);
+	acpi_in_suspend = TRUE;
 	return acpi_sleep_prepare(acpi_state);
 }
 
@@ -132,6 +140,7 @@ static int acpi_pm_finish(suspend_state_
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
 	acpi_leave_sleep_state(acpi_state);
+	acpi_in_suspend = FALSE;
 	acpi_disable_wakeup_device(acpi_state);
 
 	/* reset firmware waking vector */
diff -r ac486e270597 -r abd89292c539 drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/thermal.c	Thu Mar 30 10:59:57 2006 -0500
@@ -79,6 +79,8 @@ static int tzp;
 static int tzp;
 module_param(tzp, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
+
+extern int acpi_in_suspend;
 
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
@@ -683,6 +685,8 @@ static void acpi_thermal_run(unsigned lo
 static void acpi_thermal_run(unsigned long data)
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)data;
+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
+		return_VOID;	/* so don't do them */
 	if (!tz->zombie)
 		acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
 					    acpi_thermal_check, (void *)data);
@@ -705,6 +709,8 @@ static void acpi_thermal_check(void *dat
 
 	state = tz->state;
 
+	if (acpi_in_suspend)
+		return_VOID;
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
 		return_VOID;
@@ -1224,6 +1230,9 @@ static void acpi_thermal_notify(acpi_han
 	struct acpi_device *device = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_notify");
+
+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
+		return_VOID;	/* so don't do them */
 
 	if (!tz)
 		return_VOID;
