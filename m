Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUJEF3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUJEF3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268802AbUJEF3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:29:41 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:5837 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268812AbUJEF26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:28:58 -0400
To: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Mon, 04 Oct 2004 22:28:55 -0700
Message-ID: <52u0t9u414.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: proper way to annotate kernel use of sys_xxx?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 05 Oct 2004 05:28:56.0217 (UTC) FILETIME=[357C3890:01C4AA9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the correct way to annotate kernel code that calls a sys_xxx
function that expects a __user pointer as an argument?

To give a concrete example, sparse (among lots of other warnings for
do_mounts.c) says:

	init/do_mounts.c:69:16: warning: incorrect type in argument 1 (different address spaces)
	init/do_mounts.c:69:16:    expected char const [noderef] *filename<asn:1>
	init/do_mounts.c:69:16:    got char [addressable] *<noident>

The code in question is the following:

	char path[64];

	/* ... */

	sprintf(path, "/sys/block/%s/dev", name);
	fd = sys_open(path, 0, 0);                 /* LINE 69 */

This is an abuse of sys_open(), but we know it's OK.  Is the right way
to shut up sparse to just change it to:

	fd = sys_open((const char __user *) path, 0, 0);

Thanks,
  Roland
