Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUIJWS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUIJWS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267984AbUIJWS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:18:28 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:33124 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S267978AbUIJWSY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:18:24 -0400
X-Ironport-AV: i="3.84,150,1091422800"; 
   d="scan'208"; a="91994219:sNHT26994360"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flock/posix lock question
Date: Fri, 10 Sep 2004 17:18:23 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C046306E6@ausx2kmpc103.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: flock/posix lock question
Thread-Index: AcSXfr0aomLk/XJMTCOZBH5sE5sjQgAABNRQAAFJ4AA=
From: <Stuart_Hayes@Dell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Stuart_Hayes@Dell.com>
X-OriginalArrivalTime: 10 Sep 2004 22:18:24.0064 (UTC) FILETIME=[16687C00:01C49784]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hayes, Stuart wrote:
> Hello--
> 
> This question regards file locks and code in fs/locks.c.
> 
> I am seeing the kernel get stuck in posix_locks_deadlock() checking
> for deadlocks.  It appears that samba (smbd) is getting both an flock
> and a posix lock for the same file, which results in a circular
> dependency in the blocked_list... and posix_locks_deadlock() is
getting
> stuck in that circle.    
> The circular dependency gets into the blocked_list because deadlock
> situations aren't checked for when inserting flock requests into the
> blocked_list.  
> 
> Since flocks aren't supposed to do any deadlock checking, it seems
> like the right solution to this would be to modify
> posix_locks_deadlock() to only check for deadlock situations with
> other posix locks and lock requests, and ignore flocks.  Of course,
> samba should also probably be fixed so that it doesn't do that, too...
> but it shouldn't be able to cause a kernel hang by doing so.     
> 
> Does this sound correct?  Am I missing something?
> 
> (I am seeing this on a RHEL3 update 3 (2.4.21-20) kernel.)
> 
> Thanks!
> Stuart

Here's a patch (untested) just to illustrate what I think needs to be
done:

--- locks.c	Wed Apr 21 23:09:18 2004
+++ locks.c.new	Fri Sep 10 17:15:04 2004
@@ -685,7 +685,8 @@ next_task:
 		return 1;
 	list_for_each(tmp, &blocked_list) {
 		struct file_lock *fl = list_entry(tmp, struct file_lock,
fl_link);
-		if ((fl->fl_owner == blocked_owner)
+		if ( (fl->fl_flags & FL_POSIX)
+		    && (fl->fl_owner == blocked_owner)
 		    && (fl->fl_pid == blocked_pid)) {
 			fl = fl->fl_next;
 			blocked_owner = fl->fl_owner;


