Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTDWVGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDWVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:06:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40715 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263510AbTDWVGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:06:04 -0400
Date: Wed, 23 Apr 2003 22:18:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: PCMCIA updates
Message-ID: <20030423221810.C19573@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the same old updates, without the workqueue change, but with
another fix (for CIS caching) and a cleanup to cb_release_cis_mem().

These bk csets correspond to the patches like so:

http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030423-2.diff  => 1.1119
http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030423-3.diff  => 1.1120
http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030423-4.diff  => 1.1121
http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030423-5.diff  => 1.1122
http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030423-6.diff  => 1.1123

There are a couple of extra patches.  pcmcia-20030423-7.diff is a
replacement for the workqueue stuff which should be more to Linus'
taste (Linus didn't have any really strong objection to the workqueue
solution, but we mutually agreed that it wasn't as readable as it
should be.)

The other patch, pcmcia-20030423-8.diff, is more or less work in
progress, and is probably fairly dangerous.  However, if you're feeling
like gambling, you could apply this one as well.  It hasn't changed
much in the past month (apart from being updated to the latest scheme
of things) and needs a fair amount of further work to sanely integrate
the change.  People may still like to look at it though.

Oh, and pcmcia-20030423-1.diff is a patch which went in a while ago,
which should be in 2.5.68.  If people are using the released 2.5.67,
this patch should be applied as well.

----- Forwarded message from Russell King <rmk@arm.linux.org.uk> -----

Date: Wed, 23 Apr 2003 22:11:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [BK PULL] PCMCIA updates

Linus, please do a

	bk pull bk://bk.arm.linux.org.uk/linux-2.5-pcmcia

to include the latest PCMCIA changes.

This is a set of changes which should not be problematical.

  GNU patches set at:
     http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030423-[2-6].diff

I'm leaving the deadlock fix (pcmcia-20030423-7.diff) out of this until
I've posted it to LKML; it works for me, but I'd prefer to get some
feedback from other people on the new solution before submitting it.

This will update the following files:

 drivers/net/wireless/orinoco_cs.c |    1 
 drivers/pcmcia/cardbus.c          |    4 +
 drivers/pcmcia/cistpl.c           |  108 +++++++++++++++++++++++---------------
 drivers/pcmcia/cs.c               |    4 -
 drivers/pcmcia/cs_internal.h      |   20 +++----
 drivers/pcmcia/rsrc_mgr.c         |   13 ++--
 include/pcmcia/bus_ops.h          |    2 
 include/pcmcia/driver_ops.h       |    2 
 include/pcmcia/ds.h               |    2 
 9 files changed, 88 insertions, 68 deletions

through these ChangeSets:

<rmk@flint.arm.linux.org.uk> (03/04/23 1.1123)
	[PCMCIA] Make cb_release_cis_mem() local to cardbus.c
	
	The cardbus CIS parsing code does not use the PCMCIA resource
	subsystem, so there isn't any point in freeing its memory when
	we remove PCMCIA memory resources.  We also free CIS resources
	immediately prior to calling cb_free().  We might as well move
	the function call into cb_free(), thereby making all references
	to cb_release_cis_mem() local to cardbus.c

<rmk@flint.arm.linux.org.uk> (03/04/23 1.1122)
	[PCMCIA] Don't cache CIS bytes found to be invalid.
	
	Several PCMCIA cards I have here do not work correctly over a
	suspend/resume cycle; the PCMCIA code believes that the card has
	been changed in the slot, and therefore performs a remove/insert
	cycle.
	
	This seems to be because the card returns more or less random data
	when reading memory space, leading to the CIS cache mismatching
	the card data.  This in turn is caused because we try to read CIS
	data from both the attribute and memory spaces, and we add the result
	to the CIS cache whether or not the returned data was valid.
	
	We therefore convert the CIS cache to use a linked list, and provide
	a way to remove cached data from that list.  We also replace the
	"s->cis_used=0;" construct with a function "destroy_cis_cache(s)"
	which clearly describes what we're doing.

<proski@org.rmk.(none)> (03/04/23 1.1121)
	[PCMCIA] Fix oops in validate_mem when CONFIG_PCMCIA_PROBE=n
	
	If I compile a recent 2.5.x kernel without CONFIG_ISA defined, I get
	an oops in validate_mem().  Stack trace contains 0x6b6b6b6 - a clear
	sign that freed memory is being accessed.
	
	It's the second validate_mem() in drivers/pcmcia/rsrc_mgr.c - the one
	used when CONFIG_PCMCIA_PROBE is not defined.  It turns out the memory
	is freed in do_mem_probe() when it's called from validate_mem().
	
	The solution is to use the same trick as in the first validate_mem().
	This problem is quite serious and it's not specific to the plx9052
	driver. I see it with yenta_socket as well.

<hch@de.rmk.(none)> (03/04/23 1.1120)
	[PCMCIA] remove unused files
	
	From Christoph Hellwig
	
	There's no need to keep the stubs around.

<proski@org.rmk.(none)> (03/04/23 1.1119)
	[PCMCIA] Fix compilation of cardmgr
	
	Patch from Pavel Roskin
	
	ds.h should not be including linux/device.h when compiling userspace
	code.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

