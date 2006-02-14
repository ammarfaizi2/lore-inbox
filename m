Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWBNPzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWBNPzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBNPzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:55:36 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:40902 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964823AbWBNPzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:55:35 -0500
Message-ID: <43F1FD39.1040900@cfl.rr.com>
Date: Tue, 14 Feb 2006 10:54:33 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
References: <m3lkwg4f25.fsf@telia.com> <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com> <43F0B8FC.6020605@cfl.rr.com> <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 15:56:45.0710 (UTC) FILETIME=[418E72E0:01C6317F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14267.000
X-TM-AS-Result: No--11.800000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> I don't haven an UDF partition to test on so I am only reading the code. 
> With your patch, every time an in-memory inode has the same uid/gid as the 
> one you passed as mount option, the id on disk will become -1, no? So for 
> example, doing chown 100 for a file writes -1 to disk if you passed 100 
> as uid mount option. Am I missing something here?
>
>   
That is exactly correct. 

> Yes, I agree that the current code is broken. I was talking about what the 
> semantics should be and that your patch doesn't quite get us there. Do you 
> disagree with that? The UDF specification I am looking at [1] says that -1 
> is used by operating systems that do not support uid/gid to denote an 
> invalid id (although ECMA-167 doesn't seem to have such rule), which is  
> why I think it's an bad idea for Linux to ever write it on disk. Instead, 
> we should always write the proper id on disk unless it was invalid in the 
> first place and we did not explicity change it (via chown, for example).
Sometimes you DON'T want a valid UID written to the disk.  In the case 
of a typical desktop user, there is only one uid that is ever going to 
access the disk, but that uid may be different on each computer, even 
though it's the same person.  Thus they want to be able to take the disc 
from computer to computer, and have access to their files.  Since the 
existing uid/gid override mount options only apply if the on disk id is 
-1, it seemed a simple and appropriate thing to store -1 in the case 
where the id matches the mount option.  The only use case that this 
patch changes is where the id matches the mount option.  In that case, 
the user expected behavior is for the files on the disc to appear to be 
owned by the specified uid, with the added benefit that this will hold 
true if you remount with another uid specified, possibly even on another 
machine.  This seems to meet user expectations much better than the 
previous behavior of changing ownership to root when unmounted. 

If you want real IDs to be stored, then do nothing.  Simply continue to 
use the system just like before, where you did not specify a uid as a 
mount option. 


