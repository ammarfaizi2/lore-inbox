Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVEJSPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEJSPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEJSPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:15:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28825 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261720AbVEJSPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:15:36 -0400
Message-ID: <4280FA41.3050403@us.ibm.com>
Date: Tue, 10 May 2005 11:15:29 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com> <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com> <20050422003920.GD6829@kroah.com> <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com> <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com> <20050426065431.GB5889@suse.de> <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com> <427FE7B3.8080200@us.ibm.com> <20050510202053.3ddd9e7b.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20050510202053.3ddd9e7b.tokunaga.keiich@jp.fujitsu.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keiichiro Tokunaga wrote:
> On Mon, 09 May 2005 15:44:03 -0700 Matthew Dobson wrote:
>>Is there a reason to not make both register_node() and unregister_node()
>>__devinit?  If a user has CONFIG_HOTPLUG=y then they want these functions,
>>otherwise there is no point, as they promised they won't be hotplugging
>>anything, right?
> 
>   The main reason is Greg advised me that we had the function
> no matter if CONFIG_HOTPLUG is true or not.  An addtional
> advantage of this is that the source becomes cleaner because
> I included unregister_node() with '#ifdef CONFIG_HOTPLUG' and
> '#endif' in my previous version of patch.
> 
> Thanks,
> Keiichiro Tokunaga
> 

You're referring to this comment:

On Thu, 21 Apr 2005 17:39:20 -0700 Greg KH wrote:
>> And hey, what's the real big deal here, why not always have this
>> function no matter if CONFIG_HOTPLUG is enabled or not?  I really want
>> to just make that an option that is always enabled anyway, but changable
>> if you are using CONFIG_TINY or something...

correct?  I think GregKH was referring to you #ifdef'ing the function away
so that it isn't even there if CONFIG_HOTPLUG=n, which is completely
different from marking the function as __devinit.

If you mark the function as __devinit, it will still be there for the
kernel initialization phase whether CONFIG_HOTPLUG is on or off.  What it
does mean, however, is that the function will get freed, along with the
rest of the functions/data marked __init or __initdata, if CONFIG_HOTPLUG
is off.  If CONFIG_HOTPLUG is on, __devinit is defined to be nothing and
the function will remain because there is a possibility that someone will
call the function after the initialization phase.  If CONFIG_HOTPLUG is
off, the user is assuring us that no devices will be hot-added or
hot-removed, so there is no point in bloating the kernel text (albeit very
slightly) with functions that we *know* won't be called.

So I think it's probably a good idea to stick the __devinit on
register_node() and unregister_node(), otherwise we have no marker to know
which functions to remove for CONFIG_TINY.  Greg?

-Matt
