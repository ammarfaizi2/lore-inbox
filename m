Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWELAJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWELAJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWELAJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:09:04 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63676 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750701AbWELAJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:09:03 -0400
Date: Thu, 11 May 2006 18:08:04 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux poll() <sigh> again
In-reply-to: <6bkl7-56Y-11@gated-at.bofh.it>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4463D1E4.5070605@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6bkl7-56Y-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> The bug relates to Linux implementation of poll()
> on a connected socket. If poll() is set to detect
> changes on a connected socket, with an infinite
> timeout (-1), and the client disconnects, it returns
> with a positive value (correct). The returned
> events (revents member), shows only POLLIN bit
> set. This, according to all known documentation
> including man pages on the web, is supposed to
> mean that there are data to be read. In fact,
> there are no data and a read will return 0.

According to the Single UNIX Specification:

http://www.opengroup.org/onlinepubs/007908799/xsh/poll.html

POLLIN means "Data other than high-priority data may be read without 
blocking. For STREAMS, this flag is set in revents even if the message 
is of zero length." The way I read it, all this is telling you is that a 
read on that file descriptor will not block at that particular moment. 
It doesn't mean there is actually any data to be read. On a device like 
a socket, read returning 0 tells you that the connection's been closed.

POLLHUP means "The device has been disconnected." This would obviously 
be appropriate for a device such as a serial line or TTY, etc. but for a 
socket it is less obvious that this return value is appropriate.

> 
> I have used the subsequent read() with a returned
> value of zero, to indicate that the client disconnected
> (as a work around). However, on recent versions of
> Linux, this is not reliable and the read() may
> wait forever instead of immediately returning.

If you want nonblocking behavior, you should set the socket to 
nonblocking. This is a bit strange though, unless the data was stolen by 
another thread or something. Are you sure you've seen this?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

