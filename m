Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbRGXRVc>; Tue, 24 Jul 2001 13:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268378AbRGXRVW>; Tue, 24 Jul 2001 13:21:22 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:23989 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S268377AbRGXRVJ> convert rfc822-to-8bit; Tue, 24 Jul 2001 13:21:09 -0400
Importance: Normal
Subject: Design-Question: end_that_request_* and bh->b_end_io hooks
To: jfs-discussion@oss.lotus.com, reiserfs-dev@namesys.com, andrea@suse.de,
        sct@dcs.ed.ac.uk, linux-kernel@vger.kernel.org,
        mauelshagen@sistina.com
Cc: "Holger Smolinski" <HSmolinski@de.ibm.com>,
        "Horst Hummel" <Horst.Hummel@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF3CC2BFB9.69086721-ONC1256A93.0059C650@de.ibm.com>
From: "Carsten Otte" <COTTE@de.ibm.com>
Date: Tue, 24 Jul 2001 19:20:46 +0200
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 24/07/2001 19:18:55
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi  Folks,

as you are deeper into block-devices & filesystems than me,
here are my two simple questions in short:
Is it legal for a filesystem (or whatever) to install a hook into
bh->b_end_io
which calls generic_make_request?
Do block drivers need or are they allowed to hold the io_request_lock or
other (local)
locks when calling end_that_request_*?

Rational / Explanation:
We encountered a problem with our block device driver (dasd on arch=s390)
together with JFS:
In our bottom half ,we grab the io_request_lock & disable interrupts and
(among
other stuff) call  end_that_request* for finalized requests. Afterwards we
release
the lock and  enable again.
The problem is, that JFS hooks into bh->b_end_io and calls
generic_make_request then.
Note that generic_make_request grabs the io_request_lock, may call schedule
(in __get_request_wait), and may call the do_request function of the block
device driver.
Do you think that this hook is legal (and we have to change the device
driver to
call end_that_request from outside the bottom half -scheduling in
interrupt!- without
holding the io_request_lock)  or does the fs need to be changed?
Do other filesystems (esp. ReiserFS) require or grab the io_request_lock in
their
b_end_io hooks?

Please CC: answers directly me since I do not read the FS-Lists regulary.

mit freundlichem Gruﬂ / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!

