Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbUK3Q5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbUK3Q5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUK3QzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:55:20 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49821 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262196AbUK3Qyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:54:31 -0500
Subject: Block layer question - indicating EOF on block devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: axboe@suse.de, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101829852.25628.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 15:50:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is a block device meant to indicate to the block layer that the read
issued is beyond EOF. For the case where the true EOF is known the
capacity information is propogated into the inode and that is used. For
the case where a read exceeds the known EOF the block layer sets BIO_EOF
which appears nowhere else I can find.

I'm trying to sort out the case where the block device has only an
approximate length known in advance. At the low level I've got sense
data so I know precisely when I hit the real EOF on read. I can pull
that out, I can partially complete the request neatly up to the EOF but
I can't find any code anywhere dealing with passing back an EOF.

Nor it turns out is it handleable in user space because a read to the
true EOF causes readahead into the fuzzy zone between the actual EOF and
the end of media.

Currently I see the error, pull the sense data, extract the block number
and complete the request to the point it succeeded then fail the rest,
but this doesn't end the I/O if someone is using something like cp, and
it also fills the log with "I/O error on" spew from the block layer
innards even if REQ_QUIET is magically set.

