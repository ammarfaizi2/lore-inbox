Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVCQAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVCQAuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVCQAtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:49:25 -0500
Received: from 63-207-7-10.ded.pacbell.net ([63.207.7.10]:63479 "EHLO
	cassini.enmediainc.com") by vger.kernel.org with ESMTP
	id S262928AbVCQAjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:39:01 -0500
Message-ID: <4238D137.1030907@c2micro.com>
Date: Wed, 16 Mar 2005 16:37:11 -0800
From: Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initrd/initramfs problem
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com> <20050316120647.GB8563@linux-mips.org>
In-Reply-To: <20050316120647.GB8563@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What fails is when CONFIG_BLK_DEV_INITRD and CONFIG_INITRAMFS_SOURCE are 
both set.  I realize (now) that I don't need initrd at all, and 
initramfs works fine by itself, as you have tested.  It seems that the 
kernel may need some exclusion between these two mechanisms while the 
difference is sorted out.

I'm not totally up on Kconfig files, but maybe something like this in 
drivers/block/Kconfig:

config INITRAMFS_SOURCE
      string "Initramfs source file(s)"
      default ""
      depends on BLK_DEV_INITRD=n

Regarding the documenation it would have been helpful to me if 
Documentation/initrd.txt had a reference to 
Documentation/early-userspace/README.  I'm not sure who maintains that 
directory, or I'd send a suggestion.  tldp.org?

THX
Ed Martini

Original context: 
http://www.linux-mips.org/archives/linux-mips/2005-03/index.html

Ralf Baechle wrote:

>On Tue, Mar 15, 2005 at 02:37:45PM -0800, Ed Martini wrote:
>  
>
>>Also, unless you move the location of .init.ramfs, it gets freed twice, 
>>leading to a panic.
>>    
>>
>
>Interesting one.  When I tested the code recently it did work for me and
>it shouldn't have changed since.  The way this is supposed to work is
>by setting the page_count to 1 by using set_page_count and unmarking the
>page as reserved, so after that point a free_page should actually succeed -
>even if done twice as you've observed, first in populate_rootfs then
>once more in free_initmem.
>
>It seems a frighteningly bad idea though since it relies on no memory
>from the initrd range being allocated between the two calls - or it would
>end being freed by force, in use or not.  On startup Linux tends to
>allocate memory starting from high address towards low addresses which
>must be why we usually get away with this one.
>
>  
>
>>From the documentation alone it's impossible to figure out how to build 
>>your initramfs.  In various places the docs refer to the initial 
>>executable as /linuxrc, /kinit, /init, and possibly others.  If you read 
>>init/main.c you see that for an initramfs, your initial process will be 
>>started from /init.
>>    
>>
>
>I guess I read the code so I didn't notice the lacking qualities of the
>documentation ...
>
>  Ralf
>  
>

