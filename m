Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWJTRIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWJTRIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWJTRIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:08:37 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:12039 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932274AbWJTRIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:08:37 -0400
Message-ID: <4539025B.301@shadowen.org>
Date: Fri, 20 Oct 2006 18:07:39 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: Badari Pulavarty <pbadari@us.ibm.com>, jgarzik@pobox.com,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, sukadev@us.ibm.com
Subject: Re: Panic in pci_call_probe from 2.6.18-mm2 and 2.6.18-mm3
References: <4528A26F.9000804@mbligh.org> <1160414389.17103.7.camel@dyn9047017100.beaverton.ibm.com> <452A85D8.70806@mbligh.org>
In-Reply-To: <452A85D8.70806@mbligh.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Badari Pulavarty wrote:
>> On Sun, 2006-10-08 at 00:02 -0700, Martin J. Bligh wrote:
>>
>>> Not sure if you've seen this already ... catching up on test results.
>>>
>>> This was on NUMA-Q, on both -mm2 and -mm3. -mm1 didn't suffer from this
>>> problem.
>>>
>>> Full logs:
>>>
>>> mm2 - http://test.kernel.org/abat/50727/debug/console.log
>>> mm3 - http://test.kernel.org/abat/51442/debug/console.log
>>>
>>> config - http://test.kernel.org/abat/51442/build/dotconfig
>>>
>>> I'm guessing from the 00000004 that the pcibus_to_node(dev->bus)
>>> is failing because bus->sysdata is NULL. The disassembly and
>>> structure offsets seem to line up for that.
>>>
>>> #define pcibus_to_node(bus) (
>>>     (struct pci_sysdata *)((bus)->sysdata))->node
>>>
>>> struct pci_sysdata {
>>>         int             domain;         /* PCI domain */
>>>         int             node;           /* NUMA node */
>>> };
>>>
>>
>>
>> Martin,
>>
>> Jeff moved "node" to a proper field in sysdata, instead
>> of overloading sysdata itself. I think this is causing the
>> problem. I guess we could end up with sysdata = NULL in some
>> cases ? Since you are the NUMA-Q expert, where does sysdata gets set
>> for NUMA-Q ? :)
>>
>> -mm2 changed:
>>
>> #define pcibus_to_node(bus) ((long) (bus)->sysdata)
>>
>> to
>> #define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))-
>>
>>> node
> 
> Buggered if I know, that's some strange pci thing ;-)
> 
> But can we revert whatever patch that was until it gets fixed, please?

Unless I am going very very mad, this has came up once before some
months ago.  We went through lots of pain finding the cause of this for
NUMA-Q and fixing it.  Something about not having a sysdata and needing
to initialise it.

Thought so, this was all discussed back in December 2005.

  http://lkml.org/lkml/2005/12/20/226

I'll go see if I can forward port the patch and address the remaining
issues with it.

-apw
