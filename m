Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319506AbSH2Wqy>; Thu, 29 Aug 2002 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319497AbSH2WqH>; Thu, 29 Aug 2002 18:46:07 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:44992 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319496AbSH2WoS>;
	Thu, 29 Aug 2002 18:44:18 -0400
Date: Thu, 29 Aug 2002 15:46:58 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, Martin Diehl <lists@mdiehl.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA locking fixes for 2.5.X on the way...
Message-ID: <20020829224658.GA14118@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

	The next few e-mails will contain the "trivial" patches
necessary to get rid of "save_flags(flags);cli();" in the IrDA
stack. I guess you were right, I only needed to add a few spinlocks
left and right.
	I would like those patches to go quickly in 2.5.X, because
they cover lot's of code, so any other changes to the IrDA stack is
likely to make those patches not apply. That's also the reason why I
separated the ALI fixes, as some wanabe IrDA hackers are playing with
it (and creating compile errors).
	The patches go in TWO phases. The first 3 patches are
independant and fixes things needed by the locking fixes. The
remaining 4 patches are also independant but depend on the 3 previous
patches. Patches done and tested on 2.5.32.
	I've got still other patches in my patch queue, and I'll send
that to Jeff in a few weeks.

	Regards,

	Jean

--------------------------------------------------------
[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir252_hashbin_fixes-4.diff :
--------------------------
	o [CRITICA] Remove correct IAS Attribute/Object even if name is dup'ed
	o [CORRECT] Make irqueue 64 bit compliant (__u32 -> long)
	o [FEATURE] Don't use random handle for IrLMP handle, use self
		Remove dependancy on random generator in stack init

ir252_lap_unique_saddr.diff :
---------------------------
	o [CORRECT] Make sure LAP address is sane, which mean not NULL,
		not BROADCAST and not already in use by another link.

ir255_nsc_speed-4.diff :
----------------------
	o [FEATURE] Cleanly change speed back to 9600bps
	o [CORRECT] Change speed under spinlock/irq disabled
	o [CORRECT] Make sure interrupt handlers don't mess irq mask
	o [CORRECT] Don't change speed if we haven't fully finished to Tx

ir252_hashbin_locking_fixes-4.diff :
----------------------------------
	o [FEATURE] New hashbin locking scheme for irqueue
	o [FEATURE] Get rid of old broken hashbin locking schemes
	o [FEATURE] Lock hasbins while enumerating it in various places
	o [CORRECT] Remove all remaining "save_flags(flags);cli();"
	o [CORRECT] Fix two "return with spinlock" found by Stanford checker

ir252_ircomm_locking_fixes-4.diff :
---------------------------------
	o [FEATURE] Do the hashbin locking fixes for IrCOMM and IrLAN
	o [CORRECT] Remove all "save_flags(flags);cli();" in IrCOMM/IrLAN
	o [CORRECT] Fix other locking issues in IrCOMM

ir252_drivers_locking_fixes-3.diff :
----------------------------------
	o [CORRECT] Remove all "save_flags(flags);cli();" in IrDA driver
	o [FEATURE] Rework broken locking in irport
	o [FEATURE] Finish locking cleanup in nsc-ircc
	o [FEATURE] Improve locking in smc-ircc & w83977af_ir

ir252_ali_locking_fixes-3.diff :
------------------------------
	o [CORRECT] Remove all "save_flags(flags);cli();" in IrDA ali driver
	o [CORRECT] Fix stupid compilation error
