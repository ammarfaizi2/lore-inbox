Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUEOA1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUEOA1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUEOAYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:24:45 -0400
Received: from ns.clanhk.org ([69.93.101.154]:21648 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265313AbUEOAX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:23:28 -0400
Message-ID: <40A5630F.4040806@clanhk.org>
Date: Fri, 14 May 2004 19:23:43 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/video/riva/fbdev.c broken on x86_64
References: <40A514BD.1050308@clanhk.org>	<je4qqi1yxp.fsf@sykes.suse.de> <20040514163620.13b9172b.akpm@osdl.org>
In-Reply-To: <20040514163620.13b9172b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas' patch fixed part of the cursor problem, at least on the shell 
it's horizontal and not vertical.  However, it's still glitchy, in 
particular in a 'make menuconfig' the cursor blinks with random garbage 
in it.  I think it has to do with this warning:

  CC      drivers/video/fbmem.o
drivers/video/fbmem.c: In function `fb_cursor':
drivers/video/fbmem.c:917: warning: passing arg 1 of `copy_from_user' 
discards qualifiers from pointer target type

This line:
                if (copy_from_user(cursor.image.data, 
sprite->image.data, size) ||

-ryan

Andrew Morton wrote:

>Andreas Schwab <schwab@suse.de> wrote:
>  
>
>>         for (i = 0; i < h; i++) {
>>    
>>
>>>->             b = *((u32 *)data);
>>>                b = (u32)((u32 *)b + 1);
>>>->              m = *((u32 *)mask);
>>>                m = (u32)((u32 *)m + 1);
>>>      
>>>
>>It appears that someone tried to fix the use of cast as lvalue and failed
>>miserably.
>>    
>>
>
>That would be me.
>
>How about we simplify things a bit?
>
>
>
>
>---
>
> 25-akpm/drivers/video/riva/fbdev.c |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)
>
>diff -puN drivers/video/riva/fbdev.c~fbdev-lval-fix drivers/video/riva/fbdev.c
>--- 25/drivers/video/riva/fbdev.c~fbdev-lval-fix	Fri May 14 16:34:10 2004
>+++ 25-akpm/drivers/video/riva/fbdev.c	Fri May 14 16:35:32 2004
>@@ -492,17 +492,17 @@ static inline void reverse_order(u32 *l)
>  * CALLED FROM:
>  * rivafb_cursor()
>  */
>-static void rivafb_load_cursor_image(struct riva_par *par, u8 *data, 
>-				     u8 *mask, u16 bg, u16 fg, u32 w, u32 h)
>+static void rivafb_load_cursor_image(struct riva_par *par, u8 *data8,
>+				     u8 *mask8, u16 bg, u16 fg, u32 w, u32 h)
> {
> 	int i, j, k = 0;
> 	u32 b, m, tmp;
>+	u32 *data = (u32 *)data8;
>+	u32 *mask = (u32 *)mask8;
> 
> 	for (i = 0; i < h; i++) {
>-		b = *((u32 *)data);
>-		b = (u32)((u32 *)b + 1);
>-		m = *((u32 *)mask);
>-		m = (u32)((u32 *)m + 1);
>+		b = *data++;
>+		m = *mask++;
> 		reverse_order(&b);
> 		
> 		for (j = 0; j < w/2; j++) {
>
>_
>
>  
>

