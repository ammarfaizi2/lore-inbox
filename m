Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSDSC2v>; Thu, 18 Apr 2002 22:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314469AbSDSC2v>; Thu, 18 Apr 2002 22:28:51 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1509 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314465AbSDSC2u>;
	Thu, 18 Apr 2002 22:28:50 -0400
Date: Thu, 18 Apr 2002 19:27:10 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: IrDA patches on the way...
Message-ID: <20020418192710.A988@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	Would you mind to push the following batch of patches to Linus ?
	The first two patches feature a partial rewrite of the TTP
layer that fixes lots of things. Has been on my web page for over a
month and tested intensively.
	The remaining patches are less interesting. You may have
followed discussions about the wait_event stuff ;-)
	Regards,

	Jean

--------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir258_flow_sched_lap_lmp-6.diff :
-------------------------------
		<Won't compile without ir258_flow_sched_ttp-6.diff>
	o [FEATURE] Reduce LAP Tx queue to 2 packets (from 10)
		Improve latency, reduce buffer usage
	o [FEATURE] LAP Tx queue not full notification (flow start)
		Poll higher layer to fill synchronously LAP window (7 packets)
	o [FEATURE] LMP LSAP scheduler
		Ensure Tx fairness between LSAPs (sockets, IrCOMM, IrNET...)

ir258_flow_sched_ttp-6.diff :
---------------------------
		<Won't compile without ir258_flow_sched_lap_lmp-6.diff>
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

ir258_wait_event_fixes-2.diff :
-----------------------------
	        <Following patch from Martin Diehl, mangled by me>
	o [FEATURE] Replace interruptible_sleep_on() with wait_event().
		Most races were taken care off, but cleaner anyway

ir258_mcp2120_driver.diff :
-------------------------
	        <Following patch from Felix Tang>
	o [FEATURE] Dongle driver for mcp2120/crystal hardware

ir258_dongle_locking.diff :
-------------------------
	o [CORRECT] Load dongle module with irq disabled in irtty
	<Same fix need to go in irport, but irport doesn't work for me>

ir258_lsap_lap_close-2.diff :
---------------------------
		<apply after ir258_flow_sched_lap_lmp-6.diff to avoid fuzz>
	o [CORRECT] Cancel LSAP watchdog when putting socket back to listen
	o [CORRECT] Try to close LAP when closing LSAP still active
	        <Following patch from Felix Tang>
	o [CORRECT] Header fix for compile on Alpha architecture

ir258_irnet_simult_race-2.diff :
------------------------------
	o [CORRECT] Prevent dealock on simultaneous peer IrNET connections
		Only the primary peer will accept the IrNET connection
