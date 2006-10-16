Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWJPP5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWJPP5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWJPP5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:57:18 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:12817 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1161014AbWJPP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:57:17 -0400
Message-ID: <4533ABB3.1070104@shadowen.org>
Date: Mon, 16 Oct 2006 16:56:35 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org> <452D4BF0.20209@google.com> <452D6921.5010300@us.ibm.com>
In-Reply-To: <452D6921.5010300@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Martin J. Bligh wrote:
>> Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>>>
>>>
>>>
>>>
>>>   
>> fsx seems to fail now, across several different machines.
>>
>> http://test.kernel.org/functional/index.html
>>
>>
>> and drill down under "regression" on the failing ones.
>>
>> eg, see end of
>> http://test.kernel.org/abat/54516/debug/test.log.1 (i386)
>> and
>> http://test.kernel.org/abat/54503/debug/test.log.1 (x86_64)
>>
> 
> I am seeing fsx failures on 1k/2k ext3 filesystems, but not on 4k.
> Do you know the filesystem type & blocksize ?

Ok.  I've been poking at these results to try and get you these answers.
 In the process I noted that the benchmark was recently reviewed and
overhauled.  Looking at the changes it looks like we are now reporting
the results from some tests which are backgrounded for additional load,
which would not have previously been reported.  So this might not be a
new phenomenon.  We have some stable tests coming through now, so I
should be able to use them as a reference to be sure.

Here are the ones which are failing currently, note that the 139 at the
start is the exit status as reported by the shell, so SIGSEGV:

bl6-13: x86_64 ext3
-------------------
139 ./fsx-linux -l 500000 -r 4096 -t 2048 -w 2048 -Z -R -W -N 10000
test/junkfile
139 ./fsx-linux -N 10000 -o 128000 -A -l 500000 -r 512 -t 4096 -w 1024
-Z -R -W test/junkfile


elm3b239: x86_64 reiserfs
-------------------------
139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w 2048 -Z
-R -W test/junkfile
139 ./fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W test/junkfile
139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w 1024 -Z
-R -W test/junkfile

I have also seen the following style messages on 19-rc1-mm1:

short write: 0x15000 bytes instead of 0xf000

Note that this really does mean a _long_ write!

-apw
