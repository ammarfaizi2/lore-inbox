Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVISVEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVISVEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVISVEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:04:07 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:11196 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932685AbVISVEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:04:05 -0400
Message-ID: <432F2684.4040300@austin.rr.com>
Date: Mon, 19 Sep 2005 15:58:44 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ctime set by truncate even if NOCMTIME requested
References: <432EFAB1.4080406@austin.rr.com> <1127156303.8519.29.camel@lade.trondhjem.org>
In-Reply-To: <1127156303.8519.29.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>It is quite correct for the kernel to request that the filesystem set
>ctime/mtime on successful calls to open(O_TRUNC).
>  http://www.opengroup.org/onlinepubs/009695399/toc.htm
>  
>
I agree that it is correct to set ctime/mtime here, just not convinced 
it it worth setting it twice which is what will happen for non-local fs.

client truncate -> client setattr(for both size and ctime) -> server 
setattr (which will have a sideffect of ctime to be set on the server, 
not just the change to file size) and then another call to the server to 
set the ctime (which will end up setting ctime twice - one to the 
(correct) server's time and once to the less correct client's time.

Problem is I can't tell the difference inside the fs between the case of 
an application that needs to set ctime explicitly to something different 
than the server would want (e.g. presumably the touch utility) and 
something which can be ignored.    I noticed this when I found a server 
(windows me) that was returning an error for setting timestamps - and 
this was causing errors to be returned to truncate.  In this case 
(server refusing to let the client fs (re)set the timestamps), I would 
like to return an error on touch, but succeed on truncate but I don't 
see a way to tell the difference reliably.
