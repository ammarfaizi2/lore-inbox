Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWGFR2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWGFR2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWGFR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:28:37 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:16566 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1030312AbWGFR2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:28:36 -0400
Message-ID: <44AD4807.6090704@emc.com>
Date: Thu, 06 Jul 2006 13:27:35 -0400
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	<20060701170729.GB8763@irc.pl>	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>	<20060701181702.GC8763@irc.pl> <44AD286F.3030507@emc.com> <m3ejwyiryr.fsf@defiant.localdomain>
In-Reply-To: <m3ejwyiryr.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.7.6.101432
X-PerlMx-Spam: Gauge=, SPAM=2%, Reasons='EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:

>Ric Wheeler <ric@emc.com> writes:
>
>  
>
>>Having a checksum (or even a digital signature on a file) that lets us
>>detect corruption is very useful since, in many cases, it allows us to
>>flag the file as corrupt before it gets used.
>>    
>>
>
>We can't have that. Sector/block/etc. checksums - yes.
>  
>
I certainly don't object to sector and block checksums, but they do 
require a specially formatted disk or high end array (which my employer 
would be happy to sell you ;-)).

If you record a per sector or FS block level checksum in user space, you 
have to keep in mind the sheer size of today's commodity disks and the 
amount of space that would consume - it would be much more efficient to 
store one such signature per file. Where you put those 
checksums/signatures and when you look at them/update them/validate them 
can cause lots of headaches.

>A checksum, signature, hash etc. of the whole file would require
>actually reading the whole file. It can be done by tripwire or
>backup, and even by fsck, but not by the filesystem in normal
>operation.
>  
>
There was some  talk about this at the file system mini-summit.  
Clearly, you would not want to compute (and continually update) the 
checksum/signature on an actively written  file.

It might be useful to compute at close time (or when you set a special 
attr, etc). We could also special case sequentially written files 
(storing & updating the partial signature as we go, but that could be a 
bit iffy).

The key is to keep the signature/checksum with the file - tripwire and 
backup programs could do this (and even store it their own extended 
attribute), but I think that it is more generically useful than that. 

If you care enough about the data integrity of a file, having this kind 
of optional validation on any open would be very useful.

ric


