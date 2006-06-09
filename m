Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWFINdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWFINdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbWFINdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:33:11 -0400
Received: from uekaegateway.mam.gov.tr ([193.140.74.2]:26616 "EHLO
	uekae.uekae.gov.tr") by vger.kernel.org with ESMTP id S965258AbWFINdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:33:10 -0400
Subject: Re: Discovering select(2) parameters from driver's poll method
From: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
To: Linux e-posta listesi <linux-kernel@vger.kernel.org>
In-Reply-To: <20060609125210.E4276490168@uekae.uekae.gov.tr>
References: <20060609114940.01442490169@uekae.uekae.gov.tr>
	 <20060609125210.E4276490168@uekae.uekae.gov.tr>
Content-Type: text/plain
Organization: TUBITAK / UEKAE
Date: Fri, 09 Jun 2006 16:34:12 +0300
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20060609133300.7528F490168@uekae.uekae.gov.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your answer.

I agree you, but your assumption is correct for a generic device, not
mine.  The purpose of my driver is slightly different and is not to
realize user space request, like other drivers in Linux kernel do.  My
goal is to forward the userspace system call to a remote computer, and
therefore I need information about these variables in order to call them
correctly via an user space application on the remote host.

I experienced a similar problem with mmap call, because I couldn't
guarantee the synchronization of both memory blocks since mmap does not
imply a barrier while reaching the memory. However the applications (for
example camorama for webcam) using mmap generally can switch back to
read/write with a paramater (here, -R) and therefore my driver currently
does not support mmap.  For other system calls in struct
file_operations, it works perfectly.

In short, the difference of my driver's purpose does not mean that my
driver is broken.  The fact is I must know the parameter to be able to
implement the system call in a remote host.  Please let me know if I can
reconstruct a poll/select system call.  


Best wishes,

Ozan Eren Bilgen


PS: Currently, if the driver's poll method is invoqued, I call 

	select(n, &readfds, &readfds, &exceptionfds, &tv);

on the remote host by putting the descriptor into all 3 fds and setting
tv={0,0} (it returns immediately if there is nothing interesting, since
nobody knows how much has it to wait in reality).


On Fri, 2006-06-09 at 08:52 -0400, linux-os (Dick Johnson) wrote:
> On Fri, 9 Jun 2006, Ozan Eren Bilgen wrote:
> 
> > *** Please CC me your responses ***
> >
> > Hi,
> >
> > I am writing a device driver and I have problem with poll method.  For
> > some reason, I need learn the timeout and descriptor sets of select(2)
> > call.  Other words to say, if the user space process calls:
> >
> > 	select(n, &readfds, NULL, &exceptionfds, &tv);
> >
> > With the help of my poll implementation in device driver, I want to
> > learn that only the write fds is empty.  I am also interested in the
> > value of timeout parameter.  Please let me know if this is possible.
> >
> 
> If you want to know, your driver is HORRIBLY BROKEN beyond any
> repair.
> 
> The kernel handles poll in a POSIX correct manner. There is a
> link into your device driver which is __not__ directly attached
> to the user's poll call, even though its name is similar. Your
> driver must properly signal the kernel, with the proper wake-up
> call, after the proper bits are put into the poll variable, any
> time anything has changed.
> 
> If or when user action (read, write, etc.) changes those bits,
> then they must also be updated -- and the kernel again signaled
> that those bits have changed.
> 
> > By the way, I checked out some Linux device drivers, which are
> > implemented poll method, and related books like LDD.  Everywhere,
> > poll_wait is called for both read and write queues, without taking the
> > select(2) call's parameters into account.  For example it still waits
> > for the read queue although the select call was looking only for write
> > fds.  My second question is, why a poll method queries all the queues,
> > instead of querying only the necessary one?
> 
> Wrong. The kernel calls the poll function in the driver. The user code
> does not call this directly. The kernel knows what fds are active
> for whatever. Your driver **MUST NOT**!
> 
> >
> > Thank you in advance,
> >
> > Ozan Eren Bilgen
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
> New book: http://www.AbominableFirebug.com/
> _
> 
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.

