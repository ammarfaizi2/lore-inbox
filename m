Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVDYTWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVDYTWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVDYTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:15:43 -0400
Received: from [194.90.79.130] ([194.90.79.130]:42256 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262740AbVDYTLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:11:21 -0400
Message-ID: <426D40D4.8050900@argo.co.il>
Date: Mon, 25 Apr 2005 22:11:16 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
References: <20050425170259.GA36024@dspnet.fr.eu.org>
In-Reply-To: <20050425170259.GA36024@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2005 19:11:17.0155 (UTC) FILETIME=[8E6B5F30:01C549CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:

>I have a problem with the iscsi driver (both 4.x and 5.x) and scsi
>tape I'm not sure how to solve.  It may linked to some specific
>characteristics of the tg3 network driver.
>
>What happens is, from what I can trace:
>1- st alloc_pages a bunch of pages for buffering
>
>2- st sends a bunch of them to iscsi for writing (32K is common when
>     labelling a tape for instance)
>
>3- iscsi sends whatever header is needed followed by the data using
>     tcp_sendpage
>
>4- tcp_sendpage copies from of the pages but get_page() others,
>     probably depending on the state of the socket buffer.  It returns
>     immediatly anyway, leaving some pages with an elevated count (which, I
>     guess, it will eventually decrement again)
>
>5- iscsi returns to st
>
>6- st reuses the buffer immediatly, and/or frees it if the device is
>     closed.  Silent corruption in one case, bad_page in __free_page_ok
>     called from normalize_buffer in the other.
>
>I'm going to complete my traces to be sure that's really what's going
>on (I don't have a log immediatly after sendpage yet).  But in any
>case, what would the solution be?
>
>  
>
you need a completion to tell you when your buffer has been sent. you 
can use the kiocb parameter to tcp_sendmsg, as it has a completion. 
however, tcp_sendmsg does not appear to use it.

in effect, you need tcp aio, but the mainline kernel does not support it 
yet.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

