Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVAOCVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVAOCVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVAOCVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:21:21 -0500
Received: from palrel12.hp.com ([156.153.255.237]:20156 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262143AbVAOCVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:21:12 -0500
Date: Fri, 14 Jan 2005 18:21:02 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
To: schwidefsky@de.ibm.com, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: sparse warning, or why does jifies_to_msecs() return an int?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the following warning from sparse:

include/linux/jiffies.h:262:9: warning: cast truncates bits from constant value (3ffffffffffffffe becomes fffffffe)

it took me a while to realize that this is due to
the jiffies_to_msecs(MAX_JIFFY_OFFSET) call in
msecs_to_jiffies() and due to the fact that
jiffies_to_msecs() returns only an "unsigned int".

Is there are a good reason to constrain the return value to 4 billion
msecs?  If so, what's the proper way to shut up sparse?

On a related note, there seem to be some overflow issues in
jiffies_to_{msec,usec}.  For example:

	return (j * 1000) / HZ;

can overflow if j > MAXULONG/1000, which is the case for
MAX_JIFFY_OFFSET.

I think it would be better to use:

	return 1000*(j/HZ) + 1000*(j%HZ)/HZ;

instead.  No?

	--david
