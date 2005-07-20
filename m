Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVGUIZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVGUIZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 04:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVGUIZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 04:25:36 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:10900 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S261678AbVGUIZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 04:25:34 -0400
Message-ID: <42DE91E7.2060603@sm.sony.co.jp>
Date: Wed, 20 Jul 2005 14:03:19 -0400
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] FAT robustness
References: <42D9FDAC.3010109@sm.sony.co.jp> <42DB9911.9010106@grupopie.com>
In-Reply-To: <42DB9911.9010106@grupopie.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to explain background information more. My descriptions tends
to be depend on some knowledge about current xvfat for 2.4 kernel.

I'm not a author of xvfat fo 2.4 kernel, but can explain little more.

Current xvfat for 2.4 is designed to some specific flash memory card
controller which can guarantee atomicity of operation on ERASE-BLOCK size
unit. Xvfat for 2.4 try to merge operations on same ERASE-BLOCK under
some ordering constrain.

And xvfat for 2.4 uses own version of transaction control using 
in-core memory, not storage device like HDD nor flash ram,
to accomplish the above goal, with minimal changes on existing
FAT implementation. And this transaction control let FAT operations
came from different threads to fee from mixed up, where potentially
operation ordering problems would be caused.

We'll start with HDD, however later we'll cover memory devices.
For memory devices we may prepare another elevator functions,
depending on property of devices or lower layer. E.g. NAND/AND 
flash have  different operation units for read/write and erase,
and have some translation layer.



Paulo Marques wrote:
> Hiroyuki Machida wrote:
> 
>> [...]
>>  Q3 : I'm not sure JBD can be used for FAT improvements.       Do you 
>> have any comments ?
> 
> 
> I might not be the best person to answer this, but this just seems so 
> obvious:
Any comments are welcome.
 
> If you plan to let a recently hot-unplugged device to be used in another 
> OS that doesn't understand your journaling extensions, your disk will be 
> corrupted.
> 
> If this is supposed to work only on OS's that understand your journaling 
> extensions, then there are much better filesystems out there with 
> journaling already.

I agree. Even not removable media, this situation will be occurred.
Suppose that device like audio player which acts as USB client and provide
USB Mass class target class. Embedded storage may be handled through by
USB Host side, like Win PC or Mac.

 
> You might be able to reduce the size of the time window where hot 
> removing the media will cause problems, like writting all the data first 
> and update the metadata in as few operations as possible. But that just 
> reduces the probability of data corruption. It doesn't eliminate it at all.
> 

As other messages said, some developers suggest "SoftUpdate" to be used.
I need to consider about situation where memory devices are used, not HDD.

