Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUILKnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUILKnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUILKnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:43:21 -0400
Received: from holomorphy.com ([207.189.100.168]:45700 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268646AbUILKnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:43:19 -0400
Date: Sun, 12 Sep 2004 03:43:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912104314.GN2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com> <20040912101350.GA13164@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912101350.GA13164@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 12:13:50PM +0200, Ingo Molnar wrote:
> in fact we can now merge the max_limit and pid_max checks - see the
> attached updated patch.
> fix pid_max handling. Wrap around correctly.
> Signed-off-by: William Lee Irwin III <wli@holomorphy.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

I like the update. But I see other issues. For instance (also untested):


pid wrapping doesn't honor RESERVED_PIDS.

Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-12 03:26:07.781592064 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-12 03:26:50.063164288 -0700
@@ -128,7 +128,10 @@
 		map = next_free_map(map, &max_steps);
 		if (!map)
 			goto failure;
-		offset = 0;
+		else if (map != pidmap_array)
+			offset = 0;
+		else
+			offset = RESERVED_PIDS;
 	}
 	/*
 	 * Find the next zero bit:
