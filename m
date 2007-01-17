Return-Path: <linux-kernel-owner+w=401wt.eu-S932209AbXAQOyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbXAQOyL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXAQOyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:54:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbXAQOyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:54:10 -0500
Date: Wed, 17 Jan 2007 09:48:08 -0500 (EST)
From: Chip Coldwell <coldwell@redhat.com>
To: Andi Kleen <ak@suse.de>
cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
In-Reply-To: <200701170829.54540.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0701170942560.2900@localhost.localdomain>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net>
 <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Andi Kleen wrote:

> On Wednesday 17 January 2007 07:31, Chris Wedgwood wrote:
>> On Tue, Jan 16, 2007 at 08:52:32PM +0100, Christoph Anton Mitterer wrote:
>>> I agree,... it seems drastic, but this is the only really secure
>>> solution.
>>
>> I'd like to here from Andi how he feels about this?  It seems like a
>> somewhat drastic solution in some ways given a lot of hardware doesn't
>> seem to be affected (or maybe in those cases it's just really hard to
>> hit, I don't know).
>
> AMD is looking at the issue. Only Nvidia chipsets seem to be affected,
> although there were similar problems on VIA in the past too.
> Unless a good workaround comes around soon I'll probably default
> to iommu=soft on Nvidia.
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

We've just verified that configuring the graphics aperture to be
write-combining instead of write-back using an MTRR also solves the
problem.  It appears to be a cache incoherency issue in the graphics
aperture.

This script does the trick:

[ -- cut here -- ]
#!/bin/bash

# Read the northbridge offset 0x90 to get the size of the aperture
size=0x`lspci -xxx -s 0:18.3 | awk '/^90:/ { print $2 }'`

# bit 0 indicates the aperture is enabled, bits 1 - 3 indicate the size
if [ $((size & 1)) -eq 0 ] ; then
     echo "GART disabled; exiting"
     exit 0
fi

shft=$(((size >> 1) & 7))
size=$((0x2000000 << shft))

# Read the northbridge offset 0x94 to get the base address of the aperture
base=0x`lspci -xxx -s 0:18.3 | awk '/^90:/ { print $6 }'`
base=$((base << 25))
basehex=`printf 0x%08x $base`

printf "IOMMU aperture found at base=0x%08x size=0x%08x (%d KiB)\n" $base $size $((size/1024))

if grep -q $basehex /proc/mtrr ; then
     echo "MTRR already configured for IOMMU aperture; exiting"
     exit 0
fi

echo "Configuring write-combining MTRR for IOMMU aperture"
printf "base=0x%08x size=0x%08x type=write-combining\n" $base $size >/proc/mtrr

exit 0
[ -- cut here-- ]

Chip

-- 
Charles M. "Chip" Coldwell
Senior Software Engineer
Red Hat, Inc
978-392-2426

