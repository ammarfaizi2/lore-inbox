Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWBMQwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWBMQwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWBMQwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:52:11 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:5147 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932227AbWBMQwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:52:10 -0500
Message-ID: <43F0B8FC.6020605@cfl.rr.com>
Date: Mon, 13 Feb 2006 11:51:08 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
References: <m3lkwg4f25.fsf@telia.com> <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
In-Reply-To: <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 16:52:58.0543 (UTC) FILETIME=[F1822BF0:01C630BD]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--17.350000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> The UDF code really seems broken. It fails for new inodes and some
> chown cases, when the mount options are being used. Phillip's patch
> does not look like a complete fix, though, as it will store invalid
> uid/gid (-1) for some cases where we probably should be storing the
> real uid/gid. For example, doing chown <user> when the same user is
> passed as mount option, we'll get -1 on disk, instead of user's uid.
>   

Could you be more specific about what test cases fail?  It worked fine 
for me so far.

Also the storage of -1 id is very much intentional.  Prior to this 
patch, if you mount with uid=yourid then you create a file, it would 
appear to be owned by you.  If you unmounted and remounted the volume 
however, it would suddenly be owned by root.  Clearly that is not 
acceptable. With this patch applied, the file appears to be owned by you 
both before and after the remount.  The actual value written to disk is 
-1, which on a read is translated to the value from the mount option, 
giving the appearance that the file is owned by the user specified in 
the mount, which is the expected behavior. 

Should the desktop user insert this media in another machine where they 
have a different uid ( that is specified in the mount options ) then 
they would still have access to their files, as the -1 will be 
translated to the correct uid on that system. 

Should you chown files to a user other than the one given in the mount 
option, then that actual uid is stored on the disk.  Also if you do not 
specify a uid/gid when you mount, then the actual uid is stored. 
> I think the semantics you want is: "if uid/gid is invalid on disk,
> leave it that way unless we explicitly change it via chown; otherwise
> we can always overwrite it." Hmm?
>   

No, the semantics is if the uid/gid on disk is invalid, then use the id 
specified in the mount options.  That was the case before, however when 
you created new files or chowned files to you ( and you gave your id in 
the mount options ), an id of 0 was written to disk instead.  Now -1 is 
written, which when read, is mapped back to your id specified in the 
mount options. 


