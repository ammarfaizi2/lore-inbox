Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTBDXN7>; Tue, 4 Feb 2003 18:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbTBDXN7>; Tue, 4 Feb 2003 18:13:59 -0500
Received: from smtp1.utdallas.edu ([129.110.10.12]:29677 "EHLO
	smtp1.utdallas.edu") by vger.kernel.org with ESMTP
	id <S267553AbTBDXN4>; Tue, 4 Feb 2003 18:13:56 -0500
Message-ID: <6893267.1044400971466.JavaMail.jelucas@utdallas.edu>
Date: Tue, 4 Feb 2003 17:22:51 -0600 (CST)
From: James E Lucas <jelucas@utdallas.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: natsemi.c: Oversized(?) ethernet frame message w/ card hang
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick response.  The program I wrote can be retrieved at 
http://www.utdallas.edu/~jelucas/nstress.zip

I included the source file, and a binary compiled with mingw.  Of 
course, there are no guarantees on this.  I'm running it from win2k, I 
can't remember if there are any version dependencies in the program... 
should work under any NT version at least.  Syntax is nstress <IP 
address>.

Generally, what I've done is have an ssh session open to the offending 
box, and run tcpdump to watch the card.  Then I start throwing packets 
at it.  Between all the ssh traffic and the massive load, that usually 
brings things down pretty quick; within about 30 - 60 seconds.

The spec for the chip that I've been looking at can be found at  
http://www.national.com/ds/DP/DP83815.pdf

Take a look at page 82.  Now, in natsemi.c we find:

if ((desc_status&(DescMore|DescPktOK|DescRxLong)) != DescPktOK){
                        if (desc_status & DescMore) {
                                if (netif_msg_rx_err(np))
                                        printk(KERN_WARNING
                                                "%s: Oversized(?) 
Ethernet "
                                                "frame spanned multiple 
"
                                                "buffers, entry %#08x "
                                                "status %#08x.\n", 
dev->name,
                                                np->cur_rx, 
desc_status);
                                np->stats.rx_length_errors++;

Now, from page 82 of the spec:
A single packet may also cross descriptor boundaries. This is indicated 
by setting the MORE bit in all descriptors except the last one in the 
packet.


Maybe the chip is choking under load and spewing garbage into a packet? 
 Or trying to combine multiple packets...?  Perhaps this is a symptom 
and not the problem.  Maybe the chip's already plotzed, and this is a 
result before a total hang.

If that's the case, should we be resetting the chip at the point where 
the MORE alert comes in?  What would that do to open connections?  I 
don't know enough to say.

What has me wondering is that the card occasionally hangs apparently at 
random.  It may really be a chip bug that needs working around, and 
putting the card under heavy load just makes it show up by attrition.  
Or not.  I've actually been sitting on this one for a while, but it's 
nice to know I'm not the only one.

One related note: 
kernel: PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring 
class.

shows up in the syslog on every bootup.  That ID belongs to a (Via) PCI 
bridge on the motherboard.  I looked through the linux-kernel archives 
and saw that this had been remarked upon a few times, but nothing much 
was made of it.  I don't know what kind of board you're using... it's 
probably not even related, but I thought it worth a mention.

Sincerely,
James Lucas
