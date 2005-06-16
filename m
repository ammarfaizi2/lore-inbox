Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVFPD7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVFPD7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVFPD7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:59:49 -0400
Received: from smtpout.mac.com ([17.250.248.85]:54978 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261728AbVFPD72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:59:28 -0400
In-Reply-To: <200506152155.05865.pmcfarland@downeast.net>
References: <f192987705061303383f77c10c@mail.gmail.com> <200506151213.44742.vda@ilport.com.ua> <200506152155.05865.pmcfarland@downeast.net>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C960854D-7EA5-4DD7-8F2B-7021092CE3EB@mac.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RFC] Filesystem name storage (Was: A Great Idea (tm) about reimplementing NLS.)
Date: Wed, 15 Jun 2005 23:59:11 -0400
To: Patrick McFarland <pmcfarland@downeast.net>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15, 2005, at 21:55:04, Patrick McFarland wrote:
> On Wednesday 15 June 2005 05:13 am, Denis Vlasenko wrote:
>> I do not understand how this is going to look from userspace  
>> perspective.
>> Can you give examples how this will work?
>
> IMHO, he means that the userspace would only see Unicode filenames,  
> and the
> userspace could only give Unicode names back to the kernel. The  
> kernel, using
> this global NLS layer would translate back and forth, and the userland
> wouldn't know about it.
>
> Its basically the only sane way to approach the problem of getting  
> the entire
> Linux community to convert to Unicode.

Would the following system for filenames resolve most of the issues  
people
are raising:

First load charset tables into the kernel.  These would be stored in  
files in
userspace and could be easily updated, renamed, deleted, etc.  Such a  
table
would always be a translation from Unicode <=> Charset.  A kernel  
with this
system built in would understand natively "raw", "utf8", "utf16", and  
"utf32",
anything else would need loaded charset tables.

The following mount options would available:
   nls_raw=(0|1)  [default 1]:
     This would cause Linux to pass all chars through unmolested.   
This mode
     works well on multiuser systems where users want to use their  
own NLS
     tools, or where the whole system uses UTF-8, including the  
filesystems.
     This is backwards compatible with the way Linux currently  
presents most
     (all?) filesystems.  If the options "nls_disk" or "nls_user" are  
used,
     then this option is forced to be zero.
   nls_disk=<string-charset>
     This specifies the underlying charset which should be used on  
the disk
     or filesystem itself.  This may be "negotiate" for any filesystems
     which support NLS *and* can identify which charset is in use.   
Built in
     options are "utf8", "utf16", and "utf32".  Defaults to  
"negotiate" if
     available otherwise "utf8", but only defaults if "nls_raw" is 0.
   nls_user=<string-charset>
     This specifies the charset which should be presented to the  
user.  This
     may be used to allow a backwards compatibility (IE: A program wants
     ISO8859-1, but the admin wants the underlying filesystem to use  
UTF-8.
     Built in options are "utf8", "utf16", and "utf32".  Defaults to  
"utf8"
     if "nls_raw" is 0.

The end result is that specifying either nls_disk or nls_user will  
turn on
automatic NLS conversion, with the unspecified nls_ option being utf8.

If these options are used on bind mounts, they should override the  
underlying
filesystem's mount options (Instead of stacking).  This will allow  
the admin
to specify:

# mount -t ext3 -o nls_disk=utf8,nls_user=utf8 /dev/hdb /mnt
# mount --bind  -o nls_disk=utf8,nls_user=iso8850-1 /mnt/mail /var/ 
spool/mail

if he/she wants to provide backwards compatibility with a legacy mail
spooling program.  Note: A part of each translation table would be an
entry for "Unspecified character", such that any UTF-8 character not  
mapped
in the table could be translated to a sane default, such as '?'.  If  
names
collide under such translation, the kernel would need a way to keep  
track of
the collisions (Appended numbers?) and properly re-resolve them when  
asked.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------

