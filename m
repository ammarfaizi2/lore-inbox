Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268667AbRGZTzR>; Thu, 26 Jul 2001 15:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268666AbRGZTzH>; Thu, 26 Jul 2001 15:55:07 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:59529 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S268667AbRGZTyw>;
	Thu, 26 Jul 2001 15:54:52 -0400
Date: Thu, 26 Jul 2001 20:54:48 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Dawson Engler <engler@csl.Stanford.EDU>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Evan Parker <nave@stanford.edu>, linux-kernel@vger.kernel.org,
        mc@CS.Stanford.EDU,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
Message-ID: <602725597.996180886@[169.254.62.211]>
In-Reply-To: <200107260113.SAA11847@csl.Stanford.EDU>
In-Reply-To: <200107260113.SAA11847@csl.Stanford.EDU>
X-Mailer: Mulberry/2.1.0b1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



>> > other 10 are questionable.  Those 10 are all simple variations on the
>> > following code:
>> >
>> > Start --->
>> > 	if (!tmp_buf) {
>> > 		page = get_free_page(GFP_KERNEL);
>> >
>> > Error --->
>> > 		if (tmp_buf)
>> > 			free_page(page);
>> > 		else
>> > 			tmp_buf = (unsigned char *) page;
>> > 	}
>>
>> That one is not a bug. The serial drivers do this to handle a race.
>> Really it should be

May be I'm being dumb here, and without wishing to open the 'volatile'
can of worms elsewhere, but:

   static char * tmp_buf;

How will this be guaranteed to help handle a race, when gcc is
likely either to have tmp_buf in a register (not declared
volatile), or perhaps even optimize out the second reference.
Seems to me (and I may well be wrong), either there is a
race thread (tmp_buf being assigned between the first
test and grabbing the page), in which case as tmp_buf may
be in a register, it doesn't avoid the race (and potentially
stomps on the existing buffer), or there is not a race, in
which case the second check is unnecessary. IE the checker
found a real bug.

--
Alex Bligh
