Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVD3ObC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVD3ObC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVD3ObC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:31:02 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:51413 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261236AbVD3Oao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:30:44 -0400
Message-ID: <427387FB.4030901@austin.rr.com>
Date: Sat, 30 Apr 2005 08:28:27 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu> <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:

>>> - network/userspace filesystems should be fine aswell
>>>      
>>>
>>They should, but again I wonder if NFS with all it's complexity is
>>being careful enough with what it accepts from the server.
>>    
>>
That is the fun of trying to get our network filesystems up to the 20th 
century.  There is
at lot more work that has to be done here, but it is gradually 
improving.  At least for cifs
but probably for NFSv4 (and possibly AFS) it is possible for the client 
to validate that the
server is who it says it is, and both NFSv4 (actually the newer NFS RPC) 
and CIFS of course
allow packet signing which helps, not sure if AFS allows packet 
signing.   There does
need to be even more testing in one area though - selective packet 
corruption testing
(which can be done by temporarily modifying the server to inject random 
invalid packet
information on a subset of fields every thousand packets or so) since 
the biggest danger
in network filesystems is the huge variety of servers with different 
server bugs that you have
to be able to workaround.  Working around server bugs is a huge problem with
the client side of networking code.

>>I take that back.  Any filesystem using page cache and allowing shared
>>writable mapping is currently unsafe because of OOM deadlock if
>>mounted from local machine, or simply DoS against client by delaying
>>writeback.
>>
>>So other than FUSE, what's left as safe?
>>
>>Miklos
>>
Don't see how FUSE is that much safer, if you allocate kernel memory at 
all you eventually can create DoS,
and you can not do a filesystem without allocating some kernel memory, 
but it does not seem that easy to
do intentionally.   At least for the CIFS case you can turn off the page 
cache for inode data on a per mount
basis (with the forcedirectio mount flag) if you worry about the server 
intentionally holding up writes. 
Unless the write is past end of file, writes are timed out reasonably 
quickly anyway, and end up
killing the session, which depending on the setting of the hard/soft 
flag probably should result in a page fault.

There is one remaining issue with mount and umount - the user space 
utilities.   By the way who maintains
them these days?   Although the mount utilities allow filesystem 
specific mount and umount helpers
to be placed in /sbin and automatically executed for the matching 
filesystem type, there are a few functions
that belong in common code - in a system library which today have to be 
implemented in every helper
function and of course are implemented in different ways in different 
distros and
different tools with possibility of corruption of the /etc/mtab.   It 
may be that the file /etc/mtab
does not matter and that it needs to go away and everyone needs to look 
at /proc/mounts instead, but
in the meantime /etc/mtab can easily get out of sync with the actual 
list of mounts, although that
usuallly does not prevent unmount from working it may be confusing.   
The basic problem is that the
"lock the mtab / add a new line to it / unlock" is not available in an 
exported function (alternatively if
lock and unlock mtab functions were exported that would help) and 
similarly with umount.there
is no "safely remove the matching line from mtab" -  Looking at the 
mount utils and various mount helper
functions it looks like you can not make any assumptions about the name 
of the lock file used to protect
mtab (I am not even sure that you can guarantee that /etc/mtab is a 
file, or even a symlink).  
the lock file used to lock the mtab
