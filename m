Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264015AbVBDXAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbVBDXAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbVBDW7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:59:51 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:62727 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S266138AbVBDWnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:43:53 -0500
Date: Fri, 4 Feb 2005 23:44:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Prarit Bhargava <prarit@sgi.com>
Subject: 2.6.11-rc3-bk1: ide1: failed to initialize IDE interface
Message-Id: <20050204234422.4a9c6fd0.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just gave a quick try to 2.6.11-rc3-bk1, and noticed the following
new message in dmesg:
ide1: failed to initialize IDE interface

This seems to be new in 2.6.11-rc3-bk1. I could find the relevant
changeset in bk:
http://linux.bkbits.net:8080/linux-2.5/cset@1.1992.9.16

My (admittedly quick) analysis of the code (drivers/ide/ide-probe.c) is
that init_hwif() can return 0 in two cases: either because the IDE
interface is somehow not really there (!hwif->present) or because
something wrong happened while initializing the IDE interface. My
system's ide1 happens to be enabled (BIOS settings) but no IDE device is
connected to it. I traced the code and it unsurprisingly happens that I
am in the first "error" case - init_hwif() exits immediately because
!hwif->present.

I would tend to think that this is *not* an error, so we shouldn't
display an error message in this case. Maybe init_hwif() should return 1
instead of 0 in this case. Or maybe it should return -1, 0 and 1 for
error, no interface and success, respectively. I'm not certain I
understand the semantics behind the returned value, does it mean
error/success or interface absent/present (or a bit of each)? Or maybe
we could move the error message into init_hwif() itself, but that would
require some error path changes.

I do not propose a patch because I'm not exactly sure what has to be
done, but I still believe something has to be done. Insight anyone?

Thanks,
-- 
Jean Delvare
