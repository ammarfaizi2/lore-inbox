Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbTFRXyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbTFRXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:54:46 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:62434 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S265628AbTFRXyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:54:37 -0400
Message-ID: <3EF0FEF2.3080402@austin.rr.com>
Date: Wed, 18 Jun 2003 19:08:18 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: duplicate entry check in kmem_cache_create
References: <3EF0F0D5.5030504@austin.rr.com> <20030618164611.41ea172d.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just trying to be paranoid safe in module init code.  You can't unload a 
module with live objects
easily but in at least the case of force unloading of modules (in this 
case the cifs filesystem) is
apparently permitted by the kernel if you specify force and unless there 
is a way to autounmount
when someone forces you into your module exit routine (i.e. on rmmod 
<filesystemname.o> -f)
before all associated mounts are unmounted, I was thinking about whether 
the filesystem's module
init code should check if the filesystem module unloaded (from a slab 
perspective) cleanly but
couldn't think of an easy way to check unless I intentionally leave some 
/proc/fs/ entry around
when module unloading fails (and use the /proc/fs/cifs entry as a hint 
that module unloading was
not clean so don't even think about trying to do a module init on this 
filesystem).

Andrew Morton wrote:

>Steve French <smfrench@austin.rr.com> wrote:
>  
>
>>Is there a recommended way to check to see if a slab cache with
>>a specific name exists before calling kmem_cache_create?
>>
>>I was able to force it into the BUG() at about line 1160 of slab.c by 
>>removing my
>>module (rmmod -f) while some of my slab cache objects (e.g. private inode
>>info) were still in use, and then reloading my module which called
>>kmem_cache_create with a name that already existed.
>>    
>>
>
>errr, why on earth was the filesystem unloadable when it still had live
>objects floating about?
>
>At the very least, if the slab code tries to call a destructor it will ruin
>your whole day.
>
>
>
>  
>


