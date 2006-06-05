Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750770AbWFEW2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWFEW2N (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWFEW2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:28:13 -0400
Received: from mail.hosted.servetheworld.net ([83.143.81.74]:44232 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S1750770AbWFEW2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:28:12 -0400
Message-ID: <4484B001.3010503@osvik.no>
Date: Tue, 06 Jun 2006 00:28:17 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060504)
MIME-Version: 1.0
To: Joachim Fritschi <jfritschi@freenet.de>
CC: Dag Arne Osvik <da@osvik.no>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
References: <200606041516.46920.jfritschi@freenet.de> <200606042110.15060.ak@suse.de> <44834A0F.3000502@osvik.no> <200606051218.16125.jfritschi@freenet.de>
In-Reply-To: <200606051218.16125.jfritschi@freenet.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim Fritschi wrote:
> On Sunday 04 June 2006 23:01, Dag Arne Osvik wrote:
>> Andi Kleen wrote:
>>> On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
>>>> This patch adds the twofish x86_64 assembler routine.
>>>>
>>>> +/* Defining a few register aliases for better reading */
>>> Maybe you can read it now better, but for everybody else it is extremly
>>> confusing. It would be better if you just used the original register
>>> names.
>> I'd agree if you said this code could benefit from further readability
>> improvements.  But you're arguing against one.
>>
>> Too bad AMD kept the old register names when defining AMD64..
> 
> I'd agree that the original register names would only complicate things. 
> 
> Can you give me any hint what to improve or maybe provide a suggestion on how 
> to improve the overall readabilty.

It looks better on second reading, but I have some comments:

Remove load_s - it's needless and (slightly) confusing
There are some cases of missing ## D
Why semicolon after closing parenthesis in macro definitions?
Try to align operands in columns
It would be nice to have some explanation of macro parameter names

Btw, why do you keep zeroing tmp registers when you don't need to?
32-bit ops zero the top half of the destination register.

Here's an example of a modified macro (modulo linewrapping by my mail
client):

#define
encrypt_round(a,b,olda,oldb,newa,newb,ctx,round,tmp1,tmp2,key1,key2) \
        load_round_key(key1,key2,ctx,round);\
        movzx   a ## B,         newa ## D;\
        movzx   a ## H,         newb ## D;\
        ror     $16,            a    ## D;\
        xor     s0(ctx,newa,4), tmp1 ## D;\
        xor     s1(ctx,newb,4), tmp1 ## D;\
        movzx   a ## B,         newa ## D;\
        movzx   a ## H,         newb ## D;\
        xor     s2(ctx,newa,4), tmp1 ## D;\
        xor     s3(ctx,newb,4), tmp1 ## D;\
        ror     $16,            a    ## D;\
        movzx   b ## B,         newa ## D;\
        movzx   b ## H,         newb ## D;\
        ror     $16,            b    ## D;\
        xor     s1(ctx,newa,4), tmp2 ## D;\
        xor     s2(ctx,newb,4), tmp2 ## D;\
        movzx   b ## B,         newa ## D;\
        movzx   b ## H,         newb ## D;\
        xor     s3(ctx,newa,4), tmp2 ## D;\
        xor     s0(ctx,newb,4), tmp2 ## D;\
        ror     $15,            b    ## D;\
        add     tmp2 ## D,      tmp1 ## D;\
        add     tmp1 ## D,      tmp2 ## D;\
        add     tmp1 ## D,      key1 ## D;\
        add     tmp2 ## D,      key2 ## D;\
        mov     olda ## D,      newa ## D;\
        mov     oldb ## D,      newb ## D;\
        mov     a    ## D,      olda ## D;\
        mov     b    ## D,      oldb ## D;\
        xor     key1 ## D,      newa ## D;\
        xor     key2 ## D,      newb ## D;\
        ror     $1,             newa ## D

At least a little bit more readable, right?

-- 
  Dag Arne
