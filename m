Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbUKTGs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbUKTGs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKTGs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:48:29 -0500
Received: from dp.samba.org ([66.70.73.150]:16549 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261525AbUKTGsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:48:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16798.59519.63931.494579@samba.org>
Date: Sat, 20 Nov 2004 17:47:27 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419ECAB5.10203@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<419ECAB5.10203@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

 > can you describe qualitatively what your test does?

The access patterns are very similar to dbench, which I believe you
are already familiar with. Let me know if you'd like an explanation of
dbench.

For the test I ran, the basic load file is almost the same as dbench,
but the interpretation of the load file is a little bit different.

For example, when the load file says "open a file", Samba4 needs to
first stat() the file, and if xattrs are being used then it needs to
do a fgetattr() to grab the extended DOS attributes. Additionally, if
the open has the effect of changing any of those attributes then
Samba4 needs to use fsetxattr() to write back the extended attributes,
and sometimes fchmod() and utime() as well depending on the open
parameters.

When dbench interprets one of these load files it would just call
open(), skipping all the extra system calls.

The full load file I used is at:

  http://samba.org/ftp/tridge/dbench/client_enterprise.txt

and is based on a capture of a "Enterprise Disk Mix" Netbench run,
captured using the "nbench" load capturing proxy module in Samba4,
using a Win2003 server backend and WinXP client.  

The working set size is approximately 20 MByte per client, and I was
testing with 10 simulated clients. That means its very much a "in
memory" test, as the machine has 2G of ram.

 > You didn't answer whether it does fsyncs, etc.

I think I did mention that the test does no fsync calls in the
configuration I used. The reason I qualify the answer is that the load
file actually contains approximately 1% Flush calls, but in its
default configuration these are noops for Samba4. This is due to the
confusion in Win32 between a "flush" operation and a "fsync"
operation. Microsoft programmers use "flush" like a unix programmer
would use fflush() on stdio, which is a noop for Samba. You can also
configure Samba to treat flush as a "fsync", which is quite a
different operation.

The operation mix is as follows, listed with the approximate posix
equivalent operation.

(27%) ReadX                    (==pread)
(17%) NTCreateX                (==open)
(16%) QUERY_PATH_INFORMATION   (==stat)
(13%) Close                    (==close)
(9%)  WriteX                   (==pwrite)
(6%)  FIND_FIRST               (==opendir/readdir/closedir)
(3%)  Unlink                   (==unlink)
(3%)  QUERY_FS_INFORMATION     (==statfs)
(3%)  QUERY_FILE_INFORMATION   (==fstat)
(1%)  SET_FILE_INFORMATION     (==fchmod/utime)
(1%)  Flush                    (==noop)
(1%)  Rename                   (==rename)
(0%)  UnlockX                  (==fcntl unlock)
(0%)  LockX                    (==fcntl lock)

but the above can be a little misleading, as (for example) NTCreateX
is a very complex call, and can be used to create directories, create
files, open files or even delete files or directories (using the
delete on close semantics).

 > It might be worth testing it with the extents only mount option for
 > reiser4.

My apologies if I have just missed it, but I can't see an option that
looks like "extents only" in either reiser4_parse_options() or in
Documentation/filesystems/reiser4.txt in 2.6.10-rc2-mm2. Can you let
me know the exact option name?

Cheers, Tridge
