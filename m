Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUJUNdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUJUNdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUJUN3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:29:13 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:50833 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268326AbUJUNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:25:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 7/7] Input: remove pm_dev from core
Date: Thu, 21 Oct 2004 08:25:00 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210230.04156.dtor_core@ameritech.net> <20041021101358.B3089@flint.arm.linux.org.uk>
In-Reply-To: <20041021101358.B3089@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210825.00133.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 04:13 am, Russell King wrote:
> On Thu, Oct 21, 2004 at 02:30:02AM -0500, Dmitry Torokhov wrote:
> > ChangeSet@1.1971, 2004-10-20 00:57:45-05:00, dtor_core@ameritech.net
> >   Input: get rid of pm_dev in input core as it is deprecated and
> >          nothing uses it anyway.
> 
> You might as well remove it completely - anything which uses the
> driver model PM implementation will never call these methods, and
> ARM uses the driver model PM implementation.
> 
> Therefore, any driver using the obsolete pm_register() functions
> won't receive any PM events.
> 
> Same is true on x86 btw.
> 

Hmm, I admit I missed arm case but for x86 should work actually:

in arch/i386/kernel/apm.c:
static int suspend(int vetoable)
{
        int             err;
        struct apm_user *as;

        if (pm_send_all(PM_SUSPEND, (void *)3)) {
                /* Vetoed */
                if (vetoable) {
                        if (apm_info.connection_version > 0x100)
                                set_system_power_state(APM_STATE_REJECT);
                        err = -EBUSY;
                        ignore_sys_suspend = 0;
                        printk(KERN_WARNING "apm: suspend was vetoed.\n");
                        goto out;
                }
                printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
        }

        device_suspend(3);
        device_power_down(3);
...

but since you say arm does not care I think we'll proceed with the patch.

-- 
Dmitry
