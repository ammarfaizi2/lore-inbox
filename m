Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTKBIp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 03:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKBIp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 03:45:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:22435 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbTKBIpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 03:45:24 -0500
Date: Sun, 2 Nov 2003 00:47:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: /proc/[0-9]*/maps where did the (deleted) status go?
Message-Id: <20031102004739.12a0004c.akpm@osdl.org>
In-Reply-To: <3FA4BDAB.9080805@mnsu.edu>
References: <3FA47EAF.3070802@hundstad.net>
	<3FA4BDAB.9080805@mnsu.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm going to fine tune this report a little bit.  The behavior change is 
> more subtle than I at first thought.
> 
> In 2.4: file that has been deleted, and is mapped will show as deleted 
> in the maps file
> In 2.6: file that has been deleted, and is mapped will show as deleted 
> in the maps file
> 
> In 2.4: file that has been moved, and is mapped will show as deleted in 
> the maps file
> In 2.6: file that has been moved, and is mapped will show the new name 
> in the maps file
> 
> While I don't see this as a bug in the kernel it certainly is a 
> regression difference.

OK, it's a bugfix.  The 2.6 behaviour is correct...

> ...and I'd still like a way of tracking when the 
> filename changes.

You could copy the file and remove the original.  That way it will show up
as (deleted).

> As a side note... this is the output of a file that has actually been 
> deleted.  It looks different from the 2.4 version (note the "\040" is 
> something new):
> 
> 40018000-40019000 rw-s 00000000 03:04 13355559 
> /home/j3gum/src/mmap/testfile.old\040(deleted)
> 

No, the \040 is present in current 2.4.  Urgh, but it's not there in
2.4.20.  We shouldn't have done that; we've gone and changed the format of
/proc/pid/maps in the stable kernel - your script will break on
2.4.23-pre9.


This patch (against 2.6) will restore the old 2.4 behaviour.  I'll scoot
the 2.4 equiv over to Marcelo.

diff -puN fs/proc/task_mmu.c~proc-pid-maps-output-fix fs/proc/task_mmu.c
--- 25/fs/proc/task_mmu.c~proc-pid-maps-output-fix	2003-11-02 00:38:26.000000000 -0800
+++ 25-akpm/fs/proc/task_mmu.c	2003-11-02 00:38:30.000000000 -0800
@@ -106,7 +106,7 @@ static int show_map(struct seq_file *m, 
 		if (len < 1)
 			len = 1;
 		seq_printf(m, "%*c", len, ' ');
-		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
 	}
 	seq_putc(m, '\n');
 	return 0;

_

