Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbTEIJGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTEIJGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:06:55 -0400
Received: from pat.uio.no ([129.240.130.16]:16279 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262402AbTEIJGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:06:52 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: jesse@cats-chateau.net
CC: hch@infradead.org, hch@infradead.org, alan@lxorguk.ukuu.org.uk,
       terje.eggestad@scali.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
In-reply-to: <03050813134901.09468@tabby> (message from Jesse Pollard on Thu,
	8 May 2003 13:13:49 -0500)
Subject: Re: The disappearing sys_call_table export.
MIME-Version: 1.0
Message-Id: <E19E41r-0000ie-00@aqualene.uio.no>
Date: Fri, 9 May 2003 11:18:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jesse Pollard]
> On Thursday 08 May 2003 10:29, Terje Malmedal wrote:
>> [Christoph Hellwig]
>> 
>> >> The only problem I can see is that different modules overloading the
>> >> same function needs to be unloaded in the correct order. Is this the
>> >> only reason for removing it, or am I missing something?
>> >
>> > it's racy - and it doesn't work on half of the arches added over the
>> > last years.
>> 
>> Would you be so kind as to explain exactly what is racy? Just
>> asserting that it is does not help me understand anything.

> Look at this:

> [1]int init_module(void)
> [2]{
> [3]  orig_fsync=sys_call_table[SYS_fsync];
> [4]  sys_call_table[SYS_fsync]=hacked_fsync;
> [5]  return 0;
> [6]}

> Unless there is a LOCK on sys_call_table[SYS_fsync] another CPU could
> replace the pointer between lines 3 and 4. At that point line 4 would
> destroy the existing entry.. or destroy it when the original is restored,
> and would NOT be restoring the one insterted.

Yes, that's actually part of what I meant with my first quoted
paragraph above. Did not come out that way, sorry.

I can see one problem on unload, if the memory used by the module is
freed while another CPU is executing the module code, but it should be
easy enough to protect against with a lock. 

Assuming that loads are unloads are manually serialized in the
correct order are there any other problems?

-- 
 - Terje
malmedal@usit.uio.no
