Return-Path: <linux-kernel-owner+w=401wt.eu-S964784AbXADLw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbXADLw7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 06:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbXADLw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 06:52:59 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:24172 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964784AbXADLw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 06:52:58 -0500
Message-ID: <459CEA93.4000704@tls.msk.ru>
Date: Thu, 04 Jan 2007 14:52:51 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: open(O_DIRECT) on a tmpfs?
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder why open() with O_DIRECT (for example) bit set is
disallowed on a tmpfs (again, for example) filesystem,
returning EINVAL.

Yes, the question may seems strange a bit, because of two
somewhat conflicting reasons.  First, there's no reason to
use O_DIRECT with tmpfs in a first place, because tmpfs does
not have backing store at all, so there's no place to do
direct writes to.  But on another hand, again due to the very
nature of tmpfs, there's no reason not to allow O_DIRECT
open and just ignore it, -- exactly because there's no
backing store for this filesystem.

Why I'm asking is:  Currently I'm trying to evaluate a disk
subsystem for large loaded database (currently running with
Oracle, but there's no reason not to try Mysql or Postgres -
the stuff below equally applies to any database).

Almost any database uses two different I/O patterns for two
different kinds of files.  They are - regular data files, with
mostly random relatively large-block I/O, and control+redolog
files, which are small and receives very many relatively small
updates.

The same two kinds of load (large random I/O and small I/O)
applies to any journalling filesystem too, and even to linux
software raid devices.

I was thinking about trying to place those small redolog files
which receives alot of small updates to a battery-backed RAM.
The reason is simple: with fast I/O subsystem (composed of many
spindles, nicely distributed and so on), those redo-log files,
which can not be distributed, becomes real bottleneck.

But since such devices - battery-backed RAM - are relatively
expensive, I want to see how it works BEFORE buying a real
device.  So I just placed the redo-log files into a tmpfs,
because that's the most close "alternative", and tried to
start a database.  And it failed.

Failed because it rightly tries to open all the files with
O_DIRECT flag set, including control and redolog files.  And
tmpfs returns EINVAL.

Ok, I was able to work around this.. "issue" by creating a
loop device on a file residing on a tmpfs, creating a filesystem
on it and placing my files there.

But the original question remains...  Why tmpfs and similar
filesystems disallows O_DIRECT opens?

Thanks.

/mjt
