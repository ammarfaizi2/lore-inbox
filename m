Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSLBXan>; Mon, 2 Dec 2002 18:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbSLBXan>; Mon, 2 Dec 2002 18:30:43 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5375 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265135AbSLBXal>;
	Mon, 2 Dec 2002 18:30:41 -0500
Date: Mon, 2 Dec 2002 15:36:29 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches on the way...
Message-ID: <20021202233629.GA16284@bougret.hpl.hp.com>
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

	Hi Marcelo,

	The next batch of IrDA patches for 2.4.X. Most of those
patches were integrated in kernel 2.5.09 (6 months ago) and available
for 2.4.X on my web page since, so consider them "tested". I rediffed
and tested the patches on 2.4.20-final.
	Apart from the small important fixes, the new IrTTP
implementation (safer) and the new Donauboe driver that replaces the
obsolete Toshoboe and support more hardware.

	Have fun...

	Jean

-----------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir241_flow_sched_lap_lmp-6.diff :
-------------------------------
		<Won't compile without ir241_flow_sched_ttp-6.diff>
	o [FEATURE] Reduce LAP Tx queue to 2 packets (from 10)
		Improve latency, reduce buffer usage
	o [FEATURE] LAP Tx queue not full notification (flow start)
		Poll higher layer to fill synchronously LAP window (7 packets)
	o [FEATURE] LMP LSAP scheduler
		Ensure Tx fairness between LSAPs (sockets, IrCOMM, IrNET...)

ir241_flow_sched_ttp-6.diff :
---------------------------
		<Won't compile without ir241_flow_sched_lap_lmp-6.diff>
	o [CORRECT] Fix race condition when starting todo timer
	o [CORRECT] Fix race condition when stopping higher layer
		Higher layer would think it is stopped and us it is started
	o [CORRECT] Give credit even if packets in Tx queue
		If Tx queue was stopped, could starve peer and deadlock
	o [CORRECT] Protect Rx credit update with spinlock
	o [CORRECT] Calculate properly self->avail_credit
		Didn't take into account queued Rx fragments
		Incremented even if Rx frame not delivered to higher layer
		-> would never stop the peer (i.e. not flow control)
		-> could become infinite
	o [CORRECT] Send credit when higher layer reenable receive
		Peer wouldn't restart Tx to us if flow stopped
	o [FEATURE] Implement LAP queue not full notification
		Lower latency, ...
	o [FEATURE] Reduce Tx queue to 8 packets (from 10)
		But make sure we can always send a full LAP window (7)
	o [FEATURE] Fix and optimise TTP flow control
		Make sure peer can always send a full LAP window (7)
		Minimise explicit credit updates (give_credit)
	o [FEATURE] Remove need for todo timer in Tx/Rx paths
		Less potential races, lower latency, lower context switches
		Could not use tasklet because broken API, better anyway ;-)

ir241_dongle_locking.diff :
-------------------------
	o [CORRECT] Load dongle module with irq disabled in irtty
	<Same fix need to go in irport, but irport doesn't work for me>

ir241_lsap_lap_close-2.diff :
---------------------------
		<apply after ir241_flow_sched_lap_lmp-6.diff to avoid fuzz>
	o [CORRECT] Cancel LSAP watchdog when putting socket back to listen
	o [CORRECT] Try to close LAP when closing LSAP still active
	        <Following patch from Felix Tang>
	o [CORRECT] Header fix for compile on Alpha architecture

ir241_irnet_simult_race-2.diff :
------------------------------
	o [CORRECT] Prevent dealock on simultaneous peer IrNET connections
		Only the primary peer will accept the IrNET connection

ir241_smc_msg.diff :
------------------
	        <Following patch from Jeff Snyder>
	o [CRITICA] Release the proper region and not NULL pointer
	o [FEATURE] Fix messages

ir241_donauboe.diff :
-------------------
	        <Following patch from Martin Lucina & Christian Gennerat>
	o [FEATURE] Rewrite of the toshoboe driver using documentation
	o [FEATURE] Support Donau oboe chipsets.
	o [FEATURE] FIR support
	o [CORRECT] Probe chip before opening
	o [FEATURE] suspend/resume support
	o [FEATURE] Numerous other improvements/cleanups
		<Currently, we keep the old toshoboe driver around>

ir241_checker.diff :
------------------
	<Need to apply after ir241_flow_sched_XXX.diff to avoid "offset">
	o [CORRECT] Fix two bugs found by the Stanford checker in IrDA
	o [CORRECT] Fix two bugs found by the Stanford checker in IrCOMM
	o [CORRECT] Fix one bug found by the Stanford checker in ali driver
