Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWA1CuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWA1CuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWA1CuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:50:04 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:45219 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750735AbWA1CuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:50:03 -0500
Message-ID: <43DADB03.7080606@samwel.tk>
Date: Sat, 28 Jan 2006 03:46:27 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix overflow issues with sysctl values in centiseconds/seconds
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here's a threesome of patches to fix up some issues with the following 
sysctl values:

/proc/sys/vm/laptop_mode
/proc/sys/vm/dirty_writeback_centisecs
/proc/sys/vm/dirty_expire_centisecs

The issues:
1. The values are not range checked when they are set. They all have
a range smaller than the full integer range.
2. Conversion from these centisecond/second values is done on-the-fly 
wherever they are used. This wastes some resources.
3. The conversions are done badly. Conversion from USER_HZ to HZ is done 
by doing "value * USER_HZ / HZ". One day expressed in centiseconds 
already causes an overflow at HZ = 250. This should use 
clock_t_to_jiffies() instead.

The approach:
1. Represent everything in jiffies internally.
2. Do the conversion and range checking in the sysctl interface.

Cheers,
Bart
