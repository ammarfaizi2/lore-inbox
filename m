Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVAQHjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVAQHjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVAQHjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:39:48 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:35286 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262721AbVAQHjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:39:42 -0500
Message-ID: <41EB6CAC.13F321FC@akamai.com>
Date: Sun, 16 Jan 2005 23:43:40 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<pid>/maps API addition - seek to address
References: <1105933726.31917.50.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:

> It would be terribly useful to have some way of
> lseeking /proc/<pid>/maps to the entry of a particular address.  So, if
> you want to find the information about a mapping containing address
> 0x12345678, it would set the file position to (say) the entry of
> 0x12000000-0x20000000.
>
> I haven't looked at how /proc/<pid>/maps is implemented these days; is
> this outright hard, or relatively straightforward?  This wouldn't be
> very useful if it had to actually generate all the output up to the
> desired point, but it would be a boon if it could short-circuit that.  I
> guess the interactions with normal lseek might be tricky (but perhaps
> that could be put off until you actually use lseek, if ever).

 We can do lseek to any position  with SEEK_CUR or SEEK_SET.
That position is byte position, not  map number or map address.
Changing byte position with lseek generates all the output upto the
desired point  inside the kernel using seq  traverse().  Moreover records
are not of fixed lengths.  But given the adress,   finding the page can be
short  circuited (find_vma()  finds it in O(log n) time).  There is no API
 from user.  Changing the semantics of lseek to  other  than byte position
does not look  right.

>
> Alternatively, any other API for finding the properties of page X would
> be useful, but this seemed like a nice incremental extension of the
> existing interface.

Yes, Proc files do not implement ioctl method.  I guess we can add
this feature as ioctl on  /proc/pid/maps file, if  everyone agrees  that is right.

One of the following methods.
ioctl (fd,  GET_MAP,  address,  buf)  -  Does not interfere with lseek
or read.  Find it and copy it.
   OR
ioctl (fd,   SET_FPOS,  address)  - Changes the file position to the
byte position of the map corresponding to address, and next read
returns the data from that position.  Once the adress is found,  this
needs generating all the data upto  that address similar to lseek. If
we convert maps to fixed length records,  it would be better, but
still  needs to find how many records were before this record.


Thanks,
Prasanna.



