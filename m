Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWACUJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWACUJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWACUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:09:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750932AbWACUJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:09:28 -0500
Message-ID: <43BAD9DF.4090401@redhat.com>
Date: Tue, 03 Jan 2006 15:09:03 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: ASANO Masahiro <masano@tnes.nec.co.jp>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix posix lock on NFS
References: <20051222.132454.1025208517.masano@tnes.nec.co.jp> <43BAD2EC.2030807@redhat.com> <20060103194630.GL19769@parisc-linux.org>
In-Reply-To: <20060103194630.GL19769@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

>On Tue, Jan 03, 2006 at 02:39:24PM -0500, Peter Staubach wrote:
>  
>
>>>	/* No mandatory locks over NFS */
>>>-	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
>>>+	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
>>>+	    fl->fl_type != F_UNLCK)
>>>      
>>>
>>Just out of curiosity, what is this if() statement intended to protect?
>>For locking purposes, why would the client care if the file has the
>>mandatory lock bits set?
>>    
>>
>
>Mandatory locks aren't mandatory for other clients.
>  
>

So?

I guess that I don't understand this response.

The server is responsible for keeping itself from attempting to access
a mandatory lock file.  The client is not responsible for doing so and
trying to help the server is kind of a waste of time, mostly.

The mandatory lock mode bits really only come into play when attempting
to read or write the file.  In this case, the system will automatically
try to take a lock for the process, if that process does not already
have a lock.  The server should prevent itself from trying to access
files like this in order to avoid DoS attacks.

The NFS client does not support mandatory locking, mostly due to the
possibility of DoS attacks and also due to the locking and NFS protocols
not being sufficiently aware of each other.  NFSv4 can be used to address
this latter problem, but probably not the former.

So, why deny lock requests for such files?  Especially on the client?

    Thanx...

       ps
