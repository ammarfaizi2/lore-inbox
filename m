Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292629AbSB0RUR>; Wed, 27 Feb 2002 12:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292826AbSB0RUD>; Wed, 27 Feb 2002 12:20:03 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:40642 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S292820AbSB0RSI>;
	Wed, 27 Feb 2002 12:18:08 -0500
Message-ID: <3C7D14B5.1020702@dlr.de>
Date: Wed, 27 Feb 2002 18:17:41 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.4) Gecko/20011206 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semphores...
In-Reply-To: <3C7C9C41.5080400@dlr.de> <20020227102446.A838@elinux01.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:

> Again, the trick is to not
> sync the state of the kernel and the user level. It comes naturally 
> if you properly separate the duties.
> 

Your code for usema_down is simply:

int usema_down(ulock_t *ulock)
{
	if (!__ulock_down(ulock)) {
		return 0;
	}
	return ulock_wait(ulock,0);
}

This means you do not recheck if the usema is really available after you 
return form ulock_wait(), but you may have the following situtation:

Process 1             Process 2                        Process 3
  down

                       down
                         -> call usema_wait
                         but gets preempted shortly
                         before it
                         can enter kernel mode

  up
   (kernel sema is free)

                                                          down -> got it


                       resume execution,
                       thinks its also got it
                       because kernel sema is free!

Now you have two owners!!


Martin Wirth




