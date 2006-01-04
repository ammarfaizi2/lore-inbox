Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWADF25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWADF25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 00:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWADF25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 00:28:57 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:18532 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965195AbWADF25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 00:28:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pEfjk3mkbpZj5Ep3uKaAZfoHatugIKe6u/1XLK8Q0y5Tda6sReM059woOqcyzxhMP2ie1gZ8qhxg9IEZea6PUdRTQiSJlQw2vkNIJUvvENlMPxED7Cg1dUwu3WUjOQuQWX06lIk8lgeYi8UPzZi/glBMjeSaExhoCnXCBrAR7iU=
Message-ID: <7a37e95e0601032128l2c7d6e03v742de8dd485af9db@mail.gmail.com>
Date: Wed, 4 Jan 2006 10:58:56 +0530
From: Deven Balani <devenbalani@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Ping-Pong Compatible DMA buffer chaining
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1136250520.13968.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10300_404928.1136352536211"
References: <7a37e95e0512252205t68c6b6f6sfeedf3a75880fda9@mail.gmail.com>
	 <1136250520.13968.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10300_404928.1136352536211
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sir,

Basically My hardware is not allowing to do a scatter-gather list.
Might be my next version of Hardware _could_ allow me. So I decided to
come out with a _Work Around_.

please find attached sg_pingpong.txt.

My hardware has two Buffers B0 and B1 for both Tx and Rx path.
I had to fill the first buffer initially and then _continue_ a walk
through the sg list with help of buffer completion interrupts of B0 &
B1.

Can you suggest any inputs for this scenario.

Regards,
Deven

On 1/3/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-12-26 at 11:35 +0530, Deven Balani wrote:
> > 1) The SATA Host Controller supports a DMA Logic which has Ping Pong Bu=
ffers.
> > How Can I allocate a linear contiguous buffer and give it to the
> > Buffer Descriptors of the Host Controller. I believe consistent alloc
> > would help me in this regard. But How could I do a chaining of Buffers
> > in a Ping Pong Scenario which has Buffer Descriptors.
>
> Depends entirely on your hardware.
>
> > 2) The libata is using Scatter-Gather List to send Device Identify
> > Command. Is it necessary to have a Scatter-Gather List for non-PCI ARM
> > platforms. Can I bypass this mechanism.
>
> It is neccessary as the user space virtual memory will be fragmented in
> physical space (unless you are using MMUless Linux when it will be far
> less fragmented).
>
> If the platform is an MMUless one then you can fill in the host
> structure and indicate that you support a maximum scatter gather list
> size of one. This will break up I/O's when neccessary to keep within
> that limit but this will hurt your performance by causing a lot more
> requests on a non MMUless system.
>
> Alan
>
>



--
"A smile confuses an approaching frown..."

------=_Part_10300_404928.1136352536211
Content-Type: text/plain; name=sg_pingpong.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sg_pingpong.txt"

For conversion from SG list to ping pong:

Generate new sglist based on original sglist but taking into account MAX_DMA_BUF_SIZE bytes as the maximum per buffer.  This will simplify your continuance logic significantly.

For each entry in Sgentries
   set entry in progress to true
   while entry in progress
      if entry.buffersize larger than MAX_DMA_BUF_SIZE
         Add a new entry to SGentries1 a buffer of MAX_DMA_BUF_SIZE
         Decrement entry.buffersize by MAX_DMA_BUF_SIZE
         Increment entry.pointer by MAX_DMA_BUF_SIZE
      else
         Add a new entry to SGentries1 with a copy of current entry
         set entry in progress to false
   endwhile
endwhile

while more SGentries1 and at least one buffer free
      populate first active buffer with entry
        Remove entry from SGentries1
        toggle active buffer
endwhile

if SGentries1 is not empty
   enable DMA buffer complete interrupt
endif

Start DMA.

In your DMA buffer complete interrupt:

if SGentries1 is not empty
   populate the completed buffer
   activate newly populated buffer
endif
check the active buffer (the other one) to see if it just completed
if this other one just completed
   if Sgentries is not empty
      populate this buffer
   endif
endif
if SGentries1 is STILL not empty at this point
   enable DMA buffer interrupt
else
   disable DMA buffer interrupt
endif 







------=_Part_10300_404928.1136352536211--
