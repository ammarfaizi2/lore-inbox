Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUKCTm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUKCTm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUKCTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:41:16 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:47229 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261845AbUKCTiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:38:12 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-user@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Uml: hostfs sendfile support (was: Re: [uml-user] 2.6.9 uml & sysemu,hostfs)
Date: Wed, 3 Nov 2004 20:37:56 +0100
User-Agent: KMail/1.7.1
Cc: nils toedtmann <user-mode-linux-user@nils.toedtmann.net>
References: <20041102150339.GA6904@gandalf.intern.marcant.net> <200411030003.38983.blaisorblade_spam@yahoo.it> <20041103011704.GD17954@gandalf.intern.marcant.net>
In-Reply-To: <20041103011704.GD17954@gandalf.intern.marcant.net>
MIME-Version: 1.0
Message-Id: <200411032037.56892.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UOTiBo8/nc0xqSZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_UOTiBo8/nc0xqSZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 03 November 2004 02:17, nils toedtmann wrote:
> On Wed, Nov 03, 2004 at 12:03:38AM +0100, Blaisorblade wrote:
> > On Tuesday 02 November 2004 16:03, nils toedtmann wrote:

> [...]

> > >  * hostfs is still broken in 2.6.9, see thread "more hostfs
> > >    problems w/ current patches (2.4, 2.6)". Last working version is
> > >    uml-patch-2.4.26-1.

> > I don't remember at the moment.

> httpd cannot read files from hostfs (but httpd can list directories,
> and the httpd user can `cat`, `less`, ... files from hostfs). Strace
> shows that "sendfile()" fails.

Ok, this makes sense.

It's not, probably, a *bug* in the strict sense, but rather a missing feature. 
I've checked that to support sendfile on 2.6 kernels special help is needed 
from the FS (i.e., it must implement a special sendfile() function).

So, if you want to use httpd, either don't use in on hostfs, or use it on 2.4, 
or recompile apache disabling the usage of sendfile(). This is a new notice I 
get, however.

That said, there is a possibility the patch is just a one-liner. It seems 
there is generic support for this. Try the attached one. Report what happens, 
please, so I know what to do with it. If it works, it will be included in 
next release.

> > But I guess you mean 2.4.24-1, right?

> Right (i did not read my `uname` correctly ;-)

> > That
> > thread reports 2.4.26-1 as completely broken, and nobody has yet
> > disagreed (including me).

> Me too
Ok, nothing new here.

> > >  * "cat /proc/sysemu" and the gedpid()-benchmark verify that sysemu
> > >    is active. But when i do "echo 0 > /proc/sysemu" the uml just
> > >    dies. According to <http://sysemu.sourceforge.net/> sysemu should
> > >    be disabled instead.

> > > Host runs 2.6.8.1 with skas3-2.6.7-v5.

> > The second problem is solved by updating to skas3-v7 on the host (don't
> > use a 2.6.9 host kernel because the guest UML gives still some problems,
> > which will be soon fixed; it is a UML bug, not a SKAS bug, so the patch
> > will be for the guest, not for the host).

> Do i get it right: all guest kernels have a bug which strikes only on a
> 2.6.9 host, with or without a skas patch (you mean the "zombie bug"?). So
> until a patch is there, i should use 2.6.8.1 + host-skas3-2.6.7-v7.
Yes, this is exactly what happens.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_UOTiBo8/nc0xqSZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-add-sendfile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-add-sendfile.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/fs/hostfs/hostfs_kern.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-add-sendfile fs/hostfs/hostfs_kern.c
--- vanilla-linux-2.6.9/fs/hostfs/hostfs_kern.c~uml-add-sendfile	2004-11-03 20:33:11.847943768 +0100
+++ vanilla-linux-2.6.9-paolo/fs/hostfs/hostfs_kern.c	2004-11-03 20:34:08.254368688 +0100
@@ -393,6 +393,7 @@ int hostfs_fsync(struct file *file, stru
 static struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
+	.sendfile	= generic_file_sendfile,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
_

--Boundary-00=_UOTiBo8/nc0xqSZ--

