Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbULMTnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbULMTnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbULMTjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:39:17 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:49564 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262277AbULMSca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:32:30 -0500
Message-ID: <41BDE0B4.6020003@austin.rr.com>
Date: Mon, 13 Dec 2004 12:34:28 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cliff white <cliffw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org>
In-Reply-To: <20041213092057.5bf773fb.cliffw@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white wrote:

>On Mon, 13 Dec 2004 10:56:45 -0600
>Steve French <smfrench@austin.rr.com> wrote:
>
>  If only someone could roll all of the key fs tests into a set of 
>scripts which could generate one regularly updated set of test status 
>chart ... one for each of XFS, JFS, ext3, Reiser3, CIFS (against various 
>servers, Samba version etc), NFSv2, NFSv3, NFSv4 (against various 
>servers), AFS but that would be a lot of work (not to run) but the first 
>time writing/setup of the scripts to launch the tests in the right order 
>since some failures may be expected (at least for the network 
>filesystems) due to hard to implement features (missing fcntls, dnotify, 
>get/setlease, differences in byte range lock semantics, lack of flock 
>etc.) and also since the most sensible NFS, AFS and CIFS tests would 
>involve more than one client (to test caching/oplock/token management 
>semantics better) but no such fs tests AFAIK exist for Linux.
>  
>
>
>We ( OSDL ) would be very interested in this sort of testing. We have some fs tests
>wrappered currently
>cliffw
>OSDL
>  
>

Generally what I wanted to see was:
1) at least one little endian and one big endian client to run the tests 
on (and for the network filesystems, at least one server).
2) execute a set of similar tests on each of the filesystems (for our 
Samba purposes e.g. ext3, xfs, jfs are particular important, and cifs 
and might as well run on nfsv3, nfsv4)
- fsx on each (specify an operation count of n=10000 should be sufficient)
- fsstress with at least 100 processes on each, with at least 2 loops, 
200 ops
- "connectathon nfs" tests on each. The local filesystems should all be 
able to pass these.
- for cifs to Windows servers, there is one of the "special" subcategory 
of tests that has to be skipped (since Windows server can not support 
the operation)
- and for cifs locktests 7 and 10 are expected to fail at this time
- dbench

There are others that can be run but they don't seem to broaden it much. 
What is very important to add into the mix - based on defects I have 
seen in various network and cluster filesystems over the past few years 
- are something similar to the following:
- Add a test which hits the three Linux specific fcntls (dnotify, set 
and get lease)
- Add a test which uses O_DIRECT open flag (could also simply use the 
mount flag for those filesystems which support that). NFS guys made 
trivial mod to fsx for this and ran with fsx -W -R (to disable mmapping 
when running with direct i/o)
- Add a test which exercises flock to the mix
- Add a maximum and minimium path name and path component test
- Add a test of creating directories with very large number of entries 
(cthon "basic" subtests can be easily modified for this).
- Add a test which does sendfile with data integrity checking from one 
process and a mix of normal and mmapped writes and reads from another 
set of processes
- Add a test of data integrity to the same network fs from multiple clients
- Add a test for stable nanosecond (or 100 nanosecond which is good 
enough for the network case) timestamps (ext2 and ext3 will fail this 
since they round timestamps down to the second when inode metadata is 
written out)
- A better test for the various O_ flags and file modes (especially 
important to run from multiple clients)
- A better byte range locking functional test
- xattr testing (maximum, minimum sizes, illegal requests, bad user 
buffers etc.) There is an xattr testcase in the ltp but have not 
analyzed it enough to see if it will do
- POSIX ACL testing (getfacl/setfacl)
- Trusted and Security attribute testing (to make sure the FS properly 
handles long attributes and/or values, short attributes and/or values, 
bad buffers etc.)

