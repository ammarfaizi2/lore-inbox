Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVHZDRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVHZDRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 23:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVHZDRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 23:17:18 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:21499 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751400AbVHZDRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 23:17:18 -0400
Message-ID: <430E8913.20105@austin.rr.com>
Date: Thu, 25 Aug 2005 22:14:27 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org, staubach@redhat.com
Subject: [PATCH] [CIFS] Fix for oops in fs/locks.c in 2.6.13-rc running connectathon
 byte range lock test over cifs
References: <1124937768.9705.11.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1124937768.9705.11.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff -Naur old/fs/file.c new/fs/file.c
--- old/fs/cifs/file.c       2005-08-25 21:53:47.000000000 -0500
+++ new/fs/cifs/file.c       2005-08-25 21:54:56.000000000 -0500
@@ -643,7 +643,7 @@
                         netfid, length,
                         pfLock->fl_start, numUnlock, numLock, lockType,
                         wait_flag);
-       if (rc == 0 && (pfLock->fl_flags & FL_POSIX))
+       if (pfLock->fl_flags & FL_POSIX)
                posix_lock_file_wait(file, pfLock);
        FreeXid(xid);
        return rc;


The original problem report follows.  Thanks to Shaggy for the initial 
analysis.

Dave Kleikamp wrote:

>Running the connectathon lock tests, I hit this BUG:
>
>[ 3094.124950] ------------[ cut here ]------------
>[ 3094.124959] kernel BUG at fs/locks.c:1920!
>[ 3094.124962] invalid operand: 0000 [#1]
>[ 3094.124964] PREEMPT 
>[ 3094.124966] Modules linked in: cifs ipt_TCPMSS iptable_filter ip_tables blowfish sha256 dummy radeon irda crc_ccitt airo e1000 pcmcia yenta_socket rsrc_nonstatic pcmcia_core ntfs jfs
>[ 3094.124981] CPU:    0
>[ 3094.124982] EIP:    0060:[<c017630e>]    Not tainted VLI
>[ 3094.124984] EFLAGS: 00010246   (2.6.13-rc7) 
>[ 3094.124993] EIP is at locks_remove_flock+0x7e/0x140
>[ 3094.124997] eax: dc925b74   ebx: c66159f4   ecx: 00000001   edx: 00000001
>[ 3094.125001] esi: c6615a8c   edi: c66159f4   ebp: c50ffec0   esp: d0c27e78
>[ 3094.125004] ds: 007b   es: 007b   ss: 0068
>[ 3094.125008] Process tlocklfs (pid: 12264, threadinfo=d0c27000 task=c6b03570)
>[ 3094.125010] Stack: cb210ec0 d0c27e9c 00000000 10c27000 00000001 00000000 00000000 00000000 
>[ 3094.125017]        80000000 00000023 cb210ec0 d0c27f1c 00000000 d69cc3c0 e1d96b1a e1d911ca 
>[ 3094.125025]        00fe08bf d69cc3c0 00001f2f 00000000 80000000 00000000 00000000 00000001 
>[ 3094.125032] Call Trace:
>[ 3094.125038]  [<e1d96b1a>] _FreeXid+0x1a/0x30 [cifs]
>[ 3094.125058]  [<e1d911ca>] cifs_lock+0x17a/0x530 [cifs]
>[ 3094.125074]  [<c0176281>] locks_remove_posix+0x131/0x140
>[ 3094.125080]  [<c0188740>] inotify_dentry_parent_queue_event+0xa0/0xd0
>[ 3094.125089]  [<c015d967>] __fput+0xa7/0x200
>[ 3094.125098]  [<c015bd2d>] filp_close+0x4d/0x80
>[ 3094.125103]  [<c015bdcb>] sys_close+0x6b/0xa0
>[ 3094.125108]  [<c0103345>] syscall_call+0x7/0xb
>[ 3094.125115] Code: 74 1b 89 c6 8b 06 85 c0 75 f3 e8 3e 39 33 00 81 c4 cc 00 00 00 5b 5e 5f 5d c3 8d 76 00 0f b6 50 28 f6 c2 02 75 22 f6 c2 20 75 0a <0f> 0b 80 07 2c f7 4d c0 eb cd 89 34 24 bf 02 00 00 00 89 7c 24 
>[ 3094.125147]  
>
>I believe it is caused by this patch (stale POSIX lock handling):
>http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c293621bbf678a3d85e3ed721c3921c8a670610d
>
>The bit responsible is:
>
>@@ -1888,12 +1908,7 @@ void locks_remove_flock(struct file *fil
>
>        while ((fl = *before) != NULL) {
>                if (fl->fl_file == filp) {
>-                       /*
>-                        * We might have a POSIX lock that was created at the same time
>-                        * the filp was closed for the last time. Just remove that too,
>-                        * regardless of ownership, since nobody can own it.
>-                        */
>-                       if (IS_FLOCK(fl) || IS_POSIX(fl)) {
>+                       if (IS_FLOCK(fl)) {
>                                locks_delete_lock(before);
>                                continue;
>                        }
>
>
>Leaving this:
>
>                if (fl->fl_file == filp) {
>                        if (IS_FLOCK(fl)) {
>                                locks_delete_lock(before);
>                                continue;
>                        }
>                        if (IS_LEASE(fl)) {
>                                lease_modify(before, F_UNLCK);
>                                continue;
>                        }
>                        /* What? */
>                        BUG();
>                }
>
>  
>

