Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWJQWbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWJQWbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWJQWbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:31:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54915 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750861AbWJQWbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:31:52 -0400
Message-ID: <453559D5.4000809@us.ibm.com>
Date: Tue, 17 Oct 2006 15:31:49 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>	<4533C6A1.40203@oracle.com>	<1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>	<4533E7E2.6010506@oracle.com>	<1161031099.32606.14.camel@dyn9047017100.beaverton.ibm.com> <20061016135910.be11a2dc.akpm@osdl.org>
In-Reply-To: <20061016135910.be11a2dc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 16 Oct 2006 13:38:19 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>   
>>> So the answer is that -rc1-mm1 doesn't quite have the most recent
>>> version of this patch.  Grab the final patch at the end of this post
>>> from Andrew:
>>>
>>> 	http://lkml.org/lkml/2006/10/11/234
>>>
>>> It fixes up a misunderstanding that came from
>>> generic_file_buffered_write()'s habit of adding its 'written' input into
>>> the amount of bytes it announces having written in its return value.
>>>
>>> From mm-commits it looks like -mm2 will have the full patch.
>>>
>>>       
>> Hmm.. with that patch applied, I still have fsx failures.
>> This time read() returning -EINVAL. Are there any other fixes
>> missing in -mm ?
>>     
>
> Probably.  I need to get off butt and prepare rc2-mm1.
>
> The below is the full patch against 2.6.19-rc2.  Please test this version.
>
>
> From: Jeff Moyer <jmoyer@redhat.com>
>
> When direct-io falls back to buffered write, it will just leave the dirty data
> floating about in pagecache, pending regular writeback.
>
> But normal direct-io semantics are that IO is synchronous, and that it leaves
> no pagecache behind.
>
> So change the fallback-to-buffered-write code to sync the file region and to
> then strip away the pagecache, just as a regular direct-io write would do.
>
>   

Okay. Finally tracked down the problem I am running into.
This happens only on reiserfs

# /root/fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
jnk
mapped writes DISABLED
truncating to largest ever: 0x32740
truncating to largest ever: 0x39212
truncating to largest ever: 0x3bae9
truncating to largest ever: 0x3c1e3
truncating to largest ever: 0x3d1cd
truncating to largest ever: 0x3e8b8
truncating to largest ever: 0x3ed14
truncating to largest ever: 0x3f9c2
truncating to largest ever: 0x3ff9f
doread: read: Invalid argument
Segmentation fault

Here is the strace for it
..
ftruncate(3, 2721)                      = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=2721, ...}) = 0
lseek(3, 0, SEEK_END)                   = 2721
fstat(3, {st_mode=S_IFREG|0644, st_size=2721, ...}) = 0
lseek(3, 0, SEEK_END)                   = 2721
fstat(3, {st_mode=S_IFREG|0644, st_size=2721, ...}) = 0
lseek(3, 0, SEEK_END)                   = 2721
lseek(3, 0, SEEK_SET)                   = 0
read(3, 0x50a800, 2048)                 = -1 EINVAL (Invalid argument)

reiserfs getblock() is returing -EINVAL. There is comment in the code
about tail handling and returning EINVAL. BTW, this is not a -mm
issue, it happens on mainline too...

Thanks,
Badari

