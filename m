Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUB2OlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUB2OlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 09:41:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58000 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261863AbUB2OlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 09:41:13 -0500
To: <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: 2.6.3-bk7 i8042 does not work on a genuine i386 ibm ps/2 model 70.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Feb 2004 07:32:19 -0700
Message-ID: <m1znb29css.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The i8042 driver attempts to detect if IBM PC compatiblity mode i.e.
I8042_CTR_XLATE is enabled.  Unfortunately on a genuine IBM PS/2, (a pc
incompatible :) this does not work. 

In i8042_controller_init if I disable the detection of the keyboard
not being in XLATE mode everything works fine.

/*
 * If the chip is configured into nontranslated mode by the BIOS, don't
 * bother enabling translating and be happy.
 */     
#if 0

	if (~i8042_ctr & I8042_CTR_XLATE)
		i8042_direct = 1;
#endif


The value of i8042_initial_ctr is 0x25 in case that helps.

I am not certain where to proceed from here.

The piece I am certain about is that the keyboard controller has
traditionally been a tiny microcontroller on PCs so that there is a
wide variance in the commands and the exact format that they support.
And so far every data sheet I have looked at the documentation is
slightly different.  The only real intel datasheet I could find was
for the i8741A.  And it does not document the traditional interface
implemented but the i8042, because that was done in firmware.

This machine is primarily a test machine to make certain my code
works on older hardware.  So I am willing try any interesting or
likely patches.

My primary problem is that the code does not do the conservative
thing and assume the BIOS setup the machine in PC compatible mode,
and only when certain XLATE mode is implemented by the i8042 act on
that information.  Instead the code is assumes it knows how the
hardware works when in fact it does not.  

One solution might be check to assume XLATE mode is always enabled
unless the underlying hardware matches a known list of superio chips.

It is extremely evil to try and use a machine when the scancodes are
misinterpreted.

Eric
