Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbRGYPC2>; Wed, 25 Jul 2001 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRGYPCT>; Wed, 25 Jul 2001 11:02:19 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:31925 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S266938AbRGYPCE>;
	Wed, 25 Jul 2001 11:02:04 -0400
Message-ID: <3B5EDF6E.BB56B55A@candelatech.com>
Date: Wed, 25 Jul 2001 08:02:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M. Tavasti" <tawz@nic.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
In-Reply-To: <m266chnqyd.fsf@akvavitix.vuovasti.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"M. Tavasti" wrote:
> 
> I found this problem first time in 2.2 kernels, when doing own device
> driver. Then it was not an issue for me, and I suspected it's my
> fault. Now, with 2.4 again I tried to solve problem, but I can't find
> my way out of this, and looks like there in-kernel drivers which have
> same symptoms.
> 
> Here program where I get problems:
> 
> int fd;
> fd_set rfds;
> 
> fd = open("/dev/random", O_RDWR );
> 
> while(1) {
>         FD_ZERO(&rfds);
>         FD_SET(fd,&rfds);
>         FD_SET(fileno(stdin),&rfds);
>         if( select(fd+1, &rfds, NULL, NULL, NULL  ) > 0) {
>                 fprintf(stderr,"Select\n");
>                 fflush(stderr);
>                 if(FD_ISSET(fd,&rfds)) {
>                  .......
>                 } else if(FD_ISSET(fileno(stdin),&rfds) ) {
>                  ......
>                 }
>         }
> }
> 
> Select is working fine for device (in this example /dev/random) or
> stdin. But for both, not. When entering something to stdin, it's not
> sure select will return.
> 
> I haven't tested is this problem present in all devices, but at least
> /dev/random is infected. And if problem lies only in some of the
> drivers, it would be nice to know which driver haves decent
> implementation of poll and get others updated.

I also saw what I believe is a problem with select, but I haven't had
time to poke around the kernel to try to understand it.  In my case,
the problem is that when I have raw sockets reading ethernet frames,
select will not return immediately when there is a packet ready.  When
it does return, due to timeout, or another FD in the set being ready
for action, the FD is set correctly though.  My hack/kludge/work-around
was to sleep for a max of 5ms, but that is not a clean, or efficient
solution.  Another person sent private email to me claiming that he
saw the same problem, so it's likely I'm not insane on this issue :)

So, I do think there may be problems with select, but I'm not sure if it
relates to your problem or not.


Ben

> 
> I'm not subsribed on the list, so when replying this you may consider
> Cc:ing me.
> 
> --
> M. Tavasti /  tawz@nic.fi  /   +358-40-5078254
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
