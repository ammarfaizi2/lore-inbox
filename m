Return-Path: <linux-kernel-owner+w=401wt.eu-S1760150AbWLHXGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760150AbWLHXGS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761243AbWLHXGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:06:18 -0500
Received: from ns2.gothnet.se ([82.193.160.251]:1551 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760150AbWLHXGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:06:17 -0500
Message-ID: <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org>
In-Reply-To: <1165616236.27217.108.camel@laptopd505.fenrus.org>
References: <4579ADE3.6040609@tungstengraphics.com>
    <1165616236.27217.108.camel@laptopd505.fenrus.org>
Date: Sat, 9 Dec 2006 00:05:48 +0100 (CET)
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
From: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>,
       "Dave Jones" <davej@redhat.com>, "Dave Airlie" <airlied@linux.ie>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.6 [CVS]
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3 (Normal)
Importance: Normal
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2006-12-08 at 19:24 +0100, Thomas Hellström wrote:
>>
>> +       }
>> +
>> +       if (alloc_size <= PAGE_SIZE) {
>> +               new->memory = kmalloc(alloc_size, GFP_KERNEL);
>> +       }
>> +       if (new->memory == NULL) {
>> +               new->memory = vmalloc(alloc_size);
>
> this bit is more or less evil as well...
>
> 1) vmalloc is expensive all the way, higher tlb use etc etc
> 2) mixing allocation types is just a recipe for disaster
> 3) if this isn't a frequent operation, kmalloc is fine upto at least 2
> pages; I doubt you'll ever want more

I understand your feelings about this, and as you probably understand, the
kfree / vfree thingy is a result of the above allocation scheme.

The allocated memory holds an array of struct page pointers. The number of
struct page pointers will range from 1 to about 8192, so the alloc size
will range from 4bytes to 64K, but could go higher depending on
architecture. I figured that kmalloc could fail, and, according to "linux
device drivers" (IIRC), vmalloc is faster when allocation size exceeds 1
page. Using only vmalloc waists far too much memory if the number of small
buffers is high.

So we can't use only vmalloc, and we can't fail so we can't use only
kmalloc. I'm open to suggestions on how to improve this.

Regards,
Thomas


>
>
>
> --
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
> Test the interaction between Linux and your BIOS via
> http://www.linuxfirmwarekit.org
>
>


