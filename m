Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbULHTyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbULHTyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbULHTyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:54:38 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:16102
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S261339AbULHTyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:54:33 -0500
Message-ID: <41B75BF3.7090008@pbl.ca>
Date: Wed, 08 Dec 2004 13:54:27 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Retransmitted packets ignored?
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I started to experience rather strange problems with one 
monitoring appliaction I have (basically, it just checks if remote IMAP 
server is alive).  After looking into it, it seems to be problem with 
Linux TCP stack.

What happens on TCP level is something like this:

  - the three-way handshake goes well
  - monitoring app sends IMAP logout command (blindly, without waiting 
for the banner from IMAP server)
  - remote side responds with banner message (OK blah blah)
  - remote side sends response to logout command (* BYE ... ) and sets 
FIN flag on this packet, closing the connection

Now, sometimes the link to remote site is flaky, and drops the packet or 
two.  If it happens to the last two packets, I see the remote Linux box 
merging previous two packets into one, and retransmitting (again, with 
FIN flag set).  However, Linux box where monitoring application runs 
seems to ignore those retransmitted packets for whatever reason.

I've checked the sequence numbers and acknowledgement numbers on all 
packets (basically, followed entire TCP connection packet by packet, 
checking everything is sane using pen and paper), and everything seems 
OK (well, other than two dropped packets, but those should have been 
taken care of by retransmissions).

Both sides are running 2.4 series kernels.  Were there any recent fixes 
or updates to TCP protocol stack?

This is how it looks in tcpdump from viewpoint of local machine ("a"). 
Three way handshake goes well:

a.3994 > b.imap: S 1476546745:1476546745(0) win 5840 <mss 
1460,sackOK,timestamp 3097547910 0,nop,wscale 0> (DF)

b.imap > a.3994: S 2105003620:2105003620(0) ack 1476546746 win 5792 <mss 
1460,sackOK,timestamp 1015114245 3097547910,nop,wscale 0> (DF)

a.3994 > b.imap: . ack 1 win 5840 <nop,nop,timestamp 3097547914 
1015114245> (DF)

Logout command is sent (15 bytes):

a.3994 > b.imap: P 1:16(15) ack 1 win 5840 <nop,nop,timestamp 3097547914 
1015114245> (DF)

Ack for previous packet:

b.imap > a.3994: . ack 16 win 5792 <nop,nop,timestamp 1015114248 
3097547914> (DF)

At this point, two packets get lost in transmission (148 bytes (banner) 
and 91 bytes (response to logout command) of data respectively, visible 
from tcpdump that was running on remote side), so on local side I see 
only retransmissions for them merged into one packet (239 bytes):

b.imap > a.3994: FP 1:240(239) ack 16 win 5792 <nop,nop,timestamp 
1015114276 3097547914> (DF)

b.imap > a.3994: FP 1:240(239) ack 16 win 5792 <nop,nop,timestamp 
1015114330 3097547914> (DF)

There's couple of more retransmissions (identical to above two) before 
machine "a" times out the connection, and sends FIN ACK=1, remote side 
responds with ACK=17 (basically, local machine acknowledged transmission 
of zero bytes, and remote side of 15 bytes (the logout command)).  At 
this point monitoring application concludes something is wrong with IMAP 
server (it connected, but there was no response) and sends an alarm.

Another interesting thing I noticed was that remote machine ("b") sent 
two or three more retransmissions after it acknowledged connection 
closing (FIN ACK, ACK).  Shouldn't it given up as soon as it got FIN ACK?

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
