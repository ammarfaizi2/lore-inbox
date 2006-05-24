Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWEXIME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWEXIME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 04:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWEXIME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 04:12:04 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:2318 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932662AbWEXIMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 04:12:03 -0400
Message-ID: <44741550.5060006@argo.co.il>
Date: Wed, 24 May 2006 11:12:00 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: fitzboy <fitzboy@iparadigms.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <44720DB8.4060200@argo.co.il> <447211E1.7080207@iparadigms.com> <447212B5.1010208@argo.co.il> <447259E7.8050706@iparadigms.com> <4472C25C.2090909@argo.co.il> <44736EBE.3030704@iparadigms.com>
In-Reply-To: <44736EBE.3030704@iparadigms.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 May 2006 08:12:00.0908 (UTC) FILETIME=[BBD094C0:01C67F09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fitzboy wrote:
>
>
> Avi Kivity wrote:
>>
>> This will overflow. I think that
>
> why would it overflow? Random() returns a 32 bit number, and if I 
> multiple that by 32k (basically the number random() returns is the 
> block number I am going to), that should never be over 64 bits? It may 
> be over to size of the file though, but that is why I do mod 
> s.st_size... and a random number mod something is still a random 
> number. Also, with this method it is already currentSize aligned...
>

You're right, of course.  Thinko on my part.

>>
>> Sorry, I wasn't specific enough: please run iostat -x /dev/whatever 1 
>> and look at the 'r/s' (reads per second) field. If that agrees with 
>> what your test says, you have a block layer or lower problem, 
>> otherwise it's a filesystem problem.
>>
>
> I ran it and found an r/s at 165, which basically corresponds to my 6 
> ms access time... when it should be around 3.5ms... so it seems like 
> the seeks themselves are taking along time, NOT that I am doing extra 
> seeks...
>

I presume that was with the 20GB file?

If so, that rules out the filesystem as the cause.

I would do the following next:

- run the test on the device node (/dev/something), just to make sure. 
you will need to issue an ioctl (BLKGETSIZE64) to get the size as fstat 
will not return the correct size
- break out the array into individual disks and run the test on each 
disk.  that will show whether the controller is causing the problem or 
one of the disks (is it possible the array is in degraded mode?)

-- 
error compiling committee.c: too many arguments to function

