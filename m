Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbSJSBVW>; Fri, 18 Oct 2002 21:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSJSBVW>; Fri, 18 Oct 2002 21:21:22 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:11450 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265445AbSJSBVU>; Fri, 18 Oct 2002 21:21:20 -0400
From: "Tervel Atanassov" <noxidog@earthlink.net>
To: "'John Myers'" <jgmyers@netscape.com>,
       "'Charles 'Buck' Krasic'" <krasic@acm.org>
Cc: "'Davide Libenzi'" <davidel@xmailserver.org>,
       "'Benjamin LaHaise'" <bcrl@redhat.com>, "'Dan Kegel'" <dank@kegel.com>,
       "'Shailabh Nagar'" <nagar@watson.ibm.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'linux-aio'" <linux-aio@kvack.org>, "'Andrew Morton'" <akpm@digeo.com>,
       "'David Miller'" <davem@redhat.com>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Stephen Tweedie'" <sct@redhat.com>
Subject: RE: epoll (was Re: [PATCH] async poll for 2.5)
Date: Fri, 18 Oct 2002 18:27:34 -0700
Message-ID: <005c01c2770e$ba9cf050$0e00000a@turchodog>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3DB0AFCE.5030205@netscape.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am just joining your discussion today for the fist time.  I come from
a Windows implementation of async I/O, so please don't hold it against
me.  I can't say that I am following 100% percent, but I think you guys
are talking about what the user API will look like, correct?

Assuming the answer is yes.  Here are my two cents.  The code you have
below seems a bit awkward -- the line while(do_io(fd) != EAGAIN) appears
twice.  I think the reason for that is that you're trying to do too many
things at once, namely, you're trying to handle both the initial
accept/setup of the socket and its steady state servicing.  I don't see
any benefit to that -- it definitely doesn't make for cleaner code.  Why
not do things separately.

1.  Have a setup phase which more or less does:

*  listen()
*  accept()
*  add the new fd/socket to an "event" which all the worker threads are
waiting on.

2.  Have the worker tread/steady state operation be:

*  event_wait() which returns the fd, some descriptor of what exactly
happened (read/write), the number of bytes transferred.
*  based upon the return from event wait the user updates his state, and
posts the next operation (read/write).

Thanks,

Tervel Atanassov

-----Original Message-----
From: owner-linux-aio@kvack.org [mailto:owner-linux-aio@kvack.org] On
Behalf Of John Myers
Sent: Friday, October 18, 2002 6:05 PM
To: Charles 'Buck' Krasic
Cc: Davide Libenzi; Benjamin LaHaise; Dan Kegel; Shailabh Nagar;
linux-kernel; linux-aio; Andrew Morton; David Miller; Linus Torvalds;
Stephen Tweedie
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)

Charles 'Buck' Krasic wrote:

>Or we could have (to make John happier?):
>
>1 for(;;) {
>2      fd = event_wait(...);
>3      if(fd == my_listen_fd) {
>4           /* new connections */
>5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN)) {
>6*                  epoll_addf(new_fd, &pfd, ...);
>7*                  if(pfd.revents & POLLIN) {
>7*                      while(do_io(new_fd) != EAGAIN);
>8*                  } 
>8           }
>9       } else {
>10           /* established connections */
>11           while(do_io(fd) != EAGAIN)
>12      }
>13 }
>  
>
Close.  What we would have is a modification of the epoll_addf() 
semantics such that it would have an additional postcondition that if 
the new_fd is in the ready state (has data available) then at least one 
notification has been generated.  In the code above, the three lines 
comprising the if statement labeled "7*" would be removed.


--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/

