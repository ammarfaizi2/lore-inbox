Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUHZK3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUHZK3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUHZK2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:28:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:19663 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268032AbUHZK0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:26:42 -0400
Message-ID: <412DBAD9.6020303@grupopie.com>
Date: Thu, 26 Aug 2004 11:26:33 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, mpm@selenic.com,
       linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com>	<20040825173941.GJ5414@waste.org>	<412CDE9D.3090609@grupopie.com>	<20040825185854.GP31237@waste.org>	<412CE3ED.5000803@grupopie.com>	<20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk>	<412D236E.3030401@grupopie.com>	<20040825234345.GN21964@parcelfarce.linux.theplanet.co.uk> <20040826025904.02bf4c0e.akpm@osdl.org>
In-Reply-To: <20040826025904.02bf4c0e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.32; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
>>On Thu, Aug 26, 2004 at 12:40:30AM +0100, Paulo Marques wrote:
>> > That is why I kept a big *If* in that sentence. I'm quite new to all
>> > this, and I'm still reading a lot of source code.
>> > 
>> > If the culprit is in fact seq_file, and seq_file can be improved in a
>> > way that works for everyone (not only kallsyms), then I also agree
>> > that is is the way to go. But hunting this down might prove that the
>> > problem is somewhere else. It is just too soon to draw conclusions.
>>
>> readprofile(1) ought to narrow it down with that kind of timing difference...
> 
> 
> 
> 
> c014696c do_anonymous_page                             4   0.0133
> c0133550 kallsyms_expand_symbol                       17   0.1545
> c026b78f __copy_user_intel                            31   0.2039
> c026a5ec vsnprintf                                    39   0.0283
> c026a318 number                                       40   0.0552
> c011d102 write_profile                                79   0.7182
> c0131f39 is_exported                                3805  17.0628
> c0104028 default_idle                               4254  86.8163
> 00000000 total                                      8325   0.0025
> 
> It's all in the O(n) is_exported().  Rusty's fault ;)

The is_exported function is only called for kernel symbols, and not 
module symbols AFAICT.

If there is a way to know at compile time the exported symbols, then 
scripts/kallsyms might generate a bitmap along with all the other data 
it generates so that checking is_exported would become O(1).

For a tipical scenario of less than 16k symbols, the bitmap would take 
2kB. If we don't want to spend this 2kB we can do something a little 
more ugly:

The format of the compressed stream is basicaly:

[1 byte <name length>][N-bytes name]

repeated for every symbol. Since KSYM_NAME_LEN is defined to be 127, we 
still have an extra bit in the length to keep the "is_exported" 
information there. The format would then be:

[1 byte <7:is_exported bit>:<6..0:name length>][N-bytes name]

Of course, this limits future changes to KSYM_NAME_LEN :(

If the information is hard to get at compile time, then we could do a 
single loop the first time the information is needed, and then use that 
for subsequent calls.

But with this solved we could have sub-milisecond "cat /proc/kallsyms" :)

-- 
Paulo Marques - www.grupopie.com
