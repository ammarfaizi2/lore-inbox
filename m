Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVKUV32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVKUV32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKUV32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:29:28 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:60884 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750782AbVKUV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:29:27 -0500
Message-ID: <43823BF0.5050408@austin.rr.com>
Date: Mon, 21 Nov 2005 15:28:16 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eric2.valette@francetelecom.com
CC: linux-kernel@vger.kernel.org, torvalds@osdl.com
Subject: Re: CIFS improvements/wider testing needed
References: <4381EFF3.8000201@austin.rr.com> <4382032D.4080606@francetelecom.com>
In-Reply-To: <4382032D.4080606@francetelecom.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VALETTE Eric RD-MAPS-REN wrote:

>>>1) save a new openoffice document twice, 2) create mail folders
>>>from inside thunderbird (local mailbox
>>>      
>>>
>>shared
>>    
>>
>>>with windows),
>>>      
>>>
>>You can avoid these by mounting with "nobrl" (no remote byte range
>>lock) mount option (smbfs does not send byte range locks so would not
>>run into this problem, but would run into others). These appear to be
>>byte range locking problems. The problem is that cifs has to map
>>advisory to mandatory locks which only works if the application is
>>reasonably well behaved (not even Samba has support for advisory
>>locks although they will come with the new Unix extensions). It may
>>be made worse by a bug in openoffice (some Linux apps such as
>>Evolution lock on the "wrong" file handle which does not fail in
>>posix, although is sloppy coding) but I have not confirmed the byte
>>range lock sequence which openoffice is trying as we did with
>>Evolution - I did confirm that nobrl (disabling the byte range locks
>>on the client) works. Note that this mount option, although not
>>listed as a bug fix in git per-se - was added to address the
>>evolution etc. locking bugs. There are quite a few of the cifs
>>changes that fall into that category.
>>    
>>
>
>Well I would be surprised the "cat >> titi" command does any of this
>byte range lock. If the "create and later rewrite the same file"
>sequence fails, with a simple cat command (cat > titi ... ^D; cat >>
>titi), how can it works with complicated applications?
>
>  
>
The "cat >> titi" failure has nothing to do with the Evolution and 
OpenOffice issues.  We have had multiple people reproduce the strange 
Evolution behavior that was causing problems (months ago) and those can 
be handled now.    Those applications do byte range locking in 
counter-intuitive ways that are hard to map onto the network (and also 
Evolution IIRC also uses "illegal" (to CIFS, but legal to POSIX) 
characters in file names - which we also had to add a mount option for - 
in order to allow remapping of those characters).   The cat failure that 
you describe is likely due to 1) either the need for a full emulation of 
Unix mode bits to Windows ACLs when umask is set to certain values or 2) 
a strange combination of share permissions and ntfs acls on the server 
side which allow create in the directory but not append on new file objects.

>Yes : the system hangs when shutting down as the result of the "umount
>-a"  with the last message being as described in bug N° 3237. I have to
>press power button for 5 seconds.
>
>NB : manually doing the umount does exactly the same things.
>
>  
>
This looks like a corrupt server frame - I will try to get change samba 
to force such an illegal frame to test the changes, but it looks like 
something we can work around with defensive code in the cifs client:
    1) by allowing a minimum sized response to have an illegal bcc (byte 
area count) under this circumstance
    2) by making sure SMBLogoffX times out faster (since it is harmless 
to do that in most cases - it is often followed by a tcp session close 
which will implicitly do what SMBLogoffX does anyway)

