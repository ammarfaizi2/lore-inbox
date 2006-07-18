Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWGRQUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWGRQUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGRQUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:20:50 -0400
Received: from zaz.kom.auc.dk ([130.225.51.10]:8880 "EHLO zaz.kom.auc.dk")
	by vger.kernel.org with ESMTP id S1751357AbWGRQUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:20:50 -0400
Message-ID: <44BD0A5F.4090001@kom.aau.dk>
Date: Tue, 18 Jul 2006 18:20:47 +0200
From: Oumer Teyeb <oumer@kom.aau.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange TCP SACK behaviour in Linux TCP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guys,

I have some questions regarding TCP SACK implementation in Linux .
As I am a subscriber, could you please cc the reply to me? thanks!


I am doing these experiments to find out the impact of reordering. So I 
have different TCP versions (newReno, SACK, FACk, DSACK, FRTO,....) as 
implemented in Linux. and I am trying their combination to see how they 
behave. What struck me was that when I dont use timestamps, introducing 
SACK increases the download time but decreases the total number of 
retransmissions.
When timestamps is used, SACK leads to an increase in both the download 
time and the retransmissions.

So I looked further into the results, and what I found was that when 
SACK  is used, the retransmissions seem to happen earlier .
at www.kom.auc.dk/~oumer/first_transmission_times.pdf
you can find the pic of cdf of the time when the first TCP 
retransmission occured for the four combinations of SACK and timestamps 
after hundrends of downloads of a 100K file for the different conditions 
under network reordering...

This explains the reason why the download time increases with SACK, 
because the earlier we go into fast recovery the longer the time we 
spend on congestion avoidance, and the longer the download time....

...but I couldnt figure out why the retransmissions occur earlier for 
SACK than no SACK TCP. As far as I know, for both SACK and non SACK 
cases, we need three (or more according to the setting) duplicate ACKs 
to enter the fast retransmission /recovery state.... which would have 
resulted in the same behaviour to the first occurance of a 
retransmission..... or is there some undocumented enhancment in Linux 
TCP when using SACK that makes it enter fast retransmit earlier... the 
ony explanation I could imagine is something like this

non SACK case
=============
1 2 3 4 5 6 7 8 9 10..... were sent and 2 was reorderd....and assume we 
are using delayed ACKs...and we get a triple duplicate ACK after pkt#8 
is received. (i.e 3&4--first duplicate ACK, 5&6..second duplicate ACK 
and 7&8...third duplicate ACK.....)...

so if SACK behaved like this...

3&4 SACKEd.... 2 packets out of order received
5&6 SACKEd....4 packets out of order received.... start fast 
retransmission....as reorderd is greater than 3.... (this is true when 
it comes to marking packets as lost during fast recovery, but is it true 
als for the first retransmission?)

.. any ideas why this is happening???


Thanks in advance,
Oumer

