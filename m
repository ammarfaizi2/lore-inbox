Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264570AbTLCObj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbTLCObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 09:31:39 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:8942 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264570AbTLCObh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 09:31:37 -0500
Date: Wed, 3 Dec 2003 15:31:22 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Worst recursion in the kernel
Message-ID: <20031203143122.GA6470@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Really bad code demand really rude words, sorry.


After playing with stack checking again, I've found this little beauty
in 2.6.0-test3: [1]

WARNING: recursion detected:
      20  read_cis_cache
      36  pcmcia_get_tuple_data
     308  read_tuple
     448  pcmcia_validate_cis
      12  readable
      24  cis_readable
      28  do_mem_probe
      24  inv_probe
      16  validate_mem
      32  set_cis_map
      28  read_cis_mem
     284  verify_cis_cache

Explanation:
verify_cis_cache calls read_cis_mem, which calls set_cis_map, which
call ..., which calls read_cis_cache, which finally calls
verify_cis_cache again.

The numbers to the left is the stack space consumed by each function.
See drivers/pcmcia/cistpl.c and drivers/pcmcia/rsrc_mgr.c for all the
glory.


Most likely this recursion will never occur, as one of those calls can
depends on circumstances that prohibit recursion, but semantic
checking is a bitch for software and in this case even for humans.
Put another way: THERE IS NO WAY TO MAKE SURE THIS WORKS.

If the code cannot be made simpler, how can anyone fix bugs in it.
Just reread the famous signature about code being as smart as
possible.


*sigh*


Ok David, sorry about this.  There are more cases of similar
recursions in the kernel, just not quite as bad.  And I had to pick
someone as a bad example and start a small public flamefest, so people
realize the problem.

Still, you should have a close look at that code path during 2.7 and
see if it really makes sense the way it is now.


[1] Yes, it is outdated, but I need stable test data for now.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
