Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUCCUjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUCCUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:39:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58007 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261190AbUCCUjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:39:13 -0500
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk7 i8042 does not work on a genuine i386 ibm ps/2 model 70.
References: <m1znb29css.fsf@ebiederm.dsl.xmission.com>
	<20040303101347.GB310@ucw.cz>
	<m1znax3gsq.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Mar 2004 13:30:53 -0700
In-Reply-To: <m1znax3gsq.fsf@ebiederm.dsl.xmission.com>
Message-ID: <m1wu61wu4i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok I made time and here is what I found out with respect to 2.4.21
By default 2.4.x does not reset the keyboard so the IBM PowerPC portable
work around does not even run.

/*
 * In case we run on a non-x86 hardware we need to initialize both the
 * keyboard controller and the keyboard.  On a x86, the BIOS will
 * already have initialized them.
 *
 * Some x86 BIOSes do not correctly initialize the keyboard, so the
 * "kbd-reset" command line options can be given to force a reset.
 * [Ranger]
 */
#ifdef __i386__
 int kbd_startup_reset __initdata = 0;
#else
 int kbd_startup_reset __initdata = 1;
#endif

However I added he kbd-reset command line along with print
statements to be certain it happened.

The bit XLAT did not get set.  That register stayed at a
value of 0x25.  The PowerPC portable work around was activated.
And my keyboard still worked.

So perhaps the fix then is to attempt to set that bit and if
you can't set it assume it is always in the XLAT state?

To be very clear the problem I see on 2.6 is since it sees
XLAT disabled it does XLAT in software in
drivers/input/keyboard/atkbd.c

Eric
