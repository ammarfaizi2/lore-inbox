Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVAEV6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVAEV6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVAEV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:58:39 -0500
Received: from pat.uio.no ([129.240.130.16]:20169 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262609AbVAEVzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:55:32 -0500
Subject: Re: panic - Attempting to free lock with active block list
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Eirik Thorsnes <eithor@ii.uib.no>, smfrench@austin.rr.com,
       matthew@wil.cx
In-Reply-To: <20050105123207.J469@build.pdx.osdl.net>
References: <20050105195736.GA26989@ii.uib.no>
	 <20050105123207.J469@build.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 22:54:03 +0100
Message-Id: <1104962043.5717.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 05.01.2005 Klokka 12:32 (-0800) skreiv Chris Wright:
> * Jan-Frode Myklebust (Jan-Frode.Myklebust@bccs.uib.no) wrote:
> > We have a couple of mail-servers running first 2.6.9-1.681_FC3smp
> > and was later upgraded to the Fedora test kernel 2.6.10-1.727_FC3smp
> > which I think is pretty plain 2.6.10 + ac2. But they both keep
> > crashing with the message:
> > 
> >        Kernel panic - not syncing: Attempting to free lock with active block list
> > 
> > Any ideas how to attack this?

Well, the prevailing theory tends to start along the lines of "find out
how to reproduce the problem...". ;-)

Looking at the NFS code, I can attempt a wild guess about what may be
happening: there may be a race when pressing ^C in the middle of a
blocking NFS lock RPC call, and if so, the following patch will fix it.

Try it, and see whether or not it fixes your problem, but if it doesn't,
then I agree with Chris' suggestion of replacing those "panic()" calls
with BUG_ON()s.

Cheers,
  Trond

 file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.10/fs/nfs/file.c
===================================================================
--- linux-2.6.10.orig/fs/nfs/file.c
+++ linux-2.6.10/fs/nfs/file.c
@@ -374,7 +374,7 @@ static int do_setlk(struct file *filp, i
 		 * the process exits.
 		 */
 		if (status == -EINTR || status == -ERESTARTSYS)
-			posix_lock_file(filp, fl);
+			posix_lock_file_wait(filp, fl);
 	} else
 		status = posix_lock_file_wait(filp, fl);
 	unlock_kernel();


-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

