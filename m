Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUCVNHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 08:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUCVNHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 08:07:35 -0500
Received: from fep22-0.kolumbus.fi ([193.229.0.60]:25940 "EHLO
	fep22-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261951AbUCVNHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 08:07:32 -0500
Message-ID: <023001c4100e$c550cd10$155110ac@hebis>
From: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
Date: Mon, 22 Mar 2004 15:08:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have written the InnoDB backend to MySQL. Some notes on the fsync()
processing problem:

1. It is dangerous for a database if fsync'ed files are physically written
to the disk in an order different from the order in which the fsync's were
called on them. In a power outage this can cause database corruption.

For example, a database must make sure that the log file is written to the
disk at least up to the 'log sequence number' of any data page written to
disk. Thus, we must first write to the log file and call fsync() on it, and
only after that are allowed to write the data page to a data file and call
fsync() on the data file.

2. An 'atomic' file write in the OS does not solve the problem of partially
written database pages in a power outage if the disk drive is not guaranteed
to stay operational long enough to be able to write the whole page
physically to disk. An InnoDB data page is 16 kB, and probably not
guaranteed to be any 'atomic' unit of physical disk writes. However, in
practice, half-written pages (either because of the OS or the disk) seem to
be very rare.

3. Jeffrey Siegal wrote to me that he checked a few disk drives if they
support a cache flush. Some of them did, others did not. If the disk drive
does not support a cache flush, then the only way to do a proper fsync is to
configure it not to cache writes at all. Though, in some drives even the
non-cache configuration option may be missing.

Best regards,

Heikki Tuuri
Innobase Oy
http://www.innodb.com

...........
List:       linux-kernel
Subject:    Re: True  fsync() in Linux (on IDE)
From:       Peter Zaitsev <peter () mysql ! com>
Date:       2004-03-20 19:48:23
Message-ID: <1079812102.3182.31.camel () abyss ! local>
[Download message RAW]

On Sat, 2004-03-20 at 02:20, Jamie Lokier wrote:
> Peter Zaitsev wrote:
> > If file system would guaranty atomicity of write() calls (synchronous
> > would be enough) we could disable it and get good extra performance.
>
> Store an MD5 or SHA digest of the page in the page itself, or elsewhere.
> (Obviously the digest doesn't include the bytes used to store it).
>
> Then partial write errors are always detectable, even if there's a
> hardware failure, so journal writes are effectively atomic.

Jamie,

The problem is not detecting the partial page writes, but dealing with
them.   Obviously there is checksum on the page (it is however not
MD5/SHA which are designed for cryptographic needs) and so page
corruption is detected if it happens for whatever reason.

The problem is you can't do anything with the page if only unknown
portion of it was modified.

Innodb uses sort of "logical" logging which   just says something like
delete row #2 from page #123, so if page is badly corrupted it will not
help to recover.

Of course you can log full pages, but this will increase overhead
significantly, especially for small  row sizes.

This is why solution now is to use  long term "logical" log and short
term "physical" log, which is used by background page writer, before
writing pages to their original locations.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

