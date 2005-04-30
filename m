Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVD3Px1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVD3Px1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVD3Px1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:53:27 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:57331 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261262AbVD3Pwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:52:42 -0400
Message-ID: <42739B26.8080005@austin.rr.com>
Date: Sat, 30 Apr 2005 09:50:14 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu> <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu> <427387FB.4030901@austin.rr.com> <20050430145306.GA22276@fieldses.org>
In-Reply-To: <20050430145306.GA22276@fieldses.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:

>On Sat, Apr 30, 2005 at 08:28:27AM -0500, Steve French wrote:
>  
>
>>Miklos Szeredi wrote:
>>
>>    
>>
>>>>>- network/userspace filesystems should be fine aswell
>>>>>    
>>>>>
>>>>>          
>>>>>
>>>>They should, but again I wonder if NFS with all it's complexity is
>>>>being careful enough with what it accepts from the server.
>>>>  
>>>>        
>>>>
>>it is possible for the client to validate that the
>>server is who it says it is, and both NFSv4 (actually the newer NFS
>>RPC) and CIFS of course allow packet signing which helps, not sure if
>>AFS allows packet signing.
>>    
>>
>
>None of this helps in the situation Miklos is considering, where the
>attacker is a user on the client doing the mount.  So presumably the
>user gets to choose a server under his/her control, and all the
>authentication does is prove to the user that s/he got the right server,
>which doesn't protect the kernel at all.
>
>The only defense is auditing the client code's handling of data it
>receives from the server
>  
>
I agree that periodic auditing of returned data, and testing with 
intentionally corrupted server responses
is necessary and should continue.

But you bring up an interesting point about security policy.    For the 
case of evil user trying to mount
to evil server (e.g. one under evil user's control), in one sense it is 
no different than allowing a user to
mount an evil cdrom or usb storage device with evil contens - a device 
which may contain specially
crafted data (file and directory contents and metadata) designed to 
crash the system, but there is
a difference - for network filesystems the server also can delay the 
responses, throw away
the responses or corrupt the frame headers (this can just as often 
happen due to buggy network
hardware and routers too).  Obviously we need to continue to audit for 
both cases - but it would
not hurt to optionally verify that the server can prove its identity and 
prove that it has been properly
added to a security domain that you trust - ie allow an NFSv4 mount and 
the CIFS mount helper
to be configured/built so that users could only mount to servers that are:
    1) In the clients security domain (ie kerberos realm)
    2) In a trusted domain (realm)
IIRC this is already done for the case of some services such as winbind, 
and I vaguely remember
IBM OS/2 doing this (verifying the server's identity during mount) when 
using Kerberized SMB back in
the early 1990s in the Directory and Security server product.

