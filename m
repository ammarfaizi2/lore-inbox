Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310330AbSCGNxh>; Thu, 7 Mar 2002 08:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310329AbSCGNx2>; Thu, 7 Mar 2002 08:53:28 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:14610 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S310328AbSCGNxP>;
	Thu, 7 Mar 2002 08:53:15 -0500
Message-ID: <3C8770D5.3090209@cronyx.ru>
Date: Thu, 07 Mar 2002 16:53:25 +0300
From: Roman Kurakin <rik@cronyx.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Ed Vance <EdV@macrolink.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial.c BUG 2.4.x-2.5x
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76CB@EXCHANGE> <20020306203936.C26344@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Russell King wrote:

>On Fri, Mar 01, 2002 at 11:07:03AM -0800, Ed Vance wrote:
>
>>On Fri, Mar 01, 2002 at 4:19 AM, Roman Kurakin wrote:
>>
>>>    Who is responsible person for applying [serial driver] patches 
>>>    to main tree?
>>>
>
>This particular bug has already been fixed in the rewrite, as I originally
>said back on 14 November 2001.
>
I remember this, I thought some one responsible for updating current 
version of the main tree.
Now I see the reason this didn't  get into recent stable versions.

>The patch does fine for the most part, but I have two worries:
>
>1. the possibilities of pushing through changes in the IO or memory space
>   by changing the other space at the same time. (ie, port = 1, iomem =
>   0xfe007c00 and you already have a line at port = 0, iomem = 0xfe007c00).
>   I delt with this properly using the resource management subsystem.
>
I think such code could solve this problem ...

- 			    (rs_table[i].port == new_port) &&
+ 			    ((rs_table[i].port && rs_table[i].port == new_port) ||
+			    ((rs_table[i].iomem_base && rs_table[i].iomem_base == new_mem)) &&
 

>2. there seems to be a lack of security considerations for changing the
>   iomem address.  (ie, changing the iomem address without CAP_SYS_ADMIN.
>   I added this as an extra check for change_port)
>
And this one could be fixed with something like this (this is no a 
patch, just an idea)

        change_port = (new_port != ((int) state->port)) ||
                (new_serial.hub6 != state->hub6);
+        change_mem = (new_mem != state->iomem_base)

        if (!capable(CAP_SYS_ADMIN)) {
-                if (change_irq || change_port ||
+                if (change_irq || change_port || change_mem

As I wrote I didn't check serial.c for all possible problems, I just 
find one bug and suggested
the way it could be solved.

Best regards,
                        Roman Kurakin

>>I then asked Russell to set the rules for this co-ordination and no response
>>has been forthcoming. Perhaps he missed my question?
>>
>
>I have a fair bit of email backed up at the moment, but I have been in
>contact with Ted T'so recently.  I won't say much more at the moment,
>but should have something in a month or two.  Until then I'd rather not
>say too much publically.
>




