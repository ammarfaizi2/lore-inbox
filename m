Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312943AbSCZEMJ>; Mon, 25 Mar 2002 23:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312945AbSCZEMA>; Mon, 25 Mar 2002 23:12:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312942AbSCZELp>;
	Mon, 25 Mar 2002 23:11:45 -0500
Message-ID: <3C9FF4B3.3070408@mandrakesoft.com>
Date: Mon, 25 Mar 2002 23:10:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?ISO-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9FC76F.6050900@mandrakesoft.com> <20020326014050.GP1853@ufies.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:

>On Mon, Mar 25, 2002 at 07:57:19PM -0500, Jeff Garzik wrote:
>
>>This patch causes module defaults to be reused -- potentially incorrectly.
>>
>
>Wrong. How can the fact that a suspend/resume cycle increment the id be
>worst than the fact that the same cycle return idx to the previous
>state?
>
>The argument you have against this patch is WRONG.
>
>You think about NICs in a PCI slot. 
>That's changed the day the cardbus support was moved from pcmcia to the
>today implementation.
>You can't expect cardbus user to stop using the suspend mode because you
>expect your id to be attributed one time (that doesn't even make sense).
>
>I agree that this patch is not a full fix (I said it in my original
>post) but I disagree that it does any bad things. I would be interested
>to learn about a real case ?
>

Just exactly what I described.

The current system increments the card id on each ->probe, and does not 
decrement on ->remove, which makes sense if you are hotplugging one card 
and then another -- you don't want to reuse the same module options for 
a different card.  Your patch changes this logic to, "oh wait, let's 
stop doing this and have a special case once we reach MAX_UNITS"  Thus, 
you could potentially reuse the final slot when that was not the desired 
action.

Note that I am not defending this method of card_idx usage, because 
different use cases have different requirements (as indeed you do).  But 
your patch fixes one thing at the expense of another.

I just had another idea.  Create a new module option 'default_options', 
a single integer value.  Instead of assigning "-1" to options when we 
run out of MAX_UNITS ids, assign the default_options value.



>>This is a personal solution, that might live on temporary as an 
>>outside-the-tree patch... but we cannot apply this to the stable kernel.
>>
>>I agree the card idx is wrong on remove.  Insert and remove a 3c59x 
>>cardbus card several times, and you will lose your module options too. 
>>
>
>NO -- If I can remove/insert suspend/remove my card as I want I ever get
>the same ID. 
>
"same id" is vague.  Same PCI id?  Sure, but that doesn't mean it's the 
same card, from the driver's point of view. The driver really needs to 
keep track of whether or not a new ->probe indicates a card whose MAC 
address we have seen before.

To reiterate another issue, however, suspend/resume should _not_ be 
calling the code added in your patch.  That's a non-3c59x bug somewhere.

    Jeff




