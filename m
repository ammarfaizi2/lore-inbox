Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292643AbSCDSME>; Mon, 4 Mar 2002 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292639AbSCDSLr>; Mon, 4 Mar 2002 13:11:47 -0500
Received: from host194.steeleye.com ([216.33.1.194]:27917 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292635AbSCDSLd>; Mon, 4 Mar 2002 13:11:33 -0500
Message-Id: <200203041811.g24IBRQ09280@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Mon, 04 Mar 2002 12:48:44 EST." <1225610000.1015264124@tiny> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 12:11:27 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com said:
> Sorry, what do you mean by multi-threaded back end completion of the
> transaction?  

It's an old idea from databases with fine grained row level locking.  To alter 
data in a single row, you reserve space in the rollback log, take the row 
lock, write the transaction description, write the data, undo the transaction 
description and release the rollback log space and row lock.  These actions 
are sequential, but there may be many such transactions going on in the table 
simultaneously.  The way I've seen a database do this is to set up the actions 
as linked threads which are run as part of the completion routine of the 
previous thread.  Thus, you don't need to wait for the update to complete, you 
just kick off the transaction.   You are prevented from stepping on your own 
transaction because if you want to alter the same row again you have to wait 
for the row lock to be released.  The row locks are the "barriers" in this 
case, but they preserve the concept of transaction independence.  Of course, 
most DB transactions involve many row locks and you don't even want to get 
into what the deadlock detection algorithms look like...

I always imagined a journalled filesystem worked something like this, since 
most of the readers/writers will be acting independently there shouldn't be so 
much deadlock potential.

James


