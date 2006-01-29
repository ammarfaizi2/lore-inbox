Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWA2Qit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWA2Qit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 11:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWA2Qit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 11:38:49 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:30856 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751071AbWA2Qir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 11:38:47 -0500
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: Jens Axboe <axboe@suse.de>, Nix <nix@esperi.org.uk>,
       Ariel <askernel2615@dsgml.com>,
       Jamie Heilman <jamie@audible.transient.net>,
       Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060129155009.GT28738@edu.joroinen.fi>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
	 <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz>
	 <1137997104.2977.7.camel@laptopd505.fenrus.org>
	 <200601230029.12674.chase.venters@clientec.com>
	 <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz>
	 <20060123072556.GC15490@fifty-fifty.audible.transient.net>
	 <Pine.LNX.4.62.0601261312160.1174@pureeloreel.qftzy.pbz>
	 <87ek2td4i9.fsf@amaterasu.srvr.nix> <20060128192714.GI9750@suse.de>
	 <20060129155009.GT28738@edu.joroinen.fi>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 29 Jan 2006 10:38:12 -0600
Message-Id: <1138552692.3352.6.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 17:50 +0200, Pasi Kärkkäinen wrote:
> Are all sata drivers affected by this bug in 2.6.15?

Well, all SCSI drivers are affected by it, yes.  However, SATA devices
are peculiarly affected because the ordered_flush method of enforcing
barriers, which is where the leak is, can only be implemented for
devices that don't do tag command queueing (i.e. don't have multiple
commands outstanding for a given single device).  By and large, SATA
drivers are the only drivers in the SCSI subsystem that can't do tag
command queueing, which is why the problem didn't show up for any other
type of SCSI driver.

> Any 'official' patch available?

Well, yes, 2.6.16-rc1 has this fixed.  I can't see backporting this to
2.6.15.x since it represents a significant functionality enhancement as
well, so I'd lean towards just forcing ordered_flush to zero in 2.6.15.x
which seems to be the best bug fix.

> Or is the recommended workaround to set ordered_flush to 0 to fix this..
> does that have any downsides?

setting ordered_flush to zero for 2.6.15 turns off the flushing
functionality and restores the old behaviour.  I don't see that there
would be any down side to this.

James


