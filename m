Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUJAROj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUJAROj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUJAROj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:14:39 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:27010 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265127AbUJAROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:14:00 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: 2.6.9-rc2-mm4 BIO's still broken 
Date: Fri, 01 Oct 2004 17:14:00 +0000
Message-Id: <100120041714.26442.415D9057000F388B0000674A2200734840970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Sep 14 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have more information on the problem with bio requests.  I am seeing the bi_size 
value return through bi_end_io early with an odd size if the interface is passed 
an unaligned 4K write.  What's busted here is that bio_add_page accepts the 
4K unaligned write request, then the callback from the SCSI layer calls back 
with a partial compleation with the bi_size field set to the value of 0x1FE (????)
and no other callback is received.  What's busted here is if you use the 
recommended logic of 

if (bio->bi_size)
    return 1;

then you never get the completed callback and the IO request just sits off in left 
field and the driver never returns any error status through the callback interface.
I am also still seeing the disappearing pages and after tracking through the code, 
I am certain they are related since I am not getting any callbacks from the driver 
layer after I receive the first end_io callback with bi_size set.  

Also, my drdos.com address is blocked from posting to the list again, so I am using 
comcast.net.  What's up with this?

Jeff
