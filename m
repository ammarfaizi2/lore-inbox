Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVITCVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVITCVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 22:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVITCVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 22:21:42 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:51662 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S964843AbVITCVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 22:21:41 -0400
Message-ID: <432F70EF.9010100@austin.rr.com>
Date: Mon, 19 Sep 2005 21:16:15 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       samba-technical@lists.samba.org
Subject: Re: ctime set by truncate even if NOCMTIME requested
References: <432EFAB1.4080406@austin.rr.com> <1127156303.8519.29.camel@lade.trondhjem.org> <432F2684.4040300@austin.rr.com> <1127165311.8519.39.camel@lade.trondhjem.org> <432F5968.1020106@austin.rr.com> <1127180199.26459.17.camel@lade.trondhjem.org>
In-Reply-To: <1127180199.26459.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>
>However if you know the cases where time is set implicitly by the
>server, why can't you simply optimise away the ATTR_CTIME and/or
>ATTR_MTIME?
>
>  
>
I don't see any case other than explicit application calls on the client 
to utime in which we would ever want the client to send its timestamp to 
the server.

The cases that have to be checked for for the cifs client case are few - 
setting the file size (truncate/ftruncate) and chmod/chown (which sets 
CTIME on the client, not just the setting the mode) and in my traces 
they do look different in setattr than calls to setattr that come 
through utimes.  For example, it probably is safe to assume that ctime 
never has to be sent to the server when also one or more of the the 
mode, owner or size is being set - and no other user space application 
(just via the  truncate system call) would ever call notify_change 
(setattr) for both size and time, but it does make me nervous to throw 
away any request to update the timestamps remotely if the size is also 
changing (the change of the file size does need to go to the server).   
It does seem like
    utime(filename, timeval)
may be the only time we want to send time changes to the server but I am 
not certain how risky such an approach  is even after scanning fs/open.c 
to ignore time changes except when both ATIME/MTIME/CTIME are set at the 
same time (as they are in sys_utime and do_utimes).   Most people 
probably don't care if the server and client clocks are not too far off, 
but it does affect performance (presumably even noticeable on something 
like fsx test)
