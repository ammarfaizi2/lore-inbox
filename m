Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTJQMv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJQMv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:51:29 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:45786 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263447AbTJQMv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:51:27 -0400
Message-ID: <3F8FE5CE.41A0CE21@namesys.com>
Date: Fri, 17 Oct 2003 16:51:26 +0400
From: Edward Shushkin <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: root@chaos.analogic.com, Nikita Danilov <Nikita@Namesys.COM>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Josh Litherland <josh@temp123.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl> <16269.23199.833564.163986@laputa.namesys.com> <Pine.LNX.4.53.0310151150370.7350@chaos> <16269.29716.461117.338214@laputa.namesys.com> <Pine.LNX.4.53.0310151253001.7576@chaos> <3F8D8CA7.4000104@namesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Richard B. Johnson wrote:
> 
> >Then the degenerative case is no compression at all. There is no
> >advantage to writing a block that is 1/N full of compressed data.
> >You end up having to write the whole block anyway.
> >
> >This problem was well developed in the days where RLE (at the hardware
> >level) was used to extend the size of hard disks from their physical
> >size of about 38 megabytes to about 70 megabytes. The minimim size
> >of a read or write is a sector.
> >
> >So, lets's use the minimum compression alogithm, no sliding
> >dictionaries complicating things, just RLE and see.
> >
> >The alogithm is a sentinal byte, a byte representing the number
> >of bytes to expand -1, then the byte to expand. The sentinal byte
> >in RLE was 0xbb. If you needed to read/write a 0xbb, you need
> >to expand that to three bytes, 0xbb, 0x00, 0xbb.
> >                                  |     |     |___ byte to expand
> >                                  |     |________ nr bytes (0 + 1)
> >                                  |______________ sentinal byte
> >
> >All other sequences will reduce the size. So, we have a 512-
> >byte sector full of nulls, what gets written is:
> >        0xbb, 0xff, 0x00, 0xbb, 0xff, 0x00
> >           |     |     |     |     |     |___ byte value
> >           |     |     |     |     |_________ 256 bytes
> >           |     |     |     |_______________ sentinal
> >           |     |     |_____________________ byte value
> >           |     |___________________________ 256 bytes
> >           |_________________________________ sentinal.
> >
> >In this example, we have compressed a 512 byte sector to
> >only 6 bytes. Wonderful! Now we have to write 512 bytes
> >so that effort was wasted. 

Reiser4 packs compressed block so it will be represented by a set
of tails (fragments). This approach allows to keep compression ratio
as maximal as possible.

Edward.
