Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVDBQfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVDBQfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDBQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 11:35:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22980 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261641AbVDBQe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 11:34:57 -0500
Date: Sat, 2 Apr 2005 10:34:38 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org, gregkh@suse.de, andrew_vasquez@qlogic.com,
       davej@redhat.com
Subject: qla_os.c causes proc_file_read: Apparent buffer overflow.
Message-ID: <20050402163438.GA17627@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In qlaxxx/qla_os.c, the copy_mem_info function can cause proc_file_read
to produce an "Apparent buffer overflow" error.

For illistration, lets assume we enter with

info->offset = 0
info->len = PAGE_SIZE (16384 on ia64 where I am seeing this)
info->pos = 0

We pass in a data buffer that is 16386 bytes long.

As a result, the first len check in copy_mem_info will restrict len to
16384.  At the end of copy, info->buffer += len will point info->buffer
at the first byte of the next page.

When the qla2x00_proc_info read function returns to proc_file_read it
will check start >= page + PAGE_SIZE in the else case on fs/proc/generic.c
line 158, and produce a warning.

I am not sure what the correct fix is for this.  Any guidance would
be appreciated.

Thanks,
Robin Holt
