Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVKJQyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVKJQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVKJQyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:54:09 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:14011 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750894AbVKJQyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:54:07 -0500
Subject: Re: [PATCH 1/2] handling 64bit values for st_ino]
From: Steve French <smfltc@us.ibm.com>
To: linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org, jra@samba.org, tridge@samba.org,
       staubach@redhat.com
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1131641444.2281.20.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Nov 2005 10:50:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
>*However*, there's an area where we have a problem: stat64() and
>getdents64() _could_ return 64bit st_ino/d_ino just fine, if not for having
>too narrow field in kstat and argument of filldir_t. As it is, we have
>->getattr() fill struct kstat and the syscall proper copy the contents of
>that struct kstat into user buffer.  stat64 has 64bit st_ino; kstat
>field used to set it is only unsigned long.
> Note that it's not just a theory - there are filesystems that
> want 64bit values in st_ino (AFS, for one).  There are consumers of
> these values ready to deal with 64bit values - aside of aforementioned
> syscalls, e.g. NFSv3 and NFSv4 are happy with those

The SMB/CIFS networking protocol also returns 64 bit "UniqueIDs" which 
are similar to inode numbers and thus CIFS client (and presumably Samba
server) would benefit slightly .   This is not just the case for use of 
the core CIFS protocol which Windows and various NAS appliances support but 
also for mounts to Samba, HP etc. and servers which support the SNIA CIFS 
Unix Extensions  (struct FILE_UMIX_BASIC_INFO defines the inode number
returned over the wire as 64 bit).

The only problem with cifs using such numbers (instead of locally generated
but unique transient inode numbers) is that servers are allowed
to export above the top of a local mount - therefore it is hard, although
I believe possible, for the client to detect when it is crossing between 
two different partitions on the server as it traverses a directory tree
and thus possible that one export could report two inodes with the same
inode number, although different devices, if the server administrator chose
to configure their exports (shares) that way).  Support for DFS (transparent
referrals from one directory to one or more UNC names) on more clients
such as cifs would make it easier for server administrators because there
would be less need to export shares that high up in the server's directory tree.


