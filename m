Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTDWU0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTDWU0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:26:35 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:22498 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263581AbTDWU0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:26:33 -0400
Date: Wed, 23 Apr 2003 16:24:53 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423202453.GA354@phunnypharm.org>
References: <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423202002.GA10567@vitel.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this better or not than the -pre7 version ? Honestly I don't know,
> there were problems with the old one too (however the old version
> reacted to plug/unplug mount/umount events by freezing hard the
> laptop, while the new one just oopses, so this is an improvement
> from some point of view...)

This is the same oops I get except that for me I see it as a left over
scsi device even after sbp2 is unloaded (unload sbp2 and check
/proc/partitions). I haven't been able to figure out how to get the scsi
subsystem to remove devices in this condition:

	scsi_register_module(MODULE_SCSI_HA, &sbp2_template);


	scsi_host = scsi_register(&sbp2_template, 0);

	// (some devices get detected)


	// removal of host
	scsi_unregister(scsi_host);


	// Removal of sbp2 module to unregister template
	scsi_unregister_module(MODULE_SCSI_HA, &sbp2_template);



In actuality, doing scsi_unregister(scsi_host), in my eyes should also
deallocate the devices associated with that scsi_host. That doesn't
happen. It seems to me that the logic is that I should not call
scsi_unregister(scsi_host), since it gets called for the
scsi_unregister_module() of the template. However, that allows a
scsi_host leak for situations where ieee1394 controllers are getting
plugged/unplugged. It will continue to leak until sbp2 is unloaded.

I'm not sure if the leak is more optimal than the oops...maybe it is.
I'll revisit this in the next week.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
