Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWGMSWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWGMSWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWGMSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:22:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:14935 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030270AbWGMSWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:22:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=k24iobgkioq8SFt9dne8tnSJioJcnMp4EbOnwGYisyEEGjIGm5KIFtYVZAX98zybvnSLSQuJhirv/EAY0aO+QNk88Nclco9cdc1t/yozKV01RijZsreIngca4KjAlQ+NmEChALvlFtt2oTBzos3NxKRP5SIIMGDNUp4LnwHLA/o=
Date: Thu, 13 Jul 2006 20:22:20 +0200
From: Janos Farkas <chexum+dev@gmail.com>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: nfs problems with 2.6.18-rc1
Message-ID: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I recently updated two (old) hosts to 2.6.18-rc1, and started noticing
weird things with the nfs mounted /home s.

I frequently face EACCESs where a few minutes ago there wasn't any
problem, and after a retry everything does work again.

An example that easily trips it is keeping mutt open
on a single mailbox file (strace -tt| grep stat):

20:04:08.393815 stat64("mailbox", {st_mode=S_IFREG|0600, st_size=401000, ...}) = 0
20:08:41.859168 stat64("mailbox", {st_mode=S_IFREG|0600, st_size=401000, ...}) = 0
20:09:30.975876 stat64("mailbox", 0xbfe8966c) = -1 EACCES (Permission denied)

This results in a bit scary "Mailbox was corrupted!" message, but
otherwise harmless.  Reopening the mailbox succeeds immediately.

A sample session with an rsync session updating files on the nfs mounted
/home/:

-----
> rsync...
receiving file list ... done
file1
rsync: close failed on "/home/path/.file1.UgEmSh": Permission denied (13)
rsync error: error in file IO (code 11) at receiver.c(628) [receiver]
rsync: connection unexpectedly closed (2490 bytes received so far) [generator]
rsync error: error in rsync protocol data stream (code 12) at io.c(471) [generator]
> rsync...
receiving file list ... done
rsync: recv_generator: failed to stat "/home/path/file2": Permission denied (13)
rsync: recv_generator: failed to stat "/home/path/file3": Permission denied (13)
rsync: recv_generator: failed to stat "/home/path/file4": Permission denied (13)
rsync: recv_generator: failed to stat "/home/path/file5": Permission denied (13)
rsync: recv_generator: failed to stat "/home/path/file6": Permission denied (13)
rsync: recv_generator: failed to stat "/home/path/file7": Permission denied (13)
-----

I also think this is related in the dmesg.  Think, because there's no
other trace of any "read error" on the disks, and the comments in
mm/filemap.c (but the message is not that much help to be sure of this).

Reducing readahead size to 28K
Reducing readahead size to 4K
Reducing readahead size to 28K
Reducing readahead size to 4K
Reducing readahead size to 28K
Reducing readahead size to 4K
Reducing readahead size to 0K

The relevant part of the /proc/mounts file:

-----
automount(pid1831) /home autofs rw 0 0
HOST:/export/PATH /home/path nfs rw,vers=3,rsize=8192,wsize=8192,hard,intr,nolock,proto=udp,timeo=7,retrans=3,sec=sys,addr=HOST 0 0
-----

How can I help with tracing this?  git bisecting on these machines takes
at least an hour per step, (and no reasonable connectivity either to
compile elsewhere much quicker).

Janos
