Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSJQTeq>; Thu, 17 Oct 2002 15:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262021AbSJQTeq>; Thu, 17 Oct 2002 15:34:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7587 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261583AbSJQTeo>;
	Thu, 17 Oct 2002 15:34:44 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Stress testing cifs filesystem
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFEC9BD9C9.68C35D7B-ON87256C55.00699285@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Thu, 17 Oct 2002 14:39:24 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/17/2002 01:40:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some observations about what to expect when fs stress testing against the
CIFS filesystem.

The NFS connectathon tests seem to work against CIFS at least until the end
when one of the final (optional) tests fails in which it tries to delete an
open file (this is not allowed with CIFS servers - don't know a way around
this yet but I have a few ideas that might work against Windows servers but
not Samba).

Windows servers do not support chmod/chown/chgrp easily using the CIFS
network protocol so the basic/test4 test has to be commented out in the NFS
test script.  In theory these chmod/chown/chgrp ops could be done remotely
(sort-of) using Windows ACLs but there is more code to write for this and
it is a fairly esoteric part of the protocol which requires some more
experimentation.   Also note that the cifs vfs memory mapping code is
disabled until oplock handling is more complete so I compile the nfs
connectathon tests with memory mapping disabled.

Samba does support chmod/chgrp/chown so, unlike against Windows servers,
the connectathon nfs tests run unaltered but only if the "unix extensions"
smb.conf parm is on in the server's smb.conf file and also the "delete
readonly" parm is on (deleting read-only files is tested late in the nfs
tests).  Note that  if you have an access mask specified on the server
(optional parms in smb.conf) it can make chmod generate less permission for
chmod than testcases might expect so best not to set an access mask on your
test shares while running the testcase.

The fsx file system stress testing also runs against the CIFS VFS to either
Windows or Samba servers (if -W -R options are specified when launching the
fsx test in order to disable memory mapping) although I am not sure that I
have ever been patient enough to run it all the way until the end.    I
have tried the newer versions of LTP as well and have not found any
problems so far but have not run all the way through every test on the
current code but plan to.  I would like to find a test that tests more
esoteric combinations of open flags, multiply opening the same files from
the same process as well as from multiple processes on both the same and
different machines.   Not all remote filesystems pass through every open to
the remote target server (always restricting multiple opens of the same
file to a single network file open) but in file systems like the cifs vfs
that do, it would be nice to exhaustively test this useful feature.   It
will be especially useful when testing oplock (distributed file caching) to
do multiple conflicting and non-conflicting opens of the same files from
both the same and different clients simulataneously.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


