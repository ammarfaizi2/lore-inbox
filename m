Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbRAZU44>; Fri, 26 Jan 2001 15:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbRAZU4q>; Fri, 26 Jan 2001 15:56:46 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:13773 "EHLO
	auemlsrv.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S130599AbRAZU40>; Fri, 26 Jan 2001 15:56:26 -0500
Date: Fri, 26 Jan 2001 14:56:22 -0600
From: Dave Dykstra <dwd@bell-labs.com>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010126145622.A25707@lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Alexey's message from the mailing list archive:

> Hello! 
> 
> I take my words back. Manfred is right, this requirement is not a MUST. 
> 
> Real problem is much worse, and it is wholly on the shame of solaris. 
> Tcpdump shows at least two different bugs there. 
> 
>   2060 16:31:42.879337 eth0 < dynamic.ih.lucent.com.39406 > static.8664: . 675
> 80:67580(0) ack 1582261 win 1460 (DF) 
>   2061 16:31:42.907940 eth0 > static.8664 > dynamic.ih.lucent.com.39406: . 158
> 3721:1583721(0) ack 67580 win 1460 (DF) 
> 
> All is OK until now. Solaris's state should be: 
> 
> SND.NXT=SND.UNA=67580 
> SND.WND=1460 
> RCV.NXT=1582261 
> 
>   2062 16:31:42.908620 eth0 < dynamic.ih.lucent.com.39406 > static.8664: . 675
> 80:67581(1) ack 1583721 win 0 (DF) 
> 
> Solaris sends one byte. 
> 
> SND.NXT++ 
> RCV.NXT=1583721 
> 
>   2063 16:31:43.098761 eth0 > static.8664 > dynamic.ih.lucent.com.39406: . 158
> 3721:1583721(0) ack 67581 win 1460 (DF) 
> 
> We ACK it. 
> 
>   2064 16:31:43.100993 eth0 < dynamic.ih.lucent.com.39406 > static.8664: P 675
> 81:68456(875) ack 1583721 win 0 (DF) 
>   2065 16:31:43.101524 eth0 < dynamic.ih.lucent.com.39406 > static.8664: P 684
> 56:69041(585) ack 1583721 win 0 (DF) 
> 
> Solaris sends two segments, filling all the window. 
> 
> SND.NXT=69041 
> 
>   2066 16:31:43.108759 eth0 > static.8664 > dynamic.ih.lucent.com.39406: . 158
> 3720:1583720(0) ack 69041 win 0 (DF) 
> 
> We send zero window probe. SEG.SEQ=1583720. 
> 
> Solaris accepts ACK from it!!! (bug #1) But does not accept window. 


Why is it a bug to accept the ACK from it?  RFC793 page 69 says 

    If the RCV.WND is zero, no segments will be acceptable, but
    special allowance should be made to accept valid ACKs, URGs and
    RSTs.

Why shouldn't this be considered a valid ACK?


> So, now it thinks that SND.UNA=SND.NXT=69041 
>                        SND.WND=1460 
> 
> State is corrupted. 
> 
> This is hard bug. But it is still not fatal. Actually, such corruptions 
> (but by different reasons) are common with stacks, which borrowed code 
> from BSD. Look into tcp-impl, Subj: "Send window update algorithm ..." 
> They are recoverable, provided stack is sane. 
> 
>   2067 16:31:43.110623 eth0 < dynamic.ih.lucent.com.39406 > static.8664: P 690
> 41:69628(587) ack 1583721 win 0 (DF) 
> 
> Solaris send some crap out of window, because of corrupted state. 
> No problems. 
> 
>   2068 16:31:43.110679 eth0 > static.8664 > dynamic.ih.lucent.com.39406: . 158
> 3721:1583721(0) ack 69041 win 0 (DF) 
> 
> We tell "No pasaran", of course. 
> 
> According to rules, Solaris must shrink window now. 
> This is the only way to recover corrupted state. 
> 
>   2069 16:31:43.111641 eth0 < dynamic.ih.lucent.com.39406 > static.8664: P 696
> 28:70501(873) ack 1583721 win 0 (DF) 
> 
> It does not. And this is point after which recovery is impossible. 
> Fatal bug#2. 
> 
> To resume: it is impossible to help to this from Linux side. 
> We may accept ACK&WIN from out-of-window segments, and this 
> will help in this case _occasionally_. But Solaris is still 
> deemed to lockup randomly with such sawdust in the head. 


I agree that Solaris is wrong for continuing to send data even though the
Linux receive window is 0, and I'm trying to get a bug report into Sun. 
I did not find any mention of such a problem in their patches that are
available in their online support center for any release of Solaris (I've
seen it on Solaris 2.6 and 2.7 but haven't tried others) so this may take
quite a while to get the attention of the right people.

Doesn't it seem likely, however, that the bug is being triggered by the
zero window probe that is subtracting one from the sequence number?  I
couldn't find any mention of that kind of practice in the RFC, perhaps you
can point me to it.  Why doesn't the probe use the correct sequence number
instead of backing up one?  Perhaps a workaround is for Linux to not send
the zero probe with the deliberately incorrect sequence number.

- Dave Dykstra
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
