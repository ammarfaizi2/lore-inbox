Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUIIVwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUIIVwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUIIVvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:51:35 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:46773 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266362AbUIIVpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:45:35 -0400
Date: Thu, 9 Sep 2004 17:45:07 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909214507.GA29412@escher.cs.wm.edu>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com> <20040909105520.U1924@build.pdx.osdl.net> <20040909190511.GB28807@escher.cs.wm.edu> <4140BFCE.8010701@ericsson.com> <20040909140349.C1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20040909140349.C1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Thing is, x86 makes no distinction btween r/x so, have you tried mmaping
> with read, then executing (I haven't)?

Yup, clearly that will work on x86.  And so obviously DigSig is not
a solution to format and buffer overflows  :)  Nor, unfortunately, a
solution to code which for whatever reason exploited this behavior.

> This has nothing to do with file permissions aside of read.  All you need
> is read permission, then you can mmap(PROT_EXEC) which will kick off the
> check, and do deny_write_access.  It's a freeform way to lock writers
> out of any readable file in the system.

No, not "any readable file," because DigSig will not lock non-ELF files.

The attached patch adds a check for execute permission to the file being
mmap'ed.  Failing such permission, it will return -EPERM and not lock
the file.

thanks,
-serge

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="digsig.c.noexec.diff"

--- digsig.c	2004-09-09 17:43:51.342757952 -0500
+++ digsig.c.noexec	2004-09-09 17:43:43.569939600 -0500
@@ -556,6 +556,11 @@ int dsi_file_mmap(struct file * file, un
 		goto out_file_no_buf;
 	}
 
+	if (!(file->f_dentry->d_inode->i_mode & MAY_EXEC)) {
+		retval = -EPERM;
+		goto out_with_file;
+	}
+
 	retval = DIGSIG_MODE;
 
 	size = elf_ex->e_shnum * sizeof(Elf32_Shdr);

--9amGYk9869ThD9tj--
