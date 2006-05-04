Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWEDTnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWEDTnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWEDTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:43:37 -0400
Received: from bay105-f38.bay105.hotmail.com ([65.54.224.48]:30490 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030300AbWEDTng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:43:36 -0400
Message-ID: <BAY105-F38F372575F5B72AF1DACE6E9B40@phx.gbl>
X-Originating-IP: [84.81.201.82]
X-Originating-Email: [rwm_rietveld@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0605041459220.7134@chaos.analogic.com>
From: "Roy Rietveld" <rwm_rietveld@hotmail.com>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
Date: Thu, 04 May 2006 19:43:34 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 04 May 2006 19:43:35.0982 (UTC) FILETIME=[088B64E0:01C66FB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i Think the resolution of gettimeofday is 1us because
gettimeofday(start)
gettimeofday(end)

end - start gives 1

so when i leave out gettimeofday

while(1)
{
sendto(socket,buffer,1400,....)
}

i measured with ethereal 4000 packets per second
so

1400+headers = 1442

1442*8*4000 = 46MBits

I read something about zero copy may i need somelike that.

>From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>To: "Roy Rietveld" <rwm_rietveld@hotmail.com>
>CC: <linux-kernel@vger.kernel.org>, <jengelh@linux01.gwdg.de>
>Subject: Re: TCP/IP send, sendfile, RAW
>Date: Thu, 4 May 2006 15:12:34 -0400
>
>
>On Thu, 4 May 2006, Roy Rietveld wrote:
>
> > i tried but it doesn't help, still 40MBits. Does send or sento cost a 
>lot of
> > cpu load.
> >
> > i tried to measure the cpu time sendto cost.
> >
> > gettimeofday(start)
> > sendto
> > gettimeofday(end)
> >
> > print end - start
> >
> > time measured is 250 us.
> >
>
>That's probably the granuarity of gettimeofday().
>
>You need to do something like:
>          #define USEC 1e6
>  	double start_time, end_time, total_time, bytes_per_second;
>          get_timeofday(&tb);
>          start_time_usec = ((double)tb.tv_sec * USEC) + 
>(double)tb.tv_usec;
>  	for(i= 0; i <1000; i++)
>              sendto(s, buf, buf_size,...);
>          get_timeofday(&tb);
>          end_time_usec = ((double)tb.tv_sec * USEC) + (double)tb.tv_usec;
>          total_time = (end_time_usec - start_time_usec) / USEC;
>          bytes_per_second = (buf_size * 1000) / total_time;
>
>
> >
> >> From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
> >> Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
> >> To: "Roy Rietveld" <rwm_rietveld@hotmail.com>
> >> CC: <linux-kernel@vger.kernel.org>,<jengelh@linux01.gwdg.de>
> >> Subject: Re: TCP/IP send, sendfile, RAW
> >> Date: Thu, 4 May 2006 14:27:47 -0400
> >>
> >>
> >> On Thu, 4 May 2006, Roy Rietveld wrote:
> >>
> >>> Yes it is 100 MBits and there is a listener. and there are no other 
>pc's
> >> on
> >>> the link because its cross cable link. And when sending large buffers
> >>> 32Kbyte it will do 80 MBits. It think that there is a lot of overhead 
>in
> >> the
> >>> fucntion send or something.
> >>>
> >>
> >> Use sendto() and recvfrom() for UDP. Stream protocols require an ACK 
>and
> >> are slower.
> >>
> >>>
> >>>> From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
> >>>> Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
> >>>> To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
> >>>> CC: "Roy Rietveld"
> >>>> <rwm_rietveld@hotmail.com>,<linux-kernel@vger.kernel.org>
> >>>> Subject: Re: TCP/IP send, sendfile, RAW
> >>>> Date: Thu, 4 May 2006 13:56:31 -0400
> >>>>
> >>>>
> >>>> On Thu, 4 May 2006, Jan Engelhardt wrote:
> >>>>
> >>>>>> I would like to send ethernet packets with 1400 bytes payload.
> >>>>>> I wrote a small program witch sends a buffer of 1400 bytes in a
> >> endless
> >>>> loop.
> >>>>>> The problem is that a would like 100Mbits throughtput but when i
> >> check
> >>>> this
> >>>>>> with ethereal.
> >>>>>> I only get 40 MBits. I tried sending with an UDP socket and RAW
> >> socket.
> >>>> I also
> >>>>>> tried sendfile.
> >>>>>> The RAW socket gives the best result till now 50 MBits throughtput.
> >>>>>
> >>>>> Limitation of Ethernet.
> >>>>>
> >>>>>
> >>>>>
> >>>>> Jan Engelhardt
> >>>>
> >>>> Maybe he can tell what he means by 100 MBits! If he is looking for
> >>>> 100 megabits per second, that's easy, That's 100/8 = 12.5 megabytes
> >>>> per second. Anything, including Windows on a wet string, will
> >>>> do that. If he is looking for 100 megabytes per second, that's
> >>>> hard. He would need 100 * 8 = 800 megabits/second. A "gigabit" link
> >>>> runs that fast if nobody else is on it, but there is a header and CRC
> >>>> tail, in addition to the payload. UDP is the protocol to use to 
>realize
> >>>> this kind of bandwidth, but its possible for some packets to get lost
> >> and,
> >>>> if they are routed, they could even be duplicated. Also, when testing
> >>>> UDP, there must be a listener in order to realize the high speed.
> >>>> You can't just spew out a dead-end link.
> >>>>
> >>>> Cheers,
> >>>> Dick Johnson
> >>>> Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 
>BogoMips).
> >>>> New book: http://www.lymanschool.com
> >>>> _
> >>>> 
> >>>>
> >>>> ****************************************************************
> >>>> The information transmitted in this message is confidential and may 
>be
> >>>> privileged.  Any review, retransmission, dissemination, or other use 
>of
> >>>> this information by persons or entities other than the intended
> >> recipient
> >>>> is prohibited.  If you are not the intended recipient, please notify
> >>>> Analogic Corporation immediately - by replying to this message or by
> >>>> sending an email to DeliveryErrors@analogic.com - and destroy all
> >> copies of
> >>>> this information, including any attachments, without reading or
> >> disclosing
> >>>> them.
> >>>>
> >>>> Thank you.
> >>>> -
> >>>> To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel"
> >> in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>> Please read the FAQ at  http://www.tux.org/lkml/
> >>>
> >>>
> >>>
> >>
> >> Cheers,
> >> Dick Johnson
> >> Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
> >> New book: http://www.lymanschool.com
> >> _
> >> 
> >>
> >> ****************************************************************
> >> The information transmitted in this message is confidential and may be
> >> privileged.  Any review, retransmission, dissemination, or other use of
> >> this information by persons or entities other than the intended 
>recipient
> >> is prohibited.  If you are not the intended recipient, please notify
> >> Analogic Corporation immediately - by replying to this message or by
> >> sending an email to DeliveryErrors@analogic.com - and destroy all 
>copies of
> >> this information, including any attachments, without reading or 
>disclosing
> >> them.
> >>
> >> Thank you.
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
>New book: http://www.lymanschool.com
>_
>
>
>****************************************************************
>The information transmitted in this message is confidential and may be 
>privileged.  Any review, retransmission, dissemination, or other use of 
>this information by persons or entities other than the intended recipient 
>is prohibited.  If you are not the intended recipient, please notify 
>Analogic Corporation immediately - by replying to this message or by 
>sending an email to DeliveryErrors@analogic.com - and destroy all copies of 
>this information, including any attachments, without reading or disclosing 
>them.
>
>Thank you.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


