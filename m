Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbUKKQph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUKKQph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUKKQph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:45:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15783 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262281AbUKKQpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:45:30 -0500
Subject: Re: Oops with CIFS (2.6.10-rc1-BK)
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cifs-client@lists.samba.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1100191367.16432.106.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2004 10:42:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mounted the share with -t cifs. the share was mounted successfully, i
> could use it and then the oops occured. i could not
> reproduce it up to now but i thought perhaps the output
> could be useful somehow. here it goes:
>
> http://nerdbynature.de/bits/prinz/cifs/dmesg.txt
> http://nerdbynature.de/bits/prinz/cifs/config.txt

Oops is in cifs_readdir, a routine which has a set of problems which
require a substantial rewrite which is taking me far more time than I
expected (partly due to time spent debugging on various unrelated Samba
server issues).

Since the new readdir code is quite different, I would like to try it on
the new code when it is closer to ready to merge.  The two big issues
being addressed are:
1) removing the convert-file-name-in-place approach in that routine
which is a very bad idea for various Asian code pages especially for
long file names.
2) working around the netapp server issue (handling illegal values for
the field last search entry in buffer)
3) make configurable calling new_inode for entries during findfirst. 
Although this saves a lot of time and a huge amount of network traffic
when the client follows up immediately by calling lookup - there are a
few cases in which this is slower than only calling new_inode when doing
the lookups (SMB QPathInfo)
4) Add support for SMB FindFirst level 261 (which returns a unique
number somewhat similar to an inode number) for servers which do not
have protocol support the SNIA CIFS Unix Extensions but do have support
for this new infolevel (introduced in WindowsXP, also in Samba,
Windows2003 and other servers and appliances now).  This allows stable
inode numbers to be returned from the server (even if the server does
not support the Unix Extensions), and makes it easier to identify
hardlinked files across the network, a requirement for some
applications.

