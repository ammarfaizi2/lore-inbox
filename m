Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWJMTbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWJMTbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWJMTbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:31:12 -0400
Received: from web58109.mail.re3.yahoo.com ([68.142.236.132]:41349 "HELO
	web58109.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751012AbWJMTbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:31:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s+D2usy9KyiGOU+97tcU44PjoslFEQ7b/ahIdlM0HZiygPrr3ZkqPHbWWKe51gA81FyPTqmfdrCde6JRNTIPDtZkjkG+9S6t/LEkjnzXkdOiRKQ+5ioSuy64pkcpbPgsXcUDDKboZEDyGg7Htedsc3/L6ZkfYeWTsXAb66hvL+4=  ;
Message-ID: <20061013193107.43500.qmail@web58109.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 12:31:07 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
To: =?iso-8859-1?Q?WolfgangM=FCes?= <wolfgang@iksw-muees.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfgang (and all),

Thanks for the input.  However, I am not understanding
exactly why kernel mode is treated any differently than
user mode for this sort of thing.  I am looking at the code
in ehci-q.c and ehci-hcd.c.

It seems like the unlinking of completed URBs
happens asynchronously on a timer.  This is a
surprise to me since I thought this was happening
on an IRQ from the host controller.  But if what I'm
surmising is correct it would explain everything
I am seeing.  I'm not able to ascertain how
user mode drivers are treated differently than
kernel mode drivers in this regard.  From what I
can tell, all drivers would be broken equally!
Can anyone who has more experience
with this code confirm this for me?
  
Besides, we count on sub-10 ms response times all the
time in user mode.  Take for example, the access of a file.
If opening a file had a fixed latency of 4 ms, people
would be up in arms.  So that's not entirely a valid excuse.
A USB operation that used to take 1 ms now takes 4 ms.
That's a pretty big change.

The ability to write user-mode drivers for USB devices
is very powerful for deployment.  If one writes a kernel
driver, there are severe deployment hassles.  As such,
my company has chosen to write user-mode drivers
on both Windows to avoid driver deployment nightmares.
This has been extremely successful so far..  Ironically,
Windows (using libusb-win32) has had no such performance
glitches. As a matter of principle, Linux should at least be
as good as Windows, right?

Hopefully we can get this sorted out.

Cheers.


----- Original Message ----
From: WolfgangMües <wolfgang@iksw-muees.de>
To: linux-usb-devel@lists.sourceforge.net
Sent: Friday, October 13, 2006 12:11:08 PM
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)

On Friday 13 October 2006 19:20, Open Source wrote:
> Alan -- yes, I understand the ability to increase throughput
> by transfering more bytes and I am definitely able to see
> better overall throughput when increasing the number
> of bytes per transaction.  However, I needs to still have
> good transaction-level timing because I cannot always
> queue the transactions up.  Recall that each transaction
> is a WRITE followed by a READ.  The results of the
> READ determine the outgoing bytes for the following
> transaction's WRITE.

Relying on sub-10ms response times in userspace is broken by design.

I have written a driver with similar timing requirements, and I have 
done it in the kernel. This is the right way to go. Nothing else.

regards

Wolfgang
-- 
Das Leben kann nur rückwärts verstanden,
muß aber vorwärts gelebt werden.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel





