Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268117AbRGZPm5>; Thu, 26 Jul 2001 11:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268107AbRGZPmp>; Thu, 26 Jul 2001 11:42:45 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:34061 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268119AbRGZPmb>; Thu, 26 Jul 2001 11:42:31 -0400
Message-ID: <3B603BEC.CF55FEAB@zip.com.au>
Date: Fri, 27 Jul 2001 01:49:00 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> <E15PlYr-0003mr-00@the-village.bc.nu> <20010726163223.Q17244@emma1.emma.line.org>,
		<20010726163223.Q17244@emma1.emma.line.org> <0107261731550N.00907@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips wrote:
> 
> Ext3 does *not* leave a
> lot of dirty blocks hanging around in normal operation, so sync is not
> nearly as slow as it is with good old Ext2.

eek.

In fully-journalled data mode, we write everything to the journal
in a linear chunk, wait on it, write a commit block, wait on that
and then release all the just-journalled data into the main
filesystem for conventional bdflush/kupdate writeback in twenty
seconds time.

Calling anything which uses fsync_dev() would cause all that writeback
data to be written out and waited on, with the consequential seeking
storm.  Disastrous.

Note that fsync() is OK - in full data journalling mode nothing
is ever attached to i_dirty_buffers.

-
