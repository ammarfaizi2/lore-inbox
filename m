Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290523AbSAQXU4>; Thu, 17 Jan 2002 18:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290518AbSAQXUi>; Thu, 17 Jan 2002 18:20:38 -0500
Received: from f111.law11.hotmail.com ([64.4.17.111]:16910 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290523AbSAQXUU>;
	Thu, 17 Jan 2002 18:20:20 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
Date: Thu, 17 Jan 2002 15:20:14 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F111UkBAB7pNKpuQZmq00002b82@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2002 23:20:14.0438 (UTC) FILETIME=[84826060:01C19FAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>    The reasons why I wanted to pass the address is length
>    is
>
>    1. It gives more flexibility for any body implementing
>       the protocol specific code.
>
>And you could do what with this flexibility that can't be taken care
>of at the top level?
>
>    2. We anyway copy the length in move_addr_to_user, we
>       might as well do it in the system call and pass the
>       length to the protocol.
>
>Why?  What are you going to DO, read this: _DO_, with the
>value?
>
>    3. We can finally copy only the length specified back
>       to the  user as we do currently.
>
>We already do this in move_addr_to_user.  If we do it in
>one place, we don't have to duplicate (and thus risk bugs
>in) this logic in the various protocols.
>

I am not asking the top level functionality to change.
I am asking for the correct length be passed to
the protocol specific code. The reason *WHY* I want
to do this is

I am writing some code to use the sockets infrastructure.
My current sockaddr structure is a union of several
sub-protocols that I implement in one common code.
The family is the same in all these cases.

Depending on the length passed to me in getpeername,
I fill in the correct members and return it back.

>    But, consider a case where a user passes a negative value
>    in len.
>
>Now you are totally talking non-sense.  A negative len is
>an error (-EINVAL) and move_addr_to_user handles this case
>just fine.

I know that move_addr_to_user handles it, but after all
the processing has been done. The time and space has
been wasted. The code should have just returned in
the first place. I am sorry if that did not come
through in my last email.


>
>    I feel the error should be caught first hand, we should not have
>    spent the time and space calling the protocol specific code at all,
>    we should catch the error and return immediately.
>  ...
>    Don't u feel they should be fixed.
>
>If you want to move the "if (len < 0) return -EINVAL;" right before
>the ->getname() invocation, feel free.  However, this is code
>duplication and is error prone.
>

This duplication can be removed if the code is cleaned
up. For example in getpeername the code would look
something like

sys_getpeername(int fd, struct sockaddr *s, int *len)

1. copy length from user, check for invalid values,
   if the values are invalid return
2. Look up the socket
3. Store the value of len passed by user.
4. Pass the socket, address and len to protocol specific
   getpeername
5. copyout the sockaddr upto a maximum value of len passed
   by user (compare using the value stored in step 3)

I think this is a cleaner implementation. Again, I say
I think, there might be reasons why the existing code
is better, which I am not aware of. The protocol specific
code need not even look at len if it does not care,
it can put in its own value in the address we pass to
it. We will compare it to the original value.

This in addition to giving me what I want to see
(passing the value to protocol specific code), saves
time and space when the value of length is invalid.

The existing code handles things fine, but the code can be
improved.

Even if we do not pass the value passed by the user
to the protocol specific code, I would like to cleanup
the code in socket.c to check for invalid values
upfront and save time and space in all the calls.

I hope this is clear.



>But either way, this is not an argument at all to move the user len
>into the protocols.  YOU DONT NEED TO, and you never will, to
>accomplish any legitimate task.
>
>Again the question remains, why would you ever need the user len in
>the protocol handlers?  All I am hearing is a bunch of hot air so far
>with no real substance.
>
>Franks a lot,
>David S. Miller
>davem@redhat.com


Thanks,
Balbir



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

