Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTJOSGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTJOSGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:06:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:49058 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263854AbTJOSGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:06:33 -0400
Message-ID: <3F8D8CA7.4000104@namesys.com>
Date: Wed, 15 Oct 2003 22:06:31 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Nikita Danilov <Nikita@Namesys.COM>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Josh Litherland <josh@temp123.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Edward Shishkin <edward@namesys.com>
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl> <16269.23199.833564.163986@laputa.namesys.com> <Pine.LNX.4.53.0310151150370.7350@chaos> <16269.29716.461117.338214@laputa.namesys.com> <Pine.LNX.4.53.0310151253001.7576@chaos>
In-Reply-To: <Pine.LNX.4.53.0310151253001.7576@chaos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you use one of them silly block aligned filesystems, you indeed do 
have the problem described.  Reiser4 only block aligns files larger than 
16k that don't use the compression plugin.  Why do we block align even 
them?  mmap performance.  mmap is moderately worth optimizing for, 
unless you want to do something more important like compress the file.

Edward can say more about this more precisely....

Hans

Richard B. Johnson wrote:

>On Wed, 15 Oct 2003, Nikita Danilov wrote:
>
>  
>
>>Richard B. Johnson writes:
>> > On Wed, 15 Oct 2003, Nikita Danilov wrote:
>> >
>> > > Erik Mouw writes:
>> > >  > On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
>> > >  > > Erik Mouw writes:
>> > >  > >  > Nowadays disks are so incredibly cheap, that transparent compression
>> > >  > >  > support is not realy worth it anymore (IMHO).
>> > >  > >
>> > [SNIPPED...]
>> >
>> > >  >
>> > >  > PS: let me guess: among other things, reiser4 comes with transparent
>> > >  >     compression? ;-)
>> > >
>> > > Yes, it will.
>> > >
>> >
>> > EeeeeeK!  A single bad sector could prevent an entire database from
>> > being uncompressed! You may want to re-think that idea before you
>> > commit a lot of time to it.
>>
>>It could not if block-level compression is used. Which is the only
>>solution, given random-access to file bodies.
>>
>>    
>>
>
>Then the degenerative case is no compression at all. There is no
>advantage to writing a block that is 1/N full of compressed data.
>You end up having to write the whole block anyway.
>
>This problem was well developed in the days where RLE (at the hardware
>level) was used to extend the size of hard disks from their physical
>size of about 38 megabytes to about 70 megabytes. The minimim size
>of a read or write is a sector.
>
>So, lets's use the minimum compression alogithm, no sliding
>dictionaries complicating things, just RLE and see.
>
>The alogithm is a sentinal byte, a byte representing the number
>of bytes to expand -1, then the byte to expand. The sentinal byte
>in RLE was 0xbb. If you needed to read/write a 0xbb, you need
>to expand that to three bytes, 0xbb, 0x00, 0xbb.
>                                  |     |     |___ byte to expand
>                                  |     |________ nr bytes (0 + 1)
>                                  |______________ sentinal byte
>
>All other sequences will reduce the size. So, we have a 512-
>byte sector full of nulls, what gets written is:
>        0xbb, 0xff, 0x00, 0xbb, 0xff, 0x00
>           |     |     |     |     |     |___ byte value
>           |     |     |     |     |_________ 256 bytes
>           |     |     |     |_______________ sentinal
>           |     |     |_____________________ byte value
>           |     |___________________________ 256 bytes
>           |_________________________________ sentinal.
>
>In this example, we have compressed a 512 byte sector to
>only 6 bytes. Wonderful! Now we have to write 512 bytes
>so that effort was wasted. FYI, I invented RLE and I also
>put it into JMODEM the "last" file-transfer protocol that
>I created in 1989.  http://www.hal9k.com/cug/v300e.htm
>
>Any time you are bound to a minimum block size to transfer,
>you will have this problem.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
>            Note 96.31% of all statistics are fiction.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


