Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSDWReA>; Tue, 23 Apr 2002 13:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315280AbSDWReA>; Tue, 23 Apr 2002 13:34:00 -0400
Received: from [192.82.208.96] ([192.82.208.96]:30367 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315279AbSDWRd6>;
	Tue, 23 Apr 2002 13:33:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module() 
In-Reply-To: Your message of "Mon, 22 Apr 2002 23:35:51 -0400."
             <Pine.GSO.4.21.0204222333120.5686-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 13:45:33 +1000
Message-ID: <10796.1019533533@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002 23:35:51 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Tue, 23 Apr 2002, Keith Owens wrote:
>> When a module is loaded, it is marked !MOD_USED_ONCE.  An explicit
>> rmmod will get rid of the module but rmmod -a will not.  rmmod -a will
>> not remove a module unless __MOD_INC_USE_COUNT has been issued on the
>> module at least once, or the module is loaded to satisfy unresolved
>> symbols from another module.
>
>
>Which is still racy - open()/close() bringing stuff from the same module
>during the window in question and there we go.
>
>IOW, echo </dev/foo will merrily set MOD_USED_ONCE.

Where is the race?

  open /dev/foo
    request_module(foo)
      load foo, mark !MOD_USED_ONCE.
    continue with open, MOD_INC_USE_COUNT(foo), mark MOD_USED_ONCE.
    return to use, module is locked down
  User space closes /dev/foo
    Release foo resources.
      MOD_DEC_USE_COUNT(foo)
        return to user space
  rmmod -a cleans up.  Nothing is using foo, it is removed.	

