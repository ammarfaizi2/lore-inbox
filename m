Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTEVS06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTEVS06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:26:58 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:17938 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263062AbTEVS04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:26:56 -0400
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 22 May 2003 13:39:56 -0500
From: <tripperda@nvidia.com>
Subject: standby failures and ignoring return values
Message-ID: <20030522183956.GD532@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on some of the power management support for our driver and ran into a problem with 2.4 kernels.

I'm currently working with Dell Inspiron systems using APM (I think these bioses can do either APM or ACPI). When APM is enabled, the bios is only capable of suspend & resume, not standby.

If I try to enter standby with "apm -S" (on a red hat 7.3 system), the screen goes blank and the system appears to hang.

What's actually happening is that the bios call is failing (set_power_state w/ APM_STATE_STANDBY) and the kernel prints out the message "apm: standby: Parameter out of range". 

The system is still alive: I can break into the kernel and if I happened to vt switch out of X to the console before doing this the console works fine. But both X and apmd got a standby event and ran their standby scripts, so X is down and apmd has disabled networking, etc..

Looking closer, the function standby() in arch/i386/kernel/apm.c sees the error and prints the warning message, but doesn't do anything about it. It seems that when this error happens, this function should either queue a APM_STANDBY_RESUME event or return an error code so the caller can handle the failure. That would allow X and apmd to realize they need to restore the services they shut down.

I can put together and test a simple patch for this, but I was wondering if this wasn't done for a reason. perhaps other people had a bios fail this call and trying to recover was worse than doing nothing at all.

Thanks,
Terence
