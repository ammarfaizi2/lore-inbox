Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269980AbUJHOjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269980AbUJHOjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269995AbUJHOjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:39:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58821 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269993AbUJHOjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:39:24 -0400
Date: Fri, 8 Oct 2004 15:39:23 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: New-style module parameters in SCSI drivers
Message-ID: <20041008143923.GQ16153@parcelfarce.linux.theplanet.co.uk>
References: <7AAD212492598A4A92463C3F5D34C54F194EDC@ccd3.CC.de> <20041001162939.A4215@infradead.org> <20041001165555.GF16153@parcelfarce.linux.theplanet.co.uk> <20041008013029.GM16153@parcelfarce.linux.theplanet.co.uk> <1097202556.9363.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097202556.9363.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 12:29:16PM +1000, Rusty Russell wrote:
> Well, it'd never be neat.  I'd rather encourage migration: in 2.6.10 I
> will start my jihad on MODULE_PARM, ideally finished before 2.6.11. 

OK.  As long as the barrage of complaints is omnidirectional and it's
not just me who sucks.

> It's usually better that someone who knows the code does the transition
> (you can often do better than a naive substitution), so my first step
> might be to clean up Linus' compile, then make MODULE_PARM warn, to
> encourage people to help.

While we're breaking the world, we should probably take this opportunity
to Do Things Right.  Here are all the ways I've noticed with a quick
grep of doing two common tasks in SCSI drivers.

First, the maximum number of commands that may be in flight to any
given device simultaneously:

drivers/scsi/3w-xxxx.c:                 cmds_per_lun
drivers/scsi/atari_scsi.c:              setup_cmd_per_lun
drivers/scsi/sun3_scsi.c:               setup_cmd_per_lun
drivers/scsi/sun3_scsi_vme.c:           setup_cmd_per_lun
drivers/scsi/dc395x.c:                  tags
drivers/scsi/megaraid.c:                max_cmd_per_lun
drivers/scsi/megaraid/megaraid_mbox.c:  cmd_per_lun
drivers/scsi/qla2xxx/qla_os.c:          ql2xmaxqdepth
drivers/scsi/sym53c8xx_2/sym_glue.c:    max_tag

Second, what host ID to use:

drivers/scsi/aha152x.c:                 scsiid
drivers/scsi/dc395x.c:                  adapter_id
drivers/scsi/ibmmca.c:                  scsi_id
drivers/scsi/sun3_scsi.c:               setup_hostid
drivers/scsi/sun3_scsi_vme.c:           setup_hostid
drivers/scsi/pcmcia/aha152x_stub.c:     host_id
drivers/scsi/sym53c8xx_2/sym_glue.c:    hostid

I honestly don't think any more variants _could_ exist, for either
of these oh-so-common things to do.  Not to mention that using these
parameters is a small-system thing to do -- what if you have 25 scsi
adapters and some of them should be different host IDs from each other?
What if you need to send only two tagged commands at once to your crappy
cd-rom, but your raid array needs 256 tags to be in use in order to get
any kind of performance?

Admittedly, there are hacks for the second case in many drivers (see the
sym2 driver -- puke!)  But before we break the world, let's discuss how
to do this right so we can at least have a model to work towards.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
