Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWJFO4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWJFO4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWJFO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:56:54 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:9131 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932412AbWJFO4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:56:52 -0400
Message-ID: <45266EB9.1080205@cfl.rr.com>
Date: Fri, 06 Oct 2006 10:56:57 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Investigating poor du performance on ReiserFS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2006 14:56:59.0559 (UTC) FILETIME=[ACB4BB70:01C6E957]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14734.003
X-TM-AS-Result: No--3.986500-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking into a performance problem lately on ReiserFS 
executing du on a rather large directory.  For reference this is a 
Maildir of lkml since Jan 1 of this year which currently contains around 
90,000 messages/files.  Executing a du in this directory with cold 
caches takes a horribly long time.  A find completes rather quickly but 
all the stat()s that du performs seems to take a very long time to read 
in the required data ( orders of magnitude longer than it should take 
for the disks to read the amount of data transfered ).

I believe this is due to a massive seek storm caused in the process of 
reading all of the leaf nodes to fetch the stat blocks.  I have surmised 
that this is due to the fact that the directory entries are sorted by 
their hash value, and that is the order they are returned to du in, 
which then performs a stat() on each one in sequence.  The problem is 
that the hash sort order has no relationship to the order of the leaf 
nodes that hold the stat info.  While the leaf nodes generally have 
keys, and thus block locations, close to the parent directory, the order 
they are accessed in is essentially random, which causes the seek storm.

Does this theory sound plausible?  How hard would it be to sort the 
directory listing by key before returning it?  Would doing that likely 
fix the problem by causing du to stat the files in the order of the leaf 
node keys, and thus, quite likely in the order that the blocks appear on 
disk?

