Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSJFAD5>; Sat, 5 Oct 2002 20:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262832AbSJFAD4>; Sat, 5 Oct 2002 20:03:56 -0400
Received: from [209.184.141.189] ([209.184.141.189]:42816 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S262826AbSJFADz>;
	Sat, 5 Oct 2002 20:03:55 -0400
Subject: RE: QLogic Linux failover/Load Balancing ER0000000020860
From: Austin Gonyou <austin@coremetrics.com>
To: CSG Support <csgsupport@qlogic.com>, tbelcher@uniquedigital.com,
       ssaqr@uniquedigital.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41EBA11203419D4CA8EB4C6140D8B4017CD8EE@AVEXCH01.qlogic.org>
References: <41EBA11203419D4CA8EB4C6140D8B4017CD8EE@AVEXCH01.qlogic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Coremetrics, Inc.
Message-Id: <1033862965.27451.51.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 05 Oct 2002 19:09:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest driver does not load balance with STK D178 array either.

I've discovered why, but I'm not sure which direction to take with
helping out to get better closure/resolution with this.


The cause of the problem is that the QLogic driver doesn't to
transparent LUN masking it seems. The reason this is a problem, is that
when the LSI/StoragTEK controllers present their luns, AVT is enabled.
This causes LUN "ghosting" down each path from the storage to the HBAs.
This becomes a problem because when the Linux Driver is told to perform
load balancing via static bindings, the LUNs are now out of order.
(whether LUN ghosting is happening or not). 

This is where transparent LUN masking would solve this problem. 

Example:
HBA0 is told it's only allowed to address the even numbered volumes.
HBA1 is told it's only allowed to address the odd-numberd volumes. 

When this happens, the driver can see all the volumes, and names them
0:0:0:0-16(or whatever the last number is) for HBA0, and then
1:0:0:0-16(or whatever thelast number is). But, the OS is not shown
that, it sees the real LUN numbers as presented by the storage.
(0,2,4,6,8,10,etc) 

Linux is not allowed to address LUNs out of sequence, so searching for
further LUN numbers stops after 0, since 2 is the next one. 

Is there a way to resolve this, either at the driver level, IMHO the
place it *should* happen. At the storage level, the place that it could
also happen, or in the Kernel?

For the time being, I'm using a temporary load balanced setup for
performance reasons since we just extended our two primary loops from 1
tray each, to 3 and 4 trays. Please advise ASAP, as in this
configuration, we cannot fail-over. 

TIA
-- 
Austin Gonyou <austin@coremetrics.com>
Systems Architect
Coremetrics, Inc.
Cel: 512-698-7250
