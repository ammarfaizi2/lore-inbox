Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUDHV0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUDHV0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:26:21 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:17309 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S262648AbUDHV0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:26:18 -0400
Date: Fri, 9 Apr 2004 01:27:11 +0400
From: Kirill Korotaev <kirillx@7ka.mipt.ru>
Reply-To: Kirill Korotaev <kirillx@7ka.mipt.ru>
Organization: SWsoft
X-Priority: 3 (Normal)
Message-ID: <791543157.20040409012711@7ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: Errors in load_elf_binary()?
In-Reply-To: <40753919.2070202@sw.ru>
References: <40753919.2070202@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

File: fs/binfmt_elf.c

1.

load_elf_binary()

2002/02/05 torvalds   | retval = kernel_read(bprm->file, elf_ex.e_phoff, (char *) elf_phdata, size);
2002/02/05 torvalds   | if (retval < 0)
2002/02/05 torvalds   |       goto out_free_ph;
2003/06/29 alan       |
2003/06/29 alan       | files = current->files;           /* Refcounted so ok */
2003/06/29 alan       | if(unshare_files() < 0)
2003/06/29 alan       |       goto out_free_ph;
<<<< retval is not set >>>>
should be something like:
retval = unshare_files()
if (retval < 0)
   goto ....;
2003/08/09 agruen     | if (files == current->files) {
2003/08/09 agruen     |       put_files_struct(files);
2003/08/09 agruen     |       files = NULL;
2003/08/09 agruen     | }

........

2.

load_elf_binary()

2002/02/05 torvalds   | out_free_dentry:
2002/02/05 torvalds   |       allow_write_access(interpreter);
2002/02/05 torvalds   |       fput(interpreter);
<<<< interpreter can be NULL >>>>
e.g. we got oopses here when flush_old_exec()
returns error
should be something like:
if (interpreter)
   fput(interpreter);
2002/02/05 torvalds   | out_free_interp:

3.

load_elf_binary()

Why there is no steal_locks() call in exit path (after label 
"out_free_fh")? Shouldn't were steal locks back when undoing our changes?

Kirill


