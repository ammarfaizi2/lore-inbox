Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSFEPGD>; Wed, 5 Jun 2002 11:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSFEPGD>; Wed, 5 Jun 2002 11:06:03 -0400
Received: from mail.univie.ac.at ([131.130.1.27]:51348 "EHLO
	mailbox.univie.ac.at") by vger.kernel.org with ESMTP
	id <S315454AbSFEPF6>; Wed, 5 Jun 2002 11:05:58 -0400
Message-ID: <3CFE28B5.2050005@univie.ac.at>
Date: Wed, 05 Jun 2002 17:05:25 +0200
From: Gerald Teschl <gerald.teschl@univie.ac.at>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] opl3sa2 isapnp activation fix
In-Reply-To: <Pine.LNX.4.44.0206051414200.26634-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>Isn't 0 listed in a BAR register anyway? Can't you read it after a 
>prepare? 
>
I don't know what you mean by a BAR register. As far as I can tell, 
prepare does nothing than
setting all values in the dev struct to zero and the flags to AUTO. So 
after the prepare call

dev->dma_resource[i].start = dev->dma_resource[i].end = 0


for i=0,1. So I don't think this can be used for a test.

The current version tests ALL dma resources which the card lists as 
acceptable for the first dma.
If there is no acceptable configuration other than dma=0, then I give it 
dma=0 (see also below).

>My only objection to your patch is the hardcoded 0 and 1, get rid 
>of that and you'll get rid of my nagging ;) 
>
What is the differnece between your suggestion

if (a == 0)
    b = a;

and my

if (a == 0)
    b = 0;

>
>+               struct isapnp_resources *res;
>+               int max;
>+               res = (struct isapnp_resources *)dev->sysdata;
>+               max = res->dma->map;
>+               for (res = res->alt; res; res = res->alt) {
>+                       if (res->dma->map > max)
>+                               max = res->dma->map;
>+               }
>
>I'm sure you don't have to go to the extent of walking the resource lists.
>
I don't see any other way.

>
>+               if (max == 1) {
>+                       /* isapnp.c disallows dma=0 but this card only 
>accepts dma=0. */
>+                       printk(KERN_DEBUG PFX "Setting dma 0.\n");
>+                       isapnp_resource_change(&dev->dma_resource[0], 0, 
>1);
>+               }
>
>This is dangerous on some boxes, especially if the card failed detect for 
>some reason and we retry with DMA-0
>
As I saied, "max == 1" implies that the card will not accept any other 
value. So activation will fail for
sure unless I assign dma=0. The current version is better since the old 
version would use dma=0 even
if the activate failed for reasons other than dma settings. Now, dma=0 
will NOT be used if there is ANY other
configuration acceptable by the card. If there is an opl3sa2 card in a 
box which only works with dma=0,
but where the box does not allow dma=0, this system is already broken in 
the first place.

BTW, is this "some BIOS don't allow dma 0" somewhere documented? Is this 
a BIOS bug or a "normal" case.
I could not find anything on this other then the comment in isapnp.c.

Moreover, what happens if you use dma=0 on such a box?

case a) The sound card does not work.
case b) The box locks up

if a) It will not work any other way, so it makes no difference.
if b) With my patch the box will lock up upon insertion of the sound module.
       Without my patch, the user will eventually assign dma=0 by hand 
and the box will lock up.
       Again no difference IMHO?

Without my patch this card will never work out of the box. But there 
seems to be a real need for this
as far as I can tell from the amount of email I got with respect to the 
web page where I explain how
to get linux running on this f$%^ asus laptop.

Thanks for your help to find the right(tm) solution,
Gerald

