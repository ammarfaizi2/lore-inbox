Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTEFES7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTEFES6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:18:58 -0400
Received: from staple.laurelnetworks.com ([63.94.127.68]:55686 "EHLO
	staple.laurelnetworks.com") by vger.kernel.org with ESMTP
	id S262351AbTEFESw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:18:52 -0400
To: linux-kernel@vger.kernel.org
Subject: obscure read-only file system remount bug with 2.4 kernel
Date: Tue, 06 May 2003 00:31:22 -0400 (EDT)
Message-Id: <10242.1052195482@mja-pc-linux.dhcp.pit.laurelnetworks.com>
From: "Michael J. Accetta" <mja@laurelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With a 2.4.17 (MontaVista 2.1) kernel using ext3, we began seeing errors
of

EXT3-fs error (device ide1(22,1)) in start_transaction: Readonly filesystem
EXT3-fs error (device ide1(22,1)) in ext3_delete_inode: Readonly filesystem

after a change to a custom system install/reinstall procedure we've
written in house.

I believe I have traced the cause to a kernel bug with the
fs_may_remount_ro() call in fs/file_table.c which is used to verify
that a file system may be remounted RO.  It checks the open file list
of the super block for any deleted files and any regular files open
for writing.  However, tty_open() in drivers/char/ttyio.c moves tty
files from this list onto a tty_files list maintained per tty_struct
immediately on open.  So any open terminal devices files on the device
which get deleted (/dev/console in our case which is being replaced
by the reinstall process) are not considered in the remount RO test
and the remount is permitted when our reinstall completes.  This then
eventually gives at least ext3 indigestion when it goes to release the
deleted file on a now RO file system which should not yet have been allowed
to be remounted RO.

I've put together a fix which seems to work.  It calls into tty_io.c
from fs_may_remount_ro() and has it iterate over the open tty files in
all processes, following the pattern of __do_SAK() there, and looking
for deleted files with the same device number as the remounting device,
but this approach seems rather heavyweight to me.  However, it does do
minimal violence to existing file and tty data structures.

Caveats about this approach or alternative fix suggestions would be
quite welcome if anyone has them.  The problem appears to still exist
in 2.4.20 and I'd also be happy to package this as a patch against an
official 2.4.20 kernel release if there is interest.

Mike
