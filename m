Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTHVPvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTHVPvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:51:11 -0400
Received: from animal.blarg.net ([206.124.128.1]:56287 "EHLO animal.blarg.net")
	by vger.kernel.org with ESMTP id S263330AbTHVPvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:51:04 -0400
Date: Fri, 22 Aug 2003 08:51:02 -0700
From: Ben Johnson <ben@blarg.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: debug registers not working? 2.0 kernel
Message-ID: <20030822085102.A27952@blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experimenting with the debug registers in the 2.0 kernel.  My goal
is to implement data watchpoints.  This work seems to have been done
elsewhere and I plan to use that work, but in the meantime I'm just
experimenting.  I want to see a data watchpoint work.  so far it hasn't.
Can anyone help me figure out what I'm doing wrong?

I have verified that asm("int 1") results in the "debug" isr running.
If I understand correctly, setting the debug registers in a certain way
should result in interrupt line 1 firing.  so far I haven't seen it work
that way.  is there something I'm not getting?

Thanks a lot!

- Ben




details:
----------------------------------------------------------------

I added the following code to the top of the schedule() function as a
simple test.  I removed code elsewhere in the kernel that messes with
(disables) %db7, and part of the following verifies that %db7 is never
changed after I set it.  I think software interrupt 1 should fire when
'has_run_2' is sampled, and probably again when it's updated, but it
doesn't work.  I've tried many many variations of this.

----------------------------------------------------------------

static int odb7 = 0;
static int oaddr0 = 0;

int db7 = 0;
int addr0 = 0;

static int has_run = 0;
static unsigned long has_run_2 = 0;

asm ( "        movl %%db7, %0\n"
      "        movl %%db0, %1\n"
     :"=r"(db7), "r="(addr0) );

if( db7 != odb7 || addr0 != oaddr0 )
{
	printk(KERN_DEBUG
		"%s: change: a0:0x%8.8x oa0:0x%8.8x "
		"db7:0x%8.8x odb7:0x%8.8x\n",
		__FUNCTION__, addr0, oaddr0, db7, odb7);

	odb7 = db7;
	oaddr0 = addr0;
}

if( ! has_run && jiffies > 7000 )
{
	has_run = 1;

	asm ("  movl %0, %%db0\n"
	     "  movl %1, %%db7\n"
	     : /* no inputs */
	     :"r"(&has_run_2),
	      "r"(0x000f0202)  /*LEN0=3 R/W0=3 GE=1 G0=1 */
	    );
}

if( has_run && jiffies > 8000 )
{
	/* read has_run_2 should generate 'int 1' */
	if( ! has_run_2 )
	{
		printk(KERN_DEBUG
		"%s: tested and now setting has_run_2\n",
		__FUNCTION__);

                /* write has_run_2 should generate 'int 1' */
		has_run_2 = 1;
	}
}

