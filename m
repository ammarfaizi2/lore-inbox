Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUGSBTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUGSBTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 21:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUGSBTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 21:19:24 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26519 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264610AbUGSBTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 21:19:23 -0400
Date: Sun, 18 Jul 2004 18:18:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: numa mm/mempolicy.c maxnode off by one
Message-Id: <20040718181855.07226c74.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

As best as I can tell from code reading, the value of maxnode that is
passed in on the numa system calls mbind, get_mempolicy and
set_mempolicy is "off by one".  This seems to be undocumented, and so
far as I have yet been able to imagine, unjustified.

The kernel code in mm/mempolicy.c expects a value one larger than is
natural, and then decrements it, or it uses "maxnode-1" (sometimes one
way, sometimes the other, inconsistently).  Your libnuma user library
hides this off by one with a corresponding increment by one of maxnode. 
But we are not all using libnuma.  Some of us are using the actual
system calls, for our own nefarious purposes.

For example, on my 256 node system, with 256 bit user nodemasks, I have
to pass in a maxnode value of 257.  And the libnuma library, and numactl
command utility based on it, which are hardcoded for 2048 bit nodemasks,
always pass in a maxnode value of 2049.

Someday, someone is going to pass in some nice power of two value,
corresponding to the actual number of nodes in their nodemasks, not
expecting that their last node is being ignored.

Andi - could you explain how this came to be, and perhaps recommend a
way to fix it (or explain why it's not broken and shouldn't be fixed)?

I could propose ways to fix this without breaking any libnuma that
you've already shipped.  But first I should find out if my understanding
of the situation is correct.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
