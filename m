Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132702AbRDQUom>; Tue, 17 Apr 2001 16:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDQUoa>; Tue, 17 Apr 2001 16:44:30 -0400
Received: from bastard.inflicted.net ([216.10.33.10]:61453 "EHLO
	bastard.inflicted.net") by vger.kernel.org with ESMTP
	id <S132678AbRDQUoU>; Tue, 17 Apr 2001 16:44:20 -0400
From: Jesse S Sipprell <jss@inflicted.net>
Date: Tue, 17 Apr 2001 16:44:07 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Jesse S Sipprell <jss@inflicted.net>,
        Jan Kasprzak <kas@informatics.muni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417164407.B21620@bastard.inflicted.net>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <E14pXxg-0002cI-00@the-village.bc.nu> <20010417181524.E2589096@informatics.muni.cz> <20010417161036.A21620@bastard.inflicted.net> <15068.42539.768756.883953@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15068.42539.768756.883953@pizda.ninka.net>; from davem@redhat.com on Tue, Apr 17, 2001 at 01:23:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 01:23:07PM -0700, David S. Miller wrote:

> One more subtle note, for the case of error handling.  There is a
> change to sendfile() in the zerocopy patches which causes sendfile()
> to act more like sendmsg() when errors occur.

How is this likely to affect applications?

Currently, the glibc2.1 sendfile interface looks like:

ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);

On error, -1 is returned in the usual fashion and offset is purported to be
updated to point to the next byte following the last one sent.

Will the zerocopy patches break this?

> 
> Specifically, sendmsg() works roughly like the following when an
> error happens:
> 
> handle_error:
> 	if (sent_something)
> 		return how_much_we_sent;
> 	else
> 		return ERROR_CODE;
> 
> So when an error happens, and the kernel was able to send some of
> the data, you see something like this in the trace:
> 
> 	sendmsg() = N
> 	...
> 	sendmsg() = ERROR_CODE
> 
> sendfile() used to act differently, and this made it difficult to
> directly transform a sendmsg()+local_buffer based server into a
> sendfile() one because the error handling was so different.
> 
> Previously, sendfile() wouldn't give you the partial transfer length,
> you'd just get the error _regardless_ of whether any data was sent
> successfully during that call.  Alexey, myself, and others considered
> this behavior bogus and inconsistent.  So it was changed.
> 
> The long and short of it is that sendfile() now acts just like
> sendmsg() when errors happen mid-send.
> 
> Later,
> David S. Miller
> davem@redhat.com

-- 
"In the event of a failure, the system can be configured to automatically
restart itself.  This feature of Windows NT Server provides maximum system
up-time."  -- Reliability and Fault Tolerance in Windows NT Server, MSC
