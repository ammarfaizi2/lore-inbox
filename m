Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUF0TmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUF0TmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUF0TmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:42:19 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:4263 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262071AbUF0TmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:42:16 -0400
Message-ID: <40DF231F.6090608@inet6.fr>
Date: Sun, 27 Jun 2004 21:42:23 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en
MIME-Version: 1.0
To: V13 <v13@priest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <20040624213041.GA20649@elf.ucw.cz> <20040624220318.GE20649@elf.ucw.cz> <40DBD9AD.8070503@inet6.fr> <200406272118.23510.v13@priest.com>
In-Reply-To: <200406272118.23510.v13@priest.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V13 wrote the following on 06/27/2004 08:18 PM :

>On Friday 25 June 2004 10:52, Lionel Bouton wrote:
>  
>
>>Pavel Machek wrote the following on 06/25/2004 12:03 AM :
>>    
>>
>>>Of course, if mozilla marked them "elastic" it should better be
>>>prepared for they disappearance. I'd disappear them with simple
>>>unlink(), so they'd physically survive as long as someone held them
>>>open.
>>>      
>>>
>>Doesn't work reliably : the deletion is done in order to reclaim space
>>that is needed now. You may want to retry unlinking files until you
>>reach the free space needed, but this is clearly a receipe for famine :
>>process can wait on writes an unspecified amount of time.
>>    
>>
>
>This could be solved like OOM by killing all related processes.
>  
>

I don't want to see mozilla shut down because it was filling a cache 
file during a big download...

Note :
In practice I don't see it as a real problem with good-manered 
applications : as we are speaking of mutualised storage space, 
statistically the system should find files to remove unless it is 
burried under open filedescriptors for elastic files. But this is not 
really robust : a very simple DoS against this is to allocate all the 
available storage space in elastic files and maintain the 
filedescriptors open.

To continue on the "kill process" subject : I think making aware the 
process of the problem is much more sane. I'd really like mozilla to 
tell me : "Sorry, my download cannot continue, the system removed the 
download file in order to free some disk space".
IMHO one way to make this work *reliably* is to allow the fs to remove 
the files from disk directly and not simply unlink them and wait for the 
last fd to be closed. The fs must then return an EBADF (I don't know if 
a new error code tailored for this case is affordable) for subsequent 
read/writes and applications using elastic files must be written to 
gracefully recover from this.
It seems much more logical to me to make applications aware of the 
exotic nature of elastic files and handle the associated behavior. 
Conceptually elastic files seem different enough from regular files that 
you would want to handle them separately at the application level. In 
fact I believe elastic files should be created by elastic aware 
applications and not by adventurous users/admins. For example I'd really 
prefer mozilla to choose to create elastic files when configured to do 
so and not have an admin make a chattr on the cache directory...

