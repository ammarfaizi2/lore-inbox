Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUIGKzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUIGKzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUIGKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:55:07 -0400
Received: from [195.23.16.24] ([195.23.16.24]:3003 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267786AbUIGKy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:54:58 -0400
Message-ID: <413D937F.9070209@grupopie.com>
Date: Tue, 07 Sep 2004 11:54:55 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903172354.GR3106@holomorphy.com> <4138AF0C.4010703@grupopie.com> <20040903180200.GS3106@holomorphy.com> <413B9441.9060404@grupopie.com>
In-Reply-To: <413B9441.9060404@grupopie.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.49; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> William Lee Irwin III wrote:
> 
>> On Fri, Sep 03, 2004 at 06:51:08PM +0100, Paulo Marques wrote:
>>
>>> Could you send me the .tmp_kallsyms2.S and System.map files from
>>> this kernel build, please, please, please?
>>> I really want to address this problem, but without hardware and
>>> without more information I'm a little in the dark (although
>>> looking at the resulting names already gives some clues).
>>> Also, doing a "cat /proc/kallsyms" shows the same kind of behavior,
>>> doesn't it? (just to be sure)
>>
>>
>>
>> cat /proc/kallsyms also exhibits this problem.
>>
>> The data will appear shortly at:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/misc/kallsyms2.S-sparc64.gz 
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/misc/System.map-2.6.9-rc1-mm3-sparc64.gz 
>>
> 
> 
> Thank for all the information!
> 
> Looking at the data I found out that the "_up_up_up" is in fact the
> token with code "0", which means that the token "0" was being used a
> lot more than the others.
> 
> This pointed me in the direction of the bug.
> 
> My error was to assume the .word assembler directive meant a 16-bit
> unsigned integer, when in fact it depends on the architecture and is
> 32 bits on sparc :(
> 
> This one liner should solve the problem.
> 
> Please verify that in fact it does solve it, and I'll send a proper
> "[PATCH]" message to be included in the next version.

You might have missed this earlier, so I'm reposting it.

Could you please try the attached patch and see if it works on sparc64?

-mm4 is out already, and I haven't send the final patch because I don't
have any confirmation that it actually works :(

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978


--- linux-2.6.9-rc1-mm3/scripts/kallsyms.c      2004-09-05 21:51:14.000000000 +0100
+++ linux-2.6.9-rc1-kall/scripts/kallsyms.c     2004-09-05 21:52:38.000000000 +0100
@@ -303,7 +303,7 @@ write_src(void)

         output_label("kallsyms_token_index");
         for (i = 0; i < 256; i++)
-               printf("\t.word\t%d\n", best_idx[i]);
+               printf("\t.short\t%d\n", best_idx[i]);
         printf("\n");
  }
