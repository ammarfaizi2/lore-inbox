Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUECWn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUECWn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUECWn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:43:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:53225 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264129AbUECWnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:43:24 -0400
Date: Tue, 4 May 2004 00:33:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040503223317.GD31580@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <20040503140251.274e1239.akpm@osdl.org> <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk> <20040503212450.GC31580@wohnheim.fh-wedel.de> <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004 22:54:34 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Let's see...  Leaving aside obvious userland code (arch/*/boot/*, scripts/*,
> drivers/char/ip2/ helpers) and arch/um/* instances that are, AFAICS, in
> userland code too and refer to libc open(2), we have
> 	a) drivers/media/dvb/frontends pile (AFAICS, loading firmware)
> 	b) systemcfg_init() in asm-ppc64/systemcfg.h (WTF is that about?)
> 	c) sound/isa/wavefront/wavefront_synth.c (loading firmware)
> 	d) sound/oss/wavfront.c (loading firmware)
> 	e) odd calls of sys_close() in binfmt_elf.c, eventpoll.c and socket.c
> 	f) potentially racy flush_unauthorized_files() in selinux code - uses
> sys_close() in a strange way.
> 
> That's it.  And I suspect that we ought to switch the firmware loaders to
> use of existing helper.

That cannot be all.  What about these two?  Not sure if my patch is
correct or it should rather s/O_RDONLY/FMODE_READ/.

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius

 exec.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.5cow/fs/exec.c~exec_thinko	2004-03-28 21:51:52.000000000 +0200
+++ linux-2.6.5cow/fs/exec.c	2004-05-02 11:47:46.000000000 +0200
@@ -135,7 +135,8 @@
 	if (error)
 		goto exit;
 
-	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+	/* dentry_open used FMODE_(READ|WRITE) instead of the O_* flags. */
+	file = dentry_open(nd.dentry, nd.mnt, 0);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out;
@@ -489,7 +490,8 @@
 				err = -EACCES;
 			file = ERR_PTR(err);
 			if (!err) {
-				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+	/* dentry_open used FMODE_(READ|WRITE) instead of the O_* flags. */
+				file = dentry_open(nd.dentry, nd.mnt, 0);
 				if (!IS_ERR(file)) {
 					err = deny_write_access(file);
 					if (err) {
