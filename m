Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWBRQCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWBRQCQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWBRQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:02:05 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:37275 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751435AbWBRQBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:01:49 -0500
Message-ID: <43F744C6.8020209@pg.gda.pl>
Date: Sat, 18 Feb 2006 17:01:10 +0100
From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Organization: =?UTF-8?B?R2RhxYRzayBVbml2ZXJzaXR5IG9mIFRlY2hub2xvZ3k=?=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL; rv:1.7.12) Gecko/20050915
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <20060218025921.7456e168.akpm@osdl.org>
In-Reply-To: <20060218025921.7456e168.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Użytkownik Andrew Morton napisał:

> Adam Tla/lka <atlka@pg.gda.pl> wrote:
> 
>>
>>This patch applies to 2.6.15.3 kernel sources to drivers/char/vt.c file.
>>It should work with other versions too.
>>
>>Changed console behaviour so in UTF-8 mode vt100 alternate character
>>sequences work as described in terminfo/termcap linux terminal definition.
>>Programs can use vt100 control seqences - smacs, rmacs and acsc  characters
>>in UTF-8 mode in the same way as in normal mode so one definition is always
>>valid - current behaviour make these seqences not working in UTF-8 mode.
>>
>>Added reporting malformed UTF-8 seqences as replacement glyphs.
>>I think that terminal should always display something rather then ignoring
>>these kind of data as it does now. Also it sticks to Unicode standards
>>saying that every wrong byte should be reported. It is more human readable
>>too in case of Latin subsets including ASCII chars.
>>
>>...
>>
>>-		} else if (vc->vc_utf) {
>>+		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
>> 		    /* Combine UTF-8 into Unicode */
>>-		    /* Incomplete characters silently ignored */
>>+		    /* Malformed sequence represented as replacement glyphs */
>>+rescan_last_byte:
>> 		    if(c > 0x7f) {
>>
>>...
>>
>>+					if (vc->vc_npar) {
>>+						c = orig;
>>+						goto rescan_last_byte;
>>+					}
>>
>>...
>>
>>+				}
>>+				vc->vc_utf_count = 0;
>>+				c = orig;
>>+				goto rescan_last_byte;
>>+			}
>> 			continue;
>> 		}
> 
> 
> I spent some time trying to work out why this cannot cause an infinite loop
> and gave up.  Can you explain?

1. this code is executed only if vc_utf_count != 0
which means uncompleted UTF-8 sequence, because in case of proper UTF-8 
sequence or normal mode vc_utf_count == 0 in these places of code.

2. vc_npar is not used while completing UTF-seqence so I used it as a 
counter of scanned sequence continuation bytes, it is set to 0 if begin 
of UTF-8 seqence is detected and vc_utf_count set to number of 
continuation bytes

3. when you can't display replacement glyph bad sequence is ignored as 
previously so vc_utf_count and vc_npar is zeroed in case of  malformed 
UTF-8 seqence and there is no loop - anyway replacement glyph
should always be defined IMHO or I must change this code because
it seems not to be correct to use c as tc as a last resort because in 
this case c means byte value which malformed scanned seqence so it is 
not valuable for us. Maybe the better way is to use "?" char as a last
resort instead of c value. What do you think?
Maybe I should remember all bytes of the UTF-sequence to use their 
values as a last resort char in case of malformed sequence and 0xfffd
not defined?

Regards
-- 
Adam Tlałka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group       - - - ~~~~~~
Computer Center,  Gdańsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
