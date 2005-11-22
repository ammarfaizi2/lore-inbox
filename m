Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVKVQkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVKVQkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVKVQkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:40:12 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:28570 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S964992AbVKVQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:40:10 -0500
Message-ID: <438349E5.20103@austin.rr.com>
Date: Tue, 22 Nov 2005 10:40:05 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CIFS emulated mode bits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VALETTE Eric RD-MAPS-REN wrote:

> Steve French wrote:
>  
>
>> VALETTE Eric RD-MAPS-REN wrote:
>>
>>   
>>
>>> Steve French wrote:
>>>     
>>
>> let me know if your cat example works when mounted
>> with the relatively new "noperm" mount option on the client.   At least
>> then we will know whether we are looking at a problem with access
>> control on the server (ntfs acls) or client (unix mode bits and the
>> .permission entry point)
>>   
>
>
> Works with the "noperm" mount option.
>
> --eric
>
>  
>
OK - That is good, should be relatively easy to debug from here.

To explain what is going on, here is some obvious background.    Windows 
uses a rich ACL model locally and over the network via CIFS (other 
protocols such as NFSv4 now do something similar) and Windows of course 
does not have really have or need Unix mode bits ... and the server 
(unlike Samba and those that implement the standard SNIA CIFS Unix 
extensions) does not return emulated mode bits (although it does locally 
in Windows "services for Unix" and of course also cygwin does something 
similar) ... so the cifs  client has to approximate mode bits.    If the 
client makes an incorrect approximation you can get access denied on a 
client side permission check.   Of course some would argue that for 
clients that are running as single user desktop clients the client does 
not need to do perm checks (the server does ACL checks) so just turn off 
the client permission checks - that is why the "noperm" option is 
available on the cifs client.

So the choices today are:

1) Turn off mode bit checking (on the client) on a particular cifs mount 
(noperm mount option)
or
2) pass in a default mode and uid or gid on the cifs mount that matches 
what you want (otherwise cifs will use the uid of the mounter, and a 
default mode).  Although cifs caches the mode bits in the inode if they 
are modified by an app on the client e.g. via chmod (while the inode 
stays in memory on the client) - for querying (lookups/stat) on existing 
files cifs can only use the +R dos attribute to distinguish when to 
return something other than 0777 (or the default).
or
3) turn on the "sfu" mount option on the client and let cifs make the 
(more expensive) queries to the server for mode information the same way 
that "services for unix" would.   This does not work for all mode bits 
yet, as it requires additional CIFS ACL support to be coded, but it does 
now work for the 3 bits above 0777 (as of just after 2.6.15-rc2).

Following the suggestions of Martin Koeppe and others there may be a 
need to allow a "cygwin" mount option as well.
