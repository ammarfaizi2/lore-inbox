Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTEGO2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbTEGO2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:28:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263229AbTEGO2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:28:52 -0400
Date: Wed, 7 May 2003 07:41:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: mikpe@csd.uu.se
cc: Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
In-Reply-To: <16056.53993.774345.897852@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0305070732010.2019-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003 mikpe@csd.uu.se wrote:
> 
> The patch below hooks sysenter into the driver model and implements
> a resume() method which restores the sysenter MSRs.

This is wrong.

For one thing, you screw up SMP seriously, by not enabling sysenter on all
CPU's, only the boot one.

For another, we shouldn't have "device drivers" for the CPU. I certainly
agree about restoring the sysenter MSR's, but they should be restored by
the CPU-specific code long _before_ we start initializing devices.

So I think we should just make it part of the CPU initialization (which
should be in two parts: the low-level asm part for the "core" CPU
registers, and then the high-level C part for things like the MSR's, 
user-space segment stuff etc).

So why not just add an explicit call to "cpu_resume()" in one of the 
"do_magic_resume()" things, instead of playing games with device trees..

> The patch has a debug printk() for problematic systems that require
> the fix. If it says your machine didn't preserve the MSRs, please
> post a note about this to LKML with your machine model, so we can
> estimate the scope of the problem.

I really think that it should be done unconditionally - there's no point 
in even _expecting_ the BIOS to restore various random MSR's. I can't 
imagine that many do.

		Linus


