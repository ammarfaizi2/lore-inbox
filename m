Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbVHZMxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbVHZMxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 08:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbVHZMxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 08:53:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20910 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751523AbVHZMxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 08:53:30 -0400
Subject: Re: [PATCH] [CIFS] Fix for oops in fs/locks.c in 2.6.13-rc running
	connectathon byte range lock test over cifs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org, staubach@redhat.com
In-Reply-To: <430E8913.20105@austin.rr.com>
References: <1124937768.9705.11.camel@kleikamp.austin.ibm.com>
	 <430E8913.20105@austin.rr.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:53:27 -0500
Message-Id: <1125060807.9256.4.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch didn't apply without ignoring whitespace.  Here it is again
with tabs intact.
--------------------- Cut Here ----------------------------------------
The recent change to locks_remove_flock code in fs/locks.c changes how 
byte range locks are removed from closing files, which shows up a bug in 
cifs.   The assumption in the cifs code was that the close call sent to 
the server would remove any pending locks on the server on this file, 
but that is no longer safe as the fs/locks.c code on the client wants 
unlock of 0 to PATH_MAX to remove all locks (at least from this client, 
it is not possible AFAIK to remove all locks from other clients made to 
the server copy of the file).   Note that cifs locks are different from 
posix locks - and it is not possible to map posix locks perfectly on the 
wire yet, due to restrictions of the cifs network protocol, even to 
Samba without adding a new request type to the network protocol (which 
we plan to do for Samba 3.0.21 within a few months), but the local 
client will have the correct, posix view, of the lock in most cases. 

The correct fix for cifs for this would involve a bigger change than I 
would like to do this late in the 2.6.13-rc cycle - and would involve 
cifs keeping track of all unmerged (uncoalesced) byte range locks for 
each remote inode and scanning that list to remove locks that intersect 
or fall wholly within the range - locks that intersect may have to be 
reaquired with the smaller, remaining range.

The immediate need though is for the following fix to get into 2.6.13 to 
at least avoid the oops in the vfs.
[CIFS] Fix oops in fs/locks.c on close of file with pending locks

Signed-off-by: Steve French <sfrench@us.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff -Naur linux-2.6.13-rc7/fs/cifs/file.c linux/fs/cifs/file.c
--- linux-2.6.13-rc7/fs/cifs/file.c	2005-06-17 14:48:29.000000000 -0500
+++ linux/fs/cifs/file.c	2005-08-26 07:40:37.000000000 -0500
@@ -643,7 +643,7 @@
 			 netfid, length,
 			 pfLock->fl_start, numUnlock, numLock, lockType,
 			 wait_flag);
-	if (rc == 0 && (pfLock->fl_flags & FL_POSIX))
+	if (pfLock->fl_flags & FL_POSIX)
 		posix_lock_file_wait(file, pfLock);
 	FreeXid(xid);
 	return rc;


