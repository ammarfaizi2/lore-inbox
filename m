Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSHHP2f>; Thu, 8 Aug 2002 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSHHP2e>; Thu, 8 Aug 2002 11:28:34 -0400
Received: from mons.uio.no ([129.240.130.14]:2510 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317598AbSHHP2e>;
	Thu, 8 Aug 2002 11:28:34 -0400
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
References: <23130000.1028818693@baldur.austin.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Aug 2002 17:32:05 +0200
In-Reply-To: <23130000.1028818693@baldur.austin.ibm.com>
Message-ID: <shsofcdfjt6.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > This patch allows tasks to share credentials via a flag to
     > clone().

     > This version fixes the problem with exec() that Linus found.
     > Tasks that call exec() get their own copy of the credentials at
     > that point.

     > The URL is here because it's too big to include in email:

     > http://www.ibm.com/linux/ltc/patches/misc/cred-2.5.30-3.diff.gz

What the hell is that change to fs/nfs/dir.c below all about? Try
mounting an NFSv2 partition with that applied...

Instead of doing this as one big unreadable monolithic patch and
risking getting things wrong like in the above case, it would be nice
if you could go via a set of wrapper functions:

#define get_current_uid() (current->uid)
#define set_current_uid(a) current->uid = a
.
.
.

...

That would allow you to make the changes to the lower level filesystem
code in smaller babysteps, and make the actual move to 'struct cred' a
trivial patch...


As I argued before when Ben first presented this, that will also allow
us the flexibility to change the structure at a later date. Several
filesystems could benefit from a shared *BSD-style 'struct ucred' to
replace the tuple current->{ fsuid, fsgid, groups }.

Cheers,
  Trond

diff -Nru a/fs/nfs/dir.c b/fs/nfs/dir.c
--- a/fs/nfs/dir.c      Wed Aug  7 09:08:23 2002
+++ b/fs/nfs/dir.c      Wed Aug  7 09:08:23 2002
@@ -1237,9 +1237,6 @@

        lock_kernel();

-       if (!NFS_PROTO(inode)->access)
-               goto out_notsup;
-
        cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
        if (cache->cred == cred
            && time_before(jiffies, cache->jiffies + NFS_ATTRTIMEO(inode))) {

